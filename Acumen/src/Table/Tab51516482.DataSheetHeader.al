#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516482 "Data Sheet Header"
{

    fields
    {
        field(1;"Code";Code[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Code <> xRec.Code then begin
                  NoSetup.Get();
                  NoSeriesMgt.TestManual(NoSetup."Check Off Advisor");
                 "No. Series" := '';
                end;
            end;
        }
        field(2;"Period Month";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Period Code";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"User ID";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Total Schedule Amount";Decimal)
        {
            CalcFormula = sum("Data Sheet Lines".Amount where ("Data Sheet Header"=field(Code)));
            FieldClass = FlowField;
        }
        field(6;"Total Schedule Amount P";Decimal)
        {
            CalcFormula = sum("Data Sheet Lines"."Principal Amount" where ("Data Sheet Header"=field(Code)));
            FieldClass = FlowField;
        }
        field(7;"Total Schedule Amount I";Decimal)
        {
            CalcFormula = sum("Data Sheet Lines"."Outstanding Interest" where ("Data Sheet Header"=field(Code)));
            FieldClass = FlowField;
        }
        field(8;"Total Schedule Amount D";Decimal)
        {
            CalcFormula = sum("Data Sheet Lines"."Deposit Contribution" where ("Data Sheet Header"=field(Code)));
            FieldClass = FlowField;
        }
        field(9;Closed;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Employer Code";Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sacco Employers".Code;
        }
        field(11;"No. Series";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Cut Off Date";Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Period Code":=FnGetCheckOffDescription();
            end;
        }
        field(13;"Total Chumbefu";Decimal)
        {
            CalcFormula = sum("Data Sheet Lines"."Benevolent Contribution" where ("Data Sheet Header"=field(Code)));
            FieldClass = FlowField;
        }
        field(14;"Total Capital Reserve";Decimal)
        {
            CalcFormula = sum("Data Sheet Lines"."Capital Reserve" where ("Data Sheet Header"=field(Code)));
            FieldClass = FlowField;
        }
        field(15;"Total Members";Integer)
        {
            CalcFormula = count("Data Sheet Lines" where ("Data Sheet Header"=field(Code)));
            FieldClass = FlowField;
        }
        field(16;"FOSA Contribution";Decimal)
        {
            CalcFormula = sum("Data Sheet Lines"."FOSA Contribution" where ("Data Sheet Header"=field(Code)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Code = '' then begin
        NoSetup.Get();
        NoSetup.TestField(NoSetup."Check Off Advisor");
        NoSeriesMgt.InitSeries(NoSetup."Check Off Advisor",xRec."No. Series",0D,Code,"No. Series");
        end;
        "User ID":=UserId;
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    local procedure FnGetCheckOffDescription() rtVal: Text
    begin
        case Date2dmy("Cut Off Date",2) of
          1:
            rtVal:='JAN';
          2:
            rtVal:='FEB';
          3:
            rtVal:='MAR';
          4:
            rtVal:='APR';
          5:
            rtVal:='MAY';
          6:
            rtVal:='JUN';
          7:
            rtVal:='JUL';
          8:
            rtVal:='AUG';
          9:
            rtVal:='SEPT';
          10:
            rtVal:='OCT';
          11:
            rtVal:='NOV';
          12:
            rtVal:='DEC';
          end;
          exit('ADV'+rtVal+Format(Date2dmy("Cut Off Date",3)));
    end;
}

