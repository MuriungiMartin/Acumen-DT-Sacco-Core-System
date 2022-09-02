#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516312 "Payroll Type."
{
    DrillDownPageID = UnknownPage39004021;
    LookupPageID = UnknownPage39004021;

    fields
    {
        field(1;"Payroll Code";Code[10])
        {
        }
        field(2;"Payroll Name";Text[50])
        {
        }
        field(3;Comment;Text[200])
        {
        }
        field(4;"Period Length";DateFormula)
        {
        }
        field(5;EntryNo;Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1;"Payroll Code")
        {
            Clustered = true;
        }
        key(Key2;EntryNo)
        {
        }
    }

    fieldgroups
    {
    }
}

