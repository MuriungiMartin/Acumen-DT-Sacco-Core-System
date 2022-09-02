#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50022 "Micro Members"
{

    fields
    {
        field(1;"Group Account No";Code[30])
        {
        }
        field(2;"Group Account Name";Code[70])
        {
        }
        field(3;"Member No";Code[30])
        {
        }
        field(4;"Member Name";Code[70])
        {
        }
        field(5;"ID No";Code[30])
        {
        }
        field(6;"Mobile No";Code[50])
        {
        }
    }

    keys
    {
        key(Key1;"Group Account No","Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

