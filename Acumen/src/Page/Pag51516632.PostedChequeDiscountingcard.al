#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516632 "Posted Cheque Discounting card"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    SourceTable = "Cheque Discounting";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Transaction No";"Transaction No")
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
                field("Savings Product";"Savings Product")
                {
                    ApplicationArea = Basic;
                    Editable = SavingsProductEditable;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                    Editable = AccountNoEditable;
                }
                field("Cheque to Discount";"Cheque to Discount")
                {
                    ApplicationArea = Basic;
                    Editable = ChequetoDiscountEditable;
                }
                field("Cheque Amount";"Cheque Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque No";"Cheque No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Maturity Date";"Expected Maturity Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Percentage Discount";"Percentage Discount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Discount Amount Allowable";"Discount Amount Allowable")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount Discounted";"Amount Discounted")
                {
                    ApplicationArea = Basic;
                    Editable = AmounttoDiscountEditable;
                }
                field("Discounted Amount+Fee";"Discounted Amount+Fee")
                {
                    ApplicationArea = Basic;
                    Caption = 'Discounted Amount-Commission';
                    Editable = false;
                    Visible = false;
                }
                field("Cheque Discounting Commission";"Cheque Discounting Commission")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Excise Duty";"Excise Duty")
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
                field("Date Created";"Date Created")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By";"Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Posted";"Date Posted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000029;"FOSA Statistics FactBox")
            {
                SubPageLink = "No."=field("Account No");
            }
            part(Control1000000028;"Member Statistics FactBox")
            {
                SubPageLink = "No."=field("Member No");
            }
            part(Control1000000027;"Vendor Picture-Uploaded")
            {
                SubPageLink = "No."=field("Account No");
            }
            part(Control1000000026;"Vendor Signature-Uploaded")
            {
                SubPageLink = "No."=field("Account No");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Ledger Entries")
            {
                ApplicationArea = Basic;
                Image = LedgerEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Discounting Ledger Entry";
                RunPageLink = "Cheque No"=field("Cheque No"),
                              "Fosa Account"=field("Account No");
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin

                        DocumentType:=Documenttype::ChequeDiscounting;
                        ApprovalEntries.Setfilters(Database::"Cheque Discounting",DocumentType,"Transaction No");
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FnAddRecordRestriction();

        EnablePosting:=false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist :=true;
        if Rec.Status=Status::Approved then begin
          OpenApprovalEntriesExist:=false;
          CanCancelApprovalForRecord:=false;
          EnabledApprovalWorkflowsExist:=false;
          end;
          if (Rec.Status=Status::Approved)  then
            EnablePosting:=true;
    end;

    trigger OnAfterGetRecord()
    begin
        FnAddRecordRestriction();
    end;

    trigger OnOpenPage()
    begin
        FnAddRecordRestriction();
    end;

    var
        Accounts: Record Vendor;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting;
        MemberNoEditable: Boolean;
        SavingsProductEditable: Boolean;
        AccountNoEditable: Boolean;
        ChequetoDiscountEditable: Boolean;
        AmounttoDiscountEditable: Boolean;
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnablePosting: Boolean;

    local procedure FnAddRecordRestriction()
    begin
        if Status=Status::Open then begin
          MemberNoEditable:=true;
          SavingsProductEditable:=true;
          AccountNoEditable:=true;
          ChequetoDiscountEditable:=true;
          AmounttoDiscountEditable:=true
        end else
        if Status=Status::"Pending Approval" then begin
          MemberNoEditable:=false;
          SavingsProductEditable:=false;
          AccountNoEditable:=false;
          ChequetoDiscountEditable:=false;
          AmounttoDiscountEditable:=false
          end else
        if Status=Status::Approved then begin
          MemberNoEditable:=false;
          SavingsProductEditable:=false;
          AccountNoEditable:=false;
          ChequetoDiscountEditable:=false;
          AmounttoDiscountEditable:=false
          end;
    end;
}

