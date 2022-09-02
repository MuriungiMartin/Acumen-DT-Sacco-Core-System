tableextension 50013 "GLSETUPEXT" extends "General Ledger Setup"
{
    fields
    {
        // Add changes to table fields here

        field(50021; "Journal Approval Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
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
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(54242; "LCY Code Decimals"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(54250; "Base No. Series"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Responsibility Center,Shortcut Dimension 1,Shortcut Dimension 2,Shortcut Dimension 3,Shortcut Dimension 4';
            OptionMembers = " ","Responsibility Center","Shortcut Dimension 1","Shortcut Dimension 2","Shortcut Dimension 3","Shortcut Dimension 4","Shortcut Dimension 5","Shortcut Dimension 6","Shortcut Dimension 7","Shortcut Dimension 8";
        }
        field(54251; "Cash Purchases Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54252; "Payroll Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54253; "Interbank Transfer Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54254; "Bulk SMS Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54255; "Agency Application Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54256; "CloudPESA Comm Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(54257; "Agent Charges Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(54258; "Mobile Charge"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Charges;
        }
        field(54259; "CloudPESA Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54260; "MPESA Settl Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(54261; "PayBill Settl Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(54265; "File Movement Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54266; "family account bank"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(54267; "equity bank acc"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(54268; "coop bank acc"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(54269; "Suspense fb"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(54270; "suspense coop bank"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(54271; "suspense equity"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(54272; "Suspense Paybill"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(54273; "Safaricom Paybill"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(54274; "Transaction Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(54275; "Non Earning Cash BenchMark"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54276; "Earning Bank Cash BenchMark"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54277; "Regulator Miinimum Ratio"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54278; "New Member Suspense"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(54279; "CloudPESA Comm Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54280; "Paybill Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54281; "MPESA Recon Acc"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}