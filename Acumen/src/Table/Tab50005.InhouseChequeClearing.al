#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50005 "Inhouse Cheque Clearing"
{

    fields
    {
        field(1;No;Code[10])
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
        field(5;"Approved By";Code[10])
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
        field(10;"Cheque Clearing Bank";Code[20])
        {
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                if BankRec.Get("Cheque Clearing Bank") then begin
                "Cheque Clearing Name":=BankRec.Name;
                end;
            end;
        }
        field(11;"Cheque Clearing Name";Code[30])
        {
        }
        field(12;"Total Amount";Decimal)
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
        /*IF Approved OR Posted THEN
        ERROR('Cannot delete posted or approved batch');
        */

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
        /*IF Posted THEN
        ERROR('Cannot modify a posted batch');
        */

    end;

    trigger OnRename()
    begin
        /*IF Posted THEN
        ERROR('Cannot rename a posted batch');
        */

    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BankRec: Record "Bank Account";
}

