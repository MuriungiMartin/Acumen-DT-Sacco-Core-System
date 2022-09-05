#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516019 "Mobile Payment Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Payment Header.";
    SourceTableView = where("Payment Type" = const(Mobile));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Mode"; "Payment Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account"; "Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account Name"; "Bank Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account Balance"; "Bank Account Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Type"; "Cheque Type")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No"; "Cheque No")
                {
                    ApplicationArea = Basic;
                }
                field(Payee; Payee)
                {
                    ApplicationArea = Basic;
                }
                field("On Behalf Of"; "On Behalf Of")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Description"; "Payment Description")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Amount(LCY)"; "Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Amount"; "VAT Amount")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Amount(LCY)"; "VAT Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("WithHolding Tax Amount"; "WithHolding Tax Amount")
                {
                    ApplicationArea = Basic;
                }
                field("WithHolding Tax Amount(LCY)"; "WithHolding Tax Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount"; "Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount(LCY)"; "Net Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Cashier; Cashier)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control35; "Mobile Payment Line")
            {
                SubPageLink = Cashier = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Post Payment")
            {
                ApplicationArea = Basic;
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CheckRequiredItems;
                    TestField(Status, Status::Approved);
                    if FundsUser.Get(UserId) then begin
                        FundsUser.TestField(FundsUser."Payment Journal Template");
                        FundsUser.TestField(FundsUser."Payment Journal Batch");
                        JTemplate := FundsUser."Payment Journal Template";
                        JBatch := FundsUser."Payment Journal Batch";
                        FundsManager.PostPayment(Rec, JTemplate, JBatch);
                    end else begin
                        Error('User Account Not Setup, Contact the System Administrator');
                    end
                end;
            }
            action("Post and Print")
            {
                ApplicationArea = Basic;
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CheckRequiredItems;
                    TestField(Status, Status::Approved);
                    if FundsUser.Get(UserId) then begin
                        FundsUser.TestField(FundsUser."Payment Journal Template");
                        FundsUser.TestField(FundsUser."Payment Journal Batch");
                        JTemplate := FundsUser."Payment Journal Template";
                        JBatch := FundsUser."Payment Journal Batch";
                        FundsManager.PostPayment(Rec, JTemplate, JBatch);
                    end else begin
                        Error('User Account Not Setup, Contact the System Administrator');
                    end
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    TestField(Status, Status::New);

                    DocType := Doctype::"Payment Voucher";
                    Clear(TableID);
                    TableID := Database::"Payment Header.";
                    //IF ApprovalMgt.SendApproval(TableID,Rec."No.",DocType,Status) THEN;
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
            }
            action(Approvals)
            {
                ApplicationArea = Basic;
            }
            action(Print)
            {
                ApplicationArea = Basic;
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PHeader.Reset;
                    PHeader.SetRange(PHeader."No.", "No.");
                    if PHeader.FindFirst then begin
                        Report.RunModal(Report::"Mobile Money Voucher", true, false, PHeader);
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Payment Type" := "payment type"::Mobile;
    end;

    var
        FundsUser: Record "Funds User Setup";
        FundsManager: Codeunit "Funds Management";
        JTemplate: Code[20];
        JBatch: Code[20];
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
        TableID: Integer;
        ApprovalMgt: Codeunit WorkflowIntegration;
        PHeader: Record "Payment Header.";

    local procedure CheckRequiredItems()
    begin
        TestField("Posting Date");
        TestField(Payee);
        TestField("Bank Account");
        TestField("Payment Description");
        TestField("Global Dimension 1 Code");
        TestField("Global Dimension 2 Code");
    end;
}

