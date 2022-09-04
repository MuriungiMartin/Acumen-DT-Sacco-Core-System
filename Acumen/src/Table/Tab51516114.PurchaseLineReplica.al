#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516114 "Purchase Line Replica"
{
    Caption = 'Purchase Line';
    DrillDownPageID = "Purchase Lines";
    LookupPageID = "Purchase Lines";
    PasteIsValid = false;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            Editable = false;
            TableRelation = Vendor;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Purchase Header"."No." where("Document Type" = field("Document Type"));
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item),Resource';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)",Resource;
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(" ")) "Standard Text"
            else
            if (Type = const("G/L Account"),
                                     "System-Created Entry" = const(false)) "G/L Account" where("Direct Posting" = const(true),
                                                                                               "Account Type" = const(Posting),
                                                                                               Blocked = const(false),
                                                                                               "Expense Code" = field("Expense Code"))
            else
            if (Type = const("G/L Account"),
                                                                                                        "System-Created Entry" = const(false)) "G/L Account"
            else
            if (Type = const(Item)) Item
            else
            if (Type = const("Fixed Asset")) "Fixed Asset"
            else
            if (Type = const("Charge (Item)")) "Item Charge"
            else
            if (Type = const(Resource)) Resource;

            trigger OnValidate()
            var
                ICPartner: Record "IC Partner";
                ItemCrossReference: Record "Item Cross Reference";
                PrepmtMgt: Codeunit "Prepayment Mgt.";
            begin
            end;
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(8; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = if (Type = const(Item)) "Inventory Posting Group"
            else
            if (Type = const("Fixed Asset")) "FA Posting Group";
        }
        field(10; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
        }
        field(11; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(12; "Description 2"; Text[250])
        {
            Caption = 'Description 2';
        }
        field(13; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(16; "Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(17; "Qty. to Invoice"; Decimal)
        {
            Caption = 'Qty. to Invoice';
            DecimalPlaces = 0 : 5;
        }
        field(18; "Qty. to Receive"; Decimal)
        {
            Caption = 'Qty. to Receive';
            DecimalPlaces = 0 : 5;
        }
        field(22; "Direct Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            CaptionClass = GetCaptionClass(FIELDNO("Direct Unit Cost"));
            Caption = 'Direct Unit Cost';
        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
        }
        field(25; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(27; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(28; "Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';
        }
        field(29; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            Editable = false;
        }
        field(31; "Unit Price (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price (LCY)';
        }
        field(32; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.';
            InitValue = true;
        }
        field(34; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
        }
        field(35; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
        }
        field(36; "Units per Parcel"; Decimal)
        {
            Caption = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
        }
        field(37; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 5;
        }
        field(38; "Appl.-to Item Entry"; Integer)
        {
            Caption = 'Appl.-to Item Entry';
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(45; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;

            trigger OnValidate()
            var
                Job: Record Job;
            begin
            end;
        }
        field(54; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(57; "Outstanding Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Outstanding Amount';
            Editable = false;

            trigger OnValidate()
            var
                Currency2: Record Currency;
            begin
            end;
        }
        field(58; "Qty. Rcd. Not Invoiced"; Decimal)
        {
            Caption = 'Qty. Rcd. Not Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(59; "Amt. Rcd. Not Invoiced"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amt. Rcd. Not Invoiced';
            Editable = false;

            trigger OnValidate()
            var
                Currency2: Record Currency;
            begin
            end;
        }
        field(60; "Quantity Received"; Decimal)
        {
            Caption = 'Quantity Received';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(61; "Quantity Invoiced"; Decimal)
        {
            Caption = 'Quantity Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(63; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            Editable = false;
        }
        field(64; "Receipt Line No."; Integer)
        {
            Caption = 'Receipt Line No.';
            Editable = false;
        }
        field(67; "Profit %"; Decimal)
        {
            Caption = 'Profit %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(68; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'Pay-to Vendor No.';
            Editable = false;
            TableRelation = Vendor;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Discount Amount';
            Editable = false;
        }
        field(70; "Vendor Item No."; Text[20])
        {
            Caption = 'Vendor Item No.';
        }
        field(71; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            Editable = false;
            TableRelation = if ("Drop Shipment" = const(true)) "Sales Header"."No." where("Document Type" = const(Order));
        }
        field(72; "Sales Order Line No."; Integer)
        {
            Caption = 'Sales Order Line No.';
            Editable = false;
            TableRelation = if ("Drop Shipment" = const(true)) "Sales Line"."Line No." where("Document Type" = const(Order),
                                                                                            "Document No." = field("Sales Order No."));
        }
        field(73; "Drop Shipment"; Boolean)
        {
            Caption = 'Drop Shipment';
            Editable = false;
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(75; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(77; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(78; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(79; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(80; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            Editable = false;
            TableRelation = "Purchase Line"."Line No." where("Document Type" = field("Document Type"),
                                                              "Document No." = field("Document No."));
        }
        field(81; "Entry Point"; Code[10])
        {
            Caption = 'Entry Point';
            TableRelation = "Entry/Exit Point";
        }
        field(82; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(83; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(85; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(86; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(87; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(88; "Use Tax"; Boolean)
        {
            Caption = 'Use Tax';
        }
        field(89; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(90; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(91; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(92; "Outstanding Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Outstanding Amount (LCY)';
            Editable = false;
        }
        field(93; "Amt. Rcd. Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amt. Rcd. Not Invoiced (LCY)';
            Editable = false;
        }
        field(95; "Reserved Quantity"; Decimal)
        {
            CalcFormula = sum("Reservation Entry".Quantity where("Source ID" = field("Document No."),
                                                                  "Source Ref. No." = field("Line No."),
                                                                  "Source Type" = const(39),
                                                                  "Source Subtype" = field("Document Type"),
                                                                  "Reservation Status" = const(Reservation)));
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(97; "Blanket Order No."; Code[20])
        {
            Caption = 'Blanket Order No.';
            TableRelation = "Purchase Header"."No." where("Document Type" = const("Blanket Order"));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(98; "Blanket Order Line No."; Integer)
        {
            Caption = 'Blanket Order Line No.';
            TableRelation = "Purchase Line"."Line No." where("Document Type" = const("Blanket Order"),
                                                              "Document No." = field("Blanket Order No."));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(99; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
            Editable = false;
        }
        field(100; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            Editable = false;
        }
        field(101; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Editable = false;
        }
        field(103; "Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FIELDNO("Line Amount"));
            Caption = 'Line Amount';
        }
        field(104; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference';
            Editable = false;
        }
        field(105; "Inv. Disc. Amount to Invoice"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Disc. Amount to Invoice';
            Editable = false;
        }
        field(106; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
            Editable = false;
        }
        field(107; "IC Partner Ref. Type"; Option)
        {
            Caption = 'IC Partner Ref. Type';
            OptionCaption = ' ,G/L Account,Item,,,Charge (Item),Cross Reference,Common Item No.,Vendor Item No.';
            OptionMembers = " ","G/L Account",Item,,,"Charge (Item)","Cross Reference","Common Item No.","Vendor Item No.";
        }
        field(108; "IC Partner Reference"; Code[20])
        {
            Caption = 'IC Partner Reference';

            trigger OnLookup()
            var
                ICGLAccount: Record "IC G/L Account";
                ItemCrossReference: Record "Item Cross Reference";
                ItemVendorCatalog: Record "Item Vendor";
            begin
            end;
        }
        field(109; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            var
                GenPostingSetup: Record "General Posting Setup";
                GLAcc: Record "G/L Account";
            begin
            end;
        }
        field(110; "Prepmt. Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FIELDNO("Prepmt. Line Amount"));
            Caption = 'Prepmt. Line Amount';
            MinValue = 0;
        }
        field(111; "Prepmt. Amt. Inv."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FIELDNO("Prepmt. Amt. Inv."));
            Caption = 'Prepmt. Amt. Inv.';
            Editable = false;
        }
        field(112; "Prepmt. Amt. Incl. VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Amt. Incl. VAT';
            Editable = false;
        }
        field(113; "Prepayment Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepayment Amount';
            Editable = false;
        }
        field(114; "Prepmt. VAT Base Amt."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. VAT Base Amt.';
            Editable = false;
        }
        field(115; "Prepayment VAT %"; Decimal)
        {
            Caption = 'Prepayment VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(116; "Prepmt. VAT Calc. Type"; Option)
        {
            Caption = 'Prepmt. VAT Calc. Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(117; "Prepayment VAT Identifier"; Code[10])
        {
            Caption = 'Prepayment VAT Identifier';
            Editable = false;
        }
        field(118; "Prepayment Tax Area Code"; Code[20])
        {
            Caption = 'Prepayment Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(119; "Prepayment Tax Liable"; Boolean)
        {
            Caption = 'Prepayment Tax Liable';
        }
        field(120; "Prepayment Tax Group Code"; Code[10])
        {
            Caption = 'Prepayment Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(121; "Prepmt Amt to Deduct"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FIELDNO("Prepmt Amt to Deduct"));
            Caption = 'Prepmt Amt to Deduct';
            MinValue = 0;
        }
        field(122; "Prepmt Amt Deducted"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FIELDNO("Prepmt Amt Deducted"));
            Caption = 'Prepmt Amt Deducted';
            Editable = false;
        }
        field(123; "Prepayment Line"; Boolean)
        {
            Caption = 'Prepayment Line';
            Editable = false;
        }
        field(124; "Prepmt. Amount Inv. Incl. VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Amount Inv. Incl. VAT';
            Editable = false;
        }
        field(129; "Prepmt. Amount Inv. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Prepmt. Amount Inv. (LCY)';
            Editable = false;
        }
        field(130; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";
        }
        field(132; "Prepmt. VAT Amount Inv. (LCY)"; Decimal)
        {
            Caption = 'Prepmt. VAT Amount Inv. (LCY)';
            Editable = false;
        }
        field(135; "Prepayment VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepayment VAT Difference';
            Editable = false;
        }
        field(136; "Prepmt VAT Diff. to Deduct"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt VAT Diff. to Deduct';
            Editable = false;
        }
        field(137; "Prepmt VAT Diff. Deducted"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt VAT Diff. Deducted';
            Editable = false;
        }
        field(140; "Outstanding Amt. Ex. VAT (LCY)"; Decimal)
        {
            Caption = 'Outstanding Amt. Ex. VAT (LCY)';
        }
        field(141; "A. Rcd. Not Inv. Ex. VAT (LCY)"; Decimal)
        {
            Caption = 'A. Rcd. Not Inv. Ex. VAT (LCY)';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
        }
        field(1002; "Job Line Type"; Option)
        {
            Caption = 'Job Line Type';
            OptionCaption = ' ,Schedule,Contract,Both Schedule and Contract';
            OptionMembers = " ",Schedule,Contract,"Both Schedule and Contract";
        }
        field(1003; "Job Unit Price"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Unit Price';
        }
        field(1004; "Job Total Price"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Total Price';
            Editable = false;
        }
        field(1005; "Job Line Amount"; Decimal)
        {
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Amount';
        }
        field(1006; "Job Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Discount Amount';
        }
        field(1007; "Job Line Discount %"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(1008; "Job Unit Price (LCY)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Unit Price (LCY)';
            Editable = false;
        }
        field(1009; "Job Total Price (LCY)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Total Price (LCY)';
            Editable = false;
        }
        field(1010; "Job Line Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Amount (LCY)';
            Editable = false;
        }
        field(1011; "Job Line Disc. Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Disc. Amount (LCY)';
            Editable = false;
        }
        field(1012; "Job Currency Factor"; Decimal)
        {
            BlankZero = true;
            Caption = 'Job Currency Factor';
        }
        field(1013; "Job Currency Code"; Code[20])
        {
            Caption = 'Job Currency Code';
        }
        field(1019; "Job Planning Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Job Planning Line No.';

            trigger OnLookup()
            var
                JobPlanningLine: Record "Job Planning Line";
            begin
            end;

            trigger OnValidate()
            var
                JobPlanningLine: Record "Job Planning Line";
            begin
            end;
        }
        field(1030; "Job Remaining Qty."; Decimal)
        {
            Caption = 'Job Remaining Qty.';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                JobPlanningLine: Record "Job Planning Line";
            begin
            end;
        }
        field(1031; "Job Remaining Qty. (Base)"; Decimal)
        {
            Caption = 'Job Remaining Qty. (Base)';
        }
        field(5401; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            Editable = false;
            TableRelation = "Production Order"."No." where(Status = const(Released));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = if (Type = const(Item)) "Item Variant".Code where("Item No." = field("No."));
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = if ("Document Type" = filter(Order | Invoice),
                                Quantity = filter(< 0)) "Bin Content"."Bin Code" where("Location Code" = field("Location Code"),
                                                                                     "Item No." = field("No."),
                                                                                     "Variant Code" = field("Variant Code"))
            else
            if ("Document Type" = filter("Return Order" | "Credit Memo"),
                                                                                              Quantity = filter(>= 0)) "Bin Content"."Bin Code" where("Location Code" = field("Location Code"),
                                                                                                                                                    "Item No." = field("No."),
                                                                                                                                                    "Variant Code" = field("Variant Code"))
            else
            Bin.Code where("Location Code" = field("Location Code"));

            trigger OnLookup()
            var
                WMSManagement: Codeunit "WMS Management";
                BinCode: Code[20];
            begin
            end;

            trigger OnValidate()
            var
                WMSManagement: Codeunit "WMS Management";
            begin
            end;
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."))
            else
            "Unit of Measure";

            trigger OnValidate()
            var
                UnitOfMeasureTranslation: Record "Unit of Measure Translation";
            begin
            end;
        }
        field(5415; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5416; "Outstanding Qty. (Base)"; Decimal)
        {
            Caption = 'Outstanding Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5417; "Qty. to Invoice (Base)"; Decimal)
        {
            Caption = 'Qty. to Invoice (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5418; "Qty. to Receive (Base)"; Decimal)
        {
            Caption = 'Qty. to Receive (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5458; "Qty. Rcd. Not Invoiced (Base)"; Decimal)
        {
            Caption = 'Qty. Rcd. Not Invoiced (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5460; "Qty. Received (Base)"; Decimal)
        {
            Caption = 'Qty. Received (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5461; "Qty. Invoiced (Base)"; Decimal)
        {
            Caption = 'Qty. Invoiced (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5495; "Reserved Qty. (Base)"; Decimal)
        {
            CalcFormula = sum("Reservation Entry"."Quantity (Base)" where("Source Type" = const(39),
                                                                           "Source Subtype" = field("Document Type"),
                                                                           "Source ID" = field("Document No."),
                                                                           "Source Ref. No." = field("Line No."),
                                                                           "Reservation Status" = const(Reservation)));
            Caption = 'Reserved Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5600; "FA Posting Date"; Date)
        {
            Caption = 'FA Posting Date';
        }
        field(5601; "FA Posting Type"; Option)
        {
            Caption = 'FA Posting Type';
            OptionCaption = ' ,Acquisition Cost,Maintenance,Custom 1,Custom 2';
            OptionMembers = " ","Acquisition Cost",Maintenance,"Custom 1","Custom 2";
        }
        field(5602; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code';
            TableRelation = "Depreciation Book";
        }
        field(5603; "Salvage Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Salvage Value';
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            Caption = 'Depr. until FA Posting Date';
        }
        field(5606; "Depr. Acquisition Cost"; Boolean)
        {
            Caption = 'Depr. Acquisition Cost';
        }
        field(5609; "Maintenance Code"; Code[10])
        {
            Caption = 'Maintenance Code';
            TableRelation = Maintenance;
        }
        field(5610; "Insurance No."; Code[20])
        {
            Caption = 'Insurance No.';
            TableRelation = Insurance;
        }
        field(5611; "Budgeted FA No."; Code[20])
        {
            Caption = 'Budgeted FA No.';
            TableRelation = "Fixed Asset";
        }
        field(5612; "Duplicate in Depreciation Book"; Code[10])
        {
            Caption = 'Duplicate in Depreciation Book';
            TableRelation = "Depreciation Book";
        }
        field(5613; "Use Duplication List"; Boolean)
        {
            Caption = 'Use Duplication List';
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
        }
        field(5705; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';

            trigger OnValidate()
            var
                ReturnedCrossRef: Record "Item Cross Reference";
            begin
            end;
        }
        field(5706; "Unit of Measure (Cross Ref.)"; Code[10])
        {
            Caption = 'Unit of Measure (Cross Ref.)';
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."));
        }
        field(5707; "Cross-Reference Type"; Option)
        {
            Caption = 'Cross-Reference Type';
            OptionCaption = ' ,Customer,Vendor,Bar Code';
            OptionMembers = " ",Customer,Vendor,"Bar Code";
        }
        field(5708; "Cross-Reference Type No."; Code[30])
        {
            Caption = 'Cross-Reference Type No.';
        }
        field(5709; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(5710; Nonstock; Boolean)
        {
            Caption = 'Nonstock';
        }
        field(5711; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
        }
        field(5712; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group".Code where("Item Category Code" = field("Item Category Code"));
        }
        field(5713; "Special Order"; Boolean)
        {
            Caption = 'Special Order';
        }
        field(5714; "Special Order Sales No."; Code[20])
        {
            Caption = 'Special Order Sales No.';
            TableRelation = if ("Special Order" = const(true)) "Sales Header"."No." where("Document Type" = const(Order));
        }
        field(5715; "Special Order Sales Line No."; Integer)
        {
            Caption = 'Special Order Sales Line No.';
            TableRelation = if ("Special Order" = const(true)) "Sales Line"."Line No." where("Document Type" = const(Order),
                                                                                            "Document No." = field("Special Order Sales No."));
        }
        field(5750; "Whse. Outstanding Qty. (Base)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Warehouse Receipt Line"."Qty. Outstanding (Base)" where("Source Type" = const(39),
                                                                                        "Source Subtype" = field("Document Type"),
                                                                                        "Source No." = field("Document No."),
                                                                                        "Source Line No." = field("Line No.")));
            Caption = 'Whse. Outstanding Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5752; "Completely Received"; Boolean)
        {
            Caption = 'Completely Received';
            Editable = false;
        }
        field(5790; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
        }
        field(5791; "Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';
        }
        field(5792; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation';
        }
        field(5793; "Inbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Inbound Whse. Handling Time';
        }
        field(5794; "Planned Receipt Date"; Date)
        {
            Caption = 'Planned Receipt Date';
        }
        field(5795; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(5800; "Allow Item Charge Assignment"; Boolean)
        {
            Caption = 'Allow Item Charge Assignment';
            InitValue = true;
        }
        field(5801; "Qty. to Assign"; Decimal)
        {
            CalcFormula = sum("Item Charge Assignment (Purch)"."Qty. to Assign" where("Document Type" = field("Document Type"),
                                                                                       "Document No." = field("Document No."),
                                                                                       "Document Line No." = field("Line No.")));
            Caption = 'Qty. to Assign';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5802; "Qty. Assigned"; Decimal)
        {
            CalcFormula = sum("Item Charge Assignment (Purch)"."Qty. Assigned" where("Document Type" = field("Document Type"),
                                                                                      "Document No." = field("Document No."),
                                                                                      "Document Line No." = field("Line No.")));
            Caption = 'Qty. Assigned';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5803; "Return Qty. to Ship"; Decimal)
        {
            Caption = 'Return Qty. to Ship';
            DecimalPlaces = 0 : 5;
        }
        field(5804; "Return Qty. to Ship (Base)"; Decimal)
        {
            Caption = 'Return Qty. to Ship (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5805; "Return Qty. Shipped Not Invd."; Decimal)
        {
            Caption = 'Return Qty. Shipped Not Invd.';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5806; "Ret. Qty. Shpd Not Invd.(Base)"; Decimal)
        {
            Caption = 'Ret. Qty. Shpd Not Invd.(Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5807; "Return Shpd. Not Invd."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Return Shpd. Not Invd.';
            Editable = false;

            trigger OnValidate()
            var
                Currency2: Record Currency;
            begin
            end;
        }
        field(5808; "Return Shpd. Not Invd. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Return Shpd. Not Invd. (LCY)';
            Editable = false;
        }
        field(5809; "Return Qty. Shipped"; Decimal)
        {
            Caption = 'Return Qty. Shipped';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5810; "Return Qty. Shipped (Base)"; Decimal)
        {
            Caption = 'Return Qty. Shipped (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(6600; "Return Shipment No."; Code[20])
        {
            Caption = 'Return Shipment No.';
            Editable = false;
        }
        field(6601; "Return Shipment Line No."; Integer)
        {
            Caption = 'Return Shipment Line No.';
            Editable = false;
        }
        field(6608; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
        }
        field(50000; Committed; Boolean)
        {
        }
        field(50004; "Expense Code"; Code[10])
        {
            TableRelation = "Expense Code";
        }
        field(50005; "RFQ No."; Code[20])
        {
            Description = 'ADDED THIS FIELD';
        }
        field(50006; "RFQ Line No."; Integer)
        {
            Description = 'ADDED THIS FIELD';
            TableRelation = "Purchase Quote Line"."Line No.";
        }
        field(50010; "Project Code"; Code[10])
        {
            CalcFormula = lookup("Purchase Header"."Project Code" where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(51000; "RFQ Remarks"; Text[50])
        {
        }
        field(99000750; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            TableRelation = "Routing Header";
        }
        field(99000751; "Operation No."; Code[10])
        {
            Caption = 'Operation No.';
            Editable = false;
            TableRelation = "Prod. Order Routing Line"."Operation No." where(Status = const(Released),
                                                                              "Prod. Order No." = field("Prod. Order No."),
                                                                              "Routing No." = field("Routing No."));

            trigger OnValidate()
            var
                ProdOrderRtngLine: Record "Prod. Order Routing Line";
            begin
            end;
        }
        field(99000752; "Work Center No."; Code[20])
        {
            Caption = 'Work Center No.';
            Editable = false;
            TableRelation = "Work Center";
        }
        field(99000753; Finished; Boolean)
        {
            Caption = 'Finished';
        }
        field(99000754; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
            Editable = false;
            TableRelation = "Prod. Order Line"."Line No." where(Status = filter(Released ..),
                                                                 "Prod. Order No." = field("Prod. Order No."));
        }
        field(99000755; "Overhead Rate"; Decimal)
        {
            Caption = 'Overhead Rate';
            DecimalPlaces = 0 : 5;
        }
        field(99000756; "MPS Order"; Boolean)
        {
            Caption = 'MPS Order';
        }
        field(99000757; "Planning Flexibility"; Option)
        {
            Caption = 'Planning Flexibility';
            OptionCaption = 'Unlimited,None';
            OptionMembers = Unlimited,"None";
        }
        field(99000758; "Safety Lead Time"; DateFormula)
        {
            Caption = 'Safety Lead Time';
        }
        field(99000759; "Routing Reference No."; Integer)
        {
            Caption = 'Routing Reference No.';
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
            SumIndexFields = Amount, "Amount Including VAT";
        }
        key(Key2; "Document No.", "Line No.", "Document Type")
        {
        }
        key(Key3; "Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Expected Receipt Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Outstanding Qty. (Base)";
        }
        key(Key4; "Document Type", "Pay-to Vendor No.", "Currency Code")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Outstanding Amount", "Amt. Rcd. Not Invoiced", "Outstanding Amount (LCY)", "Amt. Rcd. Not Invoiced (LCY)";
        }
        key(Key5; "Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Location Code", "Expected Receipt Date")
        {
            Enabled = false;
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = "Outstanding Qty. (Base)";
        }
        key(Key6; "Document Type", "Pay-to Vendor No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Currency Code")
        {
            Enabled = false;
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = "Outstanding Amount", "Amt. Rcd. Not Invoiced", "Outstanding Amount (LCY)", "Amt. Rcd. Not Invoiced (LCY)";
        }
        key(Key7; "Document Type", "Blanket Order No.", "Blanket Order Line No.")
        {
        }
        key(Key8; "Document Type", Type, "Prod. Order No.", "Prod. Order Line No.", "Routing No.", "Operation No.")
        {
        }
        key(Key9; "Document Type", "Document No.", "Location Code")
        {
        }
        key(Key10; "Document Type", "Receipt No.", "Receipt Line No.")
        {
        }
        key(Key11; Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Document Type", "Expected Receipt Date")
        {
            MaintainSQLIndex = false;
        }
        key(Key12; "Document Type", "Buy-from Vendor No.")
        {
        }
        key(Key13; "Document Type", "Job No.", "Job Task No.")
        {
            SumIndexFields = "Outstanding Amt. Ex. VAT (LCY)", "A. Rcd. Not Inv. Ex. VAT (LCY)";
        }
        key(Key14; "Document Type", "Document No.", Type, "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        PurchCommentLine: Record "Purch. Comment Line";
    begin
    end;

    var
        Text000: label 'You cannot rename a %1.';
        Text001: label 'You cannot change %1 because the order line is associated with sales order %2.';
        Text002: label 'Prices including VAT cannot be calculated when %1 is %2.';
        Text003: label 'You cannot purchase resources.';
        Text004: label 'must not be less than %1';
        Text006: label 'You cannot invoice more than %1 units.';
        Text007: label 'You cannot invoice more than %1 base units.';
        Text008: label 'You cannot receive more than %1 units.';
        Text009: label 'You cannot receive more than %1 base units.';
        Text010: label 'You cannot change %1 when %2 is %3.';
        Text011: label ' must be 0 when %1 is %2';
        Text012: label 'must not be specified when %1 = %2';
        Text016: label '%1 is required for %2 = %3.';
        Text017: label '\The entered information may be disregarded by warehouse operations.';
        Text018: label '%1 %2 is earlier than the work date %3.';
        Text020: label 'You cannot return more than %1 units.';
        Text021: label 'You cannot return more than %1 base units.';
        Text022: label 'You cannot change %1, if item charge is already posted.';
        Text023: label 'You cannot change the %1 when the %2 has been filled in.';
        Text029: label 'must be positive.';
        Text030: label 'must be negative.';
        Text031: label 'You cannot define item tracking on this line because it is linked to production order %1.';
        Text032: label '%1 must not be greater than the sum of %2 and %3.';
        Text033: label 'Warehouse ';
        Text034: label 'Inventory ';
        Text035: label '%1 units for %2 %3 have already been returned or transferred. Therefore, only %4 units can be returned.';
        Text036: label 'You must cancel the existing approval for this document to be able to change the %1 field.';
        Text037: label 'cannot be %1.';
        Text038: label 'cannot be less than %1.';
        Text039: label 'cannot be more than %1.';
        Text040: label 'You must use form %1 to enter %2, if item tracking is used.';
        Text99000000: label 'You cannot change %1 when the purchase order is associated to a production order.';
        PurchHeader: Record "Purchase Header";
        PurchLine2: Record "Purchase Line";
        TempPurchLine: Record "Purchase Line";
        GLAcc: Record "G/L Account";
        Item: Record Item;
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        ItemTranslation: Record "Item Translation";
        SalesOrderLine: Record "Sales Line";
        VATPostingSetup: Record "VAT Posting Setup";
        StdTxt: Record "Standard Text";
        FA: Record "Fixed Asset";
        FADeprBook: Record "FA Depreciation Book";
        FASetup: Record "FA Setup";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        ReservEntry: Record "Reservation Entry";
        UnitOfMeasure: Record "Unit of Measure";
        ItemCharge: Record "Item Charge";
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        SKU: Record "Stockkeeping Unit";
        WorkCenter: Record "Work Center";
        PurchasingCode: Record Purchasing;
        InvtSetup: Record "Inventory Setup";
        Location: Record Location;
        GLSetup: Record "General Ledger Setup";
        ReturnReason: Record "Return Reason";
        ItemVend: Record "Item Vendor";
        CalChange: Record "Customized Calendar Change";
        JobJnlLine: Record "HR Appraisal Lines" temporary;
        Reservation: Page Reservation;
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
        UOMMgt: Codeunit "Unit of Measure Management";
        AddOnIntegrMgt: Codeunit AddOnIntegrManagement;
        DimMgt: Codeunit DimensionManagement;
        DistIntegration: Codeunit "Dist. Integration";
        NonstockItemMgt: Codeunit "Catalog Item Management";
        WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";
        LeadTimeMgt: Codeunit "Lead-Time Management";
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        CalendarMgmt: Codeunit "Calendar Management";
        CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
        TrackingBlocked: Boolean;
        StatusCheckSuspended: Boolean;
        GLSetupRead: Boolean;
        UnitCostCurrency: Decimal;
        UpdateFromVAT: Boolean;
        Text042: label 'You cannot return more than the %1 units that you have received for %2 %3.';
        Text043: label 'must be positive when %1 is not 0.';
        Text044: label 'You cannot change %1 because this purchase order is associated with %2 %3.';
        Text046: label 'Microsoft Dynamics NAV will not update %1 when changing %2 because a prepayment invoice has been posted. Do you want to continue?';
        Text047: label '%1 can only be set when %2 is set.';
        Text048: label '%1 cannot be changed when %2 is set.';
        PrePaymentLineAmountEntered: Boolean;
        Text049: label 'You have changed one or more dimensions on the %1, which is already shipped. When you post the line with the changed dimension to General Ledger, amounts on the Inventory Interim account will be out of balance when reported per dimension.\\Do you want to keep the changed dimension?';
        Text050: label 'Cancelled.';
        Text051: label 'must have the same sign as the receipt';
        Text052: label 'The quantity that you are trying to invoice is greater than the quantity in receipt %1.';
        Text053: label 'must have the same sign as the return shipment';
        Text054: label 'The quantity that you are trying to invoice is greater than the quantity in return shipment %1.';
        DataConflictQst: label 'The change creates a date conflict with existing reservations. Do you want to continue?';
        objResource: Record Resource;


    procedure InitOutstanding()
    begin
    end;


    procedure InitOutstandingAmount()
    var
        AmountInclVAT: Decimal;
    begin
    end;


    procedure InitQtyToReceive()
    begin
    end;


    procedure InitQtyToShip()
    begin
    end;


    procedure InitQtyToInvoice()
    begin
    end;

    local procedure InitItemAppl()
    begin
    end;


    procedure MaxQtyToInvoice(): Decimal
    begin
    end;


    procedure MaxQtyToInvoiceBase(): Decimal
    begin
    end;


    procedure CalcInvDiscToInvoice()
    var
        OldInvDiscAmtToInv: Decimal;
    begin
    end;

    local procedure CalcBaseQty(Qty: Decimal): Decimal
    begin
    end;

    local procedure SelectItemEntry()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
    end;


    procedure SetPurchHeader(NewPurchHeader: Record "Purchase Header")
    begin
    end;

    local procedure GetPurchHeader()
    begin
    end;

    local procedure GetItem()
    begin
    end;

    local procedure UpdateDirectUnitCost(CalledByFieldNo: Integer)
    begin
    end;


    procedure UpdateUnitCost()
    var
        DiscountAmountPerQty: Decimal;
    begin
    end;


    procedure UpdateAmounts()
    var
        RemLineAmountToInvoice: Decimal;
    begin
    end;

    local procedure UpdateVATAmounts()
    var
        PurchLine2: Record "Purchase Line";
        TotalLineAmount: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalQuantityBase: Decimal;
    begin
    end;

    local procedure UpdateSalesCost()
    begin
    end;

    local procedure GetFAPostingGroup()
    var
        LocalGLAcc: Record "G/L Account";
        FAPostingGr: Record "FA Posting Group";
    begin
    end;


    procedure UpdateUOMQtyPerStockQty()
    begin
    end;


    procedure ShowReservation()
    begin
    end;


    procedure ShowReservationEntries(Modal: Boolean)
    begin
    end;


    procedure GetDate(): Date
    begin
    end;


    procedure Signed(Value: Decimal): Decimal
    begin
    end;


    procedure BlanketOrderLookup()
    begin
    end;


    procedure BlockDynamicTracking(SetBlock: Boolean)
    begin
    end;


    procedure ShowDimensions()
    begin
    end;


    procedure OpenItemTrackingLines()
    begin
    end;


    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]; Type4: Integer; No4: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;


    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;


    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
    end;

    local procedure GetSKU(): Boolean
    begin
    end;


    procedure ShowItemChargeAssgnt()
    var
        ItemChargeAssgnts: Page "Item Charge Assignment (Purch)";
        AssignItemChargePurch: Codeunit "Item Charge Assgnt. (Purch.)";
        ItemChargeAssgntLineAmt: Decimal;
    begin
    end;


    procedure UpdateItemChargeAssgnt()
    var
        ShareOfVAT: Decimal;
        TotalQtyToAssign: Decimal;
        TotalAmtToAssign: Decimal;
    begin
    end;

    local procedure DeleteItemChargeAssgnt(DocType: Option; DocNo: Code[20]; DocLineNo: Integer)
    begin
    end;

    local procedure DeleteChargeChargeAssgnt(DocType: Option; DocNo: Code[20]; DocLineNo: Integer)
    begin
    end;


    procedure CheckItemChargeAssgnt()
    var
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
    begin
    end;

    local procedure GetFieldCaption(FieldNumber: Integer): Text[100]
    var
        "Field": Record "Field";
    begin
    end;

    local procedure GetCaptionClass(FieldNumber: Integer): Text[80]
    begin
    end;

    local procedure TestStatusOpen()
    begin
    end;


    procedure SuspendStatusCheck(Suspend: Boolean)
    begin
    end;


    procedure UpdateLeadTimeFields()
    var
        StartingDate: Date;
    begin
    end;


    procedure GetUpdateBasicDates()
    begin
    end;


    procedure UpdateDates()
    begin
    end;


    procedure InternalLeadTimeDays(PurchDate: Date): Text[30]
    var
        TotalDays: DateFormula;
    begin
    end;


    procedure UpdateVATOnLines(QtyType: Option General,Invoicing,Shipping; var PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var VATAmountLine: Record "VAT Amount Line")
    var
        TempVATAmountLineRemainder: Record "VAT Amount Line" temporary;
        Currency: Record Currency;
        NewAmount: Decimal;
        NewAmountIncludingVAT: Decimal;
        NewVATBaseAmount: Decimal;
        VATAmount: Decimal;
        VATDifference: Decimal;
        InvDiscAmount: Decimal;
        LineAmountToInvoice: Decimal;
        LineAmountToInvoiceDiscounted: Decimal;
    begin
    end;


    procedure CalcVATAmountLines(QtyType: Option General,Invoicing,Shipping; var PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var VATAmountLine: Record "VAT Amount Line")
    var
        PrevVatAmountLine: Record "VAT Amount Line";
        Currency: Record Currency;
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        TotalVATAmount: Decimal;
        QtyToHandle: Decimal;
        RoundingLineInserted: Boolean;
    begin
    end;


    procedure UpdateWithWarehouseReceive()
    begin
    end;

    local procedure CheckWarehouse()
    var
        Location2: Record Location;
        WhseSetup: Record "Warehouse Setup";
        ShowDialog: Option " ",Message,Error;
        DialogText: Text[50];
    begin
    end;

    local procedure GetOverheadRateFCY(): Decimal
    var
        QtyPerUOM: Decimal;
    begin
    end;


    procedure GetItemTranslation()
    begin
    end;

    local procedure GetGLSetup()
    begin
    end;


    procedure AdjustDateFormula(DateFormulatoAdjust: DateFormula): Text[30]
    begin
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
    end;


    procedure RowID1(): Text[250]
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
    end;

    local procedure GetDefaultBin()
    var
        WMSManagement: Codeunit "WMS Management";
    begin
    end;


    procedure IsInbound(): Boolean
    begin
    end;

    local procedure HandleDedicatedBin(IssueWarning: Boolean)
    var
        WhseIntegrationMgt: Codeunit "Whse. Integration Management";
    begin
    end;


    procedure CrossReferenceNoLookUp()
    var
        ItemCrossReference: Record "Item Cross Reference";
    begin
    end;


    procedure ItemExists(ItemNo: Code[20]): Boolean
    var
        Item2: Record Item;
    begin
    end;

    local procedure GetAbsMin(QtyToHandle: Decimal; QtyHandled: Decimal): Decimal
    begin
    end;

    local procedure CheckApplToItemLedgEntry(): Code[10]
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ApplyRec: Record "Item Application Entry";
        ItemTrackingLines: Page "Item Tracking Lines";
        ReturnedQty: Decimal;
        RemainingtobeReturnedQty: Decimal;
    begin
    end;


    procedure CalcPrepaymentToDeduct()
    begin
    end;


    procedure IsFinalInvoice(): Boolean
    begin
    end;


    procedure GetLineAmountToHandle(QtyToHandle: Decimal): Decimal
    var
        LineAmount: Decimal;
        LineDiscAmount: Decimal;
    begin
    end;


    procedure JobTaskIsSet(): Boolean
    begin
    end;


    procedure CreateTempJobJnlLine(GetPrices: Boolean)
    begin
    end;


    procedure UpdatePricesFromJobJnlLine()
    begin
    end;


    procedure JobSetCurrencyFactor()
    begin
    end;


    procedure SetUpdateFromVAT(UpdateFromVAT2: Boolean)
    begin
    end;


    procedure InitQtyToReceive2()
    begin
    end;


    procedure ShowLineComments()
    var
        PurchCommentLine: Record "Purch. Comment Line";
        PurchCommentSheet: Page "Purch. Comment Sheet";
    begin
    end;


    procedure SetDefaultQuantity()
    var
        PurchSetup: Record "Purchases & Payables Setup";
    begin
    end;


    procedure UpdatePrePaymentAmounts()
    var
        ReceiptLine: Record "Purch. Rcpt. Line";
        PurchOrderLine: Record "Purchase Line";
        PurchOrderHeader: Record "Purchase Header";
    begin
    end;


    procedure SetVendorItemNo()
    begin
    end;


    procedure ZeroAmountLine(QtyType: Option General,Invoicing,Shipping): Boolean
    begin
    end;


    procedure FilterLinesWithItemToPlan(var Item: Record Item; DocumentType: Option)
    begin
    end;


    procedure FindLinesWithItemToPlan(var Item: Record Item; DocumentType: Option): Boolean
    begin
    end;


    procedure LinesWithItemToPlanExist(var Item: Record Item; DocumentType: Option): Boolean
    begin
    end;


    procedure GetVPGInvRoundAcc(): Code[20]
    var
        Vendor: Record Vendor;
        VendorPostingGroup: Record "Vendor Posting Group";
        PurchSetup: Record "Purchases & Payables Setup";
    begin
    end;

    local procedure CheckReceiptRelation()
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
    end;

    local procedure CheckRetShptRelation()
    var
        ReturnShptLine: Record "Return Shipment Line";
    begin
    end;

    local procedure VerifyItemLineDim()
    begin
    end;


    procedure InitType()
    begin
    end;

    local procedure CheckWMS()
    var
        DialogText: Text;
    begin
    end;


    procedure IsServiceItem(): Boolean
    begin
    end;

    local procedure CheckReservationDateConflict(DateFieldNo: Integer)
    var
        ReservEntry: Record "Reservation Entry";
        PurchLineReserve: Codeunit "Purch. Line-Reserve";
    begin
    end;

    local procedure ReservEntryExist(): Boolean
    var
        NewReservEntry: Record "Reservation Entry";
    begin
    end;
}

