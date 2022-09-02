#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516938 "CRM Training Suppliers"
{

    fields
    {
        field(1;"CRM Training No";Code[20])
        {
        }
        field(2;"Supplier Vendor No";Code[20])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                if ObjVendor.Get("Supplier Vendor No") then
                   begin
                     "Supplier Name":=ObjVendor.Name;
                     end;
            end;
        }
        field(3;"Supplier Name";Code[50])
        {
        }
        field(4;Narration;Text[100])
        {
        }
        field(5;Cost;Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"CRM Training No","Supplier Vendor No",Narration)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjVendor: Record Vendor;
}

