#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516523 "Customer Care List"
{
    ApplicationArea = Basic;
    CardPageID = "Customer Care Card";
    Editable = false;
    PageType = List;
    SourceTable = "Member Register";
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
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field(Address;Address)
                {
                    ApplicationArea = Basic;
                }
                field("Phone No.";"Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No";"Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Personal No";"Personal No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No.';
                }
                field("FOSA Account No.";"FOSA Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code";"Employer Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        /*IF ("Assigned System ID"<>'')  THEN BEGIN //AND ("Assigned System ID"<>USERID)
          IF UserSetup.GET(USERID) THEN
        BEGIN
        IF UserSetup."View Special Accounts"=FALSE THEN
           ERROR ('You do not have permission to view this account Details, Contact your system administrator! ')
        END;
        
          END;*/

    end;

    var
        UserSetup: Record "User Setup";
}

