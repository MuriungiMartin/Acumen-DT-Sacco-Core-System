#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516335 "Fixed Deposit Acc. List"
{
    ApplicationArea = Basic;
    CardPageID = "FOSA Account Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Vendor;
    SourceTableView = where("Debtor Type" = const("FOSA Account"),
                            "Account Type" = const('FIXED'));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Account No"; "BOSA Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Personal No."; "Personal No.")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Earned"; "Interest Earned")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest Earned';
                }
                field("Fixed Deposit Status"; "Fixed Deposit Status")
                {
                    ApplicationArea = Basic;
                }
                field("FD Maturity Date"; "FD Maturity Date")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Duration"; "Expected Interest On Term Dep")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Interest';
                }
                field("Date Renewed"; "Date Renewed")
                {
                    ApplicationArea = Basic;
                }
                field("FD Duration"; "FD Duration")
                {
                    ApplicationArea = Basic;
                    Caption = 'FD Duration';
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Interest rate"; "Interest rate")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Savings Account No."; "Savings Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Account No.';
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000001; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Account)
            {
                Caption = 'Account';
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No." = field("No.");
                    RunPageView = sorting("Vendor No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = const(Vendor),
                                  "No." = field("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = const(23),
                                  "No." = field("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                separator(Action1102755228)
                {
                }
                separator(Action1102755226)
                {
                }
                separator(Action1102755225)
                {
                }
                action("Member Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Card';
                    Image = Planning;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Account Card";
                    RunPageLink = "No." = field("BOSA Account No");
                }
                action("<Action11027600800>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Statements';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(,TRUE,TRUE,Cust)
                        */

                    end;
                }
                separator(Action1102755222)
                {
                }
            }
            group(ActionGroup1102755220)
            {
                action("Nominee Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Nominee Details';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "FOSA Account  NOK Details";
                    RunPageLink = "Account No" = field("No.");
                }
                separator(Action1102755217)
                {
                }
                action("Page Vendor Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin

                        Vend.Reset;
                        Vend.SetRange(Vend."No.", "No.");
                        if Vend.Find('-') then
                            Report.Run(51516476, true, false, Vend)
                    end;
                }
                action("Page Vendor Statistics")
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Page "Vendor Statistics";
                    RunPageLink = "No." = field("No."),
                                  "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                }
            }
        }
    }

    var
        Cust: Record Customer;
        Vend: Record Vendor;
}

