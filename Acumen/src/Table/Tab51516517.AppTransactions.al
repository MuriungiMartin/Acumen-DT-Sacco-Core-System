#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516517 "App Transactions"
{
    DrillDownPageID = "CloudPESA Paybill Tran Card";
    LookupPageID = "CloudPESA Paybill Tran Card";

    fields
    {
        field(1;"Trace Id";Code[10])
        {
        }
        field(2;"Posting  Date";Date)
        {
        }
        field(3;"Account No";Code[50])
        {
        }
        field(4;Amount;Decimal)
        {
        }
        field(5;Posted;Boolean)
        {
        }
        field(6;"Transaction Type";Text[30])
        {
        }
        field(7;"Transaction Time";Text[50])
        {
        }
        field(8;"Transaction Date";Date)
        {
        }
        field(9;Reversed;Boolean)
        {
        }
        field(10;"Reversed Posted";Boolean)
        {
        }
        field(11;"Reverse Trace Id";Code[50])
        {
        }
        field(12;"Entry No";Integer)
        {
        }
        field(13;"Charge Type";Option)
        {
            OptionCaption = 'Balance Enquiry,Mini Statement,Cash Withdrawal,Airtime Purchase';
            OptionMembers = "Balance Enquiry","Mini Statement","Cash Withdrawal","Airtime Purchase";
        }
        field(14;"Customer Name";Text[200])
        {
        }
        field(15;"Process Code";Code[10])
        {
        }
        field(16;"Reference No";Text[50])
        {
        }
        field(17;Description;Text[50])
        {
        }
    }

    keys
    {
        key(Key1;"Trace Id")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

