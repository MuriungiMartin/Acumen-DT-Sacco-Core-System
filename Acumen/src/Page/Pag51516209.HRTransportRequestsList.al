#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516209 "HR Transport Requests List"
{
    CardPageID = "HR Staff Transport Requisition";
    Editable = false;
    PageType = List;
    SourceTable = "HR Transport Requisition";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Application Code"; "Application Code")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Employee No"; "Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(Names; Names)
                {
                    ApplicationArea = Basic;
                }
                field("Job Tittle"; "Job Tittle")
                {
                    ApplicationArea = Basic;
                }
                field("Days Applied"; "Days Applied")
                {
                    ApplicationArea = Basic;
                }
                field(Supervisor; Supervisor)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755004; Outlook)
            {
            }
            systempart(Control1102755006; Notes)
            {
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Transport Requests")
            {
                ApplicationArea = Basic;
                Caption = 'Transport Requests';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

            }
        }
    }
}

