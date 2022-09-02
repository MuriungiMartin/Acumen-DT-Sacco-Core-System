#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516255 "HR Setup Card"
{
    PageType = Card;
    SourceTable = "HR Setup";

    layout
    {
        area(content)
        {
            group("Leave Period")
            {
                Caption = 'Leave Period';
                field("Leave Posting Period[FROM]";"Leave Posting Period[FROM]")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Posting Period[TO]";"Leave Posting Period[TO]")
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
            group("HR Number Series")
            {
                Caption = 'HR Number Series';
                field("Employee Nos.";"Employee Nos.")
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
                field("Transport Req Nos";"Transport Req Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Requisition Nos.";"Employee Requisition Nos.")
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
                field("Default Leave Posting Template";"Default Leave Posting Template")
                {
                    ApplicationArea = Basic;
                }
                field(s;"Positive Leave Posting Batch")
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

