#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516474 "Status Change Permisions"
{
    ApplicationArea = Basic;
    PageType = Card;
    SourceTable = "Status Change Permision";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control3)
            {
                field("Function";"Function")
                {
                    ApplicationArea = Basic;
                }
                field("User ID";"User ID")
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

