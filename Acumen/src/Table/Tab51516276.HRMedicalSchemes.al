#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516276 "HR Medical Schemes"
{

    fields
    {
        field(1;"Scheme No";Code[10])
        {
        }
        field(2;"Medical Insurer";Code[50])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin

                         Insurer.Reset;
                         Insurer.SetRange(Insurer."No.","Medical Insurer");
                          if Insurer.Find('-') then begin
                         "Insurer Name":=Insurer.Name;

                          end;
            end;
        }
        field(3;"Scheme Name";Text[250])
        {
        }
        field(4;"In-patient limit";Decimal)
        {
        }
        field(5;"Out-patient limit";Decimal)
        {
        }
        field(6;"Area Covered";Text[30])
        {
        }
        field(7;"Dependants Included";Boolean)
        {
        }
        field(8;Comments;Text[100])
        {
        }
        field(9;"Insurer Name";Text[250])
        {
        }
    }

    keys
    {
        key(Key1;"Scheme No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"Scheme No","Scheme Name")
        {
        }
    }

    var
        Insurer: Record Vendor;
}

