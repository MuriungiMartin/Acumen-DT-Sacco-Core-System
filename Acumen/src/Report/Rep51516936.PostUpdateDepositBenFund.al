#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 51516936 "Post Update Deposit/BenFund"
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
                DOCUMENT_NO := 'TRANS_001';
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                GenJournalLine.DeleteAll;

                //Transfer Share Capital Variance======================================================================================================
                Customer.CalcFields(Customer."Current Shares", Customer."Shares Retained");
                if (Customer."Shares Retained" < ObjGensetup."Retained Shares") and (Customer."Current Shares" > 0) then begin
                    VarShareCapVariance := (ObjGensetup."Retained Shares" - Customer."Shares Retained");
                    if Customer."Current Shares" > VarShareCapVariance then begin
                        VarAmountPosted := VarShareCapVariance
                    end else
                        VarAmountPosted := Customer."Current Shares";


                    //------------------------------------1. DEBIT MEMBER DEPOSITS A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                    GenJournalLine."account type"::Member, Customer."No.", Today, VarAmountPosted, 'BOSA', '',
                    'Transfer to Share Capital- ' + Customer."No.", '');
                    //--------------------------------(Debit Member Deposit Account)---------------------------------------------

                    //------------------------------------2. CREDIT MEMBER FOSA A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Share Capital",
                    GenJournalLine."account type"::Member, Customer."No.", Today, VarAmountPosted * -1, 'BOSA', '',
                    'Transfer to Share Capital- ' + Customer."No.", '');
                    //----------------------------------(Credit Member Fosa Account)------------------------------------------------

                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                end;
                //END Transfer Share Capital Variance======================================================================================================

                //Transfer BENEVOLENT Variance======================================================================================================
                Customer.CalcFields(Customer."Current Shares", Customer."Shares Retained", Customer."Benevolent Fund");
                if (Customer."Benevolent Fund" < ObjGensetup."Insurance Contribution") and (Customer."Current Shares" > 0) then begin
                    VarBenfundVariance := (ObjGensetup."Insurance Contribution" - Customer."Benevolent Fund");
                    if Customer."Current Shares" > VarBenfundVariance then begin
                        VarAmountPosted := VarBenfundVariance
                    end else
                        VarAmountPosted := Customer."Current Shares";


                    //------------------------------------1. DEBIT MEMBER DEPOSITS A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                    GenJournalLine."account type"::Member, Customer."No.", Today, VarAmountPosted, 'BOSA', '',
                    'Transfer to Benfund- ' + Customer."No.", '');
                    //--------------------------------(Debit Member Deposit Account)---------------------------------------------

                    //------------------------------------2. CREDIT MEMBER FOSA A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Benevolent Fund",
                    GenJournalLine."account type"::Member, Customer."No.", Today, VarAmountPosted * -1, 'BOSA', '',
                    'Transfer to Benfund- ' + Customer."No.", '');
                    //----------------------------------(Credit Member Fosa Account)------------------------------------------------

                    //CU posting
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                end;
                //END Transfer Benevolent Fund Variance======================================================================================================


                //--------------------------------Update Member Monthly Contribution-----------------------------------------------------------------
                "Monthly Contribution" := FnGetMembersMonthlyContribution("No.");
                Modify;
                //--------------------------------End Update Member Monthly Contribution----------------------------------------------------------------
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

    local procedure FnGetMembersMonthlyContribution(MemberNo: Code[30]) VarMemberMonthlyContribution: Decimal
    var
        ObjMember: Record Customer;
        ObjLoans: Record "Loans Register";
        VarTotalLoansIssued: Decimal;
        ObjDeposittier: Record "Deposit Tier Setup";
    begin
        VarTotalLoansIssued := 0;

        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", MemberNo);
        if ObjMember.FindSet then begin
            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");

            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", MemberNo);
            ObjLoans.SetRange(ObjLoans.Posted, true);
            ObjLoans.SetFilter(ObjLoans."Outstanding Balance", '>%1', 0);
            if ObjLoans.FindSet then begin
                repeat
                    VarTotalLoansIssued := VarTotalLoansIssued + ObjLoans."Approved Amount";
                until ObjLoans.Next = 0;
            end;


            ObjDeposittier.Reset;
            if (VarTotalLoansIssued >= ObjDeposittier."Minimum Amount") and (VarTotalLoansIssued <= ObjDeposittier."Maximum Amount") then begin
                repeat
                    VarMemberMonthlyContribution := ObjDeposittier."Minimum Dep Contributions";

                until ObjDeposittier.Next = 0;
            end;
        end;
        exit(VarMemberMonthlyContribution);
    end;
}

