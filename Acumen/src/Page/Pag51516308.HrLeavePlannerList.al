#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516308 "Hr Leave Planner List"
{
    CardPageID = "HR Leave Planner Card";
    PageType = List;
    SourceTable = "HR Leave Planner Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application Code";"Application Code")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No";"Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(Names;Names)
                {
                    ApplicationArea = Basic;
                }
                field("Job Tittle";"Job Tittle")
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

