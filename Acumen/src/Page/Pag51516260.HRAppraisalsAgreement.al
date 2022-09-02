#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516260 "HR Appraisals Agreement"
{
    CardPageID = "HR Appraisal Agreement HD";
    PageType = List;
    SourceTable = "HR Appraisal Header";
    SourceTableView = where(Status=filter(Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No";"Appraisal No")
                {
                    ApplicationArea = Basic;
                }
                field(Supervisor;Supervisor)
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Type";"Appraisal Type")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Period";"Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field(Recommendations;Recommendations)
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Stage";"Appraisal Stage")
                {
                    ApplicationArea = Basic;
                }
                field(Sent;Sent)
                {
                    ApplicationArea = Basic;
                }
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No";"Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name";"Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Job Title";"Job Title")
                {
                    ApplicationArea = Basic;
                }
                field(Department;Department)
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code";"Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code";"Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Comments Appraisee";"Comments Appraisee")
                {
                    ApplicationArea = Basic;
                }
                field("Comments Appraiser";"Comments Appraiser")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Date";"Appraisal Date")
                {
                    ApplicationArea = Basic;
                }
                field("Evaluation Period End";"Evaluation Period End")
                {
                    ApplicationArea = Basic;
                }
                field("Target Type";"Target Type")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control26;Outlook)
            {
            }
            systempart(Control27;Notes)
            {
            }
            systempart(Control28;MyNotes)
            {
            }
            systempart(Control29;Links)
            {
            }
        }
    }

    actions
    {
    }
}

