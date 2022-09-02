#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516178 "HR Employee Kin"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SaveValues = true;
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
            part(Control1102755008;"HR Employee Kin SF")
            {
                SubPageLink = "Employee Code"=field("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control1102755004;"HR Employees Factbox")
            {
                SubPageLink = "No."=field("No.");
            }
            systempart(Control1102755002;Outlook)
            {
            }
        }
    }

    actions
    {
    }

    var
        D: Date;
        EmpNames: Text[30];
        HREmp: Record "HR Employees";
        Text19032351: label 'Next Of Kin/Beneficiaries';
}

