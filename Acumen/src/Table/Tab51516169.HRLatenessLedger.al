#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516169 "HR Lateness Ledger"
{

    fields
    {
        field(1;"Entry No";Integer)
        {
            AutoIncrement = true;
        }
        field(2;"Employee No.";Code[10])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HrEmp.Get("Employee No.");
                "First Name":=HrEmp."First Name";
                "Middle Name":=HrEmp."Middle Name";
                "Last Name":=HrEmp."Last Name";
            end;
        }
        field(3;Date;Date)
        {
        }
        field(4;"Date of Entry";DateTime)
        {
            Editable = false;
        }
        field(5;Time;Time)
        {
        }
        field(6;Absent;Boolean)
        {
        }
        field(7;"First Name";Text[30])
        {
        }
        field(8;"Middle Name";Text[30])
        {
        }
        field(9;"Last Name";Text[30])
        {
        }
        field(10;"User Id";Code[50])
        {
        }
    }

    keys
    {
        key(Key1;"Employee No.",Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Date of Entry":=CurrentDatetime;
        "User Id":=UserId;
    end;

    var
        HrEmp: Record "HR Employees";
}

