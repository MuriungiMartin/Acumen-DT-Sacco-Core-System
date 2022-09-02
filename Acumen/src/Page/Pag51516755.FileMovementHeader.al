#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516755 "File Movement Header"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "File Movement Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field("Date Requested";"Date Requested")
                {
                    ApplicationArea = Basic;
                }
                field("Requested By";"Requested By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Retrieved";"Date Retrieved")
                {
                    ApplicationArea = Basic;
                }
                field("Responsiblity Center";"Responsiblity Center")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Duration Requested";"Duration Requested")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Return Date";"Expected Return Date")
                {
                    ApplicationArea = Basic;
                }
                field("Date Returned";"Date Returned")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved By";"Retrieved By")
                {
                    ApplicationArea = Basic;
                }
                field("Returned By";"Returned By")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code";"Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Global Dimension 2 Code";"Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Issuing File Location";"Issuing File Location")
                {
                    ApplicationArea = Basic;
                }
                field("File Movement Status";"File Movement Status")
                {
                    ApplicationArea = Basic;
                }
                field("Current File Location";"Current File Location")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1000000023;"File Movement Line")
            {
                SubPageLink = "Document No."=field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Approvals)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = false;

                trigger OnAction()
                begin
                    DocumentType:=Documenttype::"File Movement";
                    ApprovalEntries.Setfilters(Database::"File Movement Header",DocumentType,"No.");
                    ApprovalEntries.Run;
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = false;

                trigger OnAction()
                begin
                    //OnSend Approval
                     //IF ApprovalsMgmt.CHECKFI(Rec) THEN
                     // ApprovalsMgmt.OnSendFileMovementDocForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Re&quest';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = false;

                trigger OnAction()
                begin
                    // IF ApprovalsMgmt.CheckFileMovementApprovalWorkflowEnabled(Rec) THEN
                    //   ApprovalsMgmt.OnCancelFileMovementApprovalRequest(Rec);
                end;
            }
            action("Dispatch File")
            {
                ApplicationArea = Basic;
                Caption = 'Dispatch File';
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    "Retrieved By":=UserId;
                end;
            }
            action("Receive File")
            {
                ApplicationArea = Basic;
                Caption = 'Receive File';
                Image = Add;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    "Returned By":=UserId
                end;
            }
            action("Transfer File")
            {
                ApplicationArea = Basic;
                Caption = 'Transfer File';
                Image = AssemblyBOM;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    "Current File Location":='REGISRTY';
                end;
            }
        }
    }

    trigger OnInit()
    begin
        if Status = Status::Approved then
          CurrPage.Editable:=false;
    end;

    trigger OnOpenPage()
    begin
        if Status = Status::Approved then
          CurrPage.Editable:=false;
        "Issuing File Location":='REGISRTY';
    end;

    var
        DocumentType: Option " ",Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Withdrawal","Membership Reg","Loan Batches","Payment Voucher","Petty Cash",Loan,Interbank,Checkoff,"Savings Product Opening","Standing Order",ChangeRequest,Custodial,"File Movement";
        ApprovalEntries: Page "Approval Entries";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
}

