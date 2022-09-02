#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516165 "PI Master"
{
    DrillDownPageID = UnknownPage55535;
    LookupPageID = UnknownPage55535;

    fields
    {
        field(1;"PI Code";Code[50])
        {
        }
        field(2;"PI Name";Text[100])
        {
        }
        field(3;"Colabotative Institution";Text[100])
        {
        }
        field(4;"PI Address";Text[30])
        {
        }
        field(5;"PI Telephone";Text[30])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(6;"PI EMail";Text[30])
        {
            ExtendedDatatype = EMail;
        }
    }

    keys
    {
        key(Key1;"PI Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

