#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516609 "Funeral Expense List"
{
    CardPageID = "Funeral Expense Card";
    Editable = false;
    PageType = List;
    SourceTable = "Funeral Expense Payment";

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
                field("Member No.";"Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Member Status";"Member Status")
                {
                    ApplicationArea = Basic;
                }
                field("Death Date";"Death Date")
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

