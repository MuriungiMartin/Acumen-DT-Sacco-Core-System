#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516286 "HR Insurance Schemes"
{
    DrillDownPageID = "HR Medical Schemes List";
    LookupPageID = "HR Medical Schemes List";

    fields
    {
        field(1;"Scheme No";Code[10])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "Scheme No" <> xRec."Scheme No" then begin
                  HRSetup.Get;
                  NoSeriesMgt.TestManual(HRSetup."HR Insurance Sch Nos");
                  "No. Series":= '';
                end;
            end;
        }
        field(2;Insurer;Code[10])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin

                         Insurer1.Reset;
                         Insurer1.SetRange(Insurer1."No.",Insurer);
                          if Insurer1.Find('-') then begin
                         "Insurer Name":=Insurer1.Name;

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
        field(10;"No. Series";Code[10])
        {

            trigger OnLookup()
            begin
                jjjjjj
            end;
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
    }

    trigger OnInsert()
    begin
        if "Scheme No" = '' then begin
             HRSetup.Get;
             HRSetup.TestField(HRSetup."HR Insurance Sch Nos");
             NoSeriesMgt.InitSeries(HRSetup."HR Insurance Sch Nos",xRec."No. Series",0D,"Scheme No","No. Series");
        end;
    end;

    var
        Insurer1: Record Vendor;
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

