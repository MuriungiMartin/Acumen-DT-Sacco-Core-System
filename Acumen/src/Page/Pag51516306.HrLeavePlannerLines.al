#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516306 "Hr Leave Planner Lines"
{
    PageType = ListPart;
    SourceTable = "HR Leave Planner Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Leave Type";"Leave Type")
                {
                    ApplicationArea = Basic;
                }
                field("Days Applied";"Days Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date";"Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date";"End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Return Date";"Return Date")
                {
                    ApplicationArea = Basic;
                }
                field("Applicant Comments";"Applicant Comments")
                {
                    ApplicationArea = Basic;
                }
                field("Request Leave Allowance";"Request Leave Allowance")
                {
                    ApplicationArea = Basic;
                }
                field(Reliever;Reliever)
                {
                    ApplicationArea = Basic;
                }
                field("Reliever Name";"Reliever Name")
                {
                    ApplicationArea = Basic;
                }
                field("Approved days";"Approved days")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Exam";"Date of Exam")
                {
                    ApplicationArea = Basic;
                }
                field("Details of Examination";"Details of Examination")
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

