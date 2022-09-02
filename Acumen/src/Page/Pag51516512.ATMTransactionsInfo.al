#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516512 "ATM Transactions Info"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ATM Transactions";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Trace ID";"Trace ID")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Posting S";"Posting S")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Unit ID";"Unit ID")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Trans Time";"Trans Time")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Time";"Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field(Source;Source)
                {
                    ApplicationArea = Basic;
                }
                field(Reversed;Reversed)
                {
                    ApplicationArea = Basic;
                }
                field("Reversed Posted";"Reversed Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Reversal Trace ID";"Reversal Trace ID")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description";"Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Location";"Withdrawal Location")
                {
                    ApplicationArea = Basic;
                }
                field("Entry No";"Entry No")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type Charges";"Transaction Type Charges")
                {
                    ApplicationArea = Basic;
                }
                field("Card Acceptor Terminal ID";"Card Acceptor Terminal ID")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card No";"ATM Card No")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Names";"Customer Names")
                {
                    ApplicationArea = Basic;
                }
                field("Process Code";"Process Code")
                {
                    ApplicationArea = Basic;
                }
                field("Reference No";"Reference No")
                {
                    ApplicationArea = Basic;
                }
                field("Is Coop Bank";"Is Coop Bank")
                {
                    ApplicationArea = Basic;
                }
                field("POS Vendor";"POS Vendor")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

