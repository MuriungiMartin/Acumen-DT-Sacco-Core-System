#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516672 "Monthly Saving Set-Up List"
{
    ApplicationArea = Basic;
    CardPageID = "Monthly Saving Setup";
    Editable = false;
    PageType = List;
    SourceTable = "Monthly  saving setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("code";code)
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field("Min saving";"Min saving")
                {
                    ApplicationArea = Basic;
                }
                field("Max saving";"Max saving")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Saving Amount";"Monthly Saving Amount")
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

