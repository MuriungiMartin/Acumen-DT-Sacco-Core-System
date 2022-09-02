#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516163 "HR AppraisalCompanyTarget list"
{
    PageType = List;
    SourceTable = "HR Appraisal Company Target";

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
                field(Score;Score)
                {
                    ApplicationArea = Basic;
                }
                field(Recommendations;Recommendations)
                {
                    ApplicationArea = Basic;
                }
                field("Description 2";"Description 2")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000008;Outlook)
            {
            }
            systempart(Control1000000009;Notes)
            {
            }
            systempart(Control1000000010;MyNotes)
            {
            }
            systempart(Control1000000011;Links)
            {
            }
        }
    }

    actions
    {
    }
}

