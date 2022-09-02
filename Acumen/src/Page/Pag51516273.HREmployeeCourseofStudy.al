#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516273 "HR Employee Course of Study"
{
    PageType = List;
    SourceTable = "HR Employee Course of Study";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Years of Study";"Years of Study")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755006;Outlook)
            {
            }
            systempart(Control1102755007;Notes)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(ActionGroup1102755009)
            {
            }
        }
    }
}

