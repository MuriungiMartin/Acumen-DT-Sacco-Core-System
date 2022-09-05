#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516263 "HR Setup List"
{
    CardPageID = "HR Setup";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Administration';
    RefreshOnActivate = false;
    SourceTable = "HR Setup";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Leave Posting Period[FROM]"; "Leave Posting Period[FROM]")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Posting Period[TO]"; "Leave Posting Period[TO]")
                {
                    ApplicationArea = Basic;
                }
                field("Default Leave Posting Template"; "Default Leave Posting Template")
                {
                    ApplicationArea = Basic;
                }
                field("Positive Leave Posting Batch"; "Positive Leave Posting Batch")
                {
                    ApplicationArea = Basic;
                }
                field("Base Calendar"; "Base Calendar")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Nos."; "Employee Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Training Application Nos."; "Training Application Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Application Nos."; "Leave Application Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Disciplinary Cases Nos."; "Disciplinary Cases Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Requisition Nos."; "Employee Requisition Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Job Application Nos"; "Job Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Exit Interview Nos"; "Exit Interview Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Nos"; "Appraisal Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Company Activities"; "Company Activities")
                {
                    ApplicationArea = Basic;
                }
                field("Job Interview Nos"; "Job Interview Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Reimbursment Nos."; "Leave Reimbursment Nos.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("HR Policies")
            {
                ApplicationArea = Basic;
                Caption = 'HR Policies';
                Image = Planning;
                Promoted = true;
                PromotedCategory = Category4;
                //RunObject = Page "HR Policies";
            }
            action("E-Mail Parameters")
            {
                ApplicationArea = Basic;
                Caption = 'E-Mail Parameters';
                Image = Email;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "HR E-Mail Parameters";
            }
            action(Calendar)
            {
                ApplicationArea = Basic;
                Caption = 'Calendar';
                Image = Calendar;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Base Calendar Card";
            }
            action("Leave Allocation")
            {
                ApplicationArea = Basic;
                Caption = 'Leave Allocation';
                Image = AccountingPeriods;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "HR Leave Journal Lines";
            }
        }
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

