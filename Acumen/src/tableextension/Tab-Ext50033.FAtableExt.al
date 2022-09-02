tableextension 50033 "FAtableExt" extends "Fixed Asset"
{
    fields
    {
        // Add changes to table fields here

        field(54249; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(54250; "Created By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54251; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(54252; "Asset Label"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54253; Location; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(54254; "Payment Details"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(54255; "Supplier Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(54256; "Asset Disposal/Writeoff Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(54257; Custodian; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Assets Meta Codes".Code;

            trigger OnValidate()
            begin
                objCustodians.Reset;
                objCustodians.SetRange(objCustodians.Code, Custodian);
                if objCustodians.FindSet then
                    "Custodian Name" := objCustodians.Description;
            end;
        }
        field(54258; "Custodian Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(54259; "Action"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(54260; DisposedDepreciation; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54261; DisposedCost; Decimal)
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
    }

    var
        objCustodians: Record "Fixed Assets Meta Codes";
}