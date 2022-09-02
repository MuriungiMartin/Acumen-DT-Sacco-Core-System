#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516294 "HR Medical Claim Entries"
{
    DrillDownPageID = "Medical Claim Entries";
    LookupPageID = "Medical Claim Entries";

    fields
    {
        field(10;"Entry No";Integer)
        {
            AutoIncrement = true;
        }
        field(11;"Document No.";Code[30])
        {
        }
        field(12;"Employee No";Code[30])
        {
        }
        field(13;"Employee Name";Text[80])
        {
        }
        field(14;"Claim Date";Date)
        {
        }
        field(15;"Hospital Visit Date";Date)
        {
        }
        field(16;"Claim Limit";Decimal)
        {
        }
        field(17;"Balance Claim Amount";Decimal)
        {
        }
        field(18;"Amount Claimed";Decimal)
        {
        }
        field(19;"Amount Charged";Decimal)
        {
        }
        field(20;Comments;Text[100])
        {
        }
        field(21;"USER ID";Code[30])
        {
        }
        field(22;"Claim No";Code[30])
        {
        }
        field(23;"Date Posted";Date)
        {
        }
        field(24;"Time Posted";Time)
        {
        }
        field(25;Posted;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

