#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 51516940 "Penalize Arrears In MDep Contr"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ObjGensetup.Get();
                BATCH_TEMPLATE := 'GENERAL';
                BATCH_NAME := 'DEFAULT';
                DOCUMENT_NO := 'MonthlyCont.';
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                GenJournalLine.DeleteAll;


                VarStartofMonthDate := 1;
                VarCurrMonth := Date2dmy(WorkDate, 2);
                VarCurrYear := Date2dmy(WorkDate, 3);
                VarFirstDayofMonth := Dmy2date(VarStartofMonthDate, VarCurrMonth, VarCurrYear);
                VarDateFilter := Format(VarFirstDayofMonth) + '..' + Format(CalcDate('CM', VarFirstDayofMonth));

                ObjMemberLedger.Reset;
                ObjMemberLedger.SetRange(ObjMemberLedger."Customer No.", "No.");
                ObjMemberLedger.SetRange(ObjMemberLedger."Transaction Type", ObjMemberLedger."transaction type"::"Deposit Contribution");
                ObjMemberLedger.SetFilter(ObjMemberLedger."Posting Date", VarDateFilter);
                if ObjMemberLedger.FindSet then begin
                    repeat
                        VarMemberContributionMade := VarMemberContributionMade + ObjMemberLedger."Credit Amount";
                    until ObjMemberLedger.Next = 0;
                end;
                //MESSAGE('VarMemberContributionMade is %1 VarDateFilter is %2',VarMemberContributionMade,VarDateFilter);
                if VarMemberContributionMade < "Monthly Contribution" then begin
                    VarMonthlyContributionDefecit := "Monthly Contribution" - VarMemberContributionMade;

                    ObjAccount.CalcFields(ObjAccount.Balance);
                    ObjAccount.Reset;
                    ObjAccount.SetRange(ObjAccount."BOSA Account No", "No.");
                    ObjAccount.SetFilter(ObjAccount."Account Type", '<>%1|%2', '503', '506');
                    ObjAccount.SetFilter(ObjAccount.Balance, '>=%1', VarMonthlyContributionDefecit);
                    if ObjAccount.FindSet then begin
                        repeat
                            VarFOSAAccountDebited := ObjAccount."No.";
                        until ObjAccount.Next = 0;
                    end;

                    //------------------------Deduct Monthly Contribution From FOSA Account----------------------------------------
                    if VarFOSAAccountDebited <> '' then begin
                        //------------------------------------1. CREDIT MEMBER DEPOSITS A/C---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                        GenJournalLine."account type"::Member, Customer."No.", Today, VarMonthlyContributionDefecit * -1, 'BOSA', '',
                        'Auto-Monthly Deposit Contribution', '');
                        //--------------------------------(Credit Member Deposit Account)---------------------------------------------

                        //------------------------------------2. DEBIT MEMBER FOSA A/C---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Share Capital",
                        GenJournalLine."account type"::Vendor, VarFOSAAccountDebited, Today, VarMonthlyContributionDefecit, 'FOSA', '',
                        'Auto-Monthly Deposit Contribution- ' + Customer."No.", '');
                        //----------------------------------(Debit Member Fosa Account)------------------------------------------------

                    end;
                    //------------------------End Deduct Monthly Contribution From FOSA Account----------------------------------------


                    //-------------------------Charge Penalty On Failed monthly Contribution-------------------------------------------
                    ObjGensetup.Get();
                    if VarFOSAAccountDebited = '' then begin

                        //------------------------------------1. DEBIT Deposit  A/C Penalty---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                        GenJournalLine."account type"::Member, Customer."No.", Today, 'Failed Monthly Contr. Penalty_' + Customer."No.", GenJournalLine."bal. account type"::"G/L Account",
                        ObjGensetup."Penalty Monthly Contr. Account", ObjGensetup."Penalty Monthly Contribution", 'BOSA', '');
                        //--------------------------------(Debit Deposit Account Penalty)-------------------------------------------------------------------------------


                        //------------------------------------1. DEBIT Deposit  A/C Tax on Penalty---------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                        GenJournalLine."account type"::Member, Customer."No.", Today, 'Failed Monthly Contr. Tax_' + Customer."No.", GenJournalLine."bal. account type"::"G/L Account",
                        ObjGensetup."Excise Duty Account", ObjGensetup."Penalty Monthly Contribution" * (ObjGensetup."Excise Duty(%)" / 100), 'BOSA', '');
                        //--------------------------------(Debit Deposit Account Tax On Penalty)-------------------------------------------------------------------------------

                    end;

                end;
                //-------------------------End Charge Penalty On Failed monthly Contribution-------------------------------------------




                //CU posting
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                if GenJournalLine.Find('-') then
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ObjGensetup: Record "Sacco General Set-Up";
        GenJournalLine: Record "Gen. Journal Line";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory.";
        VarShareCapVariance: Decimal;
        VarAmountPosted: Decimal;
        VarBenfundVariance: Decimal;
        ObjMemberLedger: Record "Cust. Ledger Entry";
        VarDateFilter: Text;
        VarStartofMonthDate: Integer;
        VarCurrMonth: Integer;
        VarCurrYear: Integer;
        VarFirstDayofMonth: Date;
        VarMemberContributionMade: Decimal;
        ObjAccount: Record Vendor;
        VarMonthlyContributionDefecit: Decimal;
        VarFOSAAccountDebited: Code[30];
}

