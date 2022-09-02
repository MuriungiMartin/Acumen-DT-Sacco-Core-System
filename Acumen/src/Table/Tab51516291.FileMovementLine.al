#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516291 "File Movement Line"
{

    fields
    {
        field(1;"Document No.";Code[20])
        {
        }
        field(2;"File Type";Code[20])
        {
            TableRelation = "File Types SetUp".Code;
        }
        field(3;"Account Type";Code[20])
        {
            TableRelation = "Account Types-Saving Products".Code;
        }
        field(4;"Account No.";Code[20])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                Vendor.Reset;
                Vendor.SetRange(Vendor."No.","Account No.");
                if Vendor.Find('-') then
                  "Account Name":=Vendor.Name;
            end;
        }
        field(5;"Purpose/Description";Text[100])
        {
        }
        field(6;"Global Dimension 1 Code";Code[20])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=filter(1));
        }
        field(7;"Global Dimension 2 Code";Code[20])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=filter(2));
        }
        field(8;"Account Name";Text[100])
        {
            Editable = false;
        }
        field(9;"File Number";Code[50])
        {
        }
        field(10;"Line No.";Integer)
        {
            AutoIncrement = true;
        }
        field(11;"Destination File Location";Code[40])
        {
            TableRelation = "File Locations Setup".Location;
        }
    }

    keys
    {
        key(Key1;"Line No.","Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Vendor: Record Vendor;
}

