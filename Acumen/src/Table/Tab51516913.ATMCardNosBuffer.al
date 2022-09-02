#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516913 "ATM Card Nos Buffer"
{

    fields
    {
        field(1;"ATM Card No";Code[20])
        {
        }
        field(2;"Account No";Code[20])
        {
        }
        field(3;"Account Name";Code[50])
        {
        }
        field(4;"Account Type";Code[20])
        {
        }
        field(5;Status;Option)
        {
            OptionCaption = 'Active,Blocked';
            OptionMembers = Active,Blocked;
        }
        field(6;"ID No";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"ATM Card No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

