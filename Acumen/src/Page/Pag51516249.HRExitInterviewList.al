#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516249 "HR Exit Interview List"
{
    CardPageID = "HR Employee Exit Interviews";
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Employee Exit Interviews";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Exit Interview No";"Exit Interview No")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Date Of Interview";"Date Of Interview")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Employee Name";"Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Interview Done By";"Interviewer Name")
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Leaving";"Reason For Leaving")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Date Of Leaving";"Date Of Leaving")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Re Employ In Future";"Re Employ In Future")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755004;Outlook)
            {
            }
            systempart(Control1102755006;Notes)
            {
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Exit Interviews")
            {
                ApplicationArea = Basic;
                Caption = 'Exit Interviews';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //RunObject = Report UnknownReport55594;
            }
        }
    }
}

