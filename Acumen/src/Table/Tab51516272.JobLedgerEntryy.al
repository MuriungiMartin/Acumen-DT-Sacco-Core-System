#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516272 "Job-Ledger Entryy"
{
    Caption = 'Job Ledger Entry';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            // TableRelation = Jobs;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Resource,Item,G/L Account';
            OptionMembers = Resource,Item,"G/L Account";
        }
        field(7; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(Resource)) Resource
            else
            if (Type = const(Item)) Item
            else
            if (Type = const("G/L Account")) "G/L Account";
        }
        field(8; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(9; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(11; "Direct Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost (LCY)';
        }
        field(12; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
            Editable = false;
        }
        field(13; "Total Cost (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Cost (LCY)';
            Editable = false;
        }
        field(14; "Unit Price (LCY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price (LCY)';
            Editable = false;
        }
        field(15; "Total Price (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price (LCY)';
            Editable = false;
        }
        field(16; "Resource Group No."; Code[20])
        {
            Caption = 'Resource Group No.';
            Editable = false;
            TableRelation = "Resource Group";
        }
        field(17; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."))
            else
            if (Type = const(Resource)) "Resource Unit of Measure".Code where("Resource No." = field("No."));
        }
        field(20; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(29; "Job Posting Group"; Code[20])
        {
            Caption = 'Job Posting Group';
            TableRelation = if (Type = const(Item)) "Inventory Posting Group"
            else
            if (Type = const("G/L Account")) "G/L Account";
        }
        field(30; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(31; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(32; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(33; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(37; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit UserManagementCUExt;
            begin
                LoginMgt.LookupUser("User ID");
            end;
        }
        field(38; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
        }
        field(60; "Amt. to Post to G/L"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amt. to Post to G/L';
        }
        field(61; "Amt. Posted to G/L"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amt. Posted to G/L';
        }
        field(62; "Amt. to Recognize"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amt. to Recognize';
        }
        field(63; "Amt. Recognized"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amt. Recognized';
        }
        field(64; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Usage,Sale';
            OptionMembers = Usage,Sale;
        }
        field(75; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
        }
        field(76; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(77; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(78; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(79; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(80; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(81; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(82; "Entry/Exit Point"; Code[10])
        {
            Caption = 'Entry/Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(83; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(84; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(85; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(86; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(87; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(88; "Additional-Currency Total Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Additional-Currency Total Cost';
        }
        field(89; "Add.-Currency Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Add.-Currency Total Price';
        }
        field(94; "Add.-Currency Line Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Add.-Currency Line Amount';
        }
        field(1000; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
        field(1001; "Line Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Amount (LCY)';
            Editable = false;
        }
        field(1002; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';
        }
        field(1003; "Total Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Total Cost';
        }
        field(1004; "Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price';
        }
        field(1005; "Total Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Total Price';
        }
        field(1006; "Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Amount';
        }
        field(1007; "Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';
        }
        field(1008; "Line Discount Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Discount Amount (LCY)';
            Editable = false;
        }
        field(1009; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(1010; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
        }
        field(1016; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(1017; "Ledger Entry Type"; Option)
        {
            Caption = 'Ledger Entry Type';
            OptionCaption = ' ,Resource,Item,G/L Account';
            OptionMembers = " ",Resource,Item,"G/L Account";
        }
        field(1018; "Ledger Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Ledger Entry No.';
            TableRelation = if ("Ledger Entry Type" = const(Resource)) "Res. Ledger Entry"
            else
            if ("Ledger Entry Type" = const(Item)) "Item Ledger Entry"
            else
            if ("Ledger Entry Type" = const("G/L Account")) "G/L Entry";
        }
        field(1019; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
        }
        field(1020; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
        }
        field(1021; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
        }
        field(1022; "Line Type"; Option)
        {
            Caption = 'Line Type';
            OptionCaption = ' ,Schedule,Contract,Both Schedule and Contract';
            OptionMembers = " ",Schedule,Contract,"Both Schedule and Contract";
        }
        field(1023; "Original Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Original Unit Cost (LCY)';
            Editable = false;
        }
        field(1024; "Original Total Cost (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Original Total Cost (LCY)';
            Editable = false;
        }
        field(1025; "Original Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Original Unit Cost';
        }
        field(1026; "Original Total Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Original Total Cost';
        }
        field(1027; "Original Total Cost (ACY)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Original Total Cost (ACY)';
        }
        field(1028; Adjusted; Boolean)
        {
            Caption = 'Adjusted';
        }
        field(1029; "DateTime Adjusted"; DateTime)
        {
            Caption = 'DateTime Adjusted';
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = if (Type = const(Item)) "Item Variant".Code where("Item No." = field("No."));
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code where("Location Code" = field("Location Code"));
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5405; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
        }
        field(5900; "Service Order No."; Code[20])
        {
            Caption = 'Service Order No.';
        }
        field(5901; "Posted Service Shipment No."; Code[20])
        {
            Caption = 'Posted Service Shipment No.';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Job No.", "Job Task No.", "Entry Type", "Posting Date")
        {
            SumIndexFields = "Total Cost (LCY)", "Line Amount (LCY)";
        }
        key(Key3; "Document No.", "Posting Date")
        {
        }
        key(Key4; "Job No.", "Posting Date")
        {
        }
        key(Key5; "Entry Type", Type, "No.", "Posting Date")
        {
        }
        key(Key6; "Service Order No.", "Posting Date")
        {
        }
        key(Key7; "Job No.", "Entry Type", Type, "No.")
        {
        }
        key(Key8; Type, "Entry Type", "Country/Region Code", "Source Code", "Posting Date")
        {
        }
    }

    fieldgroups
    {
    }
}

