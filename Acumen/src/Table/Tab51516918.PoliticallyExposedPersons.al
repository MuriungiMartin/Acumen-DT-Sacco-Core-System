#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516918 "Politically Exposed Persons"
{

    fields
    {
        field(1;"Code";Code[30])
        {
        }
        field(2;Name;Code[50])
        {
        }
        field(3;"County Code";Code[20])
        {
        }
        field(4;"County Name";Code[50])
        {
        }
        field(5;"ID/Passport No";Code[30])
        {
        }
        field(6;"Position Runing For";Code[50])
        {
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

