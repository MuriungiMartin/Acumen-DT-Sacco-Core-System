#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516292 "File Locations Setup"
{

    fields
    {
        field(1;Location;Code[20])
        {
        }
        field(2;Description;Text[100])
        {
        }
        field(3;"Custodian Code";Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(4;"Custodian Name";Text[50])
        {
        }
    }

    keys
    {
        key(Key1;Location)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

