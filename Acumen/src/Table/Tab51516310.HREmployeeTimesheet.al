#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516310 "HR Employee Timesheet."
{

    fields
    {
        field(10;"Employee No";Code[20])
        {
        }
        field(11;Day;Date)
        {
        }
        field(12;"Period Month";Integer)
        {
        }
        field(13;"Period Year";Integer)
        {
        }
        field(14;"Start Time";Time)
        {
        }
        field(15;"End Time";Time)
        {
        }
    }

    keys
    {
        key(Key1;"Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

