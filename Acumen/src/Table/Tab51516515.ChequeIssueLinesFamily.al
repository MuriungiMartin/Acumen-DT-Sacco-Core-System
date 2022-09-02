#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516515 "Cheque Issue Lines-Family"
{
    DrillDownPageID = "Loan PayOff Details";
    LookupPageID = "Loan PayOff Details";

    fields
    {
        field(1;test;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(20;dert;Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;test)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        RetCode: Record "Cheque Receipts";
}

