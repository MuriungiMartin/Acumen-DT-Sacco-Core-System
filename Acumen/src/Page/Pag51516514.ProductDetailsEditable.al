#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516514 "Product Details Editable"
{
    CardPageID = "Product Card Editable";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Vendor;
    SourceTableView = where("Debtor Type" = const("FOSA Account"));

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
                field("Search Name"; "Search Name")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Processing"; "Salary Processing")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("ATM No."""; "ATM No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'ATM No.';
                }
                field("Personal No."; "Personal No.")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Account No"; "BOSA Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No.';
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Balance; Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Loans"; "Outstanding Loans")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest"; "Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Acc. No"; "Cheque Acc. No")
                {
                    ApplicationArea = Basic;
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
                action("Import employer Code-FOSA")
                {
                    ApplicationArea = Basic;
                    Image = import;
                    RunObject = XMLport UnknownXMLport50054;
                }
            }
        }
    }

    var
        Cust: Record Customer;
        Vend: Record Vendor;
}

