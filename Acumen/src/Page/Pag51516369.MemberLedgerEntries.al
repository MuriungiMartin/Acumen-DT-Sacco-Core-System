#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516369 "Member Ledger Entries"
{
    Caption = 'Member Ledger Entries';
    DataCaptionFields = "Customer No.";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Cust. Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan No"; "Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction No."; "Transaction No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Type"; "Loan Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Credit Amount"; "Credit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Debit Amount"; "Debit Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("IC Partner Code"; "IC Partner Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specifies the Work Date Transaction Date,for transactions that are Backdated';
                }
                field("Bal. Account Type"; "Bal. Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Bal. Account No."; "Bal. Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Source Code"; "Source Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Reason Code"; "Reason Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Reversed; Reversed)
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Reversed by Entry No."; "Reversed by Entry No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Reversed Entry No."; "Reversed Entry No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Reversal Date"; "Reversal Date")
                {
                    ApplicationArea = Basic;
                }
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part("Cust. Ledger Entry FactBox"; "Cust. Ledger Entry FactBox")
            {
                SubPageLink = "Entry No." = field("Entry No.");
                Visible = true;
            }
            systempart(Control1102755003; Links)
            {
                Visible = false;
            }
            systempart(Control1102755001; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Navigate")
                {
                    ApplicationArea = Basic;
                    Caption = '&Navigate';
                    Image = Navigate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Navigate.SetDoc("Posting Date", "Document No.");
                        Navigate.Run;
                    end;
                }
                action("Reverse Transaction")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reverse Transaction';
                    Ellipsis = true;
                    Image = ReverseLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ReversalEntry: Record "Reversal Entry";
                    begin

                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Reversal Right" = false then Error('You dont have permissions to Reverse, Contact your system administrator! ')
                        end;

                        Clear(ReversalEntry);
                        if Reversed then
                            ReversalEntry.AlreadyReversedEntry(TableCaption, "Entry No.");
                        if "Journal Batch Name" = '' then
                            ReversalEntry.TestFieldError;
                        TestField("Transaction No.");
                        if ("Loan No" <> '') and ("Transaction Type" = "transaction type"::Loan) then begin
                            ObjMemberLedgerEntries.Reset;
                            ObjMemberLedgerEntries.SetRange("Loan No", "Loan No");
                            ObjMemberLedgerEntries.SetRange(Reversed, false);
                            ObjMemberLedgerEntries.SetRange("Transaction Type", "transaction type"::"Loan Repayment");
                            if ObjMemberLedgerEntries.Find('-') then
                                Error('You cannot Reverse a Loan with Repayment Entries.')
                        end;

                        ReversalEntry.ReverseTransaction("Transaction No.");

                        if (("Loan No" <> '') and ("Transaction Type" = "transaction type"::Loan)) then begin
                            ObjMemberLedgerEntries.Reset;
                            ObjMemberLedgerEntries.SetRange("Loan No", "Loan No");
                            ObjMemberLedgerEntries.SetRange(Reversed, true);
                            ObjMemberLedgerEntries.SetRange("Transaction Type", "transaction type"::Loan);
                            if ObjMemberLedgerEntries.Find('-') then begin
                                ObjLoans.Reset;
                                ObjLoans.SetRange("Loan  No.", "Loan No");
                                if ObjLoans.Find('-') then begin
                                    Message('You are about to reverse a Loan.Yo will be Required to raise the Loan afresh.');
                                    ObjLoans.Reversed := true;
                                    ObjLoans.Modify;
                                    Message('You successfully reversed Loan No ' + "Loan No");
                                end

                            end
                        end
                    end;
                }
                action(Email)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send by &Email';
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Prepare to send the document by email. The Send Email window opens prefilled for the customer where you can add or change information before you send the email.';

                    trigger OnAction()
                    var
                        MemberLedger: Record "Cust. Ledger Entry";
                    begin
                        MemberLedger := Rec;
                        CurrPage.SetSelectionFilter(MemberLedger);
                       // MemberLedger.EmailRecords(true);
                    end;
                }
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        Codeunit.Run(Codeunit::"Cust. Entry-Edit", Rec);
        exit(false);
    end;

    var
        Navigate: Page Navigate;
        UserSetup: Record "User Setup";
        ObjMemberLedgerEntries: Record "Cust. Ledger Entry";
        ObjLoans: Record "Loans Register";
}

