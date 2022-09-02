#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516742 "HR 360 Appraisals List - TS"
{
    ApplicationArea = Basic;
    CardPageID = "HR 360 Appraisal Card";
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Functions,Appraisal';
    SourceTable = "HR Appraisal Header";
    SourceTableView = where("Appraisal Stage"=const("Target Setting"));
    UsageCategory = Lists;

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
                field("Employee No";"Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name";"Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("User ID";"User ID")
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
                field("Appraisal Stage";"Appraisal Stage")
                {
                    ApplicationArea = Basic;
                }
                field(Sent;Sent)
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
        area(processing)
        {
            group(Appraisal)
            {
                Caption = 'Appraisal';
                action(SendSupervisor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send to Supervisor';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        TestField("Appraisal Stage","appraisal stage"::"Target Setting");
                        TestField("Employee No");

                        if Confirm('Send to supervisor?',false) = false then exit;

                        "Appraisal Stage":="appraisal stage"::"Target Approval";
                        Modify;
                        Message('Appraisal sent to supervisor');
                    end;
                }
            }
        }
    }
}

