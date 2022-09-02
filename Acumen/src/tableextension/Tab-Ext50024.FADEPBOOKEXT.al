tableextension 50024 "FADEPBOOKEXT" extends "FA Depreciation Book"
{
    fields
    {
        // Add changes to table fields here

        field(71; "Total Depr. Value to Date"; Decimal)
        {
            CalcFormula = sum("FA Ledger Entry".Amount where("FA No." = field("FA No."),
                                                              "FA Posting Type" = filter(Depreciation)));
            FieldClass = FlowField;
        }
        field(72; "Total Cost Value to Date"; Decimal)
        {
            CalcFormula = sum("FA Ledger Entry".Amount where("FA No." = field("FA No."),
                                                              "FA Posting Type" = filter("Acquisition Cost" | Appreciation)));
            FieldClass = FlowField;
        }
        field(73; "Disposed/Writtenoff Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(74; "Disposed/Writtenoff Depr"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Disposal Salvage Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(76; "Initial Cost Value"; Decimal)
        {
            CalcFormula = sum("FA Ledger Entry".Amount where("FA No." = field("FA No."),
                                                              "FA Posting Type" = filter("Acquisition Cost" | Appreciation),
                                                              Amount = filter(> 0)));
            FieldClass = FlowField;
        }
        field(77; "Next Depreciation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(78; "Exempt From Depreciation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

    var
        myInt: Integer;
}