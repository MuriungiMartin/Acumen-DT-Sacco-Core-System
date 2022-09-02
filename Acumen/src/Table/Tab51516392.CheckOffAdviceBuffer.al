#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516392 "Check-Off Advice Buffer"
{

    fields
    {
        field(1;"Entry No";Integer)
        {
        }
        field(2;"Member No.";Code[20])
        {
        }
        field(3;"Personal No.";Code[20])
        {
        }
        field(4;Names;Text[250])
        {
        }
        field(5;"New Amount";Decimal)
        {
        }
        field(6;"Non Rec";Decimal)
        {
        }
        field(7;"Current Amount";Decimal)
        {
        }
        field(8;"New Balance";Decimal)
        {
        }
        field(9;EDCode;Code[20])
        {
        }
        field(10;Employer;Code[20])
        {
            TableRelation = "Sacco Employers".Code;
        }
        field(11;Refference;Code[20])
        {
        }
        field(12;Month;Integer)
        {
        }
        field(13;Remarks;Text[30])
        {
        }
        field(14;Station;Code[20])
        {
        }
        field(15;"NR Code";Code[20])
        {
        }
        field(16;"Sacco Code";Code[20])
        {
        }
        field(17;"Vote Code";Code[20])
        {
        }
        field(18;"Account No.";Code[20])
        {
        }
        field(19;"Current Balance";Decimal)
        {
        }
        field(20;"Transaction Type";Code[10])
        {
        }
        field(21;"Transaction Name";Text[30])
        {
        }
        field(22;Interest;Integer)
        {
        }
        field(23;"Action";Integer)
        {
        }
        field(24;"Old Account No";Text[30])
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

