#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516996 "Member Agent/NOK Change Card"
{
    PageType = Card;
    SourceTable = "Member Agent/Next Of Kin Chang";

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
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = AccountTypeEditable;
                    Visible = false;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Change Type";"Change Type")
                {
                    ApplicationArea = Basic;
                    Editable = ChangeTypeEditable;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        FnGetListShow();
                    end;
                }
                field("Captured By";"Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Captured On";"Captured On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Change Effected";"Change Effected")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("BOSA Next of Kin";"Members Nominee Details Temp")
            {
                SubPageLink = "Account No"=field("Member No"),
                              "Document No"=field("Document No");
            }
            part("FOSA Next Of Kin";"FOSA Account  NOK Details")
            {
                SubPageLink = "Account No"=field("Account No");
                Visible = VarFOSANOKVisible;
            }
            part("Account Agent";"Agent Account Signatory list")
            {
                SubPageLink = "Account No"=field("Account No");
                Visible = VarAccountAgentVisible;
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
                    MembersNomineeTemp.Reset;
                    MembersNomineeTemp.SetRange("Account No","Member No");
                    MembersNomineeTemp.SetRange(MembersNomineeTemp."Document No","Document No");
                    if MembersNomineeTemp.Find('-') then begin
                      repeat

                        if MembersNomineeTemp."Add New" then begin
                          MemberNominee.Init;
                          MemberNominee."%Allocation":=MembersNomineeTemp."%Allocation(New)";
                          MemberNominee.Relationship:=MembersNomineeTemp."Relationship(New)";
                          MemberNominee."Date of Birth":=MembersNomineeTemp."Date of Birth(New)";
                          MemberNominee.Name:=MembersNomineeTemp.Name;
                          MemberNominee.Address:=MembersNomineeTemp."Address(New)";
                          MemberNominee.Telephone:=MembersNomineeTemp."Telephone(New)";
                          MemberNominee.Email:=MembersNomineeTemp."Email(New)";
                          MemberNominee."ID No.":=MembersNomineeTemp."ID No.(New)";
                          MemberNominee."Next Of Kin Type":=MembersNomineeTemp."Next Of Kin Type(New)";
                          MemberNominee.Insert(true);
                          Commit;
                        end else begin
                          MemberNominee.Reset;
                          MemberNominee.SetRange("Account No","Member No");
                          MemberNominee.SetRange(Name,MembersNomineeTemp.Name);
                                //MemberNominee.SETRANGE(Name,MembersNomineeTemp.Name);
                          if MemberNominee.Find('-') then begin
                          if MembersNomineeTemp."%Allocation(New)"<>0 then
                          MemberNominee."%Allocation":=MembersNomineeTemp."%Allocation(New)";
                          if MembersNomineeTemp."Relationship(New)"<>'' then
                          MemberNominee.Relationship:=MembersNomineeTemp."Relationship(New)";
                          if MembersNomineeTemp."Date of Birth(New)"<>0D then
                          MemberNominee."Date of Birth":=MembersNomineeTemp."Date of Birth(New)";
                          if MembersNomineeTemp."Address(New)"<>'' then
                          MemberNominee.Address:=MembersNomineeTemp."Address(New)";
                          if MembersNomineeTemp."Telephone(New)"<>'' then
                          MemberNominee.Telephone:=MembersNomineeTemp."Telephone(New)";
                          if MembersNomineeTemp."Email(New)"<>'' then
                          MemberNominee.Email:=MembersNomineeTemp."Email(New)";
                          if MembersNomineeTemp."ID No.(New)"<>'' then
                          MemberNominee."ID No.":=MembersNomineeTemp."ID No.(New)";
                          if MembersNomineeTemp."Next Of Kin Type(New)"<>MembersNomineeTemp."next of kin type(new)"::" " then
                          MemberNominee."Next Of Kin Type":=MembersNomineeTemp."Next Of Kin Type(New)";

                          MemberNominee.Modify(true);
                          end;
                        end;
                        "Change Effected":=true;
                      until MembersNomineeTemp.Next=0;
                    end;
                    //Delete old records,

                    MembersNomineeTemp.Reset;
                    MembersNomineeTemp.SetRange("Account No","Member No");
                    MembersNomineeTemp.SetRange(Remove,true);
                    if MembersNomineeTemp.Find('-') then begin
                        repeat
                        MemberNominee.Reset;
                        MemberNominee.SetRange("Account No","Member No");
                        MemberNominee.SetRange(Name,MembersNomineeTemp.Name);
                        if MemberNominee.Find('-') then begin
                          MemberNominee.Delete;
                        end;
                        until MembersNomineeTemp.Next=0;
                    end;
                      Message('Record updated Succesfully');
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

                    if ApprovalsMgmt.CheckMemberAgentNOKChangeApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendMemberAgentNOKChangeForApproval(Rec);
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
                     ApprovalsMgmt.OnCancelMemberAgentNOKChangeApprovalRequest(Rec);
                      //Status:=Status::Open;
                      //MODIFY;
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
                    // // DocumentType:=DocumentType::MemberAgentNOKChange;
                    // // ApprovalEntries.Setfilters(DATABASE::"Next Of Kin Change",DocumentType,"Document No");
                    // // ApprovalEntries.RUN;
                end;
            }
            action("Load Next of Kin Details")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Status=Status::Approved then
                      Error('You cannot modify an approved document!');
                    MembersNomineeTemp.Reset;
                    MembersNomineeTemp.SetRange("Account No","Member No");
                    MembersNomineeTemp.SetRange(MembersNomineeTemp."Document No","Document No");
                    if MembersNomineeTemp.Find('-') then begin
                      if Confirm('Loading next of kin details will clear the current changes on the lines,proceed?',false)=true then
                      MembersNomineeTemp.DeleteAll;
                    end;
                    MemberNominee.Reset;
                    MemberNominee.SetRange("Account No","Member No");
                    if MemberNominee.Find('-') then begin
                      repeat
                        //MembersNomineeTemp.TRANSFERFIELDS(MemberNominee);
                        MembersNomineeTemp."Entry No":=0;
                        MembersNomineeTemp."Document No":="Document No";
                        MembersNomineeTemp.Name:=MemberNominee.Name;
                        MembersNomineeTemp.Relationship:=MemberNominee.Relationship;
                        MembersNomineeTemp.Address:=MemberNominee.Address;
                        MembersNomineeTemp."Date of Birth":=MemberNominee."Date of Birth";
                        MembersNomineeTemp.Telephone:=MemberNominee.Email;
                        MembersNomineeTemp."Account No":=MemberNominee."Account No";
                        MembersNomineeTemp."ID No.":=MemberNominee."ID No.";
                        MembersNomineeTemp."%Allocation":=MemberNominee."%Allocation";
                        MembersNomineeTemp."Next Of Kin Type":=MemberNominee."Next Of Kin Type";
                        MembersNomineeTemp.Existing:=true;
                        MembersNomineeTemp.Insert;
                      until MemberNominee.Next=0;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FnGetListShow();

        EnableCreateMember:=false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist :=true;

        if ((Rec.Status=Status::Approved) ) then
            EnableCreateMember:=true;
    end;

    trigger OnAfterGetRecord()
    begin
        if Status=Status::Open then
          begin
          MemberNoEditable:=true;
          AccountTypeEditable:=true;
          AccountNoEditable:=true;
          ChangeTypeEditable:=true
          end else
            if Status=Status::"Pending Approval" then
              begin
              MemberNoEditable:=false;
              AccountTypeEditable:=false;
              AccountNoEditable:=false;
              ChangeTypeEditable:=false
              end else
              if Status=Status::Approved then
                begin
                  MemberNoEditable:=false;
                  AccountTypeEditable:=false;
                  AccountNoEditable:=false;
                  ChangeTypeEditable:=false;
                  end;

        EnableCreateMember:=false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist :=true;

        if ((Rec.Status=Status::Approved) ) then
            EnableCreateMember:=true;
    end;

    trigger OnOpenPage()
    begin
        FnGetListShow();

        if Status=Status::Open then
          begin
          MemberNoEditable:=true;
          AccountTypeEditable:=true;
          AccountNoEditable:=true;
          ChangeTypeEditable:=true
          end else
            if Status=Status::"Pending Approval" then
              begin
              MemberNoEditable:=false;
              AccountTypeEditable:=false;
              AccountNoEditable:=false;
              ChangeTypeEditable:=false
              end else
              if Status=Status::Approved then
                begin
                  MemberNoEditable:=false;
                  AccountTypeEditable:=false;
                  AccountNoEditable:=false;
                  ChangeTypeEditable:=false;
                  end;
    end;

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange;
        EnableCreateMember: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        ObjCust: Record "Member Register";
        MemberNoEditable: Boolean;
        AccountNoEditable: Boolean;
        ChangeTypeEditable: Boolean;
        AccountTypeEditable: Boolean;
        VarBOSANOKVisible: Boolean;
        VarFOSANOKVisible: Boolean;
        VarAccountAgentVisible: Boolean;
        MemberNominee: Record "Members Nominee";
        MembersNomineeTemp: Record "Members Nominee Temp";

    local procedure FnGetListShow()
    begin
        VarAccountAgentVisible:=false;
        VarFOSANOKVisible:=false;
        VarBOSANOKVisible:=false;


        if ("Change Type"="change type"::"Account Next Of Kin Change") and ("Account Type"="account type"::BOSA) then
          begin
            VarAccountAgentVisible:=false;
            VarFOSANOKVisible:=false;
            VarBOSANOKVisible:=true;
            end else
            if ("Change Type"="change type"::"Account Next Of Kin Change") and ("Account Type"="account type"::FOSA) then
              begin
                VarAccountAgentVisible:=false;
                VarFOSANOKVisible:=true;
                VarBOSANOKVisible:=false;
                if ("Change Type"="change type"::"Account Agent Change") and ("Account Type"="account type"::FOSA) then
                  begin
                    VarAccountAgentVisible:=true;
                    VarFOSANOKVisible:=false;
                    VarBOSANOKVisible:=false;
                    end;

        end;
    end;
}

