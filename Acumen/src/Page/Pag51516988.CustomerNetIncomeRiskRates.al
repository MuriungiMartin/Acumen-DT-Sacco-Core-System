#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516988 "Customer Net Income Risk Rates"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Customer Net Income Risk Rates";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Min Annual Income";"Min Annual Income")
                {
                    ApplicationArea = Basic;
                }
                field("Max Annual Income";"Max Annual Income")
                {
                    ApplicationArea = Basic;
                }
                field("Risk Rate";"Risk Rate")
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

