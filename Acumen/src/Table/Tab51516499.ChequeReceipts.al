#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516499 "Cheque Receipts"
{

    fields
    {
        field(1;"No.";Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                  SalesSetup.Get;
                  NoSeriesmgt.TestManual(SalesSetup."Cheque Receipts Nos");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Transaction Date";Date)
        {
        }
        field(3;"Refference Document";Code[20])
        {
        }
        field(4;"Transaction Time";Time)
        {
        }
        field(5;"Created By";Code[60])
        {
        }
        field(6;"Posted By";Code[60])
        {
        }
        field(7;Posted;Boolean)
        {
        }
        field(8;"No. Series";Code[10])
        {
        }
        field(9;"Unpaid By";Code[60])
        {
            Editable = false;
        }
        field(10;Unpaid;Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin


        if "No." = '' then begin
          SalesSetup.Get;
          SalesSetup.TestField(SalesSetup."Cheque Receipts Nos");
          NoSeriesmgt.InitSeries(SalesSetup."Cheque Receipts Nos",xRec."No. Series",0D,"No.","No. Series");
        end;

        "Transaction Time":=Time;
        "Transaction Date":=Today;
    end;

    var
        NoSeriesmgt: Codeunit NoSeriesManagement;
        SalesSetup: Record "Sacco No. Series";
}

