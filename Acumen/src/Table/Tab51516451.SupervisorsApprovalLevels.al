#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516451 "Supervisors Approval Levels"
{
    DrillDownPageID = "Supervisor Approval Levels";
    LookupPageID = "Supervisor Approval Levels";

    fields
    {
        field(1;"Supervisor ID";Code[50])
        {
            Caption = 'User ID';

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                //UserMgt.LookupUserID("No.");
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit "User Management";
            begin
                //UserMgt.ValidateUserID(SupervisorID );
                /*User.RESET;
                User.SETRANGE("User Security ID",SupervisorID);
                IF User.FINDSET THEN BEGIN
                  "Supervisor Name":=User."User Name";
                  END;*/

            end;
        }
        field(2;"Maximum Approval Amount";Decimal)
        {
        }
        field(3;"Transaction Type";Option)
        {
            OptionMembers = "Cash Deposits","Cheque Deposits",Withdrawals;
        }
        field(4;"E-mail Address";Text[30])
        {
        }
        field(5;"Supervisor Name";Code[50])
        {
        }
    }

    keys
    {
        key(Key1;"Supervisor ID","Transaction Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        UserMgt: Codeunit "User Setup Management";
        User: Record User;
}

