#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516449 "Standing Order Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Standing Orders";

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
                field("Source Account No."; "Source Account No.")
                {
                    ApplicationArea = Basic;
                    AssistEdit = false;
                    Editable = true;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                    Editable = AmountEditable;
                }
                field("Destination Account Type"; "Destination Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = DestinationAccountTypeEditable;

                    trigger OnValidate()
                    begin
                        ReceiptAllVisible := false;
                        DestinationAccountsVisible := false;
                        if "Destination Account Type" = "destination account type"::BOSA then begin
                            ReceiptAllVisible := true;
                            DestinationAccountsVisible := false;
                        end;

                        if "Destination Account Type" = "destination account type"::Internal then begin
                            ReceiptAllVisible := false;
                            DestinationAccountsVisible := true;
                        end;


                        BankDetailsVisible := false;
                        if "Destination Account Type" = "destination account type"::External then begin
                            BankDetailsVisible := true;
                            DestinationAccountsVisible := true;
                        end;
                    end;
                }
                group(DestinationDetails)
                {
                    Caption = 'DestinationDetails';
                    Visible = DestinationAccountsVisible;
                    field("Destination Account No."; "Destination Account No.")
                    {
                        ApplicationArea = Basic;
                        Editable = DestinationAccountNoEditable;
                    }
                    field("Destination Account Name"; "Destination Account Name")
                    {
                        ApplicationArea = Basic;
                        Editable = DestinationAccountNameEditable;
                    }
                }
                group(BankDetails)
                {
                    Caption = 'BankDetails';
                    Visible = BankDetailsVisible;
                    field("Bank Code"; "Bank Code")
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            BankName := '';
                            if Banks.Get("Bank Code") then
                                BankName := Banks."Bank Name";
                        end;
                    }
                    field(BankName; BankName)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Bank Name';
                    }
                }
                field("BOSA Account No."; "BOSA Account No.")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Allocated Amount"; "Allocated Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Effective/Start Date"; "Effective/Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(Duration; Duration)
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Frequency; Frequency)
                {
                    ApplicationArea = Basic;
                }
                field("Don't Allow Partial Deduction"; "Don't Allow Partial Deduction")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Standing Order Description"; "Standing Order Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Standing Order Description';
                }
                field(Unsuccessfull; Unsuccessfull)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Next Run Date"; "Next Run Date")
                {
                    ApplicationArea = Basic;
                }
                field("No of Tolerance Days"; "No of Tolerance Days")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("End of Tolerance Date"; "End of Tolerance Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Last Next Run Date attempt';
                    Editable = false;
                    ToolTip = 'This is the last date the system will attempt to run the standing order after the tolerance period';
                }
                field(Balance; Balance)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Effected; Effected)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Auto Process"; "Auto Process")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Standing Order Type"; "Standing Order Type")
                {
                    ApplicationArea = Basic;
                }
                field("None Salary"; "None Salary")
                {
                    ApplicationArea = Basic;
                }
                field("Date Reset"; "Date Reset")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
            }
            part("Receipt Allocation"; "Receipt Allocation-BOSA")
            {
                SubPageLink = "Document No" = field("No.");
                Visible = ReceiptAllVisible;
            }
        }
        area(factboxes)
        {
            part(Control25; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("Source Account No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Reset)
            {
                ApplicationArea = Basic;
                Caption = 'Reset';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to reset the standing order?') = true then begin

                        Effected := false;
                        Balance := 0;
                        Unsuccessfull := false;
                        "Auto Process" := false;
                        "Date Reset" := Today;
                        Modify;

                        RAllocations.Reset;
                        RAllocations.SetRange(RAllocations."Document No", "No.");
                        if RAllocations.Find('-') then begin
                            repeat
                                RAllocations."Amount Balance" := 0;
                                RAllocations."Interest Balance" := 0;
                                RAllocations.Modify;
                            until RAllocations.Next = 0;
                        end;

                    end;
                end;
            }
            action(Approve)
            {
                ApplicationArea = Basic;
                Caption = 'Approve';
                Enabled = true;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    TestField("Source Account No.");
                    if "Destination Account Type" <> "destination account type"::BOSA then
                        TestField("Destination Account No.");
                    TestField("Effective/Start Date");
                    TestField(Frequency);
                    TestField("Next Run Date");


                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to change the standing order status.');
                end;
            }
            action(Reject)
            {
                ApplicationArea = Basic;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to change the standing status.');
                end;
            }
            action(Stop)
            {
                ApplicationArea = Basic;
                Caption = 'Stop';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to stop the standing order.');

                    if Confirm('Are you sure you want to stop the standing order?', false) = true then begin
                        //Status:=Status::"2";
                        //MODIFY;
                    end;
                end;
            }
            group(Approvals)
            {
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        // DocumentType:=DocumentType::StandingOrder;
                        //
                        // ApprovalEntries.Setfilters(DATABASE::"Standing Orders",DocumentType,"No.");
                        // ApprovalEntries.RUN;

                        Status := Status::Approved;
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
                        /*TESTFIELD("Source Account No.");
                        TESTFIELD("Standing Order Description");
                        IF "Destination Account Type" <> "Destination Account Type"::BOSA THEN
                        TESTFIELD("Destination Account No.");
                        
                        TESTFIELD("Effective/Start Date");
                        TESTFIELD(Frequency);
                        TESTFIELD("Next Run Date");
                        
                        IF "Destination Account Type" = "Destination Account Type"::BOSA THEN BEGIN
                        CALCFIELDS("Allocated Amount");
                        IF Amount<>"Allocated Amount" THEN
                        ERROR('Allocated amount must be equal to amount');
                        END;
                        
                        IF Status<>Status::Open THEN
                        ERROR(Text001);
                        MESSAGE('Sent for Approval');
                        
                        IF ApprovalsMgmt.CheckStandingOrderApprovalsWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnSendStandingOrderForApproval(Rec);*/
                        // ApprovalsMgmt.OnSendSTOforApproval(Rec);
                        Status := Status::Approved;
                        CurrPage.Close;

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit WorkflowIntegration;
                        ApprovalsMgmt: Codeunit WorkflowIntegration;
                    begin
                        // // IF ApprovalsMgmt.CheckStandingOrderApprovalsWorkflowEnabled(Rec) THEN
                        // //   ApprovalsMgmt.OnCancelStandingOrderApprovalRequest(Rec);
                        Status := Status::Open;
                    end;
                }
            }
        }
        area(creation)
        {
            action(Create_STO)
            {
                ApplicationArea = Basic;
                Caption = 'Create_STO';
                Enabled = true;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    TestField("Source Account No.");
                    if "Destination Account Type" <> "destination account type"::BOSA then
                        TestField("Destination Account No.");
                    TestField("Effective/Start Date");
                    TestField(Frequency);
                    TestField("Next Run Date");

                    //IF Status<>Status::"2" THEN
                    //ERROR('Standing order status must be approved for you to create it');

                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to change the standing order status.');
                end;
            }
            action(Stop_STO)
            {
                ApplicationArea = Basic;
                Caption = 'Stop_STO';
                Image = Stop;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to stop the standing order.');

                    if Confirm('Are you sure you want to stop the standing order?', false) = true then begin
                        Status := Status::Open;
                        Modify;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        BankName := '';
        if Banks.Get("Bank Code") then
            BankName := Banks."Bank Name";

        ReceiptAllVisible := false;
        DestinationAccountsVisible := false;
        if "Destination Account Type" = "destination account type"::BOSA then begin
            ReceiptAllVisible := true;
            DestinationAccountsVisible := false;
        end;

        if "Destination Account Type" = "destination account type"::Internal then begin
            ReceiptAllVisible := false;
            DestinationAccountsVisible := true;
        end;


        BankDetailsVisible := false;
        if "Destination Account Type" = "destination account type"::External then begin
            BankDetailsVisible := true;
            DestinationAccountsVisible := true;
        end;



        if Status = Status::Open then begin
            AmountEditable := true;
            DestinationAccountNoEditable := true;
            DestinationAccountNameEditable := true;
            FrequencyEditable := true;
            DurationEditable := true;
            EffectiveDateEditable := true;
            DestinationAccountTypeEditable := true
        end else
            if Status = Status::Pending then begin
                AmountEditable := false;
                DestinationAccountNoEditable := false;
                DestinationAccountNameEditable := false;
                FrequencyEditable := false;
                DurationEditable := false;
                EffectiveDateEditable := false;
                DestinationAccountTypeEditable := false
            end else begin
                AmountEditable := false;
                DestinationAccountNoEditable := false;
                DestinationAccountNameEditable := false;
                FrequencyEditable := false;
                DurationEditable := false;
                EffectiveDateEditable := false;
                DestinationAccountTypeEditable := false;
            end;
    end;

    trigger OnOpenPage()
    begin
        if Status = Status::Approved then
            CurrPage.Editable := false;

        ReceiptAllVisible := false;
        if "Destination Account Type" = "destination account type"::BOSA then begin
            ReceiptAllVisible := true;
        end;

        BankDetailsVisible := false;
        if "Destination Account Type" = "destination account type"::External then begin
            BankDetailsVisible := true;
        end;





        if Status = Status::Open then begin
            AmountEditable := true;
            DestinationAccountNoEditable := true;
            DestinationAccountNameEditable := true;
            FrequencyEditable := true;
            DurationEditable := true;
            EffectiveDateEditable := true;
            DestinationAccountTypeEditable := true
        end else
            if Status = Status::Pending then begin
                AmountEditable := false;
                DestinationAccountNoEditable := false;
                DestinationAccountNameEditable := false;
                FrequencyEditable := false;
                DurationEditable := false;
                EffectiveDateEditable := false;
                DestinationAccountTypeEditable := false
            end else begin
                AmountEditable := false;
                DestinationAccountNoEditable := false;
                DestinationAccountNameEditable := false;
                FrequencyEditable := false;
                DurationEditable := false;
                EffectiveDateEditable := false;
                DestinationAccountTypeEditable := false;
            end;
    end;

    var
        StatusPermissions: Record "Status Change Permision";
        BankName: Text[20];
        Banks: Record Banks;
        UsersID: Record User;
        RAllocations: Record "Receipt Allocation";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        ReceiptAllVisible: Boolean;
        ObjAccount: Record Vendor;
        BankDetailsVisible: Boolean;
        AmountEditable: Boolean;
        DestinationAccountTypeEditable: Boolean;
        DestinationAccountNoEditable: Boolean;
        EffectiveDateEditable: Boolean;
        FrequencyEditable: Boolean;
        DescriptionEditable: Boolean;
        DestinationAccountNameEditable: Boolean;
        DurationEditable: Boolean;
        DestinationAccountsVisible: Boolean;

    local procedure AllocatedAmountOnDeactivate()
    begin
        CurrPage.Update := true;
    end;
}

