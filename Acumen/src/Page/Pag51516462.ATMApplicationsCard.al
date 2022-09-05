#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516462 "ATM Applications Card"
{
    PageType = Card;
    SourceTable = "ATM Card Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Editable = AccountNoEditable;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("ID No"; "ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Card No"; "Card No")
                {
                    ApplicationArea = Basic;
                    Editable = CardNoEditable;

                    trigger OnValidate()
                    begin


                        if StrLen("Card No") <> 16 then
                            Error('ATM No. cannot contain More or less than 16 Characters.');
                    end;
                }
                field("Request Type"; "Request Type")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Expiry Date"; "ATM Expiry Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Limit; Limit)
                {
                    ApplicationArea = Basic;
                }
                field("Terms Read and Understood"; "Terms Read and Understood")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Other Details")
            {
                Caption = 'Other Details';
                field("Order ATM Card"; "Order ATM Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Order';
                    Editable = false;
                }
                field("Ordered By"; "Ordered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Ordered On"; "Ordered On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Card Received"; "Card Received")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Received By"; "Received By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Received';
                    Editable = false;
                }
                field("Received On"; "Received On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Collected; Collected)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Collected"; "Date Collected")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Card Issued By"; "Card Issued By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Issued to"; "Issued to")
                {
                    ApplicationArea = Basic;
                    Editable = IssuedtoEditable;
                }
                field("Card Issued to Customer"; "Card Issued to Customer")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Card Status"; "Card Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Activated"; "Date Activated")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Frozen"; "Date Frozen")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Replacement For Card No"; "Replacement For Card No")
                {
                    ApplicationArea = Basic;
                }
                field("Has Other Accounts"; "Has Other Accounts")
                {
                    ApplicationArea = Basic;
                }
                field("Approval Date"; "Approval Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Fee Charged"; "ATM Card Fee Charged")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Fee Charged On"; "ATM Card Fee Charged On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Fee Charged By"; "ATM Card Fee Charged By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Linked"; "ATM Card Linked")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Linked By"; "ATM Card Linked By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Linked On"; "ATM Card Linked On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Pesa Point ATM Card")
            {
                Caption = 'Pesa Point ATM Card';
                action("Link ATM Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Link ATM Card';
                    Image = Link;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Status <> Status::Approved then
                            Error('This ATM Card application has not been approved');

                        if "ATM Card Fee Charged" = false then
                            Error('ATM Card Fee has not been Charged on this Application');

                        //Linking Details*******************************************************************************
                        if Confirm('Are you sure you want to link this ATM Card to the Account', false) = true then begin
                            if ObjAccount.Get("Account No") then begin

                                ObjATMCardsBuffer.Init;
                                ObjATMCardsBuffer."Account No" := "Account No";
                                ObjATMCardsBuffer."Account Name" := "Account Name";
                                ObjATMCardsBuffer."Account Type" := "Account Type C";
                                ObjATMCardsBuffer."ATM Card No" := "Card No";
                                ObjATMCardsBuffer."ID No" := "ID No";
                                ObjATMCardsBuffer.Status := ObjATMCardsBuffer.Status::Active;
                                ObjATMCardsBuffer.Insert;
                                //ObjAccount."ATM No.":="Card No";
                                //ObjAccount.MODIFY;
                            end;
                            "ATM Card Linked" := true;
                            "ATM Card Linked By" := UserId;
                            "ATM Card Linked On" := Today;
                            Modify;
                        end;
                        Message('ATM Card linked to Succesfuly to Account No %1', "Account No");
                        //End Linking Details****************************************************************************

                        //Collection Details***********************************
                        Collected := true;
                        "Date Collected" := Today;
                        "Card Issued By" := UserId;
                        "Card Status" := "card status"::Active;
                        Modify;
                        //End Collection Details******************************



                        Vend.Get("Account No");
                        Vend."ATM No." := "Card No";
                        Vend."Atm card ready" := true;
                        Vend.Modify;

                        GeneralSetup.Get();
                        "ATM Expiry Date" := CalcDate(GeneralSetup."ATM Expiry Duration", Today);
                    end;
                }
                action("Disable ATM Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Disable ATM Card';
                    Image = DisableAllBreakpoints;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Status <> Status::Approved then
                            Error('This ATM Card application has not been approved');


                        if "Card Status" <> "card status"::Active then
                            Error('Card is not active');


                        Vend.Get("Account No");
                        if Confirm('Are you sure you want to disable this account from ATM transactions  ?', false) = true then
                            Vend."ATM No." := '';
                        //Vend.Blocked:=Vend.Blocked::Payment;
                        //Vend."Account Frozen":=TRUE;
                        Vend.Modify;
                    end;
                }
                action("Enable ATM Card")
                {
                    ApplicationArea = Basic;
                    Image = EnableAllBreakpoints;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Status <> Status::Approved then
                            Error('This ATM Card application has not been approved');


                        Vend.Get("Account No");
                        if Confirm('Are you sure you want to Enable ATM no. for this account  ?', true) = true then
                            Vend."ATM No." := "Card No";
                        //Vend.Blocked:=Vend.Blocked::Payment;
                        //Vend."Account Frozen":=TRUE;
                        Vend.Modify;

                        "Card Status" := "card status"::Active;
                        Modify;
                    end;
                }
                action("Charge ATM Card Fee")
                {
                    ApplicationArea = Basic;
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Status <> Status::Approved then
                            Error('This ATM Card application has not been approved');

                        if Collected = true then
                            Error('The ATM Card has already been collected');

                        if Confirm('Are you sure you want to charge this ATM Card Application?', true) = true then begin

                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                            GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                            GenJournalLine.DeleteAll;

                            //Customer Deduction***************************************************
                            GeneralSetup.Get;

                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Journal Batch Name" := 'FTRANS';
                            GenJournalLine."Document No." := 'ATMFEE';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := "Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Today;
                            if "Request Type" = "request type"::Replacement then
                                GenJournalLine.Description := 'ATM Card Fee-Replacement_' + Format("Account No")
                            else
                                if "Request Type" = "request type"::New then
                                    GenJournalLine.Description := 'ATM Card Fee-New_' + Format("Account No")
                                else
                                    if "Request Type" = "request type"::Renewal then
                                        GenJournalLine.Description := 'ATM Card Fee-Renewal_' + Format("Account No");

                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            if "Request Type" = "request type"::Replacement then
                                GenJournalLine.Amount := GeneralSetup."ATM Card Fee-Replacement"
                            else
                                if "Request Type" = "request type"::New then
                                    GenJournalLine.Amount := GeneralSetup."ATM Card Fee New"
                                else
                                    if "Request Type" = "request type"::Renewal then
                                        GenJournalLine.Amount := GeneralSetup."ATM Card Fee-Replacement";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //Bank Charge**********************************************************
                            GeneralSetup.Get;

                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Journal Batch Name" := 'FTRANS';
                            GenJournalLine."Document No." := 'ATMFEE';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                            GenJournalLine."Account No." := GeneralSetup."ATM Card Fee Co-op Bank";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Today;
                            if "Request Type" = "request type"::Replacement then
                                GenJournalLine.Description := 'ATM Card Fee-Replacement_' + Format("Account No")
                            else
                                if "Request Type" = "request type"::New then
                                    GenJournalLine.Description := 'ATM Card Fee-New_' + Format("Account No")
                                else
                                    if "Request Type" = "request type"::Renewal then
                                        GenJournalLine.Description := 'ATM Card Fee-Renewal_' + Format("Account No");

                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            if "Request Type" = "request type"::Replacement then
                                GenJournalLine.Amount := GeneralSetup."ATM Card Fee-Replacement" * -1
                            else
                                if "Request Type" = "request type"::New then
                                    GenJournalLine.Amount := GeneralSetup."ATM Card Fee-New Coop" * -1
                                else
                                    if "Request Type" = "request type"::Renewal then
                                        GenJournalLine.Amount := GeneralSetup."ATM Card Renewal Fee Bank" * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //SACCO Charge*************************************************
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Journal Batch Name" := 'FTRANS';
                            GenJournalLine."Document No." := 'ATMFEE';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := GeneralSetup."ATM Card Fee-Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Today;
                            if "Request Type" = "request type"::Replacement then
                                GenJournalLine.Description := 'ATM Card Fee-Replacement_' + Format("Account No")
                            else
                                if "Request Type" = "request type"::New then
                                    GenJournalLine.Description := 'ATM Card Fee-New_' + Format("Account No")
                                else
                                    if "Request Type" = "request type"::Renewal then
                                        GenJournalLine.Description := 'ATM Card Fee-Renewal_' + Format("Account No");

                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            if "Request Type" = "request type"::Replacement then
                                GenJournalLine.Amount := GeneralSetup."ATM Card Renewal Fee Sacco" * -1
                            else
                                if "Request Type" = "request type"::New then
                                    GenJournalLine.Amount := GeneralSetup."ATM Card Fee-New Sacco" * -1
                                else
                                    if "Request Type" = "request type"::Renewal then
                                        GenJournalLine.Amount := GeneralSetup."ATM Card Renewal Fee Sacco" * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //Excise Duty on SACCO Comission**************************
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PURCHASES';
                            GenJournalLine."Journal Batch Name" := 'FTRANS';
                            GenJournalLine."Document No." := 'ATMFEE';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := GeneralSetup."Excise Duty Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Description := 'Excise Duty on ATM Card Fee_' + Format("Account No");
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            if "Request Type" = "request type"::Replacement then
                                GenJournalLine.Amount := (GeneralSetup."ATM Card Renewal Fee Sacco" * GeneralSetup."Excise Duty(%)" / 100) * -1
                            else
                                if "Request Type" = "request type"::New then
                                    GenJournalLine.Amount := (GeneralSetup."ATM Card Fee-New Sacco" * GeneralSetup."Excise Duty(%)" / 100) * -1
                                else
                                    if "Request Type" = "request type"::Renewal then
                                        GenJournalLine.Amount := (GeneralSetup."ATM Card Renewal Fee Sacco" * GeneralSetup."Excise Duty(%)" / 100) * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := FnGetUserBranch();
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //Post New
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                            GenJournalLine.SetRange("Journal Batch Name", 'Ftrans');
                            if GenJournalLine.Find('-') then begin

                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

                                //window.OPEN('Posting:,#1######################');
                            end;
                        end;

                        "ATM Card Fee Charged" := true;
                        "ATM Card Fee Charged By" := UserId;
                        "ATM Card Fee Charged On" := Today;
                        Message('ATM Card Charge Posted Succesfully');
                    end;
                }
            }
            group(Approvals)
            {
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::ATMCard;
                        ApprovalEntries.Setfilters(Database::"ATM Card Applications", DocumentType, "No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit WorkflowIntegration;
                    begin
                        if ApprovalsMgmt.CheckATMCardApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendATMCardForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit WorkflowIntegration;
                        ApprovalsMgmt: Codeunit WorkflowIntegration;
                    begin

                        if ApprovalsMgmt.CheckATMCardApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnCancelATMCardApprovalRequest(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FnAddRecRestriction();
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        AccountHolders: Record Vendor;
        window: Dialog;
        PostingCode: Codeunit "Gen. Jnl.-Post Line";
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        CustomizedCalEntry: Record "Office/Group";
        PictureExists: Boolean;
        AccountTypes: Record "Account Types-Saving Products";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        StatusPermissions: Record "Status Change Permision";
        Charges: Record Charges;
        ForfeitInterest: Boolean;
        InterestBuffer: Record "Interest Buffer";
        FDType: Record "Fixed Deposit Type";
        Vend: Record Vendor;
        Cust: Record Customer;
        UsersID: Record User;
        Bal: Decimal;
        AtmTrans: Decimal;
        UnCheques: Decimal;
        AvBal: Decimal;
        Minbal: Decimal;
        GeneralSetup: Record "Sacco General Set-Up";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest;
        AccountNoEditable: Boolean;
        CardNoEditable: Boolean;
        CardTypeEditable: Boolean;
        RequestTypeEditable: Boolean;
        ReplacementCardNoEditable: Boolean;
        IssuedtoEditable: Boolean;
        ObjAccount: Record Vendor;
        ObjATMCardsBuffer: Record "ATM Card Nos Buffer";

    local procedure FnGetUserBranch() branchCode: Code[50]
    var
        UserSetup: Record User;
    begin
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User Name", UserId);
        if UserSetup.Find('-') then begin
            branchCode := UserSetup."Branch Code";
        end;
        exit(branchCode);
    end;

    local procedure FnAddRecRestriction()
    begin
        if Status = Status::Open then begin
            AccountNoEditable := true;
            CardNoEditable := false;
            CardTypeEditable := true;
            ReplacementCardNoEditable := false;
            IssuedtoEditable := false;
        end else
            if Status = Status::Pending then begin
                AccountNoEditable := false;
                CardNoEditable := false;
                CardTypeEditable := false;
                ReplacementCardNoEditable := false;
                IssuedtoEditable := false
            end else
                if Status = Status::Approved then begin
                    AccountNoEditable := false;
                    CardNoEditable := true;
                    CardTypeEditable := false;
                    ReplacementCardNoEditable := true;
                    IssuedtoEditable := true;
                end;
    end;
}

