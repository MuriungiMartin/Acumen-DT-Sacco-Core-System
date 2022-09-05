#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516408 "Membership Exit List"
{
    ApplicationArea = Basic;
    CardPageID = "Membership Exit Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption';
    SourceTable = "Membership Exit";
    SourceTableView = where(Posted = filter(false),
                            "Ready to Exit" = filter(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member No."; "Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Closing Date"; "Closing Date")
                {
                    ApplicationArea = Basic;
                }
                field("Total Loan"; "Total Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Total Interest"; "Total Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Member Deposits"; "Member Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::"Member Closure";
                        ApprovalEntries.Setfilters(Database::"HR Leave Register", DocumentType, "No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetRange("User ID", UserId);
    end;

    var
        Closure: Integer;
        Cust: Record Customer;
        UBFRefund: Decimal;
        Generalsetup: Record "Sacco General Set-Up";
        Totalavailable: Decimal;
        UnpaidDividends: Decimal;
        TotalOustanding: Decimal;
        Vend: Record Vendor;
        value2: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Totalrecovered: Decimal;
        Advice: Boolean;
        TotalDefaulterR: Decimal;
        AvailableShares: Decimal;
        Loans: Record "Loans Register";
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        Vendno: Code[20];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff;
}

