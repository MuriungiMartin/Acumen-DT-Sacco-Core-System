tableextension 50015 "FaPostingrpEXT" extends "FA Posting Group"
{
    fields
    {
        // Add changes to table fields here
        field(51516060; "Depreciation Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Straight-Line,Declining-Balance 1,Declining-Balance 2,DB1/SL,DB2/SL,User-Defined,Manual';
            OptionMembers = "Straight-Line","Declining-Balance 1","Declining-Balance 2","DB1/SL","DB2/SL","User-Defined",Manual;
        }
        field(51516061; "Depreciation %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51516062; "Asset Disposal Account"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51516063; "Asset Writeoff Account"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }

    var
        myInt: Integer;
}