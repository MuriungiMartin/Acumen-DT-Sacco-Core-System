tableextension 50047 "GlentryExt" extends "G/L Entry"
{
    fields
    {
        // Add changes to table fields here
        field(51516000; "Staff Account"; Boolean)
        {
            CalcFormula = lookup(Vendor."Staff Account" where("No." = field("Bal. Account No.")));
            FieldClass = FlowField;
        }
        field(51516001; "Remaining Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51516061; "Reversal Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51516062; "Transaction Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Actual Transaction Date(Workdate)';
            Editable = false;
        }
        field(51516063; "Application Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,CBS,ATM,Mobile,Internet,MPESA,Equity,Co-op,Family,SMS Banking';
            OptionMembers = " ",CBS,ATM,Mobile,Internet,MPESA,Equity,"Co-op",Family,"SMS Banking";
        }
        field(51516064; "Created On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(51516065; "GL Account Found"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}