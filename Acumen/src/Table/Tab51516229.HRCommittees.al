#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516229 "HR Committees"
{
    LookupPageID = UnknownPage55602;

    fields
    {
        field(1;"Code";Code[20])
        {
            NotBlank = true;
        }
        field(2;Description;Text[200])
        {
            NotBlank = true;
        }
        field(3;Roles;Text[200])
        {
        }
        field(4;"Transaction Amount";Decimal)
        {
        }
        field(5;"Transaction Code";Code[45])
        {
            TableRelation = "Job-Journal Line"."Journal Template Name";
        }
        field(6;"Monetary Benefit?";Boolean)
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

