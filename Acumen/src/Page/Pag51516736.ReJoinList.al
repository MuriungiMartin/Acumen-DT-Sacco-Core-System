#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516736 "Re-Join List"
{
    ApplicationArea = Basic;
    CardPageID = "Member Account Card Rejoin";
    PageType = List;
    SourceTable = Customer;
    SourceTableView = where(Status = const(Withdrawal));
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Account No."; "FOSA Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Personal No"; "Personal No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No';
                }
                field("Customer Type"; "Customer Type")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control5; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("No.");
                Visible = true;
            }
            part(Control4; "Member Picture-Uploaded")
            {
                Caption = 'Picture';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                SubPageLink = "No." = field("No.");
            }
            part(Control3; "Member Signature-Uploaded")
            {
                Caption = 'Signature';
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        if Usersetup.Get(UserId) then begin
            if Usersetup."Re-Join" = false then Error('You dont have permissions for Re-Join, Contact your system administrator! ')
        end;
    end;

    var
        Usersetup: Record "User Setup";
}

