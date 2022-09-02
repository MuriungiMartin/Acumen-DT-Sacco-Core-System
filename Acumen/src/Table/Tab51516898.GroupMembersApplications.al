#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516898 "Group Members Applications"
{

    fields
    {
        field(1;No;Code[20])
        {
        }
        field(2;"Group Name";Code[30])
        {
        }
        field(3;"Member Name";Code[30])
        {
        }
        field(4;"Member ID No";Code[20])
        {
        }
        field(5;"Member Phone No";Code[20])
        {
        }
        field(6;"Member Designation";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;No,"Member Name","Member ID No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

