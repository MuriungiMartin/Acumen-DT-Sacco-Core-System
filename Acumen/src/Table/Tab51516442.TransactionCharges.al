#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516442 "Transaction Charges"
{
    DrillDownPageID = "Transaction Charges";
    LookupPageID = "Transaction Charges";

    fields
    {
        field(1;"Transaction Type";Code[20])
        {
            TableRelation = "Transaction Types";
        }
        field(2;"Charge Code";Code[20])
        {
            NotBlank = true;
            TableRelation = Charges;

            trigger OnValidate()
            begin
                if Charges.Get("Charge Code") then begin
                Description:=Charges.Description;
                "Charge Amount":=Charges."Charge Amount";
                "Percentage of Amount":=Charges."Percentage of Amount";
                "Use Percentage":=Charges."Use Percentage";
                //"Minimum Amount":=Charges."Minimum Amount";
                //"Maximum Amount":=Charges."Maximum Amount";
                "G/L Account":=Charges."GL Account";
                end;
            end;
        }
        field(3;Description;Text[150])
        {
        }
        field(4;"Charge Amount";Decimal)
        {
        }
        field(5;"Percentage of Amount";Decimal)
        {

            trigger OnValidate()
            begin
                if "Percentage of Amount">100 then
                Error('You cannot exceed 100. Please enter a valid number.');
            end;
        }
        field(6;"Use Percentage";Boolean)
        {
        }
        field(7;"G/L Account";Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(8;"Minimum Amount";Decimal)
        {
        }
        field(9;"Maximum Amount";Decimal)
        {
        }
        field(10;"Due Amount";Decimal)
        {
        }
        field(11;"Due to Account";Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(12;"Charges 1-999";Decimal)
        {
        }
        field(13;"Charges 1000-19999";Decimal)
        {
        }
        field(14;"Charges 20000-49999";Decimal)
        {
        }
        field(15;"Charges 50000-99999";Decimal)
        {
        }
        field(16;"Charges 100000";Decimal)
        {
        }
        field(17;"PayOut 50-100";Decimal)
        {
        }
        field(18;"PayOut 100-200";Decimal)
        {
        }
        field(19;"PayOut 201-300";Decimal)
        {
        }
        field(20;"PayOut 301-400";Decimal)
        {
        }
        field(21;"PayOut 401-500";Decimal)
        {
        }
        field(22;"PayOut 501-600";Decimal)
        {
        }
        field(23;"PayOut 601  &  Above";Decimal)
        {
        }
        field(24;"Total Charges";Decimal)
        {
            CalcFormula = sum("Transaction Charges"."Charge Amount" where ("Transaction Type"=field("Transaction Type")));
            FieldClass = FlowField;
        }
        field(25;"Include Excise Duty";Boolean)
        {
        }
        field(26;"Excise Duty (10%)";Decimal)
        {
        }
        field(27;"Transaction Code";Code[20])
        {
        }
        field(28;"charges Amount 1-50000";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29;"charges Amount 50001-100000";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30;"charges Amount 100001-500000";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(31;"charges Amount 500001-1000000";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(32;"charges Amount >1000001";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33;"RTGS Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Transaction Type","Charge Code","Transaction Code","Minimum Amount","Maximum Amount")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Charges: Record Charges;
}

