#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516106 "Purchase Quote Params"
{

    fields
    {
        field(1;"Document Type";Option)
        {
            OptionCaption = 'Quotation Request,Open Tender,Restricted Tender';
            OptionMembers = "Quotation Request","Open Tender","Restricted Tender";
        }
        field(2;"Document No.";Code[20])
        {
        }
        field(3;Specification;Code[20])
        {
            TableRelation = "Quote Specifications".Code;

            trigger OnValidate()
            begin
                Spec.Reset;
                Spec.SetRange(Spec.Code,Specification);
                if Spec.FindFirst then
                  begin
                    Description:=Spec.Description;
                  end;
            end;
        }
        field(4;Description;Text[60])
        {
        }
        field(5;"Line No.";Integer)
        {
            AutoIncrement = false;
        }
        field(6;Value;Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Document Type","Document No.",Specification,"Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Spec: Record "Quote Specifications";
}

