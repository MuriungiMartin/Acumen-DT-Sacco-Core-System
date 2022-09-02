#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516274 "HR Employees Supervisee"
{
    PageType = List;
    SourceTable = "HR Employees Supervisees";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Supervisor No.";"Supervisor No.")
                {
                    ApplicationArea = Basic;
                }
                field("Supervisee No.";"Supervisee No.")
                {
                    ApplicationArea = Basic;
                }
                field(Department;Department)
                {
                    ApplicationArea = Basic;
                }
                field("Job Title";"Job Title")
                {
                    ApplicationArea = Basic;
                }
                field("Key Experience";"Key Experience")
                {
                    ApplicationArea = Basic;
                }
                field(From;From)
                {
                    ApplicationArea = Basic;
                }
                field("To";"To")
                {
                    ApplicationArea = Basic;
                }
                field(Comment;Comment)
                {
                    ApplicationArea = Basic;
                }
                field("Number of Supervisees";"Number of Supervisees")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755011;Outlook)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        /*HREmployeeSupervisees.RESET;
        HREmployeeSupervisees.SETRANGE(HREmployeeSupervisees."Supervisor No.","Supervisor No.");
        IF HREmployeeSupervisees.GET THEN
        SETRANGE("Supervisor No.",HREmployeeSupervisees."Supervisor No.")
        ELSE
        //user id may not be the creator of the doc
        SETRANGE("Supervisor No.","Supervisor No.");
         */

    end;
}

