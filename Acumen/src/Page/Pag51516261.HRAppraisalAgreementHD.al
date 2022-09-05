#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516261 "HR Appraisal Agreement HD"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "HR Appraisal Header";
    SourceTableView = where(Status = filter(Approved));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Appraisal No"; "Appraisal No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employee No"; "Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Employment"; "Date of Employment")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = Basic;
                }
                field("Contract Type"; "Contract Type")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Period"; "Appraisal Period")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Comments Appraisee"; "Comments Appraisee")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Date"; "Appraisal Date")
                {
                    ApplicationArea = Basic;
                }
                field("Evaluation Period Start"; "Evaluation Period Start")
                {
                    ApplicationArea = Basic;
                }
                field("Evaluation Period End"; "Evaluation Period End")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility/Duties Agrd Sco"; "Responsibility/Duties Agrd Sco")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Attendance&Punctuality Agr Sco"; "Attendance&Punctuality Agr Sco")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Communication Agreed Score"; "Communication Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cooperation Agreed Score"; "Cooperation Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Customer Service Agreed Score"; "Customer Service Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Initiative Agreed Score"; "Initiative Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Quality Agreed Score"; "Quality Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Teamwork Agreed Score"; "Teamwork Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sales Skills Agreed Score"; "Sales Skills Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Leadership Agreed Score"; "Leadership Agreed Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Performance Coaching Agreed Sc"; "Performance Coaching Agreed Sc")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Responsibility/Duties Comment"; "Responsibility/Duties Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Attendance&Punctuality Comment"; "Attendance&Punctuality Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Communication Agreed Comment"; "Communication Agreed Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Cooperation Agreed Comment"; "Cooperation Agreed Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Service Agr Comment"; "Customer Service Agr Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Initiative Agreed Comment"; "Initiative Agreed Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Quality Agreed Comment"; "Quality Agreed Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Teamwork Agreed Comment"; "Teamwork Agreed Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Sales Skills Agreed Comment"; "Sales Skills Agreed Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Leadership Agreed Comment"; "Leadership Agreed Comment")
                {
                    ApplicationArea = Basic;
                }
                field("Performance Coaching Comment"; "Performance Coaching Comment")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control9; "HR Appraisal Lines-Agreed")
            {
                SubPageLink = "Appraisal No" = field("Appraisal No"),
                              "Appraisal Period" = field("Appraisal Period"),
                              "Employee No" = field("Employee No");
                SubPageView = sorting(Sections)
                              order(ascending);
            }
        }
        area(factboxes)
        {
            systempart(Control43; Outlook)
            {
            }
            systempart(Control44; Notes)
            {
            }
            systempart(Control45; MyNotes)
            {
            }
            systempart(Control46; Links)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Agreed)
            {
                ApplicationArea = Basic;
                Image = BinJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //
                end;
            }
        }
    }

    var
        objJobResp: Record "HR Job Responsiblities";
        objAppraisalLines: Record "HR Appraisal Lines";
        objPrevAppraisalLines: Record "HR Appraisal Lines";
        iNo: Integer;
        objPrevApprPeriod: Record "HR Lookup Values";
        objCurrApprPeriod: Record "HR Lookup Values";
        HREmployees: Record "HR Employees";
        objAppraisalEvaluationAreas: Record "HR Appraisal Eval Areas";
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;


    procedure enableDisable() enableDisable: Boolean
    begin
        enableDisable := false;
    end;
}

