#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516990 "Product Risk Rating"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Product Risk Rating";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Category";"Product Category")
                {
                    ApplicationArea = Basic;
                }
                field("Product Type";"Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Inherent Risk Rating";"Inherent Risk Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Risk Score";"Risk Score")
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

