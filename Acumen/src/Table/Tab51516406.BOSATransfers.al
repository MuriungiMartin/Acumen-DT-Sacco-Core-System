#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516406 "BOSA Transfers"
{

    fields
    {
        field(1;No;Code[20])
        {

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                  NoSetup.Get(0);
                  NoSeriesMgt.TestManual(No);
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Transaction Date";Date)
        {
        }
        field(3;"Schedule Total";Decimal)
        {
            CalcFormula = sum("BOSA TransferS Schedule".Amount where ("No."=field(No)));
            FieldClass = FlowField;
        }
        field(4;Approved;Boolean)
        {
        }
        field(5;"Approved By";Code[20])
        {
        }
        field(6;Posted;Boolean)
        {
        }
        field(7;"No. Series";Code[20])
        {
        }
        field(8;"Responsibility Center";Code[10])
        {
        }
        field(9;Remarks;Code[30])
        {
        }
    }

    keys
    {
        key(Key1;No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Approved or Posted then
        Error('Cannot delete posted or approved batch');
    end;

    trigger OnInsert()
    begin
         if No = '' then begin
          NoSetup.Get;
          NoSetup.TestField(NoSetup."BOSA Transfer Nos");
          NoSeriesMgt.InitSeries(NoSetup."BOSA Transfer Nos",xRec."No. Series",0D,No,"No. Series");
          end;
         "Transaction Date":=Today;
    end;

    trigger OnModify()
    begin
        if Posted then
        Error('Cannot modify a posted batch');
    end;

    trigger OnRename()
    begin
        if Posted then
        Error('Cannot rename a posted batch');
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

