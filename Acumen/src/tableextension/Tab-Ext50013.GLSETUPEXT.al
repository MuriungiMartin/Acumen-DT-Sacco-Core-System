tableextension 50013 "GLSETUPEXT" extends "General Ledger Setup"
{
    fields
    {
        // Add changes to table fields here

        field(50021; "Journal Approval Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50146; "Bank Balances"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Bank Account Ledger Entry"."Amount (LCY)" where("Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                "Posting Date" = field("Date Filter")));
            Caption = 'Bank Balances';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50147; "Pending L.O.P"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Outstanding Amount (LCY)" where("Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                "Expected Receipt Date" = field("Date Filter"),
                                                                                Amount = filter(<> 0),
                                                                                "Document Type" = filter(<> Quote)));
            FieldClass = FlowField;
        }
        field(54241; "GjnlBatch Approval No"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(54242; "LCY Code Decimals"; Code[10])
        {
        }
        field(54250; "Base No. Series"; Option)
        {
            OptionCaption = ' ,Responsibility Center,Shortcut Dimension 1,Shortcut Dimension 2,Shortcut Dimension 3,Shortcut Dimension 4';
            OptionMembers = " ","Responsibility Center","Shortcut Dimension 1","Shortcut Dimension 2","Shortcut Dimension 3","Shortcut Dimension 4","Shortcut Dimension 5","Shortcut Dimension 6","Shortcut Dimension 7","Shortcut Dimension 8";
        }
        field(54251; "Cash Purchases Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(54252; "Payroll Posting Group"; Code[20])
        {
        }
        field(54253; "Interbank Transfer Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(54254; "Bulk SMS Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(54255; "Agency Application Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(54256; "CloudPESA Comm Acc"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(54257; "Agent Charges Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(54258; "Mobile Charge"; Code[20])
        {
            TableRelation = Charges;
        }
        field(54259; "CloudPESA Charge"; Decimal)
        {
        }
        field(54260; "MPESA Settl Acc"; Code[30])
        {
            TableRelation = "Bank Account";
        }
        field(54261; "PayBill Settl Acc"; Code[30])
        {
            TableRelation = "Bank Account";
        }
        field(54265; "File Movement Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(54266; "family account bank"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(54267; "equity bank acc"; Code[50])
        {
            TableRelation = "Bank Account";
        }
        field(54268; "coop bank acc"; Code[50])
        {
            TableRelation = "Bank Account";
        }
        field(54269; AirTimeSettlAcc; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(54270; "Sacco Charge Account"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(54271; "Mobile Loanrepayment fee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Charges.Code;
        }
        field(54272; "Mobile Balance Enquiry fee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Charges.Code;
        }
        field(54273; "Mobile FOSA-BOSA transfer fee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Charges.Code;
        }
        field(54274; "Mobile FOSA transfer fee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Charges.Code;
        }
        field(54275; "Mobile Ministatement fee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Charges.Code;
        }

    }

    var
        myInt: Integer;
}