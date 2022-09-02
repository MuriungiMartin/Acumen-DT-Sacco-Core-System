#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516216 "HR Employee Qualification Line"
{
    Caption = 'Employee Qualification Lines';
    PageType = List;
    SourceTable = "HR Employee Qualifications";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Qualification Type";"Qualification Type")
                {
                    ApplicationArea = Basic;
                }
                field("Qualification Code";"Qualification Code")
                {
                    ApplicationArea = Basic;
                }
                field("Qualification Description";"Qualification Description")
                {
                    ApplicationArea = Basic;
                }
                field("Course of Study";"Course of Study")
                {
                    ApplicationArea = Basic;
                }
                field("From Date";"From Date")
                {
                    ApplicationArea = Basic;
                }
                field("To Date";"To Date")
                {
                    ApplicationArea = Basic;
                }
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field("Institution/Company";"Institution/Company")
                {
                    ApplicationArea = Basic;
                }
                field("Course Grade";"Course Grade")
                {
                    ApplicationArea = Basic;
                }
                field(Comment;Comment)
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
            group("Q&ualification")
            {
                Caption = 'Q&ualification';
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name"=const("Employee Qualification"),
                                  "No."=field("Employee No."),
                                  "Table Line No."=field("Line No.");
                }
                separator(Action1102755021)
                {
                }
                action("Q&ualification Overview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Q&ualification Overview';
                    RunObject = Page "Qualification Overview";
                }
            }
        }
    }
}

