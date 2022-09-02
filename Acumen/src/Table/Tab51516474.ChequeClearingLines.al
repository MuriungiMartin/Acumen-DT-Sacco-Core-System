#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516474 "Cheque Clearing Lines"
{

    fields
    {
        field(1;"No.";Code[10])
        {
        }
        field(2;"Transaction No";Code[20])
        {
        }
        field(3;"Account No";Code[50])
        {
        }
        field(4;"Account Name";Code[100])
        {
        }
        field(5;"Transaction Type";Code[20])
        {
        }
        field(6;Amount;Decimal)
        {
        }
        field(7;"Cheque No";Code[50])
        {
        }
        field(8;"Expected Maturity Date";Date)
        {
        }
        field(9;"Cheque Clearing Status";Option)
        {
            OptionCaption = ' ,Cleared,Bounced';
            OptionMembers = " ",Cleared,Bounced;
        }
        field(10;"Header No";Code[20])
        {
        }
        field(11;"Cheque Bounced";Boolean)
        {
        }
        field(12;"Ledger Entry No";Integer)
        {
            CalcFormula = lookup("Detailed Vendor Ledg. Entry"."Entry No." where ("Document No."=field("Transaction No")));
            FieldClass = FlowField;
        }
        field(13;"Ledger Transaction No.";Integer)
        {
            CalcFormula = lookup("Detailed Vendor Ledg. Entry"."Transaction No." where ("Document No."=field("Transaction No")));
            FieldClass = FlowField;
        }
        field(14;"Cheque Type";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Transaction No","Cheque No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Acc: Record Vendor;
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalBuffer: Record "Salary Processing Lines";
}

