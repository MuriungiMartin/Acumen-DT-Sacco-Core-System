#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516176 "HR Employee List"
{
    ApplicationArea = Basic;
    CardPageID = "HR Employee Card";
    DeleteAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Employee';
    SourceTable = "HR Employees";
    SourceTableView = where(Status = const(Active),
                            IsCommette = const(false),
                            IsBoard = const(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    StyleExpr = true;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Company E-Mail"; "Company E-Mail")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Cellular Phone Number"; "Cellular Phone Number")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755002; "HR Employees Factbox")
            {
                SubPageLink = "No." = field("No.");
            }
            systempart(Control1102755003; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Employee)
            {
                Caption = 'Employee';
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Card";
                    RunPageLink = "No." = field("No.");
                }
                action("Kin/Beneficiaries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Kin/Beneficiaries';
                    Image = Relatives;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Kin";
                    RunPageLink = "No." = field("No.");
                }
                action("Employee Attachments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Attachments";
                    RunPageLink = "No." = field("No.");
                    Visible = false;
                }
                action("Employement History")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employement History';
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employment History";
                    RunPageLink = "No." = field("No.");
                }
                action("Employee Qualifications")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employee Qualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Qualifications";
                    RunPageLink = "No." = field("No.");
                }
                action("Assigned Assets")
                {
                    ApplicationArea = Basic;
                    Caption = 'Assigned Assets';
                    Image = ResourceJournal;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Fixed Asset List";
                    RunPageLink = "Responsible Employee" = field("No.");
                }
            }
        }
    }

    var
        HREmp: Record "HR Employees";
        EmployeeFullName: Text;
}

