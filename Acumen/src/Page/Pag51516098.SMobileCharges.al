#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516098 "S-Mobile Charges"
{
    PageType = List;
    SourceTable = "S-Mobile Charges";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount";"Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Source;Source)
                {
                    ApplicationArea = Basic;
                }
                field(Tiered;Tiered)
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

