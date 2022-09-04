#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516037 "CshMgt Application"
{
    // DrillDownPageID = UnknownPage56025;
    // LookupPageID = UnknownPage56025;

    fields
    {
        field(1;"Document Type";Option)
        {
            OptionMembers = PV,Receipt;
        }
        field(2;"Document No.";Code[20])
        {
        }
        field(3;"Line No.";Integer)
        {
        }
        field(4;Amount;Decimal)
        {
        }
        field(5;"Amount Applied";Decimal)
        {
        }
        field(6;"Appl. Doc. Type";Text[30])
        {
        }
        field(7;"Appl. Doc. No";Code[20])
        {
        }
        field(8;"Appl. Ext Doc. Ref";Code[20])
        {
        }
        field(9;"Appl. Description";Text[100])
        {
        }
        field(10;"Line Number";Integer)
        {
            AutoIncrement = true;
        }
        field(11;"Appl. Doc. Original Amount";Decimal)
        {
        }
        field(12;"Appl. Doc. Amount";Decimal)
        {
        }
        field(13;"Appl.Doc. Amount Including VAT";Decimal)
        {
        }
        field(14;"Appl. Doc. VAT Amount";Decimal)
        {
        }
        field(15;"Appl. Doc. VAT Rate";Decimal)
        {
        }
        field(16;"Appl. Doc. Remaining Amount";Decimal)
        {
        }
        field(17;"Appl. Doc. VAT Paid";Decimal)
        {
            Description = 'this is theoretical';
        }
        field(18;"Appl. Doc. VAT To Pay";Decimal)
        {
            Description = 'this is far-fetched but can work';
        }
        field(19;"Appl. Doc Date";Date)
        {
        }
        field(20;"VAT Base Amount";Decimal)
        {
        }
        field(51516000;"Document Date";Date)
        {
        }
        field(51516001;"Process Date";Date)
        {
        }
        field(51516002;"Process Time";Time)
        {
        }
        field(51516003;"Process User ID";Code[50])
        {
        }
        field(51516004;"Process Name";Option)
        {
            OptionCaption = 'Currentstatus,Previousstatus';
            OptionMembers = Currentstatus,Previousstatus;
        }
    }

    keys
    {
        key(Key1;"Line Number")
        {
            Clustered = true;
        }
        key(Key2;"Appl. Doc. No","Document Type","Appl. Doc. Type")
        {
            SumIndexFields = "Amount Applied";
        }
    }

    fieldgroups
    {
    }
}

