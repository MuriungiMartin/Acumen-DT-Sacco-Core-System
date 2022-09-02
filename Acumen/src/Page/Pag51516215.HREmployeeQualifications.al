#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516215 "HR Employee Qualifications"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Qualification';
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            group("Employee Details")
            {
                Caption = 'Employee Details';
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    StyleExpr = true;
                }
                field(FullName;FullName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    StyleExpr = true;
                }
                field("Job Title";"Job Title")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    StyleExpr = true;
                }
                field("Postal Address";"Postal Address")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    StyleExpr = true;
                }
                field(Gender;Gender)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    StyleExpr = true;
                }
                field("Post Code";"Post Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    StyleExpr = true;
                    Visible = false;
                }
                field("Cell Phone Number";"Cell Phone Number")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    StyleExpr = true;
                }
                field("E-Mail";"E-Mail")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    StyleExpr = true;
                }
                field("Global Dimension 2 Code";"Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    StyleExpr = true;
                }
            }
            part(Control1102755019;"HR Employee Qualification Line")
            {
                Caption = 'Employee Qualifications';
                SubPageLink = "Employee No."=field("No.");
            }
            systempart(Control1102755011;Outlook)
            {
            }
        }
        area(factboxes)
        {
            systempart(Control1102755012;"HR Employees Factbox")
            {
                SubPageLink = "No."=field("No.");
            }
            systempart(Control1102755010;Outlook)
            {
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
                action("Q&ualification Overview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Q&ualification Overview';
                    Image = TaskQualityMeasure;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Qualification Overview";
                }
            }
        }
    }
}

