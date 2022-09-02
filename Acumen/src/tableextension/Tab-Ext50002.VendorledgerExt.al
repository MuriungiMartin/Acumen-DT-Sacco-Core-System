tableextension 50002 "VendorledgerExt" extends "Vendor Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
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
        field(51516064; Alerted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516065; "Member No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(51516066; "Created On"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(51516067; "Cheque Maturity Date"; Date)
        {
            //TODO after Fixing transactions table
            // CalcFormula = Lookup(Transactions."Expected Maturity Date" WHERE(No = FIELD("Document No.")));
            // FieldClass = FlowField;
        }
        field(51516068; "Computer Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(51516069; "Member No II"; Code[30])
        {
            CalcFormula = Lookup(Vendor."BOSA Account No" WHERE("No." = FIELD("Vendor No.")));
            FieldClass = FlowField;
        }
    }

    var
        myInt: Integer;
}