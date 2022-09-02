#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516160 "HR Leave journal Template"
{
    PageType = List;
    SourceTable = "HR Leave Journal Template";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Test Report ID";"Test Report ID")
                {
                    ApplicationArea = Basic;
                }
                field("Form ID";"Form ID")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Report ID";"Posting Report ID")
                {
                    ApplicationArea = Basic;
                }
                field("Force Posting Report";"Force Posting Report")
                {
                    ApplicationArea = Basic;
                }
                field("Source Code";"Source Code")
                {
                    ApplicationArea = Basic;
                }
                field("Reason Code";"Reason Code")
                {
                    ApplicationArea = Basic;
                }
                field("Test Report Name";"Test Report Name")
                {
                    ApplicationArea = Basic;
                }
                field("Form Name";"Form Name")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Report Name";"Posting Report Name")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series";"No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Posting No. Series";"Posting No. Series")
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

