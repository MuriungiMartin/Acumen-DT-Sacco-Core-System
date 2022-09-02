#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516170 "HR Setup"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = false;
    SourceTable = "HR Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Leave Posting Period[FROM]";"Leave Posting Period[FROM]")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Posting Period[TO]";"Leave Posting Period[TO]")
                {
                    ApplicationArea = Basic;
                }
                field("Default Leave Posting Template";"Default Leave Posting Template")
                {
                    ApplicationArea = Basic;
                }
                field("Positive Leave Posting Batch";"Positive Leave Posting Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Negative Leave Posting Batch";"Negative Leave Posting Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Max Appraisal Rating";"Max Appraisal Rating")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Template";"Leave Template")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Batch";"Leave Batch")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                field("Base Calendar";"Base Calendar")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Nos.";"Employee Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Deployed Nos";"Deployed Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Full Time Nos";"Full Time Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Board Nos";"Board Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Committee Nos";"Committee Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Training Application Nos.";"Training Application Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Application Nos.";"Leave Application Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Disciplinary Cases Nos.";"Disciplinary Cases Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Requisition Nos.";"Employee Requisition Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Claims Nos";"Medical Claims Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Job Application Nos";"Job Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Exit Interview Nos";"Exit Interview Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Nos";"Appraisal Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Company Activities";"Company Activities")
                {
                    ApplicationArea = Basic;
                }
                field("Job Nos";"Job Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Job Interview Nos";"Job Interview Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Notice Board Nos.";"Notice Board Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Transport Req Nos";"Transport Req Nos")
                {
                    ApplicationArea = Basic;
                }
                field("HR Policies";"HR Policies")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Reimbursment Nos.";"Leave Reimbursment Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Carry Over App Nos.";"Leave Carry Over App Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Pay-change No.";"Pay-change No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Transfer Nos.";"Employee Transfer Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Planner Nos.";"Leave Planner Nos.")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Leave)
            {
                Caption = 'Leave';
                field("Min. Leave App. Months";"Min. Leave App. Months")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        Reset;
        if not Get then begin
          Init;
          Insert;
        end;
    end;
}

