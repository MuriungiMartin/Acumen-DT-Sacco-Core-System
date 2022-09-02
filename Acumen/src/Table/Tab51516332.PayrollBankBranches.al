#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516332 "Payroll Bank Branches."
{

    fields
    {
        field(10;"Bank Code";Code[20])
        {
        }
        field(11;"Branch Code";Code[20])
        {
        }
        field(12;"Branch Name";Text[100])
        {
        }
        field(13;"Branch Physical Location";Text[100])
        {
        }
        field(14;"Branch Postal Code";Code[20])
        {
        }
        field(15;"Branch Address";Text[50])
        {
        }
        field(16;"Branch Phone No.";Code[50])
        {
        }
        field(17;"Branch Mobile No.";Code[50])
        {
        }
        field(18;"Branch Email Address";Text[100])
        {
        }
    }

    keys
    {
        key(Key1;"Bank Code","Branch Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

