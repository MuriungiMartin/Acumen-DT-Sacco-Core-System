#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516094 "Expense Transfer List"
{
    CardPageID = "Expense Transfer Card";
    PageType = List;
    SourceTable = "Funds Transfer Header";
    SourceTableView = where(Posted=const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date";"Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Paying Bank Account";"Paying Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Paying Bank Name";"Paying Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Transfer";"Amount to Transfer")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Transfer(LCY)";"Amount to Transfer(LCY)")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
          "Pay Mode":="pay mode"::Cash
    end;
}

