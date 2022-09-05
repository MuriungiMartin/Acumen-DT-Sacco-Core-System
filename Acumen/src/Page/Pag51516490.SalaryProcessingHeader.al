#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516490 "Salary Processing Header"
{
    PageType = Card;
    SourceTable = "Salary Processing Headerr";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By"; "Entered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Entered"; "Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Posting date"; "Posting date")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Exempt Loan Repayment"; "Exempt Loan Repayment")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Total Count"; "Total Count")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount"; "Scheduled Amount")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field(Discard; Discard)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Pre-Post Blocked Status Update"; "Pre-Post Blocked Status Update")
                {
                    ApplicationArea = Basic;
                    Caption = 'Pre-Post Blocked Status Updated';
                    Editable = false;
                    Visible = false;
                }
                field("Post-Post Blocked Statu Update"; "Post-Post Blocked Statu Update")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post-Post Blocked Status Updated';
                    Editable = false;
                    Visible = false;
                }
            }
            part("50000"; "Salary Processing Lines")
            {
                Caption = 'Salary Processing Lines';
                Enabled = false;
                SubPageLink = "Salary Header No." = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup1102755021)
            {
                action("Clear Lines")
                {
                    ApplicationArea = Basic;
                    Enabled = not ActionEnabled;
                    Image = CheckList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Confirm('This Action will clear all the Lines for the current Salary Document. Do you want to Continue') = false then
                            exit;
                        salarybuffer.Reset;
                        salarybuffer.SetRange(salarybuffer."Salary Header No.", No);
                        salarybuffer.DeleteAll;

                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'SALARIES';
                        DOCUMENT_NO := Remarks;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;
                    end;
                }
                action("Import Salaries")
                {
                    ApplicationArea = Basic;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = XMLport "Import Salaries1";
                }
                action("Validate Data")
                {
                    ApplicationArea = Basic;
                    Image = ViewCheck;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        AccountName: Text;
                    begin
                        TestField(No);
                        TestField("Document No");
                        salarybuffer.Reset;
                        salarybuffer.SetRange("Salary Header No.", No);
                        if salarybuffer.Find('-') then begin
                            repeat
                                salarybuffer."Account Name" := '';
                                salarybuffer.Modify;
                            until salarybuffer.Next = 0;
                        end;
                        salarybuffer.Reset;
                        salarybuffer.SetRange("Salary Header No.", No);
                        if salarybuffer.Find('-') then begin
                            repeat
                                AccountName := '';
                                ObjVendor.Reset;
                                //ObjVendor.SETRANGE("Personal No.",salarybuffer."Staff No.");
                                ObjVendor.SetRange("BOSA Account No", salarybuffer."Staff No.");
                                if ObjVendor.Find('-') then begin
                                    AccountName := ObjVendor.Name;
                                    salarybuffer."Account No." := ObjVendor."No.";
                                    salarybuffer."Account Name" := AccountName;
                                    salarybuffer."Mobile Phone Number" := ObjVendor."Phone No.";
                                    salarybuffer.Modify;
                                end;
                            until salarybuffer.Next = 0;
                        end;
                        Message('Validation completed successfully.');
                    end;
                }
                action("Process Salaries")
                {
                    ApplicationArea = Basic;
                    Image = Apply;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Transfer this Salary to Journals ?') = false then
                            exit;

                        TestField("Document No");
                        TestField(Amount);
                        TestField("Cheque No.");
                        Datefilter := '..' + Format("Posting date");
                        if Amount <> "Scheduled Amount" then
                            Error('Scheduled Amount must be equal to the Cheque Amount');

                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'SALARIES';
                        DOCUMENT_NO := "Document No";
                        EXTERNAL_DOC_NO := "Cheque No.";
                        SMSCODE := '';
                        Counter := 0;

                        if "Transaction Type" = "transaction type"::"Nafaka Instant Savings" then begin
                            //SMSCODE:='SMSFEE_NIS';
                            FnNISProcessing();
                        end else begin
                            SMSCODE := 'SMSFEE_SAL';
                            FnSalaryProcessing();
                        end
                    end;
                }
                action("Mark as Posted")
                {
                    ApplicationArea = Basic;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        // IF CONFIRM('Are you sure you want to mark this process as Complete ?')=FALSE THEN
                        //  EXIT;
                        //
                        //
                        // TESTFIELD("Document No");
                        // TESTFIELD(Amount);
                        // ObjVendor.RESET;
                        //  ObjVendor.SETRANGE(ObjVendor."No.","Account No");
                        //  IF ObjVendor.FIND('-') THEN
                        //    BEGIN
                        //      REPEAT
                        //        salarybuffer.RESET;
                        //        salarybuffer.SETRANGE(salarybuffer."Account No.",ObjVendor."No.");
                        //        IF salarybuffer.FIND('-') THEN
                        //          BEGIN
                        //            SMSMessages.RESET;
                        //  IF SMSMessages.FIND('+') THEN BEGIN
                        //  iEntryNo:=SMSMessages."Entry No";
                        //  iEntryNo:=iEntryNo+1;
                        //  END
                        //  ELSE BEGIN
                        //  iEntryNo:=1;
                        //  END;
                        //
                        //  SMSMessages.INIT;
                        //  SMSMessages."Entry No":=iEntryNo;
                        //  SMSMessages."Account No":="Account No";
                        //  SMSMessages."Date Entered":=TODAY;
                        //  SMSMessages."Time Entered":=TIME;
                        //  SMSMessages.Source:='SALARIES';
                        //  SMSMessages."Entered By":=USERID;
                        //  SMSMessages."Sent To Server":=SMSMessages."Sent To Server"::No;
                        //  SMSMessages."SMS Message":='Credit Note: Dear '
                        //          + "Account Name"+' kindly note that Your Salary has been Credited to your FOSA Account. You can Access it through our Mobile Banking platform(*850#)';
                        //
                        //  //IF LoanApp.GET(Lguarantors//."Loan No") THEN
                        //  SMSMessages."Telephone No":=ObjSalaryLines."Mobile Phone Number";
                        //  SMSMessages.INSERT;
                        //
                        //             // SFactory.FnSendSMS('SALARIES','Your Salary has been processed at ACUMEN Sacco. Dial *850#',salarybuffer."Account No.",salarybuffer."Mobile Phone Number")
                        //          END;
                        //     UNTIL ObjVendor.NEXT=0;
                        //  END;
                        //
                        //
                        //
                        //
                        //
                        // salarybuffer.RESET;
                        // salarybuffer.SETRANGE(salarybuffer."Account No.",No);
                        // //salarybuffer.RESET;
                        // //salarybuffer.SETRANGE(salarybuffer."Account No.","Account No");
                        //
                        //
                        //
                        // IF salarybuffer.FIND('-') THEN BEGIN
                        // //  Window.OPEN('Sending SMS to Members: @1@@@@@@@@@@@@@@@'+'Record:#2###############');
                        // //  TotalCount:=salarybuffer.COUNT;
                        //  REPEAT
                        //    salarybuffer.CALCFIELDS(salarybuffer."Mobile Phone Number");
                        //    MESSAGE(FORMAT(salarybuffer."Mobile Phone Number"));
                        //    Percentage:=(ROUND(Counter/TotalCount*10000,1));
                        //    Counter:=Counter+1;
                        //    Window.UPDATE(1,Percentage);
                        //    Window.UPDATE(2,Counter);
                        //    IF "Transaction Type"="Transaction Type"::"Salary Processing" THEN
                        //
                        //
                        //    // SFactory.FnSendSMS('SALARIES','Your Salary has been processed at ACUMEN Sacco. Dial *850#',salarybuffer."Account No.",salarybuffer."Mobile Phone Number")
                        //    SFactory.FnSendSMS('SALARIES','Dear Member, Your 2018 STOCKTAKE allowance has been posted to your FOSA Account.Dial *850#',salarybuffer."Account No.",salarybuffer."Mobile Phone Number")
                        //    ELSE
                        //    SFactory.FnSendSMS('NIS','Your Instant savings has been processed at ACUMEN Sacco. Dial *850#',salarybuffer."Account No.",salarybuffer."Mobile Phone Number");
                        //    IF ObjVendor.GET(salarybuffer."Account No.") THEN BEGIN
                        //      IF ObjVendor."Salary Processing"=FALSE THEN BEGIN
                        //        ObjVendor."Salary Processing":=TRUE;
                        //        ObjVendor.MODIFY;
                        //      END
                        //      END
                        //  UNTIL salarybuffer.NEXT=0;
                        // END;
                        // Posted:=TRUE;
                        // "Posted By":=USERID;
                        // MESSAGE('Process Completed Successfully. Account Holders will receive Salary processing notification via SMS');
                        // //Window.CLOSE;
                        if Confirm('Are you sure you want to mark this process as Complete ?') = false then
                            exit;
                        TestField("Document No");
                        TestField(Amount);
                        salarybuffer.Reset;
                        salarybuffer.SetRange("Salary Header No.", No);

                        if salarybuffer.Find('-') then begin
                            Window.Open('Sending SMS to Members: @1@@@@@@@@@@@@@@@' + 'Record:#2###############');
                            TotalCount := salarybuffer.Count;
                            repeat
                                // salarybuffer.CALCFIELDS(salarybuffer."Mobile Phone Number");
                                Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                                Counter := Counter + 1;
                                Window.Update(1, Percentage);
                                Window.Update(2, Counter);
                                if "Transaction Type" = "transaction type"::"Salary Processing" then
                                    SFactory.FnSendSMS('SALARIES', 'Your Salary has been processed at ACUMEN Sacco. Dial *850# to access', salarybuffer."Account No.", salarybuffer."Mobile Phone Number")
                                //SFactory.FnSendSMS('SALARIES','Dear Member, Your 2018 STOCKTAKE allowance has been posted to your FOSA Account.Dial *850#',salarybuffer."Account No.",salarybuffer."Mobile Phone Number")
                                else
                                    //SFactory.FnSendSMS('NIS','Your Instant savings has been processed at NAFAKA Sacco. Dial *850#',salarybuffer."Account No.",salarybuffer."Mobile Phone Number");
                                    if ObjVendor.Get(salarybuffer."Account No.") then begin
                                        if ObjVendor."Salary Processing" = false then begin
                                            ObjVendor."Salary Processing" := true;
                                            ObjVendor.Modify;
                                        end
                                    end
                            until salarybuffer.Next = 0;
                        end;
                        Posted := true;
                        "Posted By" := UserId;
                        Message('Process Completed Successfully. Account Holders will receive Salary processing notification via SMS');
                        Window.Close;
                    end;
                }
                action(Journals)
                {
                    ApplicationArea = Basic;
                    Caption = 'General Journal';
                    Image = Journals;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    RunObject = Page "General Journal";
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ObjVendorLedger.Reset;
        ObjVendorLedger.SetRange(ObjVendorLedger."Document No.", "Document No");
        ObjVendorLedger.SetRange("External Document No.", "Cheque No.");
        if ObjVendorLedger.Find('-') then
            ActionEnabled := true;
    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        iEntryNo: Integer;
        RunBal: Decimal;
        ObjSalaryLines: Record "Salary Processing Lines";
        ReceiptsProcessingLines: Record "Checkoff Lines-Distributed";
        SMSMessages: Record "SMS Messages";
        varLRepayment: Decimal;
        LineNo: Integer;
        PRpayment: Decimal;
        varMultipleLoan: Decimal;
        varTotalRepay: Decimal;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        SACCOGEN: Record "Sacco General Set-Up";
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Checkoff Header-Distributed";
        Cust: Record Customer;
        salarybuffer: Record "Salary Processing Lines";
        SalHeader: Record "Salary Processing Headerr";
        Sto: Record "Standing Orders";
        ELoanBuffer: Record "E-Loan Salary Buffer";
        ObjVendor: Record Vendor;
        MembLedg: Record "Cust. Ledger Entry";
        SFactory: Codeunit "SURESTEP Factory.";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        GenJournalLine: Record "Gen. Journal Line";
        ActionEnabled: Boolean;
        ObjVendorLedger: Record "Vendor Ledger Entry";
        ObjGenSetup: Record "Sacco General Set-Up";
        Charges: Record Charges;
        SalProcessingFee: Decimal;
        LoanApp: Record "Loans Register";
        Datefilter: Text;
        DedStatus: Option Successfull,"Partial Deduction",Failed;
        ObjSTORegister: Record "Standing Order Register";
        ObjLoanProducts: Record "Loan Products Setup";
        Window: Dialog;
        TotalCount: Integer;
        Counter: Integer;
        Percentage: Integer;
        EXTERNAL_DOC_NO: Code[40];
        SMSCODE: Code[30];
        enddate: Date;

    local procedure FnPostSalaryToFosa(ObjSalaryLines: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", "Posting date", ObjSalaryLines.Amount * -1, 'FOSA', EXTERNAL_DOC_NO, Format("Transaction Type"), '');
        exit(RunningBalance);

        /////////////savings
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
        GenJournalLine."account type"::Member, ObjSalaryLines."BOSA No", "Posting date", 2000, 'BOSA', EXTERNAL_DOC_NO, Format("Transaction Type"), '');
        exit(RunningBalance);
    end;

    local procedure FnRecoverStatutories(ObjSalaryLines: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        ObjGenSetup.Get();
        if Charges.Get('14') then begin
            if "Transaction Type" = "transaction type"::"Salary Processing" then begin
                //---------EARN-------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", Charges."GL Account", "Posting date", Charges."Charge Amount" * -1, 'FOSA', EXTERNAL_DOC_NO,
                Format("Transaction Type") + ' Fee', '');
                //-----------RECOVER--------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", "Posting date", Charges."Charge Amount", 'FOSA', EXTERNAL_DOC_NO,
                'Processing Fee', '');
                //------------EARN EXCISE DUTY-------------------------------
                SalProcessingFee := Charges."Charge Amount";
                RunningBalance := RunningBalance - SalProcessingFee;
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", ObjGenSetup."Excise Duty Account", "Posting date", Charges."Charge Amount" * -0.2, 'FOSA', EXTERNAL_DOC_NO,
                Format("Transaction Type"), '');
                //--------------RECOVER------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", "Posting date", Charges."Charge Amount" * 0.2, 'FOSA', EXTERNAL_DOC_NO,
                '20% Excise Duty on ' + Format("Transaction Type"), '');
                RunningBalance := RunningBalance - SalProcessingFee * 0.2;
                // MESSAGE(FORMAT(ObjSalaryLines."BOSA No"));
                //---------EARN-------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::Member, salarybuffer."Staff No.", "Posting date", 2000 * -1, 'BOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."Transaction Type") + ' Savings', '');
                //-----------RECOVER--------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", "Posting date", 2000, 'FOSA', EXTERNAL_DOC_NO,
                'Bosa Savings', '');
                ///////////////////////////LOANS
                if RunningBalance > 0 then begin
                    varTotalRepay := 0;
                    varMultipleLoan := 0;
                    LoanApp.Reset;
                    LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
                    LoanApp.SetRange(LoanApp."Client Code", ObjSalaryLines."Staff No.");//Account No for FOSA Loans

                    //LoanApp.SETFILTER(LoanApp."Date filter",Datefilter);
                    LoanApp.SetFilter(Source, Format(LoanApp.Source::BOSA));

                    if LoanApp.Find('-') then begin
                        repeat
                            // MESSAGE('am here');
                            if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin
                                if ObjLoanProducts."Recovery Method" = ObjLoanProducts."recovery method"::"Salary " then begin
                                    //MESSAGE('run balance is %1',RunningBalance);
                                    if RunningBalance > 0 then begin
                                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                                        if LoanApp."Outstanding Balance" > 0 then begin
                                            varLRepayment := 0;
                                            PRpayment := 0;
                                            varLRepayment := LoanApp."Loan Principle Repayment";
                                            /* IF LoanApp."Loan Product Type"='GUR' THEN
                                               varLRepayment:=LoanApp.Repayment;*/
                                            if varLRepayment > 0 then begin
                                                if varLRepayment > LoanApp."Outstanding Balance" then
                                                    varLRepayment := LoanApp."Outstanding Balance";

                                                if RunningBalance > 0 then begin
                                                    if RunningBalance > varLRepayment then begin
                                                        AmountToDeduct := varLRepayment;
                                                    end
                                                    else
                                                        AmountToDeduct := RunningBalance;
                                                end;

                                                // MESSAGE('loan no is %1',LoanApp."Loan  No.");
                                                //-------------PAY------------------
                                                LineNo := LineNo + 10000;
                                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                                GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                                Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");
                                                //-------------RECOVER---------------
                                                LineNo := LineNo + 10000;
                                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                                GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", "Posting date", AmountToDeduct, Format(LoanApp.Source), LoanApp."Loan  No.",
                                                Format(GenJournalLine."transaction type"::"Loan Repayment") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.");
                                                RunningBalance := RunningBalance - AmountToDeduct;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        until LoanApp.Next = 0;
                    end;
                    exit(RunningBalance);
                end;

                ///////LOANS
                // MESSAGE(FORMAT(ObjSalaryLines."Staff No."));
            end;
        end;

        if Charges.Get('13') then begin
            if "Transaction Type" = "transaction type"::"Salary Processing" then begin
                //--------------EARN----------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", Charges."GL Account", "Posting date", Charges."Charge Amount" * -1, 'FOSA', EXTERNAL_DOC_NO,
                Format("Transaction Type"), '');
                //--------------RECOVER------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjSalaryLines."Account No.", "Posting date", Charges."Charge Amount", 'FOSA', EXTERNAL_DOC_NO,
                Charges.Description, '');
                RunningBalance := RunningBalance - Charges."Charge Amount";
            end;
        end;
        exit(RunningBalance);
        /////////////////SAVINGS
        if SACCOGEN.Get() then
            //---------EARN-------------------------
            LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
        GenJournalLine."account type"::Member, salarybuffer."Staff No.", "Posting date", 2000, 'BOSA', EXTERNAL_DOC_NO,
        Format(GenJournalLine."Transaction Type") + ' Savings', '');
        //-----------RECOVER--------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
        GenJournalLine."account type"::Member, ObjSalaryLines."Staff No.", "Posting date", 2000, 'BOSA', EXTERNAL_DOC_NO,
        'SAVINGS', '');
        Message(Format(ObjSalaryLines."Staff No."));

    end;

    local procedure FnRecoverMobileLoanInterest(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            LoanApp.SetFilter("Loan Product Type", 'MSADV');
            LoanApp.SetFilter(Posted, 'Yes');
            if LoanApp.Find('-') then begin
                repeat
                    LoanApp.CalcFields(LoanApp."Oustanding Interest");
                    LoanApp.CalcFields(LoanApp."Outstanding Balance");
                    // IF (SFactory.FnGetInterestDueFiltered(LoanApp,Datefilter)-ABS(LoanApp."Oustanding Interest"))>0 THEN
                    if LoanApp."Outstanding Balance" > 0 then begin
                        if RunningBalance > 0 then begin
                            AmountToDeduct := 0;
                            AmountToDeduct := LoanApp."Loan Interest Repayment";//SFactory.FnGetInterestDueFiltered(LoanApp,Datefilter)-ABS(LoanApp."Oustanding Interest");
                            if RunningBalance <= AmountToDeduct then
                                AmountToDeduct := RunningBalance;
                            //-------------PAY----------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                            GenJournalLine."account type"::Employee, ObjRcptBuffer."Account No.", "Posting date", AmountToDeduct * -1, 'FOSA', EXTERNAL_DOC_NO,
                            Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.");
                            //-------------RECOVER------------------------
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", "Posting date", AmountToDeduct, 'FOSA', LoanApp."Loan  No.",
                            Format(GenJournalLine."transaction type"::"Interest Paid") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.");

                            RunningBalance := RunningBalance - AmountToDeduct;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRecoverMobileLoanPrincipal(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        varLRepayment: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            LoanApp.SetFilter("Loan Product Type", 'MSADV');
            LoanApp.SetFilter(Posted, 'Yes');
            if LoanApp.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            varLRepayment := 0;
                            varLRepayment := LoanApp."Loan Principle Repayment";
                            if LoanApp."Loan Product Type" = 'GUR' then
                                varLRepayment := LoanApp.Repayment;
                            if varLRepayment > 0 then begin
                                if varLRepayment > LoanApp."Outstanding Balance" then
                                    varLRepayment := LoanApp."Outstanding Balance";

                                if RunningBalance > 0 then begin
                                    if RunningBalance > varLRepayment then begin
                                        AmountToDeduct := varLRepayment;
                                    end
                                    else
                                        AmountToDeduct := RunningBalance;
                                end;
                                //---------------------PAY-------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                GenJournalLine."account type"::Employee, ObjRcptBuffer."Account No.", "Posting date", AmountToDeduct * -1, 'FOSA', EXTERNAL_DOC_NO,
                                Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");
                                //--------------------RECOVER-----------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", "Posting date", AmountToDeduct, 'FOSA', LoanApp."Loan  No.",
                                Format(GenJournalLine."transaction type"::"Loan Repayment") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.");
                                RunningBalance := RunningBalance - AmountToDeduct;
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunInterest(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Account No.");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::FOSA));
            if LoanApp.Find('-') then begin
                repeat
                    if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin
                        if ObjLoanProducts."Recovery Method" = ObjLoanProducts."recovery method"::"Salary " then begin
                            LoanApp.CalcFields(LoanApp."Oustanding Interest");
                            LoanApp.CalcFields(LoanApp."Outstanding Balance");
                            //IF (SFactory.FnGetInterestDueFiltered(LoanApp,Datefilter)-ABS(LoanApp."Oustanding Interest"))>0 THEN
                            if LoanApp."Outstanding Balance" > 0 then begin
                                if RunningBalance > 0 then begin
                                    AmountToDeduct := 0;
                                    AmountToDeduct := 2000;//SFactory.FnGetInterestDueFiltered(LoanApp,Datefilter)-ABS(LoanApp."Oustanding Interest");
                                    if RunningBalance <= AmountToDeduct then
                                        AmountToDeduct := RunningBalance;
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                    GenJournalLine."account type"::Employee, ObjRcptBuffer."Account No.", "Posting date", AmountToDeduct * -1, Format('FOSA'), EXTERNAL_DOC_NO,
                                    Format(GenJournalLine."transaction type"::"Deposit Contribution"), "Document No");

                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", "Posting date", AmountToDeduct, Format('FOSA'), LoanApp."Loan  No.",
                                    Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoanApp."Loan Product Type", "Document No");
                                    RunningBalance := RunningBalance - AmountToDeduct;
                                end;
                            end;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunPrinciple(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Account No", ObjRcptBuffer."Account No.");//Account No for FOSA Loans

            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            //LoanApp.SETFILTER(Source,FORMAT(LoanApp.Source::FOSA));

            if LoanApp.Find('-') then begin
                repeat
                    // MESSAGE('am here');
                    if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin
                        //IF ObjLoanProducts."Recovery Method"=ObjLoanProducts."Recovery Method"::"Salary " THEN
                        // BEGIN
                        //MESSAGE('run balance is %1',RunningBalance);
                        if RunningBalance > 0 then begin
                            LoanApp.CalcFields(LoanApp."Outstanding Balance");
                            if LoanApp."Outstanding Balance" > 0 then begin
                                varLRepayment := 0;
                                PRpayment := 0;
                                varLRepayment := LoanApp."Loan Principle Repayment";
                                /* IF LoanApp."Loan Product Type"='GUR' THEN
                                   varLRepayment:=LoanApp.Repayment;*/
                                if varLRepayment > 0 then begin
                                    if varLRepayment > LoanApp."Outstanding Balance" then
                                        varLRepayment := LoanApp."Outstanding Balance";

                                    if RunningBalance > 0 then begin
                                        if RunningBalance > varLRepayment then begin
                                            AmountToDeduct := varLRepayment;
                                        end
                                        else
                                            AmountToDeduct := RunningBalance;
                                    end;

                                    // MESSAGE('loan no is %1',LoanApp."Loan  No.");
                                    //-------------PAY------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                    GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                    Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");
                                    //-------------RECOVER---------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", "Posting date", AmountToDeduct, Format(LoanApp.Source), LoanApp."Loan  No.",
                                    Format(GenJournalLine."transaction type"::"Loan Repayment") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.");
                                    RunningBalance := RunningBalance - AmountToDeduct;
                                end;
                            end;
                        end;
                    end;
                //END;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;

    end;

    local procedure FnRunStandingOrders(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjStandingOrders: Record "Standing Orders";
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            ObjStandingOrders.Reset;
            ObjStandingOrders.SetCurrentkey("No.", "Source Account No.");
            ObjStandingOrders.SetRange("Source Account No.", ObjRcptBuffer."Account No.");
            ObjStandingOrders.SetRange(Status, ObjStandingOrders.Status::Approved);
            //ObjStandingOrders.SETRANGE("Is Active",TRUE);
            ObjStandingOrders.SetRange("Standing Order Type", ObjStandingOrders."standing order type"::Salary);
            if ObjStandingOrders.Find('-') then begin
                enddate := CalcDate('+1M', ObjStandingOrders."End Date");
                if enddate >= Today then begin
                    repeat
                        if RunningBalance > 0 then begin
                            if ObjStandingOrders."Next Run Date" = 0D then
                                ObjStandingOrders."Next Run Date" := ObjStandingOrders."Effective/Start Date";

                            //ObjStandingOrders.CALCFIELDS("Allocated Amount");
                            if RunningBalance >= ObjStandingOrders.Amount then begin
                                AmountToDeduct := ObjStandingOrders.Amount;
                                DedStatus := Dedstatus::Successfull;
                                if AmountToDeduct >= ObjStandingOrders.Balance then begin
                                    AmountToDeduct := ObjStandingOrders.Balance;
                                    ObjStandingOrders.Balance := 0;
                                    ObjStandingOrders."Next Run Date" := CalcDate(ObjStandingOrders.Frequency, ObjStandingOrders."Next Run Date");
                                    ObjStandingOrders.Unsuccessfull := false;
                                end
                                else begin
                                    ObjStandingOrders.Balance := ObjStandingOrders.Balance - AmountToDeduct;
                                    ObjStandingOrders.Unsuccessfull := true;
                                end;
                            end
                            else begin
                                if ObjStandingOrders."Don't Allow Partial Deduction" = true then begin
                                    AmountToDeduct := 0;
                                    DedStatus := Dedstatus::Failed;
                                    ObjStandingOrders.Balance := ObjStandingOrders.Amount;
                                    ObjStandingOrders.Unsuccessfull := true;
                                end
                                else begin
                                    DedStatus := Dedstatus::"Partial Deduction";
                                    ObjStandingOrders.Balance := ObjStandingOrders.Amount - AmountToDeduct;
                                    ObjStandingOrders.Unsuccessfull := true;
                                end;
                            end;



                            if ObjStandingOrders."Destination Account Type" <> ObjStandingOrders."destination account type"::BOSA then
                                RunningBalance := FnNonBosaStandingOrderTransaction(ObjStandingOrders, RunningBalance)
                            else begin
                                RunningBalance := FnBosaStandingOrderTransaction(ObjStandingOrders, RunningBalance)
                            end;


                            ObjStandingOrders.Effected := true;
                            ObjStandingOrders."Date Reset" := Today;
                            ObjStandingOrders."Next Run Date" := CalcDate('-1D', CalcDate('1M', Dmy2date(1, Date2dmy(CalcDate(ObjStandingOrders.Frequency, Today), 2), Date2dmy(CalcDate(ObjStandingOrders.Frequency, Today), 3))));
                            ObjStandingOrders.Modify;

                            FnRegisterProcessedStandingOrder(ObjStandingOrders, AmountToDeduct);
                        end;
                    until ObjStandingOrders.Next = 0;
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnCheckIfStandingOrderIsRunnable(ObjStandingOrders: Record "Standing Orders") DontEffect: Boolean
    begin
        DontEffect := false;

        if ObjStandingOrders."Effective/Start Date" <> 0D then begin
            if ObjStandingOrders."Effective/Start Date" > Today then begin
                if Date2dmy(Today, 2) <> Date2dmy(ObjStandingOrders."Effective/Start Date", 2) then
                    DontEffect := true;
            end;
        end;
        exit(DontEffect);
    end;

    local procedure FnNonBosaStandingOrderTransaction(ObjRcptBuffer: Record "Standing Orders"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjStandingOrders: Record "Standing Orders";
    begin
        if RunningBalance > 0 then begin
            //-------------RECOVER-----------------------------------------------------------------------------------------------------------------------
            if ObjVendor.Get(ObjRcptBuffer."Destination Account No.") then begin
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", "Posting date", ObjRcptBuffer.Amount, 'FOSA', ObjRcptBuffer."No.",
                'Standing Order to ' + ObjVendor.Name, '');
            end;
            //-------------PAY----------------------------------------------------------------------------------------------------------------------------
            if ObjVendor.Get(ObjRcptBuffer."Source Account No.") then begin
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Destination Account No.", "Posting date", ObjRcptBuffer.Amount * -1, 'FOSA', ObjRcptBuffer."No.",
                'Standing Order From ' + ObjVendor.Name, '');
                RunningBalance := RunningBalance - ObjRcptBuffer.Amount;
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnBosaStandingOrderTransaction(ObjRcptBuffer: Record "Standing Orders"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ObjStandingOrders: Record "Standing Orders";
    begin
        if RunningBalance > 0 then begin
            ObjReceiptTransactions.Reset;
            ObjReceiptTransactions.SetRange("Document No", ObjRcptBuffer."No.");
            if ObjReceiptTransactions.Find('-') then begin
                //ObjReceiptTransactions.CALCFIELDS("Interest Amount");
                repeat
                    if ObjReceiptTransactions."Transaction Type" = ObjReceiptTransactions."transaction type"::"Loan Repayment" then begin
                        //-------------RECOVER principal-----------------------
                        if LoanApp.Get(ObjReceiptTransactions."Loan No.") then begin
                            LineNo := LineNo + 10000;
                            LoanApp.CalcFields("Outstanding Balance");
                            if LoanApp."Outstanding Balance" > 0 then begin
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                GenJournalLine."account type"::Employee, LoanApp."Client Code", "Posting date", (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount") * -1,
                                'FOSA', ObjRcptBuffer."No.", Format(GenJournalLine."transaction type"::"Loan Repayment"), ObjReceiptTransactions."Loan No.");

                                //-------------PAY Principal----------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", "Posting date",
                                ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount", 'FOSA', ObjRcptBuffer."No.",
                                Format(GenJournalLine."transaction type"::"Loan Repayment") + '-' + LoanApp."Loan Product Type", ObjReceiptTransactions."Loan No.");

                                RunningBalance := RunningBalance - (ObjReceiptTransactions.Amount - ObjReceiptTransactions."Interest Amount");

                                //-------------RECOVER Interest-----------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                GenJournalLine."account type"::Employee, LoanApp."Client Code", "Posting date", ObjReceiptTransactions."Interest Amount" * -1,
                                'FOSA', ObjRcptBuffer."No.", Format(GenJournalLine."transaction type"::"Interest Paid"), ObjReceiptTransactions."Loan No.");

                                //-------------PAY Interest----------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", "Posting date",
                                ObjReceiptTransactions."Interest Amount", 'FOSA', ObjRcptBuffer."No.",
                                Format(GenJournalLine."transaction type"::"Interest Paid") + '-' + LoanApp."Loan Product Type", ObjReceiptTransactions."Loan No.");

                                RunningBalance := RunningBalance - ObjReceiptTransactions."Interest Amount";
                            end;
                        end;

                    end
                    else begin
                        //-------------RECOVER BOSA NONLoan Transactions-----------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."Transaction Type",
                        GenJournalLine."account type"::Employee, ObjRcptBuffer."BOSA Account No.", "Posting date", ObjReceiptTransactions.Amount * -1,
                        'FOSA', ObjRcptBuffer."No.", Format(ObjReceiptTransactions."Transaction Type"), '');

                        //-------------PAY BOSA NONLoan Transaction----------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, ObjReceiptTransactions."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, ObjRcptBuffer."Source Account No.", "Posting date", ObjReceiptTransactions.Amount,
                        'FOSA', ObjRcptBuffer."No.", Format(ObjReceiptTransactions."Transaction Type"), '');

                        RunningBalance := RunningBalance - ObjReceiptTransactions.Amount;

                    end

                until ObjReceiptTransactions.Next = 0;
            end;

            exit(RunningBalance);
        end;
    end;

    local procedure FnRegisterProcessedStandingOrder(ObjStandingOrders: Record "Standing Orders"; AmountToDeduct: Decimal)
    begin
        ObjSTORegister.Reset;
        ObjSTORegister.SetRange("Document No.", No);
        if ObjSTORegister.Find('-') then
            ObjSTORegister.DeleteAll;

        ObjSTORegister.Init;
        ObjSTORegister."Register No." := '';
        ObjSTORegister.Validate(ObjSTORegister."Register No.");
        ObjSTORegister."Standing Order No." := ObjStandingOrders."No.";
        ObjSTORegister."Source Account No." := ObjStandingOrders."Source Account No.";
        ObjSTORegister."Staff/Payroll No." := ObjStandingOrders."Staff/Payroll No.";
        ObjSTORegister.Date := Today;
        ObjSTORegister."Account Name" := ObjStandingOrders."Account Name";
        ObjSTORegister."Destination Account Type" := ObjStandingOrders."Destination Account Type";
        ObjSTORegister."Destination Account No." := ObjStandingOrders."Destination Account No.";
        ObjSTORegister."Destination Account Name" := ObjStandingOrders."Destination Account Name";
        ObjSTORegister."BOSA Account No." := ObjStandingOrders."BOSA Account No.";
        ObjSTORegister."Effective/Start Date" := ObjStandingOrders."Effective/Start Date";
        ObjSTORegister."End Date" := ObjStandingOrders."End Date";
        ObjSTORegister.Duration := ObjStandingOrders.Duration;
        ObjSTORegister.Frequency := ObjStandingOrders.Frequency;
        ObjSTORegister."Don't Allow Partial Deduction" := ObjStandingOrders."Don't Allow Partial Deduction";
        ObjSTORegister."Deduction Status" := DedStatus;
        ObjSTORegister.Remarks := ObjStandingOrders."Standing Order Description";
        ObjSTORegister.Amount := ObjStandingOrders.Amount;
        ObjSTORegister."Amount Deducted" := AmountToDeduct;
        if ObjStandingOrders."Destination Account Type" = ObjStandingOrders."destination account type"::External then
            ObjSTORegister.EFT := true;
        ObjSTORegister."Document No." := No;
        ObjSTORegister.Insert(true);
    end;

    local procedure FnSalaryProcessing()
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'SALARIES';
        DOCUMENT_NO := "Document No";
        EXTERNAL_DOC_NO := "Cheque No.";
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;
        ObjGenSetup.Get();
        salarybuffer.Reset;
        salarybuffer.SetRange("Salary Header No.", No);

        if salarybuffer.Find('-') then begin
            Window.Open(Format("Transaction Type") + ': @1@@@@@@@@@@@@@@@' + 'Record:#2###############');
            TotalCount := salarybuffer.Count;
            repeat
                Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                Counter := Counter + 1;
                Window.Update(1, Percentage);
                Window.Update(2, Counter);

                RunBal := salarybuffer.Amount;
                RunBal := FnPostSalaryToFosa(salarybuffer, RunBal);
                RunBal := FnRecoverStatutories(salarybuffer, RunBal);
                RunBal := FnRecoverMobileLoanInterest(salarybuffer, RunBal);
                RunBal := FnRunInterest(salarybuffer, RunBal);
                RunBal := FnRecoverMobileLoanPrincipal(salarybuffer, RunBal);
                RunBal := FnRunPrinciple(salarybuffer, RunBal);
                //  RunBal:=FnRunPrincipleBOSA(salarybuffer,RunBal);

                FnRunStandingOrders(salarybuffer, RunBal);

            until salarybuffer.Next = 0;
        end;
        //Balancing Journal Entry
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        "Account Type", "Account No", "Posting date", Amount, 'FOSA', EXTERNAL_DOC_NO, DOCUMENT_NO, '');
        Message('Salary journals Successfully Generated. BATCH NO=SALARIES.');
        Window.Close;
    end;

    local procedure FnNISProcessing()
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'SALARIES';
        DOCUMENT_NO := "Document No";
        EXTERNAL_DOC_NO := "Cheque No.";
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;
        ObjGenSetup.Get();
        salarybuffer.Reset;
        salarybuffer.SetRange("Salary Header No.", No);
        //salarybuffer.SETRANGE("Account No.",'2747-01616-06');
        if salarybuffer.Find('-') then begin
            Window.Open(Format("Transaction Type") + ': @1@@@@@@@@@@@@@@@' + 'Record:#2###############');
            TotalCount := salarybuffer.Count;
            repeat
                Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                Counter := Counter + 1;
                Window.Update(1, Percentage);
                Window.Update(2, Counter);

                RunBal := salarybuffer.Amount;
                RunBal := FnPostSalaryToFosa(salarybuffer, RunBal);
                RunBal := FnRecoverStatutories(salarybuffer, RunBal);
            // RunBal:=FnRecoverSavings(salarybuffer,RunBal);
            until salarybuffer.Next = 0;
        end;
        //Balancing Journal Entry
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        "Account Type", "Account No", "Posting date", Amount, 'FOSA', EXTERNAL_DOC_NO, DOCUMENT_NO, '');
        Message('Journals Successfully Generated. BATCH NO=SALARIES.');
        if ObjSalaryLines.Get("Account No") then begin
            ObjSalaryLines.Reset;
            ObjSalaryLines.SetRange(ObjSalaryLines."Account No.", "Account No");
            if Confirm('Do you want to notify Employee?', false, true) then
                //Steve guarantor SMS
                SMSMessages.Reset;
            if SMSMessages.Find('+') then begin
                iEntryNo := SMSMessages."Entry No";
                iEntryNo := iEntryNo + 1;
            end
            else begin
                iEntryNo := 1;
            end;

            SMSMessages.Init;
            SMSMessages."Entry No" := iEntryNo;
            SMSMessages."Account No" := "Account No";
            SMSMessages."Date Entered" := Today;
            SMSMessages."Time Entered" := Time;
            SMSMessages.Source := 'SALARIES';
            SMSMessages."Entered By" := UserId;
            SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
            SMSMessages."SMS Message" := 'Credit Note: Dear '
                    + "Account Name" + ' kindly note that Your Salary has been Credited to your FOSA Account. You can Access it through our Mobile Banking platform(*850#)';

            //IF LoanApp.GET(Lguarantors//."Loan No") THEN
            SMSMessages."Telephone No" := ObjSalaryLines."Mobile Phone Number";
            SMSMessages.Insert;

        end;

        Window.Close;
    end;

    local procedure FnRunPrincipleBOSA(ObjRcptBuffer: Record "Salary Processing Lines"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Account No", ObjRcptBuffer."Staff No.");

            //LoanApp.SETFILTER(LoanApp."Date filter",Datefilter);
            LoanApp.SetFilter(Source, Format(LoanApp.Source::BOSA));

            if LoanApp.Find('-') then begin
                repeat
                    // MESSAGE('am here');
                    if ObjLoanProducts.Get(LoanApp."Loan Product Type") then begin
                        // IF ObjLoanProducts."Recovery Method"=ObjLoanProducts."Recovery Method"::"Salary " THEN
                        // BEGIN
                        //MESSAGE('run balance is %1',RunningBalance);
                        if RunningBalance > 0 then begin
                            LoanApp.CalcFields(LoanApp."Outstanding Balance");
                            if LoanApp."Outstanding Balance" > 0 then begin
                                varLRepayment := 0;
                                PRpayment := 0;
                                varLRepayment := LoanApp."Loan Principle Repayment";
                                /* IF LoanApp."Loan Product Type"='GUR' THEN
                                   varLRepayment:=LoanApp.Repayment;*/
                                if varLRepayment > 0 then begin
                                    if varLRepayment > LoanApp."Outstanding Balance" then
                                        varLRepayment := LoanApp."Outstanding Balance";

                                    if RunningBalance > 0 then begin
                                        if RunningBalance > varLRepayment then begin
                                            AmountToDeduct := varLRepayment;
                                        end
                                        else
                                            AmountToDeduct := RunningBalance;
                                    end;

                                    // MESSAGE('loan no is %1',LoanApp."Loan  No.");
                                    //-------------PAY------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                    GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                    Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");
                                    //-------------RECOVER---------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, ObjRcptBuffer."Account No.", "Posting date", AmountToDeduct, Format(LoanApp.Source), LoanApp."Loan  No.",
                                    Format(GenJournalLine."transaction type"::"Loan Repayment") + '-' + LoanApp."Loan Product Type", LoanApp."Loan  No.");
                                    RunningBalance := RunningBalance - AmountToDeduct;
                                end;
                            end;
                        end;
                    end;
                //END;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;

    end;

    local procedure FnRecoverSavings(Gensetup: Record "Sacco General Set-Up")
    begin
    end;
}

