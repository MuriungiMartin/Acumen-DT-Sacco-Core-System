#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516311 "Payroll Employee List."
{
    ApplicationArea = Basic;
    CardPageID = "Payroll Employee Card.";
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = true;
    PageType = List;
    SourceTable = "Payroll Employee.";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff  No.';
                }
                field("Payroll No";"Payroll No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sacco Membership No.';
                }
                field(Surname;Surname)
                {
                    ApplicationArea = Basic;
                }
                field(Firstname;Firstname)
                {
                    ApplicationArea = Basic;
                }
                field(Lastname;Lastname)
                {
                    ApplicationArea = Basic;
                }
                field("Basic Pay";"Basic Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Joining Date";"Joining Date")
                {
                    ApplicationArea = Basic;
                }
                field("Job Group";"Job Group")
                {
                    ApplicationArea = Basic;
                }
                field("Pension Month";"Pension Month")
                {
                    ApplicationArea = Basic;
                }
                field(Category;Category)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Group";"Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Pays PAYE";"Pays PAYE")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No";"Bank Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Email";"Employee Email")
                {
                    ApplicationArea = Basic;
                }
                field("Suspend Pay";"Suspend Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Suspend Date";"Suspend Date")
                {
                    ApplicationArea = Basic;
                }
                field("Suspend Reason";"Suspend Reason")
                {
                    ApplicationArea = Basic;
                }
                field("Hourly Rate";"Hourly Rate")
                {
                    ApplicationArea = Basic;
                }
                field(Gratuity;Gratuity)
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code";"Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name";"Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Code";"Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field("Pays NHIF";"Pays NHIF")
                {
                    ApplicationArea = Basic;
                }
                field("Pays NSSF";"Pays NSSF")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9;Outlook)
            {
            }
            systempart(Control10;Notes)
            {
            }
            systempart(Control11;MyNotes)
            {
            }
            systempart(Control12;Links)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        //TODO
        if Usersetup.Get(UserId) then
        begin
        if Usersetup."View Payroll"=false then Error ('You dont have permissions for payroll, Contact your system administrator! ')
        end;
    end;

    var
        Usersetup: Record "User Setup";
}

