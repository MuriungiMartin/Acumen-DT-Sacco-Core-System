#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516584 "Standing Orders - List Approve"
{
    ApplicationArea = Basic;
    CardPageID = "Standing Order Card Approved";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Standing Orders";
    SourceTableView = where(Status=filter(Approved));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Active;"Is Active")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account No.";"Source Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Staff/Payroll No.";"Staff/Payroll No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("None Salary";"None Salary")
                {
                    ApplicationArea = Basic;
                }
                field("Next Run Date";"Next Run Date")
                {
                    ApplicationArea = Basic;
                }
                field("Date Reset";"Date Reset")
                {
                    ApplicationArea = Basic;
                }
                field("Effective/Start Date";"Effective/Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Allocated Amount";"Allocated Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Type";"Destination Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account No.";"Destination Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Name";"Destination Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Standing Order Description";"Standing Order Description")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Account No.";"BOSA Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Old STO No.";"Old STO No.")
                {
                    ApplicationArea = Basic;
                }
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

                    Effected:=false;
                    Balance:=0;
                    Unsuccessfull:=false;
                    "Auto Process":=false;
                    "Date Reset":=Today;
                    Modify;

                    RAllocations.Reset;
                    RAllocations.SetRange(RAllocations."Document No","No.");
                    if RAllocations.Find('-') then begin
                    repeat
                    RAllocations."Amount Balance":=0;
                    RAllocations."Interest Balance":=0;
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
                    StatusPermissions.SetRange(StatusPermissions."User ID",UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::"Standing Order");
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
                    StatusPermissions.SetRange(StatusPermissions."User ID",UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                    Error('You do not have permissions to change the standing status.');
                end;
            }
            action(Stop)
            {
                ApplicationArea = Basic;
                Caption = 'Stop';
                Image = DeactivateDiscounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID",UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                    Error('You do not have permissions to stop the standing order.');

                    if Confirm('Are you sure you want to stop the standing order?',false) = true then begin
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
                        DocumentType:=Documenttype::STO;
                        ApprovalEntries.Setfilters(Database::"HR Commitee Members",DocumentType,"No.");
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
                    Visible = false;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        TestField("Source Account No.");
                        if "Destination Account Type" <> "destination account type"::BOSA then
                        TestField("Destination Account No.");

                        TestField("Effective/Start Date");
                        TestField(Frequency);
                        TestField("Next Run Date");

                        if "Destination Account Type" = "destination account type"::BOSA then begin
                        CalcFields("Allocated Amount");
                        if Amount<>"Allocated Amount" then
                        Error('Allocated amount must be equal to amount');
                        end;

                        if Status<>Status::Open then
                        Error(Text001);



                        //End allocate batch number
                        //IF Approvalmgt.SendFOSASTOApprovalRequest(Rec) THEN;
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
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin

                        //IF Approvalmgt.CancelFOSASTOApprovalRequest(Rec,TRUE,TRUE) THEN;
                        Status:=Status::Open;
                        Modify;
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

                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID",UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::"Standing Order");
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
                    StatusPermissions.SetRange(StatusPermissions."User ID",UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                    Error('You do not have permissions to stop the standing order.');

                    if Confirm('Are you sure you want to stop the standing order?',false) = true then begin
                    end;
                end;
            }
        }
    }

    var
        StatusPermissions: Record "Status Change Permision";
        BankName: Text[200];
        Banks: Record Banks;
        UsersID: Record User;
        RAllocations: Record "Receipt Allocation";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",STO;
}

