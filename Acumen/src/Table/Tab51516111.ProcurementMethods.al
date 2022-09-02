#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516111 "Procurement Methods"
{

    fields
    {
        field(1;"Code";Code[20])
        {
            NotBlank = true;
        }
        field(2;Description;Text[30])
        {
        }
        field(3;"Invite/Advertise date";Date)
        {
        }
        field(4;"Invite/Advertise period";DateFormula)
        {
        }
        field(5;"Open tender period";Integer)
        {
        }
        field(6;"Evaluate tender period";Integer)
        {
        }
        field(7;"Committee period";Integer)
        {
        }
        field(8;"Notification period";Integer)
        {
        }
        field(9;"Contract period";Integer)
        {
        }
        field(11;"Planned Date";Date)
        {
        }
        field(12;"Planned Days";DateFormula)
        {
        }
        field(13;"Actual Days";DateFormula)
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

