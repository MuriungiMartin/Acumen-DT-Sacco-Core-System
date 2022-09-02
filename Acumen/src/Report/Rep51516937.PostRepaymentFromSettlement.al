#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 51516937 "Post Repayment From Settlement"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin

                ObjRepamentSchedule.Reset;
                ObjRepamentSchedule.SetRange(ObjRepamentSchedule."Loan No.", "Loan  No.");
                //ObjRepamentSchedule.SETFILTER(ObjRepamentSchedule."Repayment Date",'=%1',TODAY);
                ObjRepamentSchedule.SetRange(ObjRepamentSchedule."Repayment Date", WorkDate);
                if ObjRepamentSchedule.FindSet then begin
                    ObjAccounts.Reset;
                    ObjAccounts.SetRange(ObjAccounts."BOSA Account No", "Client Code");
                    ObjAccounts.SetRange(ObjAccounts."Account Type", '507');
                    if ObjAccounts.FindSet then begin
                        ObjAccounts.CalcFields(ObjAccounts.Balance, ObjAccounts."Uncleared Cheques");
                        AvailableBal := (ObjAccounts.Balance - ObjAccounts."Uncleared Cheques");

                        ObjAccTypes.Reset;
                        ObjAccTypes.SetRange(ObjAccTypes.Code, ObjAccounts."Account Type");
                        if ObjAccTypes.Find('-') then
                            AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";


                        ObjGensetup.Get();
                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'DEFAULT';
                        DOCUMENT_NO := 'AutoR' + Format(Today);
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;


                        //Loan Settlement Account has more or equal to the monthly repayment==================================
                        CalcFields("Outstanding Insurance", "Oustanding Interest", "Outstanding Balance");
                        VarPrincipalRepayment := Repayment - ("Outstanding Balance" * (Interest / 1200));
                        VarTotalRepaymentDue := VarPrincipalRepayment + "Outstanding Insurance" + "Oustanding Interest" + "Outstanding Balance";

                        if AvailableBal >= VarTotalRepaymentDue then begin

                            //------------------------------------1. Repay Insurance---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                            GenJournalLine."account type"::Member, "Client Code", Today, 'Insurance Paid from Settlement', GenJournalLine."bal. account type"::Vendor, ObjAccounts."No.",
                            "Outstanding Insurance" * -1, 'BOSA', "Loan  No.");
                            //--------------------------------(Repay Insurance)---------------------------------------------

                            //------------------------------------2. Interest Paid---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                            GenJournalLine."account type"::Member, "Client Code", Today, 'Interest Paid from Settlement', GenJournalLine."bal. account type"::Vendor, ObjAccounts."No.",
                            "Oustanding Interest" * -1, 'BOSA', "Loan  No.");
                            //--------------------------------(Interest Paid)---------------------------------------------

                            //------------------------------------3. Principle Repayment---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                            GenJournalLine."account type"::Member, "Client Code", Today, 'Principle Repayment from Settlement', GenJournalLine."bal. account type"::Vendor, ObjAccounts."No.",
                            VarPrincipalRepayment * -1, 'BOSA', "Loan  No.");
                            //--------------------------------(Principle Repayment)---------------------------------------------
                        end;
                        //End Loan Settlement Account has more or equal to the monthly repayment===============================
                    end;

                    //Loan Settlement Account has Less than Monthly Repayment


                    //------------------------------------1. Repay Insurance---------------------------------------------------------------------------------------------

                    if "Outstanding Insurance" < AvailableBal then begin
                        VarInsuranceAmountDed := AvailableBal
                    end else
                        VarInsuranceAmountDed := "Outstanding Insurance";

                    if AvailableBal > 0 then begin
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                        GenJournalLine."account type"::Member, "Client Code", Today, 'Insurance Paid from Settlement', GenJournalLine."bal. account type"::Vendor, ObjAccounts."No.",
                        "Outstanding Insurance" * -1, 'BOSA', "Loan  No.");
                        AvailableBal := AvailableBal - VarInsuranceAmountDed;
                    end;
                    //--------------------------------(Repay Insurance)---------------------------------------------

                    //------------------------------------2. Interest Paid---------------------------------------------------------------------------------------------
                    if "Oustanding Interest" > AvailableBal then begin
                        VarInterestAmountDed := AvailableBal
                    end else
                        VarInterestAmountDed := "Oustanding Interest";

                    if AvailableBal > 0 then begin
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::Member, "Client Code", Today, 'Interest Paid from Settlement', GenJournalLine."bal. account type"::Vendor, ObjAccounts."No.",
                        "Oustanding Interest" * -1, 'BOSA', "Loan  No.");
                        AvailableBal := AvailableBal - VarInsuranceAmountDed;
                    end;
                    //--------------------------------(Interest Paid)---------------------------------------------

                    //------------------------------------3. Principle Repayment---------------------------------------------------------------------------------------------
                    if VarPrincipalRepayment > AvailableBal then begin
                        VarPrincipleAmountDed := AvailableBal
                    end else
                        VarPrincipleAmountDed := VarPrincipalRepayment;

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                    GenJournalLine."account type"::Member, "Client Code", Today, 'Principle Repayment from Settlement', GenJournalLine."bal. account type"::Vendor, ObjAccounts."No.",
                    VarPrincipalRepayment * -1, 'BOSA', "Loan  No.");
                    AvailableBal := AvailableBal - VarPrincipleAmountDed;
                    //--------------------------------(Principle Repayment)---------------------------------------------


                end;


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
        ObjRepamentSchedule: Record "Loan Repayment Schedule";
        ObjAccounts: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        VarPrincipalRepayment: Decimal;
        VarTotalRepaymentDue: Decimal;
        VarInsuranceAmountDed: Decimal;
        VarInterestAmountDed: Decimal;
        VarPrincipleAmountDed: Decimal;
}

