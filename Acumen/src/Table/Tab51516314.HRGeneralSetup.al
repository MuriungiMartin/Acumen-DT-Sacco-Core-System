#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516314 "HR General Setup."
{

    fields
    {
        field(10;"Primary Key";Code[10])
        {
        }
        field(11;"Employee Nos";Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(12;"Payroll Nos";Code[20])
        {
            TableRelation = "No. Series".Code;
        }
    }

    keys
    {
        key(Key1;"Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

