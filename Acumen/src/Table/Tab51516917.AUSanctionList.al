#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516917 "AU Sanction List"
{

    fields
    {
        field(1;"Code";Code[20])
        {
        }
        field(2;"Name of Individual/Entity";Text[250])
        {
        }
        field(3;"Date of Birth";Text[250])
        {
        }
        field(4;"Palace Of Birth";Text[250])
        {
        }
        field(5;Citizenship;Text[250])
        {
        }
        field(6;"Listing Information";Text[250])
        {
        }
        field(7;"Control Date";Date)
        {
        }
        field(8;"AU Sactions kenya";Boolean)
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

