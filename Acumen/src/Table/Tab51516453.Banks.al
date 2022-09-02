#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516453 "Banks"
{
    DrillDownPageID = Banks;
    LookupPageID = Banks;

    fields
    {
        field(1;"Code";Code[20])
        {
            NotBlank = true;
        }
        field(2;"Bank Name";Text[150])
        {
        }
        field(3;Branch;Text[150])
        {
        }
        field(4;"Bank Code";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Code",Branch,"Bank Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

