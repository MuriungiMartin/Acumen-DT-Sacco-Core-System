#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516983 "House Change Request Change"
{
    PageType = Card;
    SourceTable = "House Group Change Request";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No";"Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                    Editable = MemberNoEditable;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("House Group";"House Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("House Group Name";"House Group Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Change Type";"Change Type")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Cell";"Destination Cell")
                {
                    ApplicationArea = Basic;
                    Editable = DestinationHouseEditable;
                }
                field("Destination Cell Group";"Destination Cell Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("House Group Status";"House Group Status")
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Changing Groups";"Reason For Changing Groups")
                {
                    ApplicationArea = Basic;
                    Editable = ReasonforChangeEditable;
                }
                field("Date Group Changed";"Date Group Changed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Changed By";"Changed By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Deposits on Date of Change";"Deposits on Date of Change")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposits On the Date of Change';
                    Editable = false;
                }
                field("Outs. Loans on Date of Change";"Outs. Loans on Date of Change")
                {
                    ApplicationArea = Basic;
                    Caption = 'Outstanding Loans On the Date of Change';
                    Editable = false;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Change Effected";"Change Effected")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Effect Change")
            {
                ApplicationArea = Basic;
                Enabled = EnableCreateMember;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to effect this change?',false)=true then begin
                      if ObjCust.Get("Member No") then begin
                        ObjCust."Member House Group":="Destination Cell";
                        ObjCust."Member House Group Name":="Destination Cell Group";
                        ObjCust."House Group Status":=ObjCust."house group status"::Active;
                        "Date Group Changed":=Today;
                        "Changed By":=UserId;
                        "Change Effected":=true;
                        ObjCust.Modify;
                        end;
                    end;
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
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ObjHouseGroups.Reset;
                    ObjHouseGroups.SetRange(ObjHouseGroups."Group Leader","Member No");
                    if ObjHouseGroups.Find('-')=true then
                      begin
                        FnGroupLeaderExitNotification();
                        end;

                    ObjHouseGroups.Reset;
                    ObjHouseGroups.SetRange(ObjHouseGroups."Assistant group Leader","Member No");
                    if ObjHouseGroups.Find('-')=true then
                      begin
                        FnGroupLeaderExitNotification();
                        end;


                    if ApprovalsMgmt.CheckHouseChangeApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendHouseChangeForApproval(Rec);
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
                    Approvalmgt: Codeunit "Approvals Mgmt.";
                begin
                    if Confirm('Are you sure you want to cancel this approval request',false)=true then
                     ApprovalsMgmt.OnCancelHouseChangeApprovalRequest(Rec);
                      Status:=Status::Open;
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
                    DocumentType:=Documenttype::HouseChange;
                    ApprovalEntries.Setfilters(Database::"House Group Change Request",DocumentType,"Document No");
                    ApprovalEntries.Run;
                end;
            }
            action("Member is  a Guarantor")
            {
                ApplicationArea = Basic;
                Caption = 'Loans Guaranteed';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.","Member No");
                    if ObjCust.Find('-') then
                    Report.Run(51516503,true,false,ObjCust);
                end;
            }
            action("Member is  Guaranteed")
            {
                ApplicationArea = Basic;
                Caption = 'Member is  Guaranteed';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.","Member No");
                    if ObjCust.Find('-') then
                    Report.Run(51516504,true,false,ObjCust);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        MemberNoEditable:=false;
        DestinationHouseEditable:=false;
        ReasonforChangeEditable:=false;

        if Status=Status::Open then
          begin
          MemberNoEditable:=true;
          DestinationHouseEditable:=true;
          ReasonforChangeEditable:=true
          end else
            if Status=Status::"Pending Approval" then
              begin
              MemberNoEditable:=false;
              DestinationHouseEditable:=false;
              ReasonforChangeEditable:=false
              end else
              if Status=Status::Approved then
                begin
                  MemberNoEditable:=false;
                  DestinationHouseEditable:=false;
                  ReasonforChangeEditable:=false;
                  end;

        EnableCreateMember:=false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist :=true;

        if ((Rec.Status=Status::Approved) ) then
            EnableCreateMember:=true;
    end;

    trigger OnAfterGetRecord()
    begin

        EnableCreateMember:=false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist :=true;

        if ((Rec.Status=Status::Approved) ) then
            EnableCreateMember:=true;
    end;

    trigger OnOpenPage()
    begin
        MemberNoEditable:=false;
        DestinationHouseEditable:=false;
        ReasonforChangeEditable:=false;

        if Status=Status::Open then
          begin
          MemberNoEditable:=true;
          DestinationHouseEditable:=true;
          ReasonforChangeEditable:=true
          end else
            if Status=Status::"Pending Approval" then
              begin
              MemberNoEditable:=false;
              DestinationHouseEditable:=false;
              ReasonforChangeEditable:=false
              end else
              if Status=Status::Approved then
                begin
                  MemberNoEditable:=false;
                  DestinationHouseEditable:=false;
                  ReasonforChangeEditable:=false;
                  end;
    end;

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange;
        EnableCreateMember: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        ObjCust: Record "Member Register";
        MemberNoEditable: Boolean;
        DestinationHouseEditable: Boolean;
        ReasonforChangeEditable: Boolean;
        ExitMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Group Leader Group Exit </p><p style="font-family:Verdana,Arial;font-size:9pt">This is to inform you that %2  a group Leader of  %3  has applied to exit the Group,house group change application no %4,</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%5</p><p><b>KINGDOM SACCO LTD</b></p>';
        ObjHouseGroups: Record "Member House Groups";

    local procedure FnGroupLeaderExitNotification()
    var
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        ObjUser: Record User;
        ObjHouseGroups: Record "Member House Groups";
        VarGroupOfficer: Code[50];
    begin
        SMTPSetup.Get();

        if ObjHouseGroups.Get("House Group") then
          begin
            VarGroupOfficer:=ObjHouseGroups."Credit Officer";
            end;

          ObjUser.Reset;
          ObjUser.SetRange(ObjUser."User Name",VarGroupOfficer);
            if ObjUser.FindSet then
              begin
                if ObjUser."Contact Email"='' then
                  begin
                    Error ('Email Address Missing for User' +'-'+ VarGroupOfficer);
                  end;
                if ObjUser."Contact Email"<>'' then
                  SMTPMail.CreateMessage(SMTPSetup."Email Sender Name",SMTPSetup."Email Sender Address",ObjUser."Contact Email",'Group Leader Group Exit Notification','',true);
                  SMTPMail.AppendBody(StrSubstNo(ExitMessage,VarGroupOfficer,"Member Name","House Group Name","Document No",UserId));
                  SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
                  SMTPMail.AppendBody('<br><br>');
                  SMTPMail.AddAttachment(FileName,Attachment);
                  SMTPMail.Send;
                  Message('Email Sent');
              end;
    end;
}

