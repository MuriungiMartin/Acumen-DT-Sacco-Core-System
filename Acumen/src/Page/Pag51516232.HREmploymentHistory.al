#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516232 "HR Employment History"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SaveValues = true;
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            group("Employmee Details")
            {
                Caption = 'Employmee Details';
                Editable = false;
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
            part(Control1000000028;"HR Employment History Lines")
            {
                Caption = 'Employment History Details';
                SubPageLink = "Employee No."=field("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control1102755010;"HR Employees Factbox")
            {
                SubPageLink = "No."=field("No.");
            }
            systempart(Control1102755009;Outlook)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
                                    HREmp.Reset;
                                    if HREmp.Get("No.") then
                                    begin
                                    EmpNames:=HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                                    end else begin
                                    EmpNames:='';
                                    end;
    end;

    var
        EmpNames: Text[30];
        HREmp: Record "HR Employees";
        Text19034996: label 'Employment History';
}

