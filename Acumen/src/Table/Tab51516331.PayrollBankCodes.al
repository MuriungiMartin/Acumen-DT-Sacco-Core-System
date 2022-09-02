#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516331 "Payroll Bank Codes."
{

    fields
    {
        field(10;"Bank Code";Code[10])
        {
        }
        field(11;"Bank Name";Text[50])
        {
        }
        field(12;"Branch Code";Code[20])
        {
        }
        field(13;"Branch Name";Text[50])
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

