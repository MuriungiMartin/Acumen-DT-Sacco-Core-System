#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516253 "HR Notice Board Feedback Form"
{

    fields
    {
        field(1;"Event Date";Date)
        {
        }
        field(2;Venue;Text[30])
        {
        }
        field(3;"Start Time";Time)
        {
        }
        field(4;"Closing Time";Time)
        {
        }
        field(5;"Opening prayer By?";Code[70])
        {
        }
        field(6;"Closing Prayer By?";Code[70])
        {
        }
        field(7;Secretary;Code[70])
        {
        }
        field(8;Details;Text[250])
        {
        }
        field(9;"Action Parties";Code[70])
        {
        }
        field(10;"Close Out Date";Date)
        {
        }
        field(11;Remark;Text[100])
        {
        }
        field(12;"Next Meeting Date if Known";Date)
        {
        }
        field(13;"Line No.";Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(14;"Document No";Text[30])
        {
        }
    }

    keys
    {
        key(Key1;"Document No","Line No.","Event Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

