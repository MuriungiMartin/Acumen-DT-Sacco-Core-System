#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516751 "HR 360 Appraisals List - EV"
{
    ApplicationArea = Basic;
    CardPageID = "HR 360 Appraisal Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Functions,Appraisal';
    SourceTable = "HR Appraisal Header";
    SourceTableView = where("Appraisal Stage"=const("End Year Evalauation"));
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
            group(ActionGroup1000000005)
            {
                Caption = 'Functions';
                action(ReturnSupervisor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Return to Supervisor';
                    Image = Return;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        TestField("Appraisal Stage","appraisal stage"::"End Year Evalauation");

                        if Confirm('Return to supervisor?',false) = false then exit;

                        "Appraisal Stage":="appraisal stage"::"Target Approval";
                        Modify;
                        Message('Appraisal returned to supervisor');
                    end;
                }
                action(ReturnAppraisee)
                {
                    ApplicationArea = Basic;
                    Caption = 'Return to Appraisee';
                    Image = ReopenCancelled;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        TestField("Appraisal Stage");

                        if Confirm('Return to appraisee?',false) = false then exit;

                        "Appraisal Stage":="appraisal stage"::"Target Setting";
                        Modify;
                        Message('Appraisal returned to appraisee');
                    end;
                }
            }
        }
    }
}

