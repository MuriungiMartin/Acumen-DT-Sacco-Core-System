#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516013 "Guarantor Sub Card"
{
    PageType = Card;
    SourceTable = "Guarantorship Substitution H";

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
                field("Application Date";"Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loanee Member No";"Loanee Member No")
                {
                    ApplicationArea = Basic;
                    Editable = LoaneeNoEditable;
                }
                field("Loanee Name";"Loanee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Guaranteed";"Loan Guaranteed")
                {
                    ApplicationArea = Basic;
                    Editable = LoanGuaranteedEditable;
                }
                field("Substituting Member";"Substituting Member")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member to be substuted';
                    Editable = SubMemberEditable;
                }
                field("Substituting Member Name";"Substituting Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By";"Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Substituted;Substituted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Substituted";"Date Substituted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Substituted By";"Substituted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1000000014;"Guarantor Sub Subform")
            {
                SubPageLink = "Document No"=field("Document No"),
                              "Member No"=field("Substituting Member"),
                              "Loan No."=field("Loan Guaranteed");
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

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    // DocumentType:=DocumentType::GuarantorSubstitution;
                    //
                    // ApprovalEntries.Setfilters(DATABASE::"Guarantorship Substitution H",DocumentType,"Document No");
                    // ApprovalEntries.RUN;
                    ApprovalsMgmt.OpenApprovalEntriesPage(RecordId);
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    if Status<>Status::Open then
                    Error('Status must be open.');

                    if ApprovalsMgmt.CheckGuarSubApprovalWorkflowEnabled(Rec) then
                      ApprovalsMgmt.OnSendGuarSubForApproval(Rec);

                    //Status:=Status::Approved;
                    //MODIFY;
                    //MESSAGE('Successful!!');
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel A&pproval Request';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                       if Status<>Status::Pending then
                          Error(text001);

                      if ApprovalsMgmt.CheckGuarSubApprovalWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnCancelGuarSubApprovalRequest(Rec);
                end;
            }
            action("Process Substitution")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Status<>Status::Approved then;
                     // ERROR('This Application has to be Approved');

                    LGuarantor.Reset;
                    LGuarantor.SetRange(LGuarantor."Loan No","Loan Guaranteed");
                    LGuarantor.SetRange(LGuarantor."Member No","Substituting Member");
                    if LGuarantor.FindSet then begin
                      //Add All Replaced Amounts
                      TotalReplaced:=0;
                      GSubLine.Reset;
                      GSubLine.SetRange(GSubLine."Document No","Document No");
                      GSubLine.SetRange(GSubLine."Member No","Substituting Member");
                      if GSubLine.FindSet then begin
                        repeat
                          TotalReplaced:=TotalReplaced+GSubLine."Sub Amount Guaranteed";
                          until GSubLine.Next=0;
                        end;
                      //End Add All Replaced Amounts

                      //Compare with committed shares
                      Commited:=LGuarantor."Amont Guaranteed";
                      if TotalReplaced <Commited then
                        //ERROR('Guarantors replaced do not cover the whole amount');
                      //End Compare with committed Shares

                      //Create Lines
                      GSubLine.Reset;
                      GSubLine.SetRange(GSubLine."Document No","Document No");
                      GSubLine.SetRange(GSubLine."Member No","Substituting Member");
                      if GSubLine.FindSet then begin
                        repeat
                          NewLGuar.Init;
                          NewLGuar."Loan No":="Loan Guaranteed";
                          NewLGuar."Guar Sub Doc No.":="Document No";
                          NewLGuar."Member No":=GSubLine."Substitute Member";
                          NewLGuar.Validate(NewLGuar."Member No");
                          NewLGuar.Name:=GSubLine."Substitute Member Name";
                          NewLGuar."Committed Shares":=GSubLine."Sub Amount Guaranteed";
                          NewLGuar."Amont Guaranteed":=GSubLine."Sub Amount Guaranteed";//CalculateAmountGuaranteed(GSubLine."Sub Amount Guaranteed",TotalReplaced,GSubLine."Amount Guaranteed");
                          NewLGuar."Substituted Guarantor":=GSubLine."Member No";
                          NewLGuar.Insert;
                          until GSubLine.Next=0;
                        end;
                      //End Create Lines

                      //Edit Loan Guar
                        LGuarantor.Substituted:=true;
                        LGuarantor."Committed Shares" := 0;
                        LGuarantor."Guar Sub Doc No.":="Document No";
                        LGuarantor.Modify;
                        //End Edit Loan Guar

                      Substituted:=true;
                      "Date Substituted":=Today;
                      "Substituted By":=UserId;
                      Modify;

                      Message('Guarantor Substituted Succesfully');
                      end;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FNAddRecordRestriction();
    end;

    trigger OnAfterGetRecord()
    begin
        FNAddRecordRestriction();
    end;

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,GuarantorSubstitution;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        LGuarantor: Record "Loans Guarantee Details";
        GSubLine: Record "Guarantorship Substitution L";
        LoaneeNoEditable: Boolean;
        LoanGuaranteedEditable: Boolean;
        SubMemberEditable: Boolean;
        TotalReplaced: Decimal;
        Commited: Decimal;
        NewLGuar: Record "Loans Guarantee Details";

    local procedure FNAddRecordRestriction()
    begin
        if Status=Status::Open then begin
           LoaneeNoEditable:=true;
           LoanGuaranteedEditable:=true;
           SubMemberEditable:=true
           end else
            if Status=Status::Pending then begin
             LoaneeNoEditable:=false;
             LoanGuaranteedEditable:=false;
             SubMemberEditable:=false
             end else
              if Status=Status::Approved then begin
               LoaneeNoEditable:=false;
               LoanGuaranteedEditable:=false;
               SubMemberEditable:=false;
               end;
    end;

    local procedure CalculateAmountGuaranteed(AmountReplaced: Decimal;TotalAmount: Decimal;AmountGuaranteed: Decimal) AmtGuar: Decimal
    begin
        AmtGuar:=((AmountReplaced/TotalAmount)*AmountGuaranteed);

        exit(AmtGuar);
    end;
}

