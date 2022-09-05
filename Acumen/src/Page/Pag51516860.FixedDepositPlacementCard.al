#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516860 "Fixed Deposit Placement Card"
{
    PageType = Card;
    SourceTable = "Fixed Deposit Placement";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                    Editable = VarMemberNoEditable;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Fixed Deposit Account No"; "Fixed Deposit Account No")
                {
                    ApplicationArea = Basic;
                    Editable = VarAccountNoEditable;
                    TableRelation = "Fixed Deposit Placement"."Fixed Deposit Account No";
                    ToolTip = 'Specify the Fixed Deposit Account to fix the amount';
                }
                field("Account to Tranfers FD Amount"; "Account to Tranfers FD Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account to Tranfers Fixed Deposit Amount';
                    Editable = VarAccounttoTransferFDAmount;
                    ToolTip = 'Specify the savings account to transfer the amount to be fixed';
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Fixed Deposit Type"; "Fixed Deposit Type")
                {
                    ApplicationArea = Basic;
                    Editable = VarFixedDepTypeEditable;
                }
                field("Fixed Duration"; "Fixed Duration")
                {
                    ApplicationArea = Basic;
                    Editable = VarFDDurationEditable;
                }
                field("Fixed Deposit Start Date"; "Fixed Deposit Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = VarFDStartDateEditable;
                }
                field("Amount to Fix"; "Amount to Fix")
                {
                    ApplicationArea = Basic;
                    Editable = VarAmountFixedEditable;
                }
                field("FD Interest Rate"; "FD Interest Rate")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("FD Maturity Date"; "FD Maturity Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Fixed Deposit Status"; "Fixed Deposit Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Interest Earned"; "Expected Interest Earned")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Tax After Term Period"; "Expected Tax After Term Period")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Net After Term Period"; "Expected Net After Term Period")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Effected; Effected)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Effected By"; "Effected By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Effected"; "Date Effected")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("FD Closed On"; "FD Closed On")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Closed';
                    Editable = false;
                }
                field("FD Closed By"; "FD Closed By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Closed By';
                    Editable = false;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Interest Earned to Date"; "Interest Earned to Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control33; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("Fixed Deposit Account No");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(EnablePlaceFixedDeposit)
            {
                ApplicationArea = Basic;
                Caption = 'Place Fixed Deposit';
                Enabled = EnablePlaceFixedDeposit;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Place this Fixed Deposit?', false) = true then begin
                        if ObjAccount.Get("Fixed Deposit Account No") then begin
                            ObjAccount."Fixed Deposit Type" := "Fixed Deposit Type";
                            ObjAccount."Fixed Deposit Start Date" := "Fixed Deposit Start Date";
                            ObjAccount."Fixed Deposit Status" := "Fixed Deposit Status";
                            ObjAccount."Fixed Duration" := "FD Duration";
                            ObjAccount."FD Maturity Date" := "FD Maturity Date";
                            ObjAccount."Interest rate" := "FD Interest Rate";
                            ObjAccount."Expected Interest On Term Dep" := "Expected Interest Earned";
                        end;
                    end;

                    Message(FDEffectedSuccesfully);
                    Effected := true;
                    "Effected By" := UserId;
                    "Date Effected" := WorkDate;
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send Approval Request';
                Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Text001: label 'This request is already pending approval';
                    ApprovalsMgmt: Codeunit WorkflowIntegration;
                begin

                    if ApprovalsMgmt.CheckFixedDepositApprovalsWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendFixedDepositForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    Approvalmgt: Codeunit WorkflowIntegration;
                begin
                    if Confirm('Are you sure you want to cancel this approval request', false) = true then
                        ApprovalsMgmt.OnCancelFixedDepositApprovalRequest(Rec);
                    Status := Status::Open;
                    Modify;
                end;
            }
            action(Approval)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    DocumentType := Documenttype::FixedDeposit;
                    ApprovalEntries.Setfilters(Database::"Fixed Deposit Placement", DocumentType, "Document No");
                    ApprovalEntries.Run;
                end;
            }
            action(PostFixedDepositFromSavings)
            {
                ApplicationArea = Basic;
                Caption = 'Post Fixed Deposit From Savings';
                Enabled = EnablePlaceFixedDeposit;
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    ObjVendors.Reset;
                    ObjVendors.SetRange(ObjVendors."No.", "Account to Tranfers FD Amount");
                    if ObjVendors.Find('-') then begin
                        ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                        AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                        ObjAccTypes.Reset;
                        ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                        if ObjAccTypes.Find('-') then
                            AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                    end;


                    if AvailableBal < "Amount to Fix" then begin
                        Error('The FOSA Account has Less than the amount to Fix,Account balance is %1', AvailableBal);
                    end;

                    if Confirm('Do you want to effect this transfer from the Savings account', false) = true then
                        BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'DEFAULT';
                    DOCUMENT_NO := "Document No";
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;




                    //------------------------------------1. CREDIT FIXED DEPOSIT A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, "Fixed Deposit Account No", Today, "Amount to Fix" * -1, 'FOSA', '',
                    'Fixed Deposit Amount- ' + '-' + "Document No", '');
                    //--------------------------------(Credit fixed Deposit A/C)---------------------------------------------

                    //------------------------------------2. DEBIT FOSA SAVINGS A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, "Account to Tranfers FD Amount", Today, "Amount to Fix", 'FOSA', '',
                    'Fixed Deposit Amount- ' + '-' + "Document No", '');
                    //----------------------------------(Debit Fosa Savings Account)------------------------------------------------

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

                    Message(FDEffectedSuccesfully);
                    Effected := true;
                    "Effected By" := UserId;
                    "Date Effected" := WorkDate;
                end;
            }
            action(PostFixedDeposittoSavings)
            {
                ApplicationArea = Basic;
                Caption = 'Post Fixed Deposit to Savings';
                Enabled = EnablePlaceFixedDeposit;
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    ObjVendors.Reset;
                    ObjVendors.SetRange(ObjVendors."No.", "Fixed Deposit Account No");
                    if ObjVendors.Find('-') then begin
                        ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                        AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                        ObjAccTypes.Reset;
                        ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                        if ObjAccTypes.Find('-') then
                            AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                    end;


                    if AvailableBal < "Amount to Fix" then begin
                        Error('The FOSA Account has Less than the amount to Fix,Account balance is %1', AvailableBal);
                    end;

                    if Confirm('Do you want to effect this transfer from the Savings account', false) = true then
                        BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'DEFAULT';
                    DOCUMENT_NO := "Document No";
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;




                    //------------------------------------1. CREDIT FIXED DEPOSIT A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, "Fixed Deposit Account No", Today, "Amount to Fix" * -1, 'FOSA', '',
                    'Fixed Deposit Amount- ' + '-' + "Document No", '');
                    //--------------------------------(Credit fixed Deposit A/C)---------------------------------------------

                    //------------------------------------2. DEBIT FOSA SAVINGS A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, "Account to Tranfers FD Amount", Today, "Amount to Fix", 'FOSA', '',
                    'Fixed Deposit Amount- ' + '-' + "Document No", '');
                    //----------------------------------(Debit Fosa Savings Account)------------------------------------------------

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

                    Message(FDTermination);
                    Closed := true;
                    "FD Closed By" := UserId;
                    "FD Closed On" := WorkDate;
                end;
            }
            action(RenewFixedDeposit)
            {
                ApplicationArea = Basic;
                Caption = 'Renew Fixed Deposit';
                Enabled = EnablePlaceFixedDeposit;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Do you want to Renew this Fixed Deposit', false) = true then begin
                        ObjVendors.Reset;
                        ObjVendors.SetRange(ObjVendors."No.", "Fixed Deposit Account No");
                        if ObjVendors.Find('-') then begin

                            ObjVendors."Prevous Fixed Deposit Type" := "Fixed Deposit Type";
                            ObjVendors."Prevous FD Deposit Status Type" := "FDR Deposit Status Type";
                            ObjVendors."Prevous FD Maturity Date" := "FD Maturity Date";
                            ObjVendors."Prevous FD Start Date" := "Fixed Deposit Start Date";
                            ObjVendors."Prevous Fixed Duration" := "FD Duration";
                            ObjVendors."Prevous Interest Rate FD" := "FD Interest Rate";
                            ObjVendors."Prevous Expected Int On FD" := "Expected Interest Earned";
                            ObjVendors."Date Renewed" := Today;


                            ObjVendors."Fixed Deposit Type" := '';
                            ObjVendors."FDR Deposit Status Type" := ObjVendors."fdr deposit status type"::New;
                            ObjVendors."FD Maturity Date" := 0D;
                            ObjVendors."Fixed Deposit Start Date" := 0D;
                            ObjVendors."Expected Interest On Term Dep" := 0;
                            ObjVendors."Interest rate" := 0;
                            ObjVendors."Amount to Transfer" := 0;
                            ObjVendors."Transfer Amount to Savings" := 0;
                            ObjVendors."Fixed Deposit Status" := "fixed deposit status"::" ";


                            ObjInterestBuffer.Reset;
                            ObjInterestBuffer.SetRange(ObjInterestBuffer."Account No", "Fixed Deposit Account No");
                            if ObjInterestBuffer.Find('-') then begin
                                ObjInterestBuffer.DeleteAll;
                            end;



                            ObjVendors."FDR Deposit Status Type" := ObjVendors."fdr deposit status type"::New;
                            ObjVendors.Modify;

                            Message('Fixed deposit renewed successfully');
                        end;
                    end;
                end;
            }
            action(TerminateFixedDeposit)
            {
                ApplicationArea = Basic;
                Caption = 'Terminate Fixed Deposit';
                Enabled = EnablePlaceFixedDeposit;
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    ObjVendors.Reset;
                    ObjVendors.SetRange(ObjVendors."No.", "Fixed Deposit Account No");
                    if ObjVendors.Find('-') then begin
                        ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                        AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                        ObjAccTypes.Reset;
                        ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                        if ObjAccTypes.Find('-') then
                            AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                    end;


                    if AvailableBal < "Amount to Fix" then begin
                        Error('The FOSA Account has Less than the amount to Fix,Account balance is %1', AvailableBal);
                    end;

                    if Confirm('Do you want to Terminate this Fixed Deposit', false) = true then
                        BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'DEFAULT';
                    DOCUMENT_NO := "Document No";
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;




                    //------------------------------------1. DEBIT FIXED DEPOSIT A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, "Fixed Deposit Account No", Today, "Amount to Fix", 'FOSA', '',
                    'Fixed Deposit Terminated- ' + '-' + "Document No", '');
                    //--------------------------------(Debit fixed Deposit A/C)---------------------------------------------

                    //------------------------------------2. CREDIT FOSA SAVINGS A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, "Account to Tranfers FD Amount", Today, "Amount to Fix" * -1, 'FOSA', '',
                    'Fixed Deposit Terminated- ' + '-' + "Document No", '');
                    //----------------------------------(Credit Fosa Savings Account)------------------------------------------------

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);


                    Message(FDTermination);
                    Closed := true;
                    "FD Closed By" := UserId;
                    "FD Closed On" := WorkDate;
                end;
            }
            action(BreakCall)
            {
                ApplicationArea = Basic;
                Caption = 'Break Call Deposit';
                Enabled = EnablePlaceFixedDeposit;
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ObjAccount.Reset;
                    ObjAccount.SetRange(ObjAccount."No.", "Fixed Deposit Account No");
                    if ObjAccount.Find('-') then
                        Report.Run(51516465, true, false, ObjAccount)
                end;
            }
            action(CERTIFICATE)
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    Report.Run(51516877, true, false);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Status = Status::Open then begin
            VarMemberNoEditable := true;
            VarAccountNoEditable := true;
            VarFixedDepTypeEditable := true;
            VarFDStartDateEditable := true;
            VarAmountFixedEditable := true;
            VarFDDurationEditable := true
        end else
            if Status = Status::"Pending Approval" then begin
                VarMemberNoEditable := false;
                VarAccountNoEditable := false;
                VarFixedDepTypeEditable := false;
                VarFDStartDateEditable := false;
                VarAmountFixedEditable := false;
                VarFDDurationEditable := false
            end else
                if Status = Status::Approved then begin
                    VarMemberNoEditable := false;
                    VarAccountNoEditable := false;
                    VarFixedDepTypeEditable := false;
                    VarFDStartDateEditable := false;
                    VarAmountFixedEditable := false;
                    VarFDDurationEditable := false;
                end;


        EnablePlaceFixedDeposit := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Status::Approved)) then
            EnablePlaceFixedDeposit := true;
    end;

    trigger OnOpenPage()
    begin
        if Status = Status::Open then begin
            VarMemberNoEditable := true;
            VarAccountNoEditable := true;
            VarFixedDepTypeEditable := true;
            VarFDStartDateEditable := true;
            VarAmountFixedEditable := true;
            VarAccounttoTransferFDAmount := true;
            VarFDDurationEditable := true
        end else
            if Status = Status::"Pending Approval" then begin
                VarMemberNoEditable := false;
                VarAccountNoEditable := false;
                VarFixedDepTypeEditable := false;
                VarFDStartDateEditable := false;
                VarAmountFixedEditable := false;
                VarAccounttoTransferFDAmount := false;
                VarFDDurationEditable := false
            end else
                if Status = Status::Approved then begin
                    VarMemberNoEditable := false;
                    VarAccountNoEditable := false;
                    VarFixedDepTypeEditable := false;
                    VarFDStartDateEditable := false;
                    VarAmountFixedEditable := false;
                    VarAccounttoTransferFDAmount := false;
                    VarFDDurationEditable := false;
                end;

        EnablePlaceFixedDeposit := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        if ((Rec.Status = Status::Approved)) then
            EnablePlaceFixedDeposit := true;
    end;

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange,HouseRegistration,LoanPayOff,FixedDeposit;
        EnablePlaceFixedDeposit: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        EnabledApprovalWorkflowsExist: Boolean;
        ObjVendors: Record Vendor;
        VarMemberNoEditable: Boolean;
        VarAccountNoEditable: Boolean;
        VarFixedDepTypeEditable: Boolean;
        VarFDDurationEditable: Boolean;
        VarFDStartDateEditable: Boolean;
        VarAmountFixedEditable: Boolean;
        VarAccounttoTransferFDAmount: Boolean;
        ObjAccTypes: Record "Account Types-Saving Products";
        ObjAccount: Record Vendor;
        AvailableBal: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        SFactory: Codeunit "SURESTEP Factory.";
        LineNo: Integer;
        ObjInterestBuffer: Record "Interest Buffer";
        ErrorAlreadyEffected: label 'Fixed Deposit Already Effected';
        FDEffectedSuccesfully: label 'Fixed Deposit Effected Succesfully';
        FDTermination: label 'Fixed Deposit Terminated Sucessfully';
}

