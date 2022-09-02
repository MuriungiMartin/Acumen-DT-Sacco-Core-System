#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516181 "HR Job Responsibilities"
{
    Caption = 'HR Job Responsibilities';
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Qualification';
    SourceTable = "HR Jobss";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Job Details';
                field("Job ID";"Job ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Job Description";"Job Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Position Reporting to";"Position Reporting to")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Supervisor Name";"Supervisor Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("No of Posts";"No of Posts")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Occupied Positions";"Occupied Positions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Vacant Positions";"Vacant Positions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Employee Requisitions";"Employee Requisitions")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1102755008;"HR Job Responsiblities Lines")
            {
                Caption = 'Job Responsibilities';
                SubPageLink = "Job ID"=field("Job ID");
            }
        }
        area(factboxes)
        {
            systempart(Control1102755013;Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Evaluation Areas")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    //DELETE RESPONSIBILITIES PREVIOUSLY IMPORTED
                    HRJobResponsibilities.Reset;
                    HRJobResponsibilities.SetRange(HRJobResponsibilities."Job ID","Job ID");
                    if HRJobResponsibilities.Find('-') then
                    HRJobResponsibilities.DeleteAll;

                    //IMPORT EVALUATION AREAS FOR THIS JOB
                    HRAppraisalEvaluationAreas.Reset;
                    HRAppraisalEvaluationAreas.SetRange(HRAppraisalEvaluationAreas."External Source Name","Job ID");
                    if HRAppraisalEvaluationAreas.Find('-') then
                    HRAppraisalEvaluationAreas.FindFirst;
                    begin
                         HRJobResponsibilities.Reset;
                              repeat
                                  HRJobResponsibilities.Init;
                                  HRJobResponsibilities."Job ID":="Job ID";
                                  HRJobResponsibilities."Responsibility Code":=HRAppraisalEvaluationAreas."Assign To";
                                  HRJobResponsibilities."Responsibility Description":= HRAppraisalEvaluationAreas.Code;
                                  HRJobResponsibilities.Insert();
                              until HRAppraisalEvaluationAreas.Next=0;
                    end;
                end;
            }
        }
    }

    var
        HRJobResponsibilities: Record "HR Job Responsiblities";
        HRAppraisalEvaluationAreas: Record "HR Appraisal Eval Areas";
}

