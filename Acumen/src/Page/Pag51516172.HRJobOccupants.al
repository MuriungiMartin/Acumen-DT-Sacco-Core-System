#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516172 "HR Job Occupants"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report';
    SourceTable = "HR Jobss";

    layout
    {
        area(content)
        {
            group("Job Details")
            {
                Caption = 'Job Details';
                Editable = false;
                field("Job ID";"Job ID")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Job Description";"Job Description")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                }
            }
            part(Control1102755000;"HR Employee List")
            {
                Caption = 'Job Occupants';
                Editable = false;
            }
        }
        area(factboxes)
        {
            part(Control1102755005;"HR Job Applications Factbox")
            {
            }
            systempart(Control1102755003;Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print HR Job Occupants")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report UnknownReport55582;
            }
        }
    }

    trigger OnOpenPage()
    begin
              if IsEmpty then
              Error('No jobs have been setup');
    end;

    var
        Text19006026: label 'Job Occupants';
}

