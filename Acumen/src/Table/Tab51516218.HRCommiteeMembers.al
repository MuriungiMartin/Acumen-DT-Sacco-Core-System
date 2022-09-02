#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516218 "HR Commitee Members"
{

    fields
    {
        field(1;"Member No.";Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HREmp.Reset;
                HREmp.Get("Member No.");
                "Member Name":=HREmp."First Name"+' '+HREmp."Middle Name"+' '+HREmp."Last Name";
            end;
        }
        field(2;"Member Name";Text[100])
        {
        }
        field(3;Role;Text[100])
        {
        }
        field(8;"Date Appointed";Date)
        {
        }
        field(9;Grade;Code[20])
        {
        }
        field(10;Active;Boolean)
        {
        }
        field(11;Committee;Code[20])
        {
        }
    }

    keys
    {
        key(Key1;Committee,"Member No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HREmp: Record "HR Employees";
}

