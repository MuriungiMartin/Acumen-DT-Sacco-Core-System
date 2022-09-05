#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516409 "Membership Exit Card"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption';
    SourceTable = "Membership Exit";
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No."; "Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = MNoEditable;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closing Date"; "Closing Date")
                {
                    ApplicationArea = Basic;
                    Editable = ClosingDateEditable;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment Date';
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Date Approved"; "Date Approved")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Posting Date"; "Expected Posting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Payment Date';
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closure Type"; "Closure Type")
                {
                    ApplicationArea = Basic;
                    Editable = ClosureTypeEditable;
                }
                field("Sell Share Capital"; "Sell Share Capital")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ShareCapitalTransferVisible := false;
                        ShareCapSellPageVisible := false;
                        if "Sell Share Capital" = true then begin
                            ShareCapitalTransferVisible := true;
                            ShareCapSellPageVisible := true;
                        end;
                    end;
                }
                field("Total Loan"; "Total Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Loan BOSA';
                    Editable = false;
                }
                field("Total Interest"; "Total Interest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Interest Due BOSA';
                    Editable = false;
                }
                field("Total Loans FOSA"; "Total Loans FOSA")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Oustanding Int FOSA"; "Total Oustanding Int FOSA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Interest Due FOSA';
                    Editable = false;
                }
                field("Member Deposits"; "Member Deposits")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Share Capital"; "Share Capital")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Refundable Share Capital"; "Refundable Share Capital")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Share Capital to Sell"; "Share Capital to Sell")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Risk Fund"; "Risk Fund")
                {
                    ApplicationArea = Basic;
                    Caption = 'Net Refund';
                    Editable = false;
                    Visible = false;
                }
                field("Risk Fund Arrears"; "Risk Fund Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Risk Beneficiary"; "Risk Beneficiary")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Mode Of Disbursement"; "Mode Of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Paying Bank"; "Paying Bank")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("FOSA Account No."; "FOSA Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("cheque Date"; "cheque Date")
                {
                    ApplicationArea = Basic;
                }
                field("Bank AccNo"; "Bank AccNo")
                {
                    ApplicationArea = Basic;
                }
                field(Payee; Payee)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
            }
            group("Share Capital Transfer Details")
            {
                Caption = 'Share Capital Transfer Details';
                Visible = ShareCapitalTransferVisible;
                field("Share Capital Transfer Fee"; "Share Capital Transfer Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("Share Capital Sell"; "M_Withdrawal Share Cap Sell")
            {
                SubPageLink = "Document No" = field("No."),
                              "Selling Member No" = field("Member No."),
                              "Selling Member Name" = field("Member Name");
                Visible = ShareCapSellPageVisible;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        TestField(Posted, false);
                        //TESTFIELD(Status,Status::Approved);
                        if Confirm('Are you absolutely sure you want to recover the loans from member deposit') = false then
                            exit;
                        WithdrawalFee := 0;
                        TransferFee := 0;
                        RunningBal := 0;


                        if cust.Get("Member No.") then begin
                            if "Net Payable to the Member" < 0 then
                                // ERROR('The Member Does have enough Deposits to Clear Loans');

                                //-----------------------------------------Assign Standard variables-------------------------------------------------------------
                                DActivity := cust."Global Dimension 1 Code";
                            DBranch := cust."Global Dimension 2 Code";
                            TemplateName := 'GENERAL';
                            BatchName := 'CLOSURE';
                            Doc_No := "No.";

                            Generalsetup.Get();
                            WithdrawalFee := Generalsetup."Withdrawal Fee" / 100;
                            WithFeeGL := Generalsetup."Withdrawal Fee Account";
                            ExciseGL := Generalsetup."Excise Duty Account";
                            if "Sell Share Capital" then begin
                                TransferFee := Generalsetup."Share Capital Transfer Fee";
                                TransferGL := Generalsetup."Share Capital Transfer Fee Acc";
                            end;

                            //------------------------------------------Assign Standard variables-----------------------------------------------------------------

                            //------------------------------------------Delete Journal Lines----------------------------------------------------------------------
                            Gnljnline.Reset;
                            Gnljnline.SetRange("Journal Template Name", TemplateName);
                            Gnljnline.SetRange("Journal Batch Name", BatchName);
                            Gnljnline.DeleteAll;
                            //------------------------------------------Post Transaction---------------------------------------------------------------------------
                            if ("Closure Type" = "closure type"::"Withdrawal - Normal") or ("Closure Type" = "closure type"::"Withdrawal - Death(Defaulter)") then begin
                                FnDebitMemberDepositsAndShareCapital("Member Deposits", "Refundable Share Capital");
                                RunningBal := "Member Deposits";
                                FnTransferToCurrentAccount(RunningBal);
                                FnTransferToBankAcc(RunningBal);
                                RunningBal := FnRecoverBOSAInterest(RunningBal);
                                RunningBal := FnRecoverFOSAInterest(RunningBal);
                                RunningBal := FnRecoverBOSALoanPrinciple(RunningBal);
                                RunningBal := FnRecoverFOSALoanPrinciple(RunningBal);
                                // RunningBal:=FnPostWithdrawalFee(RunningBal);
                                RunningBal := FnPostExciseDuty(RunningBal);
                                //----------------------------------------Post Transaction----------------------------------------------------------------------------
                            end else
                                if ("Closure Type" = "closure type"::"Withdrawal - Death") then begin
                                    RunningBal := "Member Deposits";
                                    FnDebitMemberDepositsAndShareCapital("Member Deposits", "Refundable Share Capital");
                                end;
                        end;


                        //FNPostShareCapTransfer();

                        if cust.Get("Member No.") then begin
                            cust.Blocked := cust.Blocked::" ";
                            cust.Modify;
                        end;


                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'CLOSURE');
                        if GenJournalLine.Find('-') then begin
                            // CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch",GenJournalLine);
                        end;


                        "Closing Date" := Today;
                        //Posted:=TRUE;
                        "Ready to Exit" := true;
                        Message('Closure posted successfully.');


                        //CHANGE ACCOUNT STATUS
                        // // IF ("Closure Type"="Closure Type"::"Withdrawal - Death" ) OR ("Closure Type"="Closure Type"::"Withdrawal - Death(Defaulter)") THEN BEGIN
                        // // cust.RESET;
                        // // cust.SETRANGE(cust."No.","Member No.");
                        // // IF cust.FIND('-') THEN BEGIN
                        // // cust.Status:=cust.Status::Deceased;
                        // // cust.Blocked:=cust.Blocked::All;
                        // // cust.MODIFY;
                        // // END;
                        // // END ELSE
                        // // cust.RESET;
                        // // cust.SETRANGE(cust."No.","Member No.");
                        // // IF cust.FIND('-') THEN BEGIN
                        // // cust.Status:=cust.Status::Withdrawal;
                        // // cust."Closing Date":=TODAY;
                        // // cust.Blocked:=cust.Blocked::All;
                        // // cust.MODIFY;
                        // // END;


                        CurrPage.Close();
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        ApprovalsMgmt: Codeunit WorkflowIntegration;
                    begin
                        //TESTFIELD("FOSA Account No.");
                        if Status <> Status::Open then
                            Error(text001);

                        if ApprovalsMgmt.CheckMWithdrawalApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendMWithdrawalForApproval(Rec);

                        //Change Status To Awaiting Withdrawing
                        MemberRegister.Reset;
                        MemberRegister.SetRange(MemberRegister."No.", "Member No.");
                        if MemberRegister.Find('-') then begin
                            MemberRegister.Status := MemberRegister.Status::"Awaiting Withdrawal";
                            MemberRegister.Modify;
                        end;

                        GenSetUp.Get();

                        if Generalsetup."Send Membership Withdrawal SMS" = true then begin
                            FnSendWithdrawalApplicationSMS();
                        end;
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel A&pproval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        ApprovalMgt: Codeunit WorkflowIntegration;
                    begin
                        if ApprovalsMgmt.CheckMWithdrawalApprovalsWorkflowEnabled(Rec) then
                            ApprovalMgt.OnCancelMWithdrawalApprovalRequest(Rec);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(RecordId);
                    end;
                }
                action("Account closure Slip")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        cust.Reset;
                        cust.SetRange(cust."No.", "Member No.");
                        if cust.Find('-') then
                            Report.Run(51516474, true, false, cust);
                    end;
                }
                action("Print Cheque")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*
                        ClosureR.RESET;
                        ClosureR.SETRANGE(ClosureR."Member No.","Member No.");
                        IF ClosureR.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,ClosureR);
                        */

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        ShareCapitalTransferVisible := false;
        ShareCapSellPageVisible := false;
        if "Sell Share Capital" = true then begin
            ShareCapitalTransferVisible := true;
            ShareCapSellPageVisible := true;
        end;
        //"Mode Of Disbursement":="Mode Of Disbursement"::Vendor;
        //MODIFY;
        UpdateControl();
    end;

    trigger OnOpenPage()
    begin
        ShareCapitalTransferVisible := false;
        ShareCapSellPageVisible := false;
        PostingDateEditable := false;
        if "Sell Share Capital" = true then begin
            ShareCapitalTransferVisible := true;
            ShareCapSellPageVisible := true;
        end;
        "Mode Of Disbursement" := "mode of disbursement"::Vendor;
        UpdateControl();
    end;

    var
        Closure: Integer;
        Text001: label 'Not Approved';
        cust: Record Customer;
        UBFRefund: Decimal;
        Generalsetup: Record "Sacco General Set-Up";
        Totalavailable: Decimal;
        UnpaidDividends: Decimal;
        TotalOustanding: Decimal;
        Vend: Record Vendor;
        value2: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Totalrecovered: Decimal;
        Advice: Boolean;
        TotalDefaulterR: Decimal;
        AvailableShares: Decimal;
        Loans: Record "Loans Register";
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        Vendno: Code[20];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval;
        MNoEditable: Boolean;
        ClosingDateEditable: Boolean;
        ClosureTypeEditable: Boolean;
        PostingDateEditable: Boolean;
        TotalFOSALoan: Decimal;
        TotalInsuarance: Decimal;
        DActivity: Code[30];
        DBranch: Code[30];
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        "Remaining Amount": Decimal;
        LoansR: Record "Loans Register";
        "AMOUNTTO BE RECOVERED": Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        ClosureR: Record "Membership Exit";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval;
        PTEN: Text;
        DataSheet: Record "Data Sheet Main";
        Customer: Record Customer;
        GenSetUp: Record "Sacco General Set-Up";
        compinfo: Record "Company Information";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        ShareCapitalTransferVisible: Boolean;
        ShareCapSellPageVisible: Boolean;
        ObjShareCapSell: Record "M_Withdrawal Share Cap Sell";
        SurestepFactory: Codeunit "SURESTEP Factory.";
        JVTransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares";
        JVAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;
        TemplateName: Code[20];
        BatchName: Code[20];
        JVBalAccounttype: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        JVBalAccountNo: Code[20];
        TransferFee: Decimal;
        WithdrawalFee: Decimal;
        TransferGL: Code[20];
        WithFeeGL: Code[20];
        ExciseGL: Code[20];
        RunningBal: Decimal;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        OpenApprovalEntriesExist: Boolean;
        MWithdrawalGraduatedCharges: Record "MWithdrawal Graduated Charges";
        MemberRegister: Record Customer;


    procedure UpdateControl()
    begin
        if Status = Status::Open then begin
            MNoEditable := true;
            ClosingDateEditable := false;
            ClosureTypeEditable := true;
            PostingDateEditable := false;
        end;

        if Status = Status::Pending then begin
            MNoEditable := false;
            ClosingDateEditable := false;
            ClosureTypeEditable := false;
            PostingDateEditable := false;
        end;

        if Status = Status::Rejected then begin
            MNoEditable := false;
            ClosingDateEditable := false;
            ClosureTypeEditable := false;
            PostingDateEditable := false;
        end;

        if Status = Status::Approved then begin
            MNoEditable := false;
            ClosingDateEditable := true;
            ClosureTypeEditable := false;
            PostingDateEditable := true;
        end;
    end;


    procedure FnSendWithdrawalApplicationSMS()
    begin

        GenSetUp.Get;
        compinfo.Get;



        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := "No.";
        SMSMessage."Document No" := "No.";
        SMSMessage."Account No" := "Member No.";
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'MEMBERSHIPWITH';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member,Your Membership Withdrawal Application has been received and is being Processed '
        + compinfo.Name + ' ' + GenSetUp."Customer Care No";
        cust.Reset;
        cust.SetRange(cust."No.", "Member No.");
        if cust.Find('-') then begin
            SMSMessage."Telephone No" := cust."Mobile Phone No";
        end;
        if cust."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure FNPostShareCapTransfer()
    begin

        JVTransactionType := Jvtransactiontype::"Share Capital";
        JVAccountType := Jvaccounttype::Member;
        TemplateName := 'GENERAL';
        BatchName := 'CLOSURE';

        //Credit Buyer Account
        ObjShareCapSell.Reset;
        ObjShareCapSell.SetRange(ObjShareCapSell."Document No", "No.");
        if ObjShareCapSell.FindSet then begin
            repeat
                LineNo := LineNo + 10000;
                SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, "No.", LineNo, JVTransactionType, JVAccountType, ObjShareCapSell."Buyer Member No", "Closing Date",
                (ObjShareCapSell.Amount * -1), 'BOSA', "No.", 'Share Capital Sell' + Format("No."), '');
            until ObjShareCapSell.Next = 0;
        end;

        LineNo := LineNo + 10000;
        //Debit Seller Account
        CalcFields("Share Capital to Sell");
        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, "No.", LineNo, JVTransactionType, JVAccountType, "Member No.", "Closing Date",
            ("Share Capital to Sell"), 'BOSA', "No.", 'Share Capital Sell' + Format("No."), '');

        LineNo := LineNo + 10000;
        //Post Transfer Fee
        Generalsetup.Get();
        JVBalAccounttype := Jvbalaccounttype::"G/L Account";
        JVBalAccountNo := Generalsetup."Share Capital Transfer Fee Acc";
        JVTransactionType := Jvtransactiontype::"Deposit Contribution";

        SurestepFactory.FnCreateGnlJournalLineBalanced(TemplateName, BatchName, "No.", LineNo, JVTransactionType, JVAccountType, "Member No.", "Closing Date"
        , 'Transfer Fee_' + Format("No."), JVBalAccounttype, JVBalAccountNo, ("Share Capital Transfer Fee"), 'BOSA', '');
        //Post JV

        LineNo := LineNo + 10000;
        //Post Transfer Fee Excise Duty
        Generalsetup.Get();
        JVBalAccounttype := Jvbalaccounttype::"G/L Account";
        JVBalAccountNo := Generalsetup."Excise Duty Account";
        JVTransactionType := Jvtransactiontype::"Deposit Contribution";

        SurestepFactory.FnCreateGnlJournalLineBalanced(TemplateName, BatchName, "No.", LineNo, JVTransactionType, JVAccountType, "Member No.", "Closing Date"
        , 'Transfer Fee Excise_' + Format("No."), JVBalAccounttype, JVBalAccountNo, ("Share Capital Transfer Fee" * (Generalsetup."Excise Duty(%)" / 100)), 'BOSA', '');
        //Post Transfer Fee Excise Duty

        //SurestepFactory.FnPostGnlJournalLine(TemplateName,BatchName);
    end;

    local procedure FnPostWithdrawalFee(Bal: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
    begin

        if ((Bal > 0) and ("Posting Date" < "Expected Posting Date")) then begin
            if ("Posting Date" < "Expected Posting Date") then
                AmountToDeduct := Bal * 0.1 + 500;
            MWithdrawalGraduatedCharges.Reset;
            MWithdrawalGraduatedCharges.SetRange(MWithdrawalGraduatedCharges."Notice Status", MWithdrawalGraduatedCharges."notice status"::Notified);
            if MWithdrawalGraduatedCharges.Find('-') then begin
                repeat
                    if (Bal >= MWithdrawalGraduatedCharges."Minimum Amount") and (Bal <= MWithdrawalGraduatedCharges."Maximum Amount") then begin
                        if MWithdrawalGraduatedCharges."Use Percentage" = true then begin
                            AmountToDeduct := Bal * (MWithdrawalGraduatedCharges."Percentage of Amount" / 100)
                        end else
                            AmountToDeduct := MWithdrawalGraduatedCharges.Amount;
                    end;
                until MWithdrawalGraduatedCharges.Next = 0;
            end;
            LineNo := LineNo + 10000;
            SurestepFactory.FnCreateGnlJournalLineBalanced(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, "FOSA Account No.", "Posting Date", 'Withdrawal Fee: ' + "Member No.",
            GenJournalLine."bal. account type"::"G/L Account", WithFeeGL, AmountToDeduct, DActivity, '');

            /*LineNo:=LineNo+10000;
            SurestepFactory.FnCreateGnlJournalLineBalanced(TemplateName,BatchName,Doc_No,LineNo,GenJournalLine."Transaction Type"::" ",
            GenJournalLine."Account Type"::Vendor,"FOSA Account No.","Posting Date",'Excise(20%): '+"Member No.",
            GenJournalLine."Bal. Account Type"::"G/L Account",Generalsetup."Excise Duty Account",AmountToDeduct*0.2,DActivity,'');*/
            //------------------------------------End--------------------------------------------------
        end;
        exit(Bal);

    end;

    local procedure FnRecoverBOSAInterest(Bal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
    begin
        if Bal > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", "Member No.");
            ObjLoans.SetRange(ObjLoans.Source, ObjLoans.Source::BOSA);
            if ObjLoans.Find('-') then begin
                repeat
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Oustanding Interest");
                    if ObjLoans."Oustanding Interest" > 0 then begin
                        AmountToDeduct := ObjLoans."Oustanding Interest";
                        if AmountToDeduct > Bal then
                            AmountToDeduct := Bal
                        else
                            AmountToDeduct := AmountToDeduct;
                        //------------------------------Debit FOSA------------------------------
                        LineNo := LineNo + 10000;
                        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
                                                  GenJournalLine."account type"::Vendor, "FOSA Account No.", "Posting Date", AmountToDeduct, DActivity,
                                                  ObjLoans."Loan  No.", 'Repay Interest(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        //--------------------------------End------------------------------------
                        //-------------------------------Credit Loan Interest-----------------------------
                        LineNo := LineNo + 10000;
                        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                                  GenJournalLine."account type"::Member, ObjLoans."Client Code", "Posting Date", AmountToDeduct * -1, DActivity,
                                                  ObjLoans."Loan  No.", 'Interest Recovered(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        //--------------------------------End------------------------------------
                        Bal := Bal - AmountToDeduct;
                    end;

                until ObjLoans.Next = 0;
            end;
        end;

        exit(Bal);
    end;

    local procedure FnRecoverFOSAInterest(Bal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
    begin
        if Bal > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", "FOSA Account No.");
            ObjLoans.SetRange(ObjLoans.Source, ObjLoans.Source::FOSA);
            if ObjLoans.Find('-') then begin
                repeat
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Oustanding Interest");
                    if ObjLoans."Oustanding Interest" > 0 then begin
                        AmountToDeduct := ObjLoans."Oustanding Interest";
                        if AmountToDeduct > Bal then
                            AmountToDeduct := Bal
                        else
                            AmountToDeduct := AmountToDeduct;
                        //----------------------------------Debit FOSA-------------------------------------------
                        LineNo := LineNo + 10000;
                        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, "FOSA Account No.", "Posting Date", AmountToDeduct, DActivity,
                        ObjLoans."Loan  No.", 'Repay Interest(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        //------------------------------------End--------------------------------------------------
                        //----------------------------------Credit Loan--------------------------------------------
                        LineNo := LineNo + 10000;
                        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::Member, ObjLoans."Client Code", "Posting Date", AmountToDeduct * -1, DActivity,
                        ObjLoans."Loan  No.", 'Interest Recovered(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        //------------------------------------End--------------------------------------------------
                        Bal := Bal - AmountToDeduct;
                    end;

                until ObjLoans.Next = 0;
            end;
        end;

        exit(Bal);
    end;

    local procedure FnRecoverBOSALoanPrinciple(Bal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
    begin
        if Bal > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", "Member No.");
            ObjLoans.SetRange(ObjLoans.Source, ObjLoans.Source::BOSA);
            if ObjLoans.Find('-') then begin
                repeat
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        AmountToDeduct := ObjLoans."Outstanding Balance";
                        if AmountToDeduct > Bal then
                            AmountToDeduct := Bal
                        else
                            AmountToDeduct := AmountToDeduct;
                        //-----------------------------------------Debit FOSA-----------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
                                                  GenJournalLine."account type"::Vendor, "FOSA Account No.", "Posting Date", AmountToDeduct, DActivity,
                                                  ObjLoans."Loan  No.", 'Repay Loan(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        //----------------------------------------------End---------------------------------------------------------------------------------
                        //-----------------------------------------Credit Loans-----------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                                  GenJournalLine."account type"::Member, ObjLoans."Client Code", "Posting Date", AmountToDeduct * -1, DActivity,
                                                  ObjLoans."Loan  No.", 'Offset by Transferred(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        //------------------------------------------End--------------------------------------------------------------------------------------
                        Bal := Bal - AmountToDeduct;
                        //FnUpdateDatasheetMain(ObjLoans."Loan  No.");
                    end;
                until ObjLoans.Next = 0;
            end;
        end;

        exit(Bal);
    end;

    local procedure FnRecoverFOSALoanPrinciple(Bal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
    begin
        if Bal > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", "Member No.");
            ObjLoans.SetRange(ObjLoans.Source, ObjLoans.Source::FOSA);
            if ObjLoans.Find('-') then begin
                repeat
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        AmountToDeduct := ObjLoans."Outstanding Balance";
                        if AmountToDeduct > Bal then
                            AmountToDeduct := Bal
                        else
                            AmountToDeduct := AmountToDeduct;
                        //-------------------------------------Debit FOSA---------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
                                                  GenJournalLine."account type"::Vendor, "FOSA Account No.", "Posting Date", AmountToDeduct, DActivity,
                                                  ObjLoans."Loan  No.", 'Repay Loan(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        //-----------------------------------------End---------------------------------------------------------------------------------------
                        //---------------------------------------Credit Loan----------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                                  GenJournalLine."account type"::Member, ObjLoans."Client Code", "Posting Date", AmountToDeduct * -1, DActivity,
                                                  ObjLoans."Loan  No.", 'Offset by Transferred(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        //----------------------------------------End----------------------------------------------------------------------------------------
                        Bal := Bal - AmountToDeduct;
                    end;
                until ObjLoans.Next = 0;
            end;
        end;

        exit(Bal);
    end;

    local procedure FnDebitMemberDepositsAndShareCapital(DepositContributions: Decimal; RefundableShareCapital: Decimal)
    var
        AmountToTransfer: Decimal;
        AccountNo: Code[20];
    begin
        LineNo := LineNo + 10000;
        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                   GenJournalLine."account type"::Member, "Member No.", "Posting Date", DepositContributions, DActivity, "No.", 'Account Closure(With): ' + "No.", '');
        /*LineNo:=LineNo+10000;
        SurestepFactory.FnCreateGnlJournalLine(TemplateName,BatchName,Doc_No,LineNo,GenJournalLine."Transaction Type"::"Share Capital",
                   GenJournalLine."Account Type"::Member,"Member No.","Posting Date",RefundableShareCapital,DActivity,"No.",'Account Closure(With): '+"No.",'');*/

    end;

    local procedure FnUpdateDatasheetMain(LoanNum: Code[20])
    var
        ObjLoans: Record "Loans Register";
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", LoanNum);
        if ObjLoans.Find('-') then begin
            PTEN := '';

            if StrLen(ObjLoans."Staff No") = 10 then begin
                PTEN := CopyStr(ObjLoans."Staff No", 10);
            end else
                if StrLen(ObjLoans."Staff No") = 9 then begin
                    PTEN := CopyStr(ObjLoans."Staff No", 9);
                end else
                    if StrLen(ObjLoans."Staff No") = 8 then begin
                        PTEN := CopyStr(ObjLoans."Staff No", 8);
                    end else
                        if StrLen(ObjLoans."Staff No") = 7 then begin
                            PTEN := CopyStr(ObjLoans."Staff No", 7);
                        end else
                            if StrLen(ObjLoans."Staff No") = 6 then begin
                                PTEN := CopyStr(ObjLoans."Staff No", 6);
                            end else
                                if StrLen(ObjLoans."Staff No") = 5 then begin
                                    PTEN := CopyStr(ObjLoans."Staff No", 5);
                                end else
                                    if StrLen(ObjLoans."Staff No") = 4 then begin
                                        PTEN := CopyStr(ObjLoans."Staff No", 4);
                                    end else
                                        if StrLen(ObjLoans."Staff No") = 3 then begin
                                            PTEN := CopyStr(ObjLoans."Staff No", 3);
                                        end else
                                            if StrLen(ObjLoans."Staff No") = 2 then begin
                                                PTEN := CopyStr(ObjLoans."Staff No", 2);
                                            end else
                                                if StrLen(ObjLoans."Staff No") = 1 then begin
                                                    PTEN := CopyStr(ObjLoans."Staff No", 1);
                                                end;

            //IF LoanTypes.GET(ObjLoans."Loan Product Type") THEN BEGIN
            //IF Customer.GET(ObjLoans."Client Code") THEN BEGIN
            //Loans."Staff No":=customer."Payroll/Staff No";
            DataSheet.Init;
            DataSheet."PF/Staff No" := ObjLoans."Staff No";
            DataSheet."Type of Deduction" := ObjLoans."Loan Product Type";
            DataSheet."Remark/LoanNO" := ObjLoans."Loan  No.";
            DataSheet.Name := ObjLoans."Client Name";
            DataSheet."ID NO." := ObjLoans."ID NO";
            DataSheet."Principal Amount" := ObjLoans."Loan Principle Repayment";
            DataSheet."Interest Amount" := ObjLoans."Loan Interest Repayment";
            DataSheet."Amount OFF" := ROUND(ObjLoans.Repayment, 5, '>');
            DataSheet."REF." := '2026';
            DataSheet."Batch No." := "No.";
            DataSheet."New Balance" := 0;
            DataSheet."Repayment Method" := ObjLoans."Repayment Method";
            DataSheet."Transaction Type" := DataSheet."transaction type"::ADJUSTMENT;
            DataSheet.Date := "Closing Date";
            if Customer.Get(ObjLoans."Client Code") then begin
                DataSheet.Employer := Customer."Employer Code";
            end;
            DataSheet."Sort Code" := PTEN;
            DataSheet.Insert;
        end;
    end;

    local procedure FnTransferToCurrentAccount(TotalTransferredAmount: Decimal)
    begin
        LineNo := LineNo + 10000;
        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
                   GenJournalLine."account type"::Vendor, "FOSA Account No.", "Posting Date", TotalTransferredAmount * -1, DActivity, "No.", 'Account Closure(With): ' + "No.", '');
    end;

    local procedure FnPostExciseDuty(Bal: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
    begin
        if ("Posting Date" < "Expected Posting Date") then
            AmountToDeduct := "Ten WIthdrawal";
        LineNo := LineNo + 10000;
        SurestepFactory.FnCreateGnlJournalLineBalanced(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, "FOSA Account No.", "Posting Date", 'Early withdrawal Charge' + "Member No.",
        GenJournalLine."bal. account type"::"G/L Account", WithFeeGL, AmountToDeduct, DActivity, '');

        LineNo := LineNo + 10000;
        SurestepFactory.FnCreateGnlJournalLineBalanced(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, "FOSA Account No.", "Posting Date", 'Excise(20%): ' + "Member No.",
        GenJournalLine."bal. account type"::"G/L Account", Generalsetup."Excise Duty Account", AmountToDeduct * 0.2, DActivity, '');
        //------------------------------------End--------------------------------------------------

        exit(Bal);
    end;

    local procedure FnTransferToBankAcc(TotalTransferredAmount: Decimal)
    begin
        LineNo := LineNo + 10000;
        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
                   GenJournalLine."account type"::Vendor, "Bank AccNo", "Posting Date", TotalTransferredAmount * -1, DActivity, "No.", 'Account Closure(With): ' + "No.", '');
    end;
}

