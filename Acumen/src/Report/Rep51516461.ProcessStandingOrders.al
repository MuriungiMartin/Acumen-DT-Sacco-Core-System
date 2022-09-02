#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 51516461 "Process Standing Orders"
{
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = where("Creditor Type" = const("FOSA Account"), Status = const(Active), Blocked = filter(<> All));
            RequestFilterFields = "Account Type", "Employer Code", "No.";
            RequestFilterHeading = 'Account';
            column(ReportForNavId_3182; 3182)
            {
            }
            dataitem("Standing Orders"; "Standing Orders")
            {
                DataItemLink = "Source Account No." = field("No.");
                DataItemTableView = sorting("No.") where(Status = const(Approved), "Standing Order Type" = filter("Date Based"));
                RequestFilterFields = "No.";
                column(ReportForNavId_8337; 8337)
                {
                }

                trigger OnAfterGetRecord()
                var
                    ObjVendors: Record Vendor;
                    ObjAccTypes: Record "Account Types-Saving Products";
                begin
                    BATCH_TEMPLATE := 'PURCHASES';
                    BATCH_NAME := 'STO';
                    DOCUMENT_NO := "Standing Orders"."No.";


                    VarAmountDed := 0;
                    if ("Standing Orders"."Next Run Date" = WorkDate) or ("Standing Orders"."Next Attempt Date" = WorkDate) then begin

                        //MESSAGE (FORMAT( Vendor.Name));

                        //Get Account Available Account Balance============================================================================================
                        ObjVendors.Reset;
                        ObjVendors.SetRange(ObjVendors."No.", "Standing Orders"."Source Account No.");
                        if ObjVendors.Find('-') then begin
                            ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                            AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                            ObjAccTypes.Reset;
                            ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                            if ObjAccTypes.Find('-') then
                                AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                        end;
                        //End Get Account Available Account Balance============================================================================================


                        //Post When Account Available is > than Standing Order Amount=============================================================================
                        if AvailableBal >= "Standing Orders".Amount then begin

                            //------------------------------------1. DEBIT SOURCE  A/C---------------------------------------------------------------------------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, "Standing Orders"."Source Account No.", Today, "Standing Orders".Amount, 'FOSA', '',
                            "Standing Orders"."Standing Order Description", '');
                            //--------------------------------(Debit Source Account)-------------------------------------------------------------------------------

                            //--------------------------------Post to the Respective Destination Account-----------------------------------------------------------
                            if "Standing Orders"."Destination Account Type" = "Standing Orders"."destination account type"::BOSA then begin
                                FnPostBackOfficeTransactions()
                            end else
                                if "Standing Orders"."Destination Account Type" = "Standing Orders"."destination account type"::Internal then begin
                                    FnPostFOSATransactions()
                                end else
                                    if "Standing Orders"."Destination Account Type" = "Standing Orders"."destination account type"::External then begin
                                        FnPostExternalTransactions();
                                    end;
                            //--------------------------------End Post to the Respective Destination Account-----------------------------------------------------------

                            FnPostStandingOrderFee_Succesful();//---------Post Standing Order Fee-------------------------------------------------------------------
                            "Standing Orders".Effected := true;
                            "Standing Orders"."Auto Process" := true;
                            "Standing Orders"."Next Run Date" := CalcDate("Standing Orders".Frequency, "Standing Orders"."Next Run Date");

                            "Standing Orders"."Next Attempt Date" := CalcDate("Standing Orders".Frequency, "Standing Orders"."Next Run Date");
                            "Standing Orders".Modify;
                            VarDedStatus := Vardedstatus::Successfull;
                            FnUpdateStandingOrderRegister();
                        end;
                        //End Post When Account Available is > than Standing Order Amount==========================================================================


                        //-----Update Next Attempt Date------------------------------------------------------------------------------------------------------------
                        if AvailableBal < "Standing Orders".Amount then begin
                            // MESSAGE ('DATE YA KWANZA NI %1',"Standing Orders"."Next Run Date");

                            //"Standing Orders"."Next Attempt Date":=CALCDATE('1D',"Standing Orders"."Next Attempt Date");
                            "Standing Orders"."Next Attempt Date" := CalcDate("Standing Orders".Frequency, "Standing Orders"."Next Run Date");

                            // MESSAGE ('next atte date is %1',"Standing Orders"."Next Attempt Date");
                            exit;
                        end;
                        //-----End Update Next Attempt Date-----------------------------------------------------------------------------------------------------------

                        //----Finalize for Failed Standing Order------------------------------------------------------------------------------------------------------
                        if (AvailableBal < "Standing Orders".Amount) and ("Standing Orders"."Next Attempt Date" = "Standing Orders"."End of Tolerance Date") then begin
                            FnPostStandingOrderFee_Failed();

                            "Standing Orders".Unsuccessfull := true;
                            "Standing Orders"."Auto Process" := true;
                            "Standing Orders"."Next Run Date" := CalcDate("Standing Orders".Frequency, "Standing Orders"."Next Run Date");
                            "Standing Orders"."Next Attempt Date" := CalcDate("Standing Orders".Frequency, "Standing Orders"."Next Run Date");
                            "Standing Orders".Modify;
                            VarDedStatus := Vardedstatus::Failed;
                            FnUpdateStandingOrderRegister();
                        end;
                        //----End Finalize for Failed Standing Order------------------------------------------------------------------------------------------------------
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields(Balance, "Uncleared Cheques");
                AvailableBal := (Balance - "Uncleared Cheques");
                if VarAccountTypeS.Get("Account Type") then
                    AvailableBal := AvailableBal - VarAccountTypeS."Minimum Balance";
            end;

            trigger OnPostDataItem()
            begin

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                GenJournalLine.SetRange("Journal Batch Name", 'STO');
                if GenJournalLine.Find('-') then begin
                    repeat
                        GLPosting.Run(GenJournalLine);
                    until GenJournalLine.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'STO');
                if GenJournalLine.Find('-') then
                    GenJournalLine.DeleteAll;
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
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        ObjAccount: Record Vendor;
        ObjAccountType: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        ObjStoRegister: Record "Standing Order Register";
        VarAmountDed: Decimal;
        VarDedStatus: Option Successfull,"Partial Deduction",Failed;
        ObjCharges: Record Charges;
        LineNo: Integer;
        DActivity: Code[20];
        DBranch: Code[20];
        VarStoAmount: Decimal;
        ObjReceiptAllocations: Record "Receipt Allocation";
        VarStoRunBal: Decimal;
        VarReceiptAmount: Decimal;
        ObjLoans: Record "Loans Register";
        VarDocNo: Code[20];
        VarInsCont: Decimal;
        VarActualSto: Decimal;
        VarAccountS: Record Vendor;
        DActivity3: Code[20];
        DBranch3: Code[20];
        VarAccountTypeS: Record "Account Types-Saving Products";
        VarStandingOrderFee: Decimal;
        VarGenSetup: Record "Sacco General Set-Up";
        SFactory: Codeunit "SURESTEP Factory.";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];

    local procedure FnPostBackOfficeTransactions()
    var
        ObjStandingOrder: Record "Standing Orders";
    begin

        ObjReceiptAllocations.Reset;
        ObjReceiptAllocations.SetRange(ObjReceiptAllocations."Document No", "Standing Orders"."No.");
        if ObjReceiptAllocations.Find('-') then begin
            repeat
                //------------------------------------1. CREDIT DESTINATION  A/C---------------------------------------------------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptAllocations."Transaction Type",
                ObjReceiptAllocations."Account Type", ObjReceiptAllocations."Member No", Today, ObjReceiptAllocations.Amount * -1, 'BOSA', '',
                "Standing Orders"."Standing Order Description", ObjReceiptAllocations."Loan No.");
            //--------------------------------(Credit Destination Account)-------------------------------------------------------------------------------
            until ObjReceiptAllocations.Next = 0;
        end;
    end;

    local procedure FnPostFOSATransactions()
    begin
        //------------------------------------1. CREDIT FOSA  A/C---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, "Standing Orders"."Destination Account No.", Today, "Standing Orders".Amount * -1, 'FOSA', '',
        "Standing Orders"."Standing Order Description", '');
        //--------------------------------(Credit FOSA Account)-------------------------------------------------------------------------------
    end;

    local procedure FnPostExternalTransactions()
    var
        ObjGensetup: Record "Sacco General Set-Up";
    begin
        ObjGensetup.Get();

        //------------------------------------1. CREDIT BANK  A/C---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::"Bank Account", ObjGensetup."Standing Order Bank", Today, "Standing Orders".Amount * -1, 'FOSA', '',
        "Standing Orders"."Standing Order Description", '');
        //--------------------------------(Credit Bank Account)-------------------------------------------------------------------------------
    end;

    local procedure FnPostStandingOrderFee_Succesful()
    var
        ObjGensetup: Record "Sacco General Set-Up";
        ObjFosaCharges: Record Charges;
        VarStoFeeSuccess: Decimal;
        VarStoFeeFailed: Decimal;
        VarStoFeeAccount: Code[30];
    begin
        ObjGensetup.Get();

        ObjFosaCharges.Reset;
        ObjFosaCharges.SetRange(ObjFosaCharges."Charge Type", ObjCharges."charge type"::"Standing Order Fee");
        if ObjFosaCharges.FindSet then begin
            if ObjFosaCharges."Use Percentage" = true then begin
                VarStoFeeSuccess := "Standing Orders".Amount * (ObjFosaCharges."Percentage of Amount" / 10)
            end else
                VarStoFeeSuccess := ObjFosaCharges."Charge Amount";
            VarStoFeeAccount := ObjFosaCharges."GL Account";
        end;

        //------------------------------------1. DEBIT FOSA  A/C STO Charge---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, "Standing Orders"."Source Account No.", Today, "Standing Orders"."Standing Order Description", GenJournalLine."bal. account type"::"G/L Account",
        VarStoFeeAccount, VarStoFeeSuccess, 'FOSA', '');
        //--------------------------------(Debit FOSA Account STO Charge)-------------------------------------------------------------------------------

        //------------------------------------2. DEBIT FOSA  A/C Tax---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, "Standing Orders"."Source Account No.", Today, "Standing Orders"."Standing Order Description", GenJournalLine."bal. account type"::"G/L Account",
        ObjGensetup."Excise Duty Account", VarStoFeeSuccess * (ObjGensetup."Excise Duty(%)" / 100), 'FOSA', '');
        //--------------------------------(Debit FOSA Account STO Charge Tax)-------------------------------------------------------------------------------
    end;

    local procedure FnPostStandingOrderFee_Failed()
    var
        ObjGensetup: Record "Sacco General Set-Up";
        ObjFosaCharges: Record Charges;
        VarStoFeeSuccess: Decimal;
        VarStoFeeFailed: Decimal;
        VarStoFeeAccount: Code[30];
    begin
        ObjGensetup.Get();

        ObjFosaCharges.Reset;
        ObjFosaCharges.SetRange(ObjFosaCharges."Charge Type", ObjCharges."charge type"::"Failed Standing Order Fee");
        if ObjFosaCharges.FindSet then begin
            if ObjFosaCharges."Use Percentage" = true then begin
                VarStoFeeSuccess := "Standing Orders".Amount * (ObjFosaCharges."Percentage of Amount" / 10)
            end else
                VarStoFeeSuccess := ObjFosaCharges."Charge Amount";
            VarStoFeeAccount := ObjFosaCharges."GL Account";
        end;

        //------------------------------------1. DEBIT FOSA  A/C STO Charge---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, "Standing Orders"."Source Account No.", Today, "Standing Orders"."Standing Order Description", GenJournalLine."bal. account type"::"G/L Account",
        VarStoFeeAccount, VarStoFeeSuccess, 'FOSA', '');
        //--------------------------------(Debit FOSA Account STO Charge)-------------------------------------------------------------------------------

        //------------------------------------2. DEBIT FOSA  A/C Tax---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, "Standing Orders"."Source Account No.", Today, "Standing Orders"."Standing Order Description", GenJournalLine."bal. account type"::"G/L Account",
        ObjGensetup."Excise Duty Account", VarStoFeeSuccess * (ObjGensetup."Excise Duty(%)" / 100), 'FOSA', '');
        //--------------------------------(Debit FOSA Account STO Charge Tax)-------------------------------------------------------------------------------
    end;

    local procedure FnUpdateStandingOrderRegister()
    begin
        ObjStoRegister.Init;
        ObjStoRegister."Register No." := '';
        ObjStoRegister.Validate(ObjStoRegister."Register No.");
        ObjStoRegister."Standing Order No." := "Standing Orders"."No.";
        ObjStoRegister."Source Account No." := "Standing Orders"."Source Account No.";
        ObjStoRegister."Staff/Payroll No." := "Standing Orders"."Staff/Payroll No.";
        ObjStoRegister.Date := Today;
        ObjStoRegister."Account Name" := "Standing Orders"."Account Name";
        ObjStoRegister."Destination Account Type" := "Standing Orders"."Destination Account Type";
        ObjStoRegister."Destination Account No." := "Standing Orders"."Destination Account No.";
        ObjStoRegister."Destination Account Name" := "Standing Orders"."Destination Account Name";
        ObjStoRegister."BOSA Account No." := "Standing Orders"."BOSA Account No.";
        ObjStoRegister."Effective/Start Date" := "Standing Orders"."Effective/Start Date";
        ObjStoRegister."End Date" := "Standing Orders"."End Date";
        ObjStoRegister.Duration := "Standing Orders".Duration;
        ObjStoRegister.Frequency := "Standing Orders".Frequency;
        ObjStoRegister."Don't Allow Partial Deduction" := "Standing Orders"."Don't Allow Partial Deduction";
        ObjStoRegister."Deduction Status" := VarDedStatus;
        ObjStoRegister.Remarks := "Standing Orders"."Standing Order Description";
        ObjStoRegister.Amount := "Standing Orders".Amount;
        ObjStoRegister."Amount Deducted" := VarAmountDed;
        if "Standing Orders"."Destination Account Type" = "Standing Orders"."destination account type"::External then
            ObjStoRegister.EFT := true;
        ObjStoRegister.Insert(true);
    end;
}

