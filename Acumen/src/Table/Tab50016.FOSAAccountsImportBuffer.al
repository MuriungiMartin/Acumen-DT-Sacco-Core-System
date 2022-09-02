#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50016 "FOSA Accounts Import Buffer"
{

    fields
    {
        field(1;"FOSA Account No";Code[30])
        {
        }
        field(2;"Member No";Code[30])
        {
        }
        field(4;Name;Code[60])
        {
        }
        field(6;"Account Type";Code[20])
        {
        }
        field(7;Status;Option)
        {
            OptionMembers = Active,Dormant;
        }
    }

    keys
    {
        key(Key1;"FOSA Account No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
