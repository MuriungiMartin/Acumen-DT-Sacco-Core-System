#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516364 "Member Register"
{
    Caption = 'Members Register';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "Member List";
    LookupPageID = "Member List";
    Permissions = TableData "Cust. Ledger Entry" = r;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            SQLDataType = Varchar;

            trigger OnValidate()
            begin
                /*
                //IF "Customer Type"="Customer Type"::Member THEN BEGIN
                IF "No." <> xRec."No." THEN BEGIN
                  SalesSetup.GET;
                  NoSeriesMgt.TestManual(SalesSetup."Members Nos");
                  "No. Series" := '';
                END;
                //END;
                
                
                
                //Prevent Changing once entries exist
                TestNoEntriesExist(FIELDCAPTION("No."),"No.");*/
                CalcFields("Current Shares", "Shares Retained");
                if ("Current Shares" * -1 > 0) or ("Shares Retained" * -1 > 0) then
                    Error(Text001);

            end;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
                    "Search Name" := Name;
                /*
              StatusPermissions.RESET;
              StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
              StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::NameEdit);
              IF StatusPermissions.FIND('-') = FALSE THEN
              ERROR('You do not have permissions to edit the name.');
                  */

            end;
        }
        field(3; "Search Name"; Code[70])
        {
            Caption = 'Search Name';
        }
        field(4; "Name 2"; Text[25])
        {
            Caption = 'Name 2';
        }
        field(5; Address; Text[20])
        {
            Caption = 'Address';
        }
        field(6; "Address 2"; Text[10])
        {
            Caption = 'Address 2';
        }
        field(7; City; Text[15])
        {
            Caption = 'City';

            trigger OnLookup()
            begin
                //PostCode.LookUpCity(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Post Code");
            end;
        }
        field(8; Contact; Text[20])
        {
            Caption = 'Contact';

            trigger OnValidate()
            begin
                //IF RMSetup.GET THEN
                //  IF RMSetup."Bus. Rel. Code for Customers" <> '' THEN
                //    IF (xRec.Contact = '') AND (xRec."Primary Contact No." = '') THEN BEGIN
                //      MODIFY;
                //      UpdateContFromCust.OnModify(Rec);
                //      UpdateContFromCust.InsertNewContactPerson(Rec,FALSE);
                //      MODIFY(TRUE);
                //    END
            end;
        }
        field(9; "Phone No."; Text[12])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(10; "Telex No."; Text[1])
        {
            Caption = 'Telex No.';
        }
        field(14; "Our Account No."; Text[10])
        {
            Caption = 'Our Account No.';
        }
        field(15; "Territory Code"; Code[10])
        {
            Caption = 'Territory Code';
            TableRelation = Territory;
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Dimension Value ID" = const(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Dimension Value ID" = const(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(18; "Chain Name"; Code[10])
        {
            Caption = 'Chain Name';
        }
        field(19; "Budgeted Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Budgeted Amount';
        }
        field(20; "Credit Limit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Credit Limit (LCY)';
        }
        field(21; "Customer Posting Group"; Code[20])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
        }
        field(22; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(23; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(24; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(26; "Statistics Group"; Integer)
        {
            Caption = 'Statistics Group';
        }
        field(27; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(28; "Fin. Charge Terms Code"; Code[10])
        {
            Caption = 'Fin. Charge Terms Code';
            TableRelation = "Finance Charge Terms";
        }
        field(29; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(30; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(31; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            begin
                if "Shipping Agent Code" <> xRec."Shipping Agent Code" then
                    Validate("Shipping Agent Service Code", '');
            end;
        }
        field(32; "Place of Export"; Code[10])
        {
            Caption = 'Place of Export';
        }
        field(33; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
            TableRelation = Customer;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(34; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(35; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(36; "Collection Method"; Code[20])
        {
            Caption = 'Collection Method';
        }
        field(37; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(38; Comment; Boolean)
        {
            CalcFormula = exist("Comment Line" where("Table Name" = const(Customer),
                                                      "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Ship,Invoice,All';
            OptionMembers = " ",Ship,Invoice,All;
        }
        field(40; "Invoice Copies"; Integer)
        {
            Caption = 'Invoice Copies';
        }
        field(41; "Last Statement No."; Integer)
        {
            Caption = 'Last Statement No.';
        }
        field(42; "Print Statements"; Boolean)
        {
            Caption = 'Print Statements';
        }
        field(45; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
        }
        field(46; Priority; Integer)
        {
            Caption = 'Priority';
        }
        field(47; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(54; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(55; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(56; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(57; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(58; Balance; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Balance';
            Editable = false;
        }
        field(59; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Cust. Ledger Entry"."Amount (LCY)" where("Customer No." = field("No.")));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Net Change"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Net Change';
            Editable = false;
        }
        field(61; "Net Change (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Net Change (LCY)';
            Editable = false;
        }
        field(62; "Sales (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Cust. Ledger Entry"."Sales (LCY)" where("Customer No." = field("No."),
                                                                        "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                        "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                        "Posting Date" = field("Date Filter"),
                                                                        "Currency Code" = field("Currency Filter")));
            Caption = 'Sales (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "Profit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Cust. Ledger Entry"."Profit (LCY)" where("Customer No." = field("No."),
                                                                         "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                         "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Profit (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64; "Inv. Discounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Cust. Ledger Entry"."Inv. Discount (LCY)" where("Customer No." = field("No."),
                                                                                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                "Posting Date" = field("Date Filter"),
                                                                                "Currency Code" = field("Currency Filter")));
            Caption = 'Inv. Discounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(65; "Pmt. Discounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                                  "Entry Type" = filter("Payment Discount" .. "Payment Discount (VAT Adjustment)"),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Pmt. Discounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(66; "Balance Due"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                         "Posting Date" = field(upperlimit("Date Filter")),
                                                                         "Initial Entry Due Date" = field("Date Filter"),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Balance Due';
            Editable = false;
            FieldClass = FlowField;
        }
        field(67; "Balance Due (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                                 "Posting Date" = field(upperlimit("Date Filter")),
                                                                                 "Initial Entry Due Date" = field("Date Filter"),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Balance Due (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(69; Payments; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Initial Document Type" = const(Payment),
                                                                          "Entry Type" = const("Initial Entry"),
                                                                          "Customer No." = field("No."),
                                                                          "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                          "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Currency Code" = field("Currency Filter")));
            Caption = 'Payments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70; "Invoice Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Initial Document Type" = const(Invoice),
                                                                         "Entry Type" = const("Initial Entry"),
                                                                         "Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Invoice Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(71; "Cr. Memo Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry".Amount where("Initial Document Type" = const("Credit Memo"),
                                                                          "Entry Type" = const("Initial Entry"),
                                                                          "Customer No." = field("No."),
                                                                          "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                          "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                          "Posting Date" = field("Date Filter"),
                                                                          "Currency Code" = field("Currency Filter")));
            Caption = 'Cr. Memo Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(72; "Finance Charge Memo Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Initial Document Type" = const("Finance Charge Memo"),
                                                                         "Entry Type" = const("Initial Entry"),
                                                                         "Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Finance Charge Memo Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(74; "Payments (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(Payment),
                                                                                  "Entry Type" = const("Initial Entry"),
                                                                                  "Customer No." = field("No."),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Payments (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(75; "Inv. Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(Invoice),
                                                                                 "Entry Type" = const("Initial Entry"),
                                                                                 "Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Inv. Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(76; "Cr. Memo Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const("Credit Memo"),
                                                                                  "Entry Type" = const("Initial Entry"),
                                                                                  "Customer No." = field("No."),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Cr. Memo Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(77; "Fin. Charge Memo Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const("Finance Charge Memo"),
                                                                                 "Entry Type" = const("Initial Entry"),
                                                                                 "Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Fin. Charge Memo Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(78; "Outstanding Orders"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Outstanding Amount" where("Document Type" = const(Order),
                                                                       "Bill-to Customer No." = field("No."),
                                                                       "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                       "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                       "Currency Code" = field("Currency Filter")));
            Caption = 'Outstanding Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(79; "Shipped Not Invoiced"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Shipped Not Invoiced" where("Document Type" = const(Order),
                                                                         "Bill-to Customer No." = field("No."),
                                                                         "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                         "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Shipped Not Invoiced';
            Editable = false;
            FieldClass = FlowField;
        }
        field(80; "Application Method"; Option)
        {
            Caption = 'Application Method';
            OptionCaption = 'Manual,Apply to Oldest';
            OptionMembers = Manual,"Apply to Oldest";
        }
        field(82; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';
        }
        field(83; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(84; "Fax No."; Text[10])
        {
            Caption = 'Fax No.';
            Enabled = false;
        }
        field(85; "Telex Answer Back"; Text[15])
        {
            Caption = 'Telex Answer Back';
            Enabled = false;
        }
        field(86; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            Enabled = false;

            trigger OnValidate()
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
            begin
                VATRegNoFormat.Test("VAT Registration No.", "Country/Region Code", "No.", Database::Customer);
            end;
        }
        field(87; "Combine Shipments"; Boolean)
        {
            Caption = 'Combine Shipments';
        }
        field(88; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin
                if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
                    if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group") then
                        Validate("VAT Bus. Posting Group", GenBusPostingGrp."Def. VAT Bus. Posting Group");
            end;
        }
        field(89; Picture; MediaSet)
        {
            Caption = 'Picture';
            Editable = true;
        }
        field(91; "Post Code"; Code[15])
        {
            Caption = 'Post Code';
            TableRelation = if ("Country/Region Code" = const('')) "Post Code"
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(92; County; Text[20])
        {
            Caption = 'County';
        }
        field(97; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Debit Amount" where("Customer No." = field("No."),
                                                                                 "Entry Type" = filter(<> Application),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(98; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Credit Amount" where("Customer No." = field("No."),
                                                                                  "Entry Type" = filter(<> Application),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(99; "Debit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Debit Amount (LCY)" where("Customer No." = field("No."),
                                                                                       "Entry Type" = filter(<> Application),
                                                                                       "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                       "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                       "Posting Date" = field("Date Filter"),
                                                                                       "Currency Code" = field("Currency Filter")));
            Caption = 'Debit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(100; "Credit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Credit Amount (LCY)" where("Customer No." = field("No."),
                                                                                        "Entry Type" = filter(<> Application),
                                                                                        "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                        "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                        "Posting Date" = field("Date Filter"),
                                                                                        "Currency Code" = field("Currency Filter")));
            Caption = 'Credit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(102; "E-Mail"; Text[70])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(103; "Home Page"; Text[10])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(104; "Reminder Terms Code"; Code[10])
        {
            Caption = 'Reminder Terms Code';
            Enabled = false;
            TableRelation = "Reminder Terms";
        }
        field(105; "Reminder Amounts"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Initial Document Type" = const(Reminder),
                                                                         "Entry Type" = const("Initial Entry"),
                                                                         "Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Reminder Amounts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(106; "Reminder Amounts (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(Reminder),
                                                                                 "Entry Type" = const("Initial Entry"),
                                                                                 "Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Reminder Amounts (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(107; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Tax Area Code"; Code[10])
        {
            Caption = 'Tax Area Code';
            Enabled = false;
            TableRelation = "Tax Area";
        }
        field(109; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(110; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            Enabled = false;
            TableRelation = "VAT Business Posting Group";
        }
        field(111; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter';
            Enabled = false;
            FieldClass = FlowFilter;
            TableRelation = Currency;
        }
        field(113; "Outstanding Orders (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Outstanding Amount (LCY)" where("Document Type" = const(Order),
                                                                             "Bill-to Customer No." = field("No."),
                                                                             "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                             "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                             "Currency Code" = field("Currency Filter")));
            Caption = 'Outstanding Orders (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(114; "Shipped Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Shipped Not Invoiced (LCY)" where("Document Type" = const(Order),
                                                                               "Bill-to Customer No." = field("No."),
                                                                               "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                               "Currency Code" = field("Currency Filter")));
            Caption = 'Shipped Not Invoiced (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(115; Reserve; Option)
        {
            Caption = 'Reserve';
            InitValue = Optional;
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
        }
        field(116; "Block Payment Tolerance"; Boolean)
        {
            Caption = 'Block Payment Tolerance';
        }
        field(117; "Pmt. Disc. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                                  "Entry Type" = filter("Payment Discount Tolerance" | "Payment Discount Tolerance (VAT Adjustment)" | "Payment Discount Tolerance (VAT Excl.)"),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Pmt. Disc. Tolerance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(118; "Pmt. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                                  "Entry Type" = filter("Payment Tolerance" | "Payment Tolerance (VAT Adjustment)" | "Payment Tolerance (VAT Excl.)"),
                                                                                  "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                  "Posting Date" = field("Date Filter"),
                                                                                  "Currency Code" = field("Currency Filter")));
            Caption = 'Pmt. Tolerance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(119; "IC Partner Code"; Code[10])
        {
            Caption = 'IC Partner Code';
            Enabled = false;
            TableRelation = "IC Partner";

            trigger OnValidate()
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                AccountingPeriod: Record "Accounting Period";
                ICPartner: Record "IC Partner";
            begin
                if xRec."IC Partner Code" <> "IC Partner Code" then begin
                    CustLedgEntry.SetCurrentkey("Customer No.", "Posting Date");
                    CustLedgEntry.SetRange("Customer No.", "No.");
                    AccountingPeriod.SetRange(Closed, false);
                    if AccountingPeriod.Find('-') then
                        CustLedgEntry.SetFilter("Posting Date", '>=%1', AccountingPeriod."Starting Date");
                    if CustLedgEntry.Find('-') then
                        if not Confirm(Text011, false, TableCaption) then
                            "IC Partner Code" := xRec."IC Partner Code";

                    CustLedgEntry.Reset;
                    if not CustLedgEntry.SetCurrentkey("Customer No.", Open) then
                        CustLedgEntry.SetCurrentkey("Customer No.");
                    CustLedgEntry.SetRange("Customer No.", "No.");
                    CustLedgEntry.SetRange(Open, true);
                    if CustLedgEntry.Find('+') then
                        Error(Text012, FieldCaption("IC Partner Code"), TableCaption);
                end;

                if "IC Partner Code" <> '' then begin
                    ICPartner.Get("IC Partner Code");
                    if (ICPartner."Customer No." <> '') and (ICPartner."Customer No." <> "No.") then
                        Error(Text010, FieldCaption("IC Partner Code"), "IC Partner Code", TableCaption, ICPartner."Customer No.");
                    ICPartner."Customer No." := "No.";
                    ICPartner.Modify;
                end;

                if (xRec."IC Partner Code" <> "IC Partner Code") and ICPartner.Get(xRec."IC Partner Code") then begin
                    ICPartner."Customer No." := '';
                    ICPartner.Modify;
                end;
            end;
        }
        field(120; Refunds; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Initial Document Type" = const(Refund),
                                                                         "Entry Type" = const("Initial Entry"),
                                                                         "Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Refunds';
            FieldClass = FlowField;
        }
        field(121; "Refunds (LCY)"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(Refund),
                                                                                 "Entry Type" = const("Initial Entry"),
                                                                                 "Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Refunds (LCY)';
            FieldClass = FlowField;
        }
        field(122; "Other Amounts"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Initial Document Type" = const(" "),
                                                                         "Entry Type" = const("Initial Entry"),
                                                                         "Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Caption = 'Other Amounts';
            FieldClass = FlowField;
        }
        field(123; "Other Amounts (LCY)"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Document Type" = const(" "),
                                                                                 "Entry Type" = const("Initial Entry"),
                                                                                 "Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Other Amounts (LCY)';
            FieldClass = FlowField;
        }
        field(124; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(125; "Outstanding Invoices (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Outstanding Amount (LCY)" where("Document Type" = const(Invoice),
                                                                             "Bill-to Customer No." = field("No."),
                                                                             "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                             "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                             "Currency Code" = field("Currency Filter")));
            Caption = 'Outstanding Invoices (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(126; "Outstanding Invoices"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line"."Outstanding Amount" where("Document Type" = const(Invoice),
                                                                       "Bill-to Customer No." = field("No."),
                                                                       "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                       "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                       "Currency Code" = field("Currency Filter")));
            Caption = 'Outstanding Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(130; "Bill-to No. Of Archived Doc."; Integer)
        {
            CalcFormula = count("Sales Header Archive" where("Document Type" = const(Order),
                                                              "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-to No. Of Archived Doc.';
            FieldClass = FlowField;
        }
        field(131; "Sell-to No. Of Archived Doc."; Integer)
        {
            CalcFormula = count("Sales Header Archive" where("Document Type" = const(Order),
                                                              "Sell-to Customer No." = field("No.")));
            Caption = 'Sell-to No. Of Archived Doc.';
            FieldClass = FlowField;
        }
        field(5049; "Primary Contact No."; Code[20])
        {
            Caption = 'Primary Contact No.';
            Enabled = false;
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
            begin
                ContBusRel.SetCurrentkey("Link to Table", "No.");
                ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Customer);
                ContBusRel.SetRange("No.", "No.");
                if ContBusRel.FindFirst then
                    Cont.SetRange("Company No.", ContBusRel."Contact No.")
                else
                    Cont.SetRange("No.", '');

                if "Primary Contact No." <> '' then
                    if Cont.Get("Primary Contact No.") then;
                if Page.RunModal(0, Cont) = Action::LookupOK then
                    Validate("Primary Contact No.", Cont."No.");
            end;

            trigger OnValidate()
            var
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
            begin
                Contact := '';
                if "Primary Contact No." <> '' then begin
                    Cont.Get("Primary Contact No.");

                    ContBusRel.SetCurrentkey("Link to Table", "No.");
                    ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Customer);
                    ContBusRel.SetRange("No.", "No.");
                    ContBusRel.Find('-');

                    if Cont."Company No." <> ContBusRel."Contact No." then
                        Error(Text003, Cont."No.", Cont.Name, "No.", Name);

                    if Cont.Type = Cont.Type::Person then
                        Contact := Cont.Name
                end;
            end;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Enabled = false;
            TableRelation = "Responsibility Center";
        }
        field(5750; "Shipping Advice"; Option)
        {
            Caption = 'Shipping Advice';
            OptionCaption = 'Partial,Complete';
            OptionMembers = Partial,Complete;
        }
        field(5790; "Shipping Time"; DateFormula)
        {
            Caption = 'Shipping Time';
        }
        field(5792; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            Enabled = false;
            TableRelation = "Shipping Agent Services".Code where("Shipping Agent Code" = field("Shipping Agent Code"));

            trigger OnValidate()
            begin
                if ("Shipping Agent Code" <> '') and
                   ("Shipping Agent Service Code" <> '')
                then
                    if ShippingAgentService.Get("Shipping Agent Code", "Shipping Agent Service Code") then
                        "Shipping Time" := ShippingAgentService."Shipping Time"
                    else
                        Evaluate("Shipping Time", '<>');
            end;
        }
        field(5900; "Service Zone Code"; Code[10])
        {
            Caption = 'Service Zone Code';
            Enabled = false;
            TableRelation = "Service Zone";
        }
        field(5902; "Contract Gain/Loss Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Contract Gain/Loss Entry".Amount where("Customer No." = field("No."),
                                                                       "Ship-to Code" = field("Ship-to Filter"),
                                                                       "Change Date" = field("Date Filter")));
            Caption = 'Contract Gain/Loss Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5903; "Ship-to Filter"; Code[10])
        {
            Caption = 'Ship-to Filter';
            Enabled = false;
            FieldClass = FlowFilter;
            TableRelation = "Ship-to Address".Code where("Customer No." = field("No."));
        }
        field(5910; "Outstanding Serv. Orders (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Service Line"."Outstanding Amount (LCY)" where("Document Type" = const(Order),
                                                                               "Bill-to Customer No." = field("No."),
                                                                               "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                               "Currency Code" = field("Currency Filter")));
            Caption = 'Outstanding Serv. Orders (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5911; "Serv Shipped Not Invoiced(LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Service Line"."Shipped Not Invoiced (LCY)" where("Document Type" = const(Order),
                                                                                 "Bill-to Customer No." = field("No."),
                                                                                 "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                 "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'Serv Shipped Not Invoiced(LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5912; "Outstanding Serv.Invoices(LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Service Line"."Outstanding Amount (LCY)" where("Document Type" = const(Invoice),
                                                                               "Bill-to Customer No." = field("No."),
                                                                               "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                               "Currency Code" = field("Currency Filter")));
            Caption = 'Outstanding Serv.Invoices($)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            InitValue = true;
        }
        field(7171; "No. of Approved Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Status" = const(Approved),
                                                        "Client Code" = field("No."),
                                                        "Outstanding Balance" = filter(<> 0)));
            Caption = 'No. of Quotes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7172; "No. of Issued Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Status" = const(Issued),
                                                        "Client Code" = field("No.")));
            Caption = 'No. of Blanket Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7173; "No. of Rejected Loans"; Integer)
        {
            CalcFormula = count("Loans Register" where("Loan Status" = const(Rejected),
                                                        "Client Code" = field("No.")));
            Caption = 'No. of Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7174; "No. of Invoices"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Invoice),
                                                      "Sell-to Customer No." = field("No.")));
            Caption = 'No. of Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7175; "No. of Members Guaranteed"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("No."),
                                                                 "Outstanding Balance" = filter(<> 0),
                                                                 Substituted = filter(false)));
            Caption = 'No. Members Guaranteed';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7176; "No. of Credit Memos"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const("Credit Memo"),
                                                      "Sell-to Customer No." = field("No.")));
            Caption = 'No. of Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7177; "No. of Pstd. Shipments"; Integer)
        {
            CalcFormula = count("Sales Shipment Header" where("Sell-to Customer No." = field("No.")));
            Caption = 'No. of Pstd. Shipments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7178; "No. of Pstd. Invoices"; Integer)
        {
            CalcFormula = count("Sales Invoice Header" where("Sell-to Customer No." = field("No.")));
            Caption = 'No. of Pstd. Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7179; "No. of Pstd. Return Receipts"; Integer)
        {
            CalcFormula = count("Return Receipt Header" where("Sell-to Customer No." = field("No.")));
            Caption = 'No. of Pstd. Return Receipts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7180; "No. of Pstd. Credit Memos"; Integer)
        {
            CalcFormula = count("Sales Cr.Memo Header" where("Sell-to Customer No." = field("No.")));
            Caption = 'No. of Pstd. Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7181; "No. of Ship-to Addresses"; Integer)
        {
            CalcFormula = count("Ship-to Address" where("Customer No." = field("No.")));
            Caption = 'No. of Ship-to Addresses';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7182; "Bill-To No. of Quotes"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Quote),
                                                      "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Quotes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7183; "Bill-To No. of Blanket Orders"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const("Blanket Order"),
                                                      "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Blanket Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7184; "Bill-To No. of Orders"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Order),
                                                      "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7185; "Bill-To No. of Invoices"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Invoice),
                                                      "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7186; "Bill-To No. of Return Orders"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const("Return Order"),
                                                      "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Return Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7187; "Bill-To No. of Credit Memos"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const("Credit Memo"),
                                                      "Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Credit Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7188; "Bill-To No. of Pstd. Shipments"; Integer)
        {
            CalcFormula = count("Sales Shipment Header" where("Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Pstd. Shipments';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7189; "Bill-To No. of Pstd. Invoices"; Integer)
        {
            CalcFormula = count("Sales Invoice Header" where("Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Pstd. Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7190; "Bill-To No. of Pstd. Return R."; Integer)
        {
            CalcFormula = count("Return Receipt Header" where("Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Pstd. Return R.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7191; "Bill-To No. of Pstd. Cr. Memos"; Integer)
        {
            CalcFormula = count("Sales Cr.Memo Header" where("Bill-to Customer No." = field("No.")));
            Caption = 'Bill-To No. of Pstd. Cr. Memos';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7600; "Base Calendar Code"; Code[10])
        {
            Caption = 'Base Calendar Code';
            TableRelation = "Base Calendar";
        }
        field(7601; "Copy Sell-to Addr. to Qte From"; Option)
        {
            Caption = 'Copy Sell-to Addr. to Qte From';
            OptionCaption = 'Company,Person';
            OptionMembers = Company,Person;
        }
        field(68000; "Customer Type"; Option)
        {
            OptionCaption = ' ,Member,FOSA,Investments,Property,MicroFinance';
            OptionMembers = " ",Member,FOSA,Investments,Property,MicroFinance;
        }
        field(68001; "Registration Date"; Date)
        {
        }
        field(68002; "Current Loan"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = const("Share Capital"),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68003; "Current Shares"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("Deposit Contribution"),
                                                                   "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68004; "Total Repayments"; Decimal)
        {
            Editable = false;
        }
        field(68005; "Principal Balance"; Decimal)
        {
        }
        field(68006; "Principal Repayment"; Decimal)
        {
        }
        field(68008; "Debtors Type"; Option)
        {
            OptionCaption = ' ,Staff,Client,Others';
            OptionMembers = " ",Staff,Client,Others;
        }
        field(68011; "Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Loan Repayment" | Loan)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68012; Status; Option)
        {
            OptionCaption = 'Active,Non-Active,Blocked,Dormant,Re-instated,Deceased,Withdrawal,Retired,Termination,Resigned,Ex-Company,Casuals,Family Member,Defaulter,Applicant,Rejected,New,Awaiting Withdrawal,Archived';
            OptionMembers = Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawal,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member",Defaulter,Applicant,Rejected,New,"Awaiting Withdrawal",Archived;

            trigger OnValidate()
            begin
                //Advice:=TRUE;
                //"Status Change Date" := TODAY;
                //"Last Marking Date" := TODAY;
                //MODIFY;
                /*
                IF xRec.Status=xRec.Status::Deceased THEN
                ERROR('Deceased status cannot be changed');
                
                Vend2.RESET;
                Vend2.SETRANGE(Vend2."Staff No","Payroll/Staff No");
                Vend2.SETRANGE(Vend2."Account Type",'PRIME');
                IF Vend2.FIND('-') THEN BEGIN
                REPEAT
                IF Status = Status::Deceased THEN BEGIN
                IF (Vend2."Account Type"<>'JUNIOR') THEN BEGIN
                Vend2.Status:=Vend2.Status::"6";
                Vend2.Blocked:=Vend2.Blocked::All;
                Vend2.MODIFY;
                END;
                END;
                UNTIL Vend2.NEXT = 0;
                END;
                
                //Charge Entrance fee on reinstament
                IF Status=Status::"Re-instated" THEN BEGIN
                GenSetUp.GET(0);
                "Registration Fee":=GenSetUp."Registration Fee";
                MODIFY;
                END;
                
                IF (Status<>Status::Active) OR (Status<>Status::Dormant) THEN
                Blocked:=Blocked::All;
                 */

            end;
        }
        field(68013; "FOSA Account No."; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(68015; "Old Account No."; Code[10])
        {
        }
        field(68016; "Loan Product Filter"; Code[15])
        {
            FieldClass = FlowFilter;
            TableRelation = "Loan Products Setup".Code;
        }
        field(68017; "Employer Code"; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate()
            begin
                Vend2.Reset;
                Vend2.SetRange(Vend2."Personal No.", "Personal No");
                if Vend2.Find('-') then begin
                    repeat
                        Vend2."Employer Code" := "Employer Code";
                        Vend2.Modify;
                    until Vend2.Next = 0;
                end;

                Employer.Reset;
                Employer.SetRange(Code, "Employer Code");
                if Employer.Find('-') then begin
                    "Employer Name" := Employer.Description;
                end
            end;
        }
        field(68018; "Date of Birth"; Date)
        {

            trigger OnValidate()
            begin
                /*IF "Date of Birth" <> 0D THEN BEGIN
                IF GenSetUp.GET(0) THEN BEGIN
                IF CALCDATE(GenSetUp."Min. Member Age","Date of Birth") > TODAY THEN
                ERROR('Applicant bellow the mininmum membership age of %1',GenSetUp."Min. Member Age");
                END;
                END;*/
                /*
              IF "Date of Birth" > TODAY THEN
              ERROR('Date of birth cannot be greater than today');
               */

            end;
        }
        field(68019; "E-Mail (Personal)"; Text[70])
        {
        }
        field(68020; "Station/Department"; Code[20])
        {
            TableRelation = "Member Section"."No.";
        }
        field(68021; "Home Address"; Text[20])
        {
        }
        field(68022; Location; Text[20])
        {
        }
        field(68023; "Sub-Location"; Text[2])
        {
        }
        field(68024; District; Text[25])
        {
        }
        field(68025; "Resons for Status Change"; Text[20])
        {
        }
        field(68026; "Personal No"; Code[20])
        {

            trigger OnValidate()
            begin
                Vend.Reset;
                Vend.SetRange("BOSA Account No", "No.");
                if Vend.Find('-') then begin
                    Vend."Personal No." := "Personal No";
                    Vend.Modify;
                end
            end;
        }
        field(68027; "ID No."; Code[40])
        {

            trigger OnValidate()
            begin
                if "ID No." <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."ID No.", "ID No.");
                    Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                    if Cust.Find('-') then begin
                        // IF Cust."No." <> "No." THEN
                        //  // ERROR('ID No. /exists');
                    end;
                end;

                Vend2.Reset;
                Vend2.SetRange(Vend2."BOSA Account No", "No.");
                if Vend2.Find('-') then begin
                    repeat
                        Vend2."ID No." := "ID No.";
                        Vend2.Modify;
                    until Vend2.Next = 0;
                end;
            end;
        }
        field(68028; "Mobile Phone No"; Code[12])
        {
        }
        field(68029; "Marital Status"; Option)
        {
            OptionCaption = ' ,Single,Married,Divorced,Widower,Separated';
            OptionMembers = " ",Single,Married,Divorced,Widower,Separated;
        }
        field(68030; Signature; MediaSet)
        {
            Caption = 'Signature';
            Editable = false;
        }
        field(68031; "Passport No."; Code[10])
        {
        }
        field(68032; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;

            trigger OnValidate()
            begin
                Vend2.Reset;
                Vend2.SetRange(Vend2."Personal No.", "Personal No");
                if Vend2.Find('-') then begin
                    repeat
                        Vend2.Gender := Gender;
                        Vend2.Modify;
                    until Vend2.Next = 0;
                end;
            end;
        }
        field(68033; "Withdrawal Date"; Date)
        {
        }
        field(68034; "Withdrawal Fee"; Decimal)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(68035; "Status - Withdrawal App."; Option)
        {
            CalcFormula = lookup("Membership Exit".Status where("Member No." = field("No.")));
            FieldClass = FlowField;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;

            trigger OnValidate()
            begin
                //"Approval Date":=TODAY;


                /*IF "Status - Withdrawal App." = "Status - Withdrawal App."::Approved THEN BEGIN
                TESTFIELD("Closure Remarks");
                
                CALCFIELDS("Outstanding Balance","Accrued Interest","Current Shares","Insurance Fund","FOSA Outstanding Balance",
                           "FOSA Oustanding Interest");
                
                CALCFIELDS("Outstanding Balance");
                IF ("Outstanding Balance"+"Accrued Interest"+"FOSA Outstanding Balance"+"FOSA Oustanding Interest") +
                   ("Current Shares"+"Insurance Fund") > 0 THEN
                IF CONFIRM('Member shares deposits and insurance fund not enough to clear loan. Do you wish to continue') = FALSE THEN
                ERROR('Approval terminated.');
                
                END; */

            end;
        }
        field(68036; "Withdrawal Application Date"; Date)
        {

            trigger OnValidate()
            begin
                // IF "Withdrawal Application Date" <> 0D THEN
                // "Withdrawal Date":=CALCDATE('2M',"Withdrawal Application Date");
                //
                // GenSetUp.GET();
                // "Withdrawal Fee":=GenSetUp."Withdrawal Fee";
                // Status:=Status::"Awaiting Withdrawal";
                // Blocked:=Blocked::All;
                CDays := 60;

                EMaturity := "Withdrawal Application Date";
                if i < CDays then begin
                    repeat
                        EMaturity := CalcDate('1D', EMaturity);
                        if (Date2dwy(EMaturity, 1) <> 6) and (Date2dwy(EMaturity, 1) <> 7) then
                            i := i + 1;

                    until i = CDays;
                end;

                "Withdrawal Date" := EMaturity
            end;
        }
        field(68037; "Investment Monthly Cont"; Decimal)
        {
        }
        field(68038; "Investment Max Limit."; Decimal)
        {
        }
        field(68039; "Current Investment Total"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Loan Insurance Charged"),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68040; "Document No. Filter"; Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(68041; "Shares Retained"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Share Capital"),
                                                                   "Document No." = field("Document No. Filter"),
                                                                   "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68043; "Registration Fee Paid"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                           "Transaction Type" = const("Registration Fee")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68044; "Registration Fee"; Decimal)
        {
        }
        field(68045; "Society Code"; Code[10])
        {
        }
        field(68046; "Insurance Fund"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("Insurance Contribution"),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68047; "Monthly Contribution"; Decimal)
        {

            trigger OnValidate()
            begin
                //SURESTEP - Check Min Contractual Shares
                /*IF GenSetUp."Contactual Shares (%)" <> 0 THEN BEGIN
                IF "Monthly Contribution" <> 0 THEN BEGIN
                GenSetUp.GET(0);
                
                Loans.RESET;
                Loans.SETRANGE(Loans."Client Code","No.");
                IF Loans.FIND('-') THEN BEGIN
                REPEAT
                Loans.CALCFIELDS(Loans."Outstanding Balance");
                IF (Loans."Outstanding Balance" > 0) THEN BEGIN
                IF MinShares < ((Loans."Approved Amount"* GenSetUp."Contactual Shares (%)")*0.01) THEN
                MinShares:=(Loans."Approved Amount"* GenSetUp."Contactual Shares (%)")*0.01;
                END;
                UNTIL Loans.NEXT = 0;
                END;
                
                IF MinShares > GenSetUp."Max. Contactual Shares" THEN
                MinShares := GenSetUp."Max. Contactual Shares";
                
                
                IF MinShares < GenSetUp."Min. Contribution" THEN
                MinShares := GenSetUp."Min. Contribution";
                
                IF "Monthly Contribution" <  MinShares THEN
                ERROR('Monthly contribution cannot be less than the contractual shares i.e. %1',MinShares);
                
                END;
                END;
                
                IF xRec."Monthly Contribution" <> 0 THEN BEGIN
                Advice:=TRUE;
                "Advice Type":="Advice Type"::"Shares Adjustment";
                END;
                
                //SURESTEP - Check Min Contractual Shares
                
                "Previous Share Contribution":=xRec."Monthly Contribution"; */


                "Previous Share Contribution" := xRec."Monthly Contribution";



                Advice := true;
                //"Advice Type":="Advice Type"::Adjustment;
                /*
                
                DataSheet.INIT;
                DataSheet."PF/Staff No":="Personal No";
                DataSheet."Type of Deduction":='Shares/Deposits';
                DataSheet."Remark/LoanNO":='ADJ FORM';
                DataSheet.Name:=Name;
                DataSheet."ID NO.":="ID No.";
                DataSheet."Amount ON":="Monthly Contribution";
                DataSheet."REF.":='2026';
                DataSheet."New Balance":="Current Shares"*-1;
                DataSheet.Date:=TODAY;
                DataSheet."Amount OFF":=xRec."Monthly Contribution";
                DataSheet.Employer:="Employer Code";
                DataSheet."Transaction Type":=DataSheet."Transaction Type"::ADJUSTMENT;
                //DataSheet."Sort Code":=PTEN;
                DataSheet.INSERT;
                */

            end;
        }
        field(68048; "Investment B/F"; Decimal)
        {
        }
        field(68049; "Dividend Amount"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                   "Transaction Type" = const(Dividend),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            FieldClass = FlowField;
        }
        field(68050; "Name of Chief"; Text[10])
        {
        }
        field(68051; "Office Telephone No."; Code[10])
        {
        }
        field(68052; "Extension No."; Code[10])
        {
        }
        field(68053; "Welfare Contribution"; Decimal)
        {

            trigger OnValidate()
            begin
                //Advice:=TRUE;
            end;
        }
        field(68054; Advice; Boolean)
        {
        }
        field(68055; Province; Code[10])
        {
            Enabled = false;
        }
        field(68056; "Previous Share Contribution"; Decimal)
        {
        }
        field(68057; "Un-allocated Funds"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Unallocated Funds"),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68058; "Refund Request Amount"; Decimal)
        {
            Editable = false;
        }
        field(68059; "Refund Issued"; Boolean)
        {
            Editable = false;
        }
        field(68060; "Batch No."; Code[15])
        {
            Enabled = false;

            trigger OnValidate()
            begin
                /*IF "Refund Issued"=TRUE THEN BEGIN
                RefundsR.RESET;
                RefundsR.SETRANGE(RefundsR."Member No.","No.");
                IF RefundsR.FIND('-') THEN
                RefundsR.DELETEALL;
                
                "Refund Issued":=FALSE;
                END;
                
                IF "Batch No." <> '' THEN BEGIN
                MovementTracker.RESET;
                MovementTracker.SETRANGE(MovementTracker."Document No.","Batch No.");
                MovementTracker.SETRANGE(MovementTracker."Current Location",TRUE);
                IF MovementTracker.FIND('-') THEN BEGIN
                ApprovalsUsers.RESET;
                ApprovalsUsers.SETRANGE(ApprovalsUsers."Approval Type",MovementTracker."Approval Type");
                ApprovalsUsers.SETRANGE(ApprovalsUsers.Stage,MovementTracker.Stage);
                ApprovalsUsers.SETRANGE(ApprovalsUsers."User ID",USERID);
                IF ApprovalsUsers.FIND('-') = FALSE THEN
                ERROR('You cannot assign a batch which is in %1.',MovementTracker.Station);
                
                END;
                END; */

            end;
        }
        field(68061; "Current Status"; Option)
        {
            OptionMembers = Approved,Rejected;
        }
        field(68062; "Cheque No."; Code[10])
        {
        }
        field(68063; "Cheque Date"; Date)
        {
        }
        field(68064; "Accrued Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Deposit Contribution")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68065; "Defaulted Loans Recovered"; Boolean)
        {
        }
        field(68066; "Withdrawal Posted"; Boolean)
        {
        }
        field(68069; "Loan No. Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("No."));
        }
        field(68070; "Currect File Location"; Code[10])
        {
            CalcFormula = max("File Movement Tracker".Station where("Member No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68071; "Move To1"; Integer)
        {
            TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));
        }
        field(68073; "File Movement Remarks"; Text[10])
        {
        }
        field(68076; "Status Change Date"; Date)
        {
        }
        field(68077; "Last Payment Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("No."),
                                                                          "Credit Amount" = filter(> 0)));
            FieldClass = FlowField;
        }
        field(68078; "Discounted Amount"; Decimal)
        {
        }
        field(68079; "Current Savings"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Deposit Contribution")));
            FieldClass = FlowField;
        }
        field(68080; "Payroll Updated"; Boolean)
        {
        }
        field(68081; "Last Marking Date"; Date)
        {
        }
        field(68082; "Dividends Capitalised %"; Decimal)
        {

            trigger OnValidate()
            begin
                /*IF ("Dividends Capitalised %" < 0) OR ("Dividends Capitalised %" > 100) THEN
                ERROR('Invalied Entry.');*/

            end;
        }
        field(68083; "FOSA Outstanding Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Share Capital" | "Interest Paid" | "FOSA Shares")));
            FieldClass = FlowField;
        }
        field(68084; "FOSA Oustanding Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Deposit Contribution")));
            FieldClass = FlowField;
        }
        field(68085; "Formation/Province"; Code[10])
        {

            trigger OnValidate()
            begin
                /*Vend.RESET;
                Vend.SETRANGE(Vend."Staff No","Payroll/Staff No");
                IF Vend.FIND('-') THEN BEGIN
                REPEAT
                Vend."Formation/Province":="Formation/Province";
                Vend.MODIFY;
                UNTIL Vend.NEXT=0;
                END;*/

            end;
        }
        field(68086; "Division/Department"; Code[10])
        {
            TableRelation = "Member Departments"."No.";
        }
        field(68087; "Station/Section"; Code[10])
        {
            TableRelation = "prTax Law".Field1;
        }
        field(68088; "Closing Deposit Balance"; Decimal)
        {
        }
        field(68089; "Closing Loan Balance"; Decimal)
        {
        }
        field(68090; "Closing Insurance Balance"; Decimal)
        {
        }
        field(68091; "Dividend Progression"; Decimal)
        {
        }
        field(68092; "Closing Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("No.")));
            FieldClass = FlowField;
        }
        field(68093; "Welfare Fund"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Transaction Type" = filter("School Fees"),
                                                                   "Customer No." = field("No."),
                                                                   "Transaction Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68094; "Discounted Dividends"; Decimal)
        {
        }
        field(68095; "Mode of Dividend Payment"; Option)
        {
            OptionCaption = ' ,FOSA,EFT,Cheque,Defaulted Loan (Capitalised)';
            OptionMembers = " ",FOSA,EFT,Cheque,"Defaulted Loan";
        }
        field(68096; "Qualifying Shares"; Decimal)
        {
        }
        field(68097; "Defaulter Overide Reasons"; Text[10])
        {
        }
        field(68098; "Defaulter Overide"; Boolean)
        {

            trigger OnValidate()
            begin
                /*TESTFIELD("Defaulter Overide Reasons");
                
                StatusPermissions.RESET;
                StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
                StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::"Loan External EFT");
                IF StatusPermissions.FIND('-') = FALSE THEN
                ERROR('You do not have permissions to overide defaulters.'); */

            end;
        }
        field(68099; "Closure Remarks"; Text[10])
        {
        }
        field(68100; "Bank Account No."; Code[10])
        {
        }
        field(68101; "Bank Code"; Code[10])
        {
            TableRelation = "Member App Signatories"."Account No";
            ValidateTableRelation = false;
        }
        field(68102; "Dividend Processed"; Boolean)
        {
        }
        field(68103; "Dividend Error"; Boolean)
        {
        }
        field(68104; "Dividend Capitalized"; Decimal)
        {
        }
        field(68105; "Dividend Paid FOSA"; Decimal)
        {
        }
        field(68106; "Dividend Paid EFT"; Decimal)
        {
        }
        field(68107; "Dividend Withholding Tax"; Decimal)
        {
        }
        field(68109; "Loan Last Payment Date"; Date)
        {
            FieldClass = Normal;
        }
        field(68110; "Outstanding Interest"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("Interest Due" | "Interest Paid"),
                                                                  "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(68111; "Last Transaction Date"; Date)
        {
            FieldClass = Normal;
        }
        field(68112; "Account Category"; Option)
        {
            OptionCaption = 'Single,Joint,Corporate,Group,Parish,Church,Church Department,Staff';
            OptionMembers = Single,Joint,Corporate,Group,Parish,Church,"Church Department",Staff;
        }
        field(68113; "Type Of Organisation"; Option)
        {
            OptionCaption = ' ,Club,Association,Partnership,Investment,Merry go round,Other,Group';
            OptionMembers = " ",Club,Association,Partnership,Investment,"Merry go round",Other,Group;
        }
        field(68114; "Source Of Funds"; Option)
        {
            OptionCaption = ' ,Business Receipts,Income from Investment,Salary,Other';
            OptionMembers = " ","Business Receipts","Income from Investment",Salary,Other;
        }
        field(68115; "MPESA Mobile No"; Code[15])
        {
        }
        field(68120; "Force No."; Code[10])
        {
            Enabled = false;
        }
        field(68121; "Last Advice Date"; Date)
        {
        }
        field(68122; "Advice Type"; Option)
        {
            OptionMembers = " ","New Member","Shares Adjustment","ABF Adjustment","Registration Fees",Withdrawal,Reintroduction,"Reintroduction With Reg Fees";
        }
        field(68137; "Signing Instructions"; Option)
        {
            OptionCaption = 'Any to Sign,Two to Sign,Three to Sign,All to Sign';
            OptionMembers = "Any to Sign","Two to Sign","Three to Sign","All to Sign";
        }
        field(68140; "Share Balance BF"; Decimal)
        {
        }
        field(68143; "Move to"; Integer)
        {
            TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));

            trigger OnValidate()
            begin
                Approvalsetup.Reset;
                Approvalsetup.SetRange(Approvalsetup.Stage, "Move to");
                if Approvalsetup.Find('-') then begin
                    "Move to description" := Approvalsetup.Station;
                end;
            end;
        }
        field(68144; "File Movement Remarks1"; Option)
        {
            OptionCaption = ' ,Reconciliation purposes,Auditing purposes,Refunds,Loan & Signatories,Withdrawal,Risks payment,Cheque Payment,Custody,Document Filing,Passbook,Complaint Letters,Defaulters,Dividends,Termination,New Members Details,New Members Verification';
            OptionMembers = " ","Reconciliation purposes","Auditing purposes",Refunds,"Loan & Signatories",Withdrawal,"Risks payment","Cheque Payment",Custody,"Document Filing",Passbook,"Complaint Letters",Defaulters,Dividends,Termination,"New Members Details","New Members Verification";
        }
        field(68145; "File MVT User ID"; Code[10])
        {
            Enabled = false;
        }
        field(68146; "File MVT Time"; Time)
        {
        }
        field(68147; "File Previous Location"; Code[10])
        {
            Enabled = false;
        }
        field(68148; "File MVT Date"; Date)
        {
        }
        field(68149; "file received date"; Date)
        {
        }
        field(68150; "File received Time"; Time)
        {
        }
        field(68151; "File Received by"; Code[10])
        {
        }
        field(68152; "file Received"; Boolean)
        {
        }
        field(68153; User; Code[20])
        {
            TableRelation = "User Setup";
        }
        field(68154; "Change Log"; Integer)
        {
            CalcFormula = count("Change Log Entry" where("Primary Key Field 1 Value" = field("No.")));
            FieldClass = FlowField;
        }
        field(68155; Section; Code[10])
        {
            TableRelation = if (Section = const('')) "HR Leave Carry Allocation".Status;
        }
        field(68156; rejoined; Boolean)
        {
        }
        field(68157; "Job title"; Code[10])
        {
        }
        field(68158; Pin; Code[20])
        {
        }
        field(68160; "Remitance mode"; Option)
        {
            OptionCaption = ',Check off,Cash,Standing Order';
            OptionMembers = ,"Check off",Cash,"Standing Order";
        }
        field(68161; "Terms of Service"; Option)
        {
            OptionCaption = ',Permanent,Temporary,Contract';
            OptionMembers = ,Permanent,"Temporary",Contract;
        }
        field(68162; Comment1; Text[10])
        {
        }
        field(68163; Comment2; Text[10])
        {
        }
        field(68164; "Current file location"; Code[10])
        {
        }
        field(68165; "Work Province"; Code[10])
        {
            Enabled = false;
        }
        field(68166; "Work District"; Code[10])
        {
            Enabled = false;
        }
        field(68167; "Sacco Branch"; Code[10])
        {
        }
        field(68168; "Bank Branch Code"; Code[20])
        {
        }
        field(68169; "Customer Paypoint"; Code[10])
        {
        }
        field(68170; "Date File Opened"; Date)
        {
        }
        field(68171; "File Status"; Code[10])
        {
        }
        field(68172; "Customer Title"; Code[10])
        {
        }
        field(68173; "Folio Number"; Code[10])
        {
        }
        field(68174; "Move to description"; Text[20])
        {
        }
        field(68175; Filelocc; Integer)
        {
            CalcFormula = max("File Movement Tracker"."Entry No." where("Member No." = field("No.")));
            FieldClass = FlowField;
        }
        field(68176; "S Card No."; Code[10])
        {
        }
        field(68177; "Reason for file overstay"; Text[10])
        {
        }
        field(68179; "Loc Description"; Text[10])
        {
        }
        field(68180; "Current Balance"; Decimal)
        {
        }
        field(68181; "Member Transfer Date"; Date)
        {
        }
        field(68182; "Contact Person"; Code[20])
        {
        }
        field(68183; "Member withdrawable Deposits"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Document No." = field("Document No. Filter"),
                                                                  "Transaction Type" = const(Holiday)));
            FieldClass = FlowField;
        }
        field(68184; "Current Location"; Text[10])
        {
        }
        field(68185; "Group Code"; Code[10])
        {
        }
        field(68186; "Xmas Contribution"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                   "Transaction Type" = const(Holiday),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68187; "Risk Fund"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                   "Transaction Type" = const("Benevolent Fund"),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68188; "Office Branch"; Code[10])
        {
        }
        field(68189; Department; Code[15])
        {
            TableRelation = "Member Departments"."No.";
        }
        field(68190; Occupation; Text[20])
        {
        }
        field(68191; Designation; Text[20])
        {
        }
        field(68192; "Village/Residence"; Text[20])
        {
            TableRelation = "Approvals Set Up".Stage where("Approval Type" = const("File Movement"));
        }
        field(68194; "Contact Person Phone"; Code[20])
        {
        }
        field(68195; "Development Shares"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("24"),
                                                                  "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(68198; "Recruited By"; Code[20])
        {
            Editable = false;
        }
        field(68200; "ContactPerson Relation"; Code[15])
        {
            TableRelation = "Relationship Types";
        }
        field(68201; "ContactPerson Occupation"; Code[15])
        {
        }
        field(68206; "Insurance on Shares"; Decimal)
        {
        }
        field(68207; Disabled; Boolean)
        {
        }
        field(68212; "Mobile No. 2"; Code[15])
        {
        }
        field(68213; "Employer Name"; Code[50])
        {
        }
        field(68214; Title; Option)
        {
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.,Rev.,Capt.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.","Rev.","Capt.";
        }
        field(68215; Town; Code[10])
        {
            Editable = false;
            TableRelation = "Post Code".City;
        }
        field(68222; "Home Town"; Code[10])
        {
            Editable = false;
        }
        field(69038; "Loans Defaulter Status"; Option)
        {
            CalcFormula = lookup("Loans Register"."Loans Category-SASRA" where("Client Code" = field("No.")));
            FieldClass = FlowField;
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(69039; "Home Postal Code"; Code[10])
        {
            TableRelation = "Post Code".Code;
        }
        field(69040; "Total Loans Outstanding"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment" | "Interest Paid")));
            FieldClass = FlowField;
        }
        field(69041; "No of Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("No."),
                                                                 "Outstanding Balance" = filter(<> 0),
                                                                 Substituted = const(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69046; "Member Can Guarantee  Loan"; Boolean)
        {
        }
        field(69047; "FOSA  Account Bal"; Decimal)
        {
            FieldClass = FlowFilter;
            TableRelation = Vendor.Balance where("No." = field("FOSA Account No."));

            trigger OnValidate()
            begin
                if Rec.Get(Rec."FOSA Account No.") then
                    Rec.Reset;
                Rec.SetRange(Rec."FOSA Account No.", Vend."No.");
                Vend.CalcFields(Vend.Balance);
                Rec."FOSA  Account Bal" := Vend.Balance;
                Rec.Modify;
            end;
        }
        field(69048; "Rejoining Date"; Date)
        {
        }
        field(69049; "Active Loans Guarantor"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Member No" = field("No."),
                                                                 "Outstanding Balance" = filter(> 0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69050; "Loans Guaranteed"; Integer)
        {
            CalcFormula = count("Loans Guarantee Details" where("Substituted Guarantor" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69051; "Member Deposit Mult 3"; Decimal)
        {
        }
        field(69052; "New loan Eligibility"; Decimal)
        {
        }
        field(69053; "Share Certificate No"; Integer)
        {
        }
        field(69054; "Last Share Certificate No"; Integer)
        {
            CalcFormula = max("Member Register"."Share Certificate No");
            FieldClass = FlowField;
        }
        field(69055; "No Of Days"; Integer)
        {
        }
        field(69056; "Application No."; Code[10])
        {
        }
        field(69057; "Member Category"; Option)
        {
            OptionCaption = 'New Application,Account Reactivation,Transfer';
            OptionMembers = "New Application","Account Reactivation",Transfer;
        }
        field(69058; "Terms Of Employment"; Option)
        {
            OptionCaption = ' ,Permanent,Temporary,Contract,Private,Probation';
            OptionMembers = " ",Permanent,"Temporary",Contract,Private,Probation;
        }
        field(69059; "Nominee Envelope No."; Code[20])
        {
        }
        field(69060; Defaulter; Boolean)
        {
        }
        field(69061; "Shares Variance"; Decimal)
        {
        }
        field(69062; "Net Dividend Payable"; Decimal)
        {
        }
        field(69063; "Tax on Dividend"; Decimal)
        {
        }
        field(69064; "Div Amount"; Decimal)
        {
        }
        field(69065; "Payroll Agency"; Code[10])
        {
        }
        field(69066; "Introduced By"; Code[20])
        {
            Editable = true;
        }
        field(69067; "Introducer Name"; Text[20])
        {
            Editable = false;
        }
        field(69068; "Introducer Staff No"; Code[20])
        {
        }
        field(69069; BoostedDate; Date)
        {
        }
        field(69070; BoostedAmount; Decimal)
        {
        }
        field(69071; "Bridge Amount Release"; Decimal)
        {
            CalcFormula = sum("Loan Offset Details"."Monthly Repayment" where("Client Code" = field("No.")));
            FieldClass = FlowField;
        }
        field(69072; "Repayment Method"; Option)
        {
            OptionCaption = ' ,Amortised,Reducing Balance,Straight Line,Constants,Ukulima Flat';
            OptionMembers = " ",Amortised,"Reducing Balance","Straight Line",Constants,"Ukulima Flat";
        }
        field(69073; Staff; Boolean)
        {
        }
        field(69074; "Death date"; Date)
        {
        }
        field(69075; "Edit Status"; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(69076; "Deposit Boosted Date"; Date)
        {
        }
        field(69077; "Deposit Boosted Amount"; Decimal)
        {
        }
        field(69078; "Investment Account"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Document No." = field("Document No. Filter"),
                                                                  "Transaction Type" = const("Loan Insurance Charged")));
            FieldClass = FlowField;
        }
        field(69079; "Mobile No 3"; Code[15])
        {
        }
        field(69080; "Share Capital B Class"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter"),
                                                                   "Transaction Type" = const("41")));
            FieldClass = FlowField;
        }
        field(69081; "Normal Shares B Class"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter"),
                                                                   "Transaction Type" = const("42")));
            FieldClass = FlowField;
        }
        field(69082; "FOSA Shares"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter"),
                                                                   "Transaction Type" = const("FOSA Shares")));
            FieldClass = FlowField;
        }
        field(69083; "Members Parish"; Code[10])
        {
            TableRelation = "Member's Parishes".Code;

            trigger OnValidate()
            begin
                Parishes.Reset;
                Parishes.SetRange(Parishes.Code, "Members Parish");
                if Parishes.Find('-') then begin
                    "Parish Name" := Parishes.Description;
                    "Member Share Class" := Parishes."Share Class";
                end;
            end;
        }
        field(69084; "Parish Name"; Text[20])
        {
        }
        field(69085; "Employment Info"; Option)
        {
            OptionCaption = ' ,Employed,UnEmployed,Contracting,Others';
            OptionMembers = " ",Employed,UnEmployed,Contracting,Others;
        }
        field(69086; "Contracting Details"; Text[20])
        {
        }
        field(69087; "Others Details"; Text[15])
        {
        }
        field(69088; Products; Option)
        {
            OptionCaption = 'BOSA Account,BOSA+Current Account,BOSA+Smart Saver,BOSA+Fixed Deposit,Smart Saver Only,Current Only,Fixed  Deposit Only,Fixed+Smart Saver,Fixed+Current,Current+Smart Saver';
            OptionMembers = "BOSA Account","BOSA+Current Account","BOSA+Smart Saver","BOSA+Fixed Deposit","Smart Saver Only","Current Only","Fixed  Deposit Only","Fixed+Smart Saver","Fixed+Current","Current+Smart Saver";
        }
        field(69089; "Joint Account Name"; Text[30])
        {
        }
        field(69090; "Postal Code 2"; Code[10])
        {
            TableRelation = "Post Code";
        }
        field(69091; "Town 2"; Code[20])
        {
        }
        field(69092; "Passport 2"; Code[20])
        {
        }
        field(69093; "Member Parish 2"; Code[10])
        {
            Enabled = false;
        }
        field(69094; "Member Parish Name 2"; Text[10])
        {
            Enabled = false;
        }
        field(69095; "Name of the Group/Corporate"; Text[20])
        {
        }
        field(69096; "Date of Registration"; Date)
        {
        }
        field(69097; "No of Members"; Integer)
        {
        }
        field(69098; "Group/Corporate Trade"; Code[20])
        {
        }
        field(69099; "Certificate No"; Code[20])
        {
        }
        field(69100; "ID No.2"; Code[15])
        {
        }
        field(69101; "Picture 2"; Blob)
        {
            SubType = Bitmap;
        }
        field(69102; "Signature  2"; Blob)
        {
            SubType = Bitmap;
        }
        field(69103; Title2; Option)
        {
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(69104; "Mobile No. Three"; Code[15])
        {
        }
        field(69105; "Date of Birth2"; Date)
        {

            trigger OnValidate()
            begin
                if "Date of Birth" > Today then
                    Error('Date of birth cannot be greater than today');


                if "Date of Birth" <> 0D then begin
                    if GenSetUp.Get() then begin
                        if CalcDate(GenSetUp."Min. Member Age", "Date of Birth") > Today then
                            Error('Applicant bellow the mininmum membership age of %1', GenSetUp."Min. Member Age");
                    end;
                end;
            end;
        }
        field(69106; "Marital Status2"; Option)
        {
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(69107; Gender2; Option)
        {
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(69108; "Address3-Joint"; Code[15])
        {
        }
        field(69109; "Home Postal Code2"; Code[15])
        {
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                PostCode.Reset;
                PostCode.SetRange(PostCode.Code, "Home Postal Code");
                if PostCode.Find('-') then begin
                    "Home Town" := PostCode.City
                end;
            end;
        }
        field(69110; "Home Town2"; Text[15])
        {
        }
        field(69111; "Payroll/Staff No2"; Code[15])
        {
        }
        field(69112; "Employer Code2"; Code[15])
        {
            TableRelation = "HR Asset Transfer Header";

            trigger OnValidate()
            begin
                Employer.Get("Employer Code");
                "Employer Name" := Employer.Description;
            end;
        }
        field(69113; "Employer Name2"; Code[20])
        {
        }
        field(69114; "E-Mail (Personal2)"; Text[20])
        {
        }
        field(69115; "Member Share Class"; Option)
        {
            OptionCaption = ' ,Class A,Class B';
            OptionMembers = " ","Class A","Class B";
        }
        field(69116; "Member's Residence"; Code[25])
        {
        }
        field(69117; "Postal Code 3"; Code[15])
        {
            TableRelation = "Post Code";
        }
        field(69118; "Town 3"; Code[15])
        {
        }
        field(69119; "Passport 3"; Code[15])
        {
        }
        field(69120; "Member Parish 3"; Code[10])
        {
        }
        field(69121; "Member Parish Name 3"; Text[10])
        {
        }
        field(69122; "Picture 3"; Blob)
        {
            SubType = Bitmap;
        }
        field(69123; "Signature  3"; Blob)
        {
            SubType = Bitmap;
        }
        field(69124; Title3; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Mr.,Mrs.,Miss.,DR.,Prof.,Fr.,Sr.,Bro.';
            OptionMembers = " ","Mr.","Mrs.","Miss.","DR.","Prof.","Fr.","Sr.","Bro.";
        }
        field(69125; "Middle Name"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Middle Name" := Memb."Middle Name";
            end;
        }
        field(69126; "Last Name"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Last Name" := Memb."Last Name";
            end;
        }
        field(69127; "Marital Status3"; Option)
        {
            OptionMembers = " ",Single,Married,Devorced,Widower,Widow;
        }
        field(69128; Gender3; Option)
        {
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(69129; Address3; Code[10])
        {
        }
        field(69130; "Home Postal Code3"; Code[10])
        {
            TableRelation = "Post Code";

            trigger OnValidate()
            begin
                PostCode.Reset;
                PostCode.SetRange(PostCode.Code, "Home Postal Code");
                if PostCode.Find('-') then begin
                    "Home Town" := PostCode.City
                end;
            end;
        }
        field(69131; "Home Town3"; Text[10])
        {
        }
        field(69132; "Payroll/Staff No3"; Code[15])
        {
        }
        field(69133; "Employer Code3"; Code[10])
        {
            TableRelation = "HR Asset Transfer Header";

            trigger OnValidate()
            begin
                Employer.Get("Employer Code");
                "Employer Name" := Employer.Description;
            end;
        }
        field(69134; "Employer Name3"; Code[20])
        {
        }
        field(69135; "E-Mail (Personal3)"; Text[20])
        {
        }
        field(69136; "Name 3"; Code[20])
        {
        }
        field(69137; "ID No.3"; Code[10])
        {
        }
        field(69138; "Mobile No. 4"; Code[15])
        {
        }
        field(69139; Address4; Code[15])
        {
        }
        field(69140; "Assigned System ID"; Code[15])
        {
            TableRelation = User."User Name";
        }
        field(69141; "Risk Fund Arrears"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("45" | "44"),
                                                                  "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69143; "Pension No"; Code[15])
        {
        }
        field(69144; "Benevolent Fund"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("Benevolent Fund"),
                                                                   "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69145; "Risk Fund Paid"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("45"),
                                                                  "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69146; "BRID No"; Code[15])
        {
        }
        field(69147; "Gross Dividend Amount Payable"; Decimal)
        {
        }
        field(69148; "Card No"; Code[15])
        {
        }
        field(69149; "Funeral Rider"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                  "Transaction Type" = filter("48"),
                                                                  "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69150; "Loan Liabilities"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Transaction Type" = filter("Share Capital" | "Interest Paid" | "Deposit Contribution" | "Insurance Contribution")));
            FieldClass = FlowField;
        }
        field(69151; "Last Deposit Contribution Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = field("No."),
                                                                          "Transaction Type" = filter("Deposit Contribution"),
                                                                          Amount = filter(< 0)));
            FieldClass = FlowField;
        }
        field(69153; "Member House Group"; Code[15])
        {
            TableRelation = "Member House Groups"."Cell Group Code";

            trigger OnValidate()
            begin
                if ObjCellGroup.Get("Member House Group") then begin
                    "Member House Group Name" := ObjCellGroup."Cell Group Name";
                end;
                /*CellGroups.RESET;
                CellGroups.SETRANGE(CellGroups."Cell Group Code","Member Cell Group");
                IF CellGroups.FIND('-') THEN BEGIN
                "Member Cell Group Name":=CellGroups."Cell Group Name";
                END;*/

            end;
        }
        field(69154; "Member House Group Name"; Code[1])
        {
        }
        field(69155; "No Of Group Members."; Integer)
        {
        }
        field(69156; "Group Account Name"; Code[20])
        {
        }
        field(69157; "Business Loan Officer"; Code[2])
        {
        }
        field(69158; "Group Account"; Boolean)
        {
        }
        field(69159; "Group Account No"; Code[15])
        {
            TableRelation = "Member Register"."No." where("Group Account" = filter(true));
        }
        field(69160; "FOSA Account"; Code[15])
        {
        }
        field(69161; "Micro Group Code"; Code[10])
        {
        }
        field(69162; "Loan Officer Name"; Code[15])
        {
        }
        field(69163; "BOSA Account No."; Code[15])
        {
        }
        field(69164; "Any Other Sacco"; Text[10])
        {
        }
        field(69165; "Member class"; Option)
        {
            OptionCaption = ',Class A,Class B';
            OptionMembers = ,"Class A","Class B";
        }
        field(69166; "Employment Terms"; Option)
        {
            OptionCaption = ' ,Permanent,Casual';
            OptionMembers = " ",Permanent,Casual;
        }
        field(69167; "Group Deposits"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Group Code" = field("No."),
                                                                   "Transaction Type" = filter("Deposit Contribution"),
                                                                   "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69168; "Group Loan Balance"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Group Code" = field("No."),
                                                                  "Transaction Type" = filter(Loan | "Loan Repayment"),
                                                                  "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69169; "No of Group Members"; Integer)
        {
            CalcFormula = count("Member Register" where("Group Account No" = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69170; "No of Active Group Members"; Integer)
        {
            CalcFormula = count("Member Register" where("Group Account No" = field("No."),
                                                         Status = filter(Active)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69171; "No of Dormant Group Members"; Integer)
        {
            CalcFormula = count("Member Register" where("Group Account No" = field("No."),
                                                         Status = filter(Dormant)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69172; "Khoja Shares"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("49"),
                                                                   "Posting Date" = field("Date Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(69173; "Group Shares"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("50"),
                                                                   "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69174; "Member Of a Group"; Boolean)
        {
        }
        field(69175; TLoansGuaranteed; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("No."),
                                                                                  "Outstanding Balance" = filter(<> 0)));
            FieldClass = FlowField;
        }
        field(69176; "Total Committed Shares"; Decimal)
        {
            CalcFormula = sum("Loans Guarantee Details"."Amont Guaranteed" where("Member No" = field("No."),
                                                                                  "Outstanding Balance" = filter(<> 0)));
            FieldClass = FlowField;
        }
        field(69177; "Existing Loan Repayments"; Decimal)
        {
            CalcFormula = sum("Loans Register".Repayment where("Client Code" = field("No.")));
            FieldClass = FlowField;
        }
        field(69178; "Existing Fosa Loan Repayments"; Decimal)
        {
            CalcFormula = sum("Loans Register".Repayment where("Client Code" = field("FOSA Account No.")));
            FieldClass = FlowField;
        }
        field(69179; "Employer Address"; Code[15])
        {
        }
        field(69180; "Date of Employment"; Date)
        {
        }
        field(69181; "Position Held"; Code[20])
        {
        }
        field(69182; "Expected Monthly Income"; Decimal)
        {
        }
        field(69183; "Nature Of Business"; Option)
        {
            OptionCaption = 'Sole Proprietorship, Partnership';
            OptionMembers = "Sole Proprietorship"," Partnership";
        }
        field(69184; Industry; Code[15])
        {
        }
        field(69185; "Business Name"; Code[20])
        {
        }
        field(69186; "Physical Business Location"; Code[15])
        {
        }
        field(69187; "Year of Commence"; Date)
        {
        }
        field(69188; "Identification Document"; Option)
        {
            OptionCaption = 'Nation ID Card,Passport Card,Aliens Card,Birth Certificate,Company Reg. No,Driving License';
            OptionMembers = "Nation ID Card","Passport Card","Aliens Card","Birth Certificate","Company Reg. No","Driving License";
        }
        field(69189; "Referee Member No"; Code[15])
        {
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Referee Member No") then begin
                    "Referee Name" := Cust.Name;
                    "Referee Mobile Phone No" := Cust."Mobile Phone No";
                    "Referee ID No" := Cust."ID No.";
                end;
            end;
        }
        field(69190; "Referee Name"; Code[30])
        {
            Editable = false;
        }
        field(69191; "Referee ID No"; Code[15])
        {
            Editable = false;
        }
        field(69192; "Referee Mobile Phone No"; Code[15])
        {
            Editable = false;
        }
        field(69193; "Email Indemnified"; Boolean)
        {
        }
        field(69194; "Send E-Statements"; Boolean)
        {
        }
        field(69195; "Reason For Membership Withdraw"; Option)
        {
            OptionCaption = 'Relocation,Financial Constraints,House/Group Challages,Join another Institution,Personal Reasons,Other';
            OptionMembers = Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other;
        }
        field(69196; "Action On Dividend Earned"; Option)
        {
            OptionCaption = 'Pay to FOSA Account,Capitalize On Deposits,Repay Loans';
            OptionMembers = "Pay to FOSA Account","Capitalize On Deposits","Repay Loans";
        }
        field(69197; "Deposits Account No"; Code[15])
        {
        }
        field(69198; "Share Capital No"; Code[15])
        {
        }
        field(69199; "Benevolent Fund No"; Code[15])
        {
        }
        field(69200; "Loans Recoverd from Guarantors"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                   "Recovery Transaction Type" = filter("Guarantor Recoverd"),
                                                                   "Document No." = field("Document No. Filter"),
                                                                   "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69201; "Loan Recovered From Guarantors"; Code[15])
        {
            CalcFormula = lookup("Cust. Ledger Entry"."Recoverd Loan" where("Customer No." = field("No.")));
            FieldClass = FlowField;
        }
        field(69202; "ID Date of Issue"; Date)
        {
        }
        field(69203; "Literacy Level"; Code[10])
        {
        }
        field(69204; "Created By"; Code[20])
        {
        }
        field(69205; "Modified By"; Code[15])
        {
        }
        field(69206; "Modified On"; Date)
        {
        }
        field(69207; "Approved By"; Code[15])
        {
        }
        field(69208; "Approved On"; Date)
        {
        }
        field(69210; "Additional Shares"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter"),
                                                                   "Transaction Type" = const("Additional Shares")));
            FieldClass = FlowField;
        }
        field(69211; "FOSA Shares Account No"; Code[15])
        {
        }
        field(69212; "Additional Shares Account No"; Code[13])
        {
        }
        field(69213; "No of House Group Changes"; Integer)
        {
            CalcFormula = count("House Group Change Request" where("Member No" = field("No."),
                                                                    "Change Effected" = filter(true)));
            FieldClass = FlowField;
        }
        field(69215; "Last Contribution Entry No"; Integer)
        {
            CalcFormula = max("Cust. Ledger Entry"."Entry No." where("Customer No." = field("No."),
                                                                       "Transaction Type" = filter("Deposit Contribution"),
                                                                       Amount = filter(< 0)));
            FieldClass = FlowField;
        }
        field(69216; "House Group Status"; Option)
        {
            OptionCaption = 'Active,Exiting the Group';
            OptionMembers = Active,"Exiting the Group";
        }
        field(69217; "Member Residency Status"; Option)
        {
            Description = 'What is the customer''s residency status?';
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 ´┐¢ 1 Year,1 ´┐¢ 3 Years,Trade/Export Finance,Local Trade';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 ´┐¢ 1 Year","1 ´┐¢ 3 Years","Trade/Export Finance","Local Trade";
        }
        field(69218; "Individual Category"; Option)
        {
            Description = 'What is the customer category?';
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 ´┐¢ 1 Year,1 ´┐¢ 3 Years,Trade/Export Finance,Local Trade';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 ´┐¢ 1 Year","1 ´┐¢ 3 Years","Trade/Export Finance","Local Trade";
        }
        field(69219; Entities; Option)
        {
            Description = 'What is the Entity Type?';
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 ´┐¢ 1 Year,1 ´┐¢ 3 Years,Trade/Export Finance,Local Trade';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 ´┐¢ 1 Year","1 ´┐¢ 3 Years","Trade/Export Finance","Local Trade";
        }
        field(69220; "Industry Type"; Option)
        {
            Description = 'What Is the Industry Type?';
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 ´┐¢ 1 Year,1 ´┐¢ 3 Years,Trade/Export Finance,Local Trade';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 ´┐¢ 1 Year","1 ´┐¢ 3 Years","Trade/Export Finance","Local Trade";
        }
        field(69221; "Lenght Of Relationship"; Option)
        {
            Description = 'What Is the Lenght Of the Relationship';
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 to 1 Year,1 to 3 Years,Trade/Export Finance,Local Trade';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 ´┐¢ 1 Year","1 ´┐¢ 3 Years","Trade/Export Finance","Local Trade";
        }
        field(69222; "International Trade"; Option)
        {
            Description = 'Is the customer involved in International Trade?';
            OptionCaption = 'Politically Exposed Persons (PEPs),High Net worth,Other,Publicly Held Companies,Privately Held Companies,Domestic Government Entities,Churches,SMEs,Schools,Welfare Groups,Financial entities Regulated by local regulators,Resident,Non-Resident,Money Services Businesses,Charities and Non-Profit Organizations,Trusts,Real Estate Agencies,High Value Goods Businesses,Precious Metals Businesses,Cash Intensive Businesses,Art Galleries & related businesses,Professional Service Providers,None of the above industries,0 ´┐¢ 1 Year,1 ´┐¢ 3 Years,Trade/Export Finance,Local Trade';
            OptionMembers = "Politically Exposed Persons (PEPs)","High Net worth",Other,"Publicly Held Companies","Privately Held Companies","Domestic Government Entities",Churches,SMEs,Schools,"Welfare Groups","Financial entities Regulated by local regulators",Resident,"Non-Resident","Money Services Businesses","Charities and Non-Profit Organizations",Trusts,"Real Estate Agencies","High Value Goods Businesses","Precious Metals Businesses","Cash Intensive Businesses","Art Galleries & related businesses","Professional Service Providers","None of the above industries","0 ´┐¢ 1 Year","1 ´┐¢ 3 Years","Trade/Export Finance","Local Trade";
        }
        field(69223; "Electronic Payment"; Option)
        {
            Description = 'Does the customer engage in electronic payments?';
            OptionCaption = 'International Wire Transfers,Local Wire Transfers,Mobile Transfers,None of the Above,Fixed/Call Deposit Accounts,FOSA(KSA,Imara, MJA,Heritage),Account with Sealed Safe deposit,Account with  Open Safe Deposit,All Loan Accounts,BOSA, Ufalme,ATM Debit,Credit,Both,None,Non-face to face channels,Unsolicited Account Origination e.g. Walk-Ins,Cheque book,Others';
            OptionMembers = "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        }
        field(69224; "Accounts Type Taken"; Option)
        {
            Description = 'Which account type is the customer taking?';
            OptionCaption = 'International Wire Transfers,Local Wire Transfers,Mobile Transfers,None of the Above,Fixed/Call Deposit Accounts,FOSA(KSA,Imara, MJA,Heritage),Account with Sealed Safe deposit,Account with  Open Safe Deposit,All Loan Accounts,BOSA, Ufalme,ATM Debit,Credit,Both,None,Non-face to face channels,Unsolicited Account Origination e.g. Walk-Ins,Cheque book,Others';
            OptionMembers = "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        }
        field(69225; "Cards Type Taken"; Option)
        {
            Description = 'Which card is the customer taking?';
            OptionCaption = 'International Wire Transfers,Local Wire Transfers,Mobile Transfers,None of the Above,Fixed/Call Deposit Accounts,FOSA(KSA,Imara, MJA,Heritage),Account with Sealed Safe deposit,Account with  Open Safe Deposit,All Loan Accounts,BOSA, Ufalme,ATM Debit,Credit,Both,None,Non-face to face channels,Unsolicited Account Origination e.g. Walk-Ins,Cheque book,Others';
            OptionMembers = "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        }
        field(69226; "Others(Channels)"; Option)
        {
            Description = 'Which products or channels is the customer taking?';
            OptionCaption = 'International Wire Transfers,Local Wire Transfers,Mobile Transfers,None of the Above,Fixed/Call Deposit Accounts,FOSA(KSA,Imara, MJA,Heritage),Account with Sealed Safe deposit,Account with  Open Safe Deposit,All Loan Accounts,BOSA, Ufalme,ATM Debit,Credit,Both,None,Non-face to face channels,Unsolicited Account Origination e.g. Walk-Ins,Cheque book,Others';
            OptionMembers = "International Wire Transfers","Local Wire Transfers","Mobile Transfers","None of the Above","Fixed/Call Deposit Accounts","FOSA(KSA",Imara," MJA","Heritage)","Account with Sealed Safe deposit","Account with  Open Safe Deposit","All Loan Accounts",BOSA," Ufalme","ATM Debit",Credit,Both,"None","Non-face to face channels","Unsolicited Account Origination e.g. Walk-Ins","Cheque book",Others;
        }
        field(69227; "No of BD Trainings Attended"; Integer)
        {
            CalcFormula = count("CRM Traineees" where("Member No" = field("No."),
                                                       Attended = filter(true)));
            FieldClass = FlowField;
        }
        field(69228; "Member Needs House Group"; Boolean)
        {
        }
        field(69229; "Old Payrol Number"; Code[18])
        {
        }
        field(69230; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69231; Password; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(69232; "Password Reset Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(69233; "FOSA Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69234; "Captital Reserve"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Customer No." = field("No."),
                                                                   "Transaction Type" = filter("Capital Reserve"),
                                                                   "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(69235; colleges; Code[2])
        {
            DataClassification = ToBeClassified;
            TableRelation = "College List".Code;
        }
        field(69236; "Retirement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69237; Dioces; Code[1])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Dioces := Memb."Member Dioces";
            end;
        }
        field(69238; "Arch Dioces"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Arch Dioces" := Memb."Member Arch Dioces";
            end;
        }
        field(69239; "First Name"; Text[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "First Name" := Memb."First Name";
            end;
        }
        field(69240; Commission; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Transaction Type" = filter(Commission),
                                                                   "Customer No." = field("No."),
                                                                   "Transaction Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            FieldClass = FlowField;
        }
        field(69241; "Commission Paid"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69242; "Children Savings"; Decimal)
        {
            CalcFormula = - sum("Cust. Ledger Entry".Amount where("Transaction Type" = filter(Children),
                                                                   "Customer No." = field("No."),
                                                                   "Transaction Date" = field("Date Filter"),
                                                                   "Document No." = field("Document No. Filter")));
            FieldClass = FlowField;
        }
        field(69243; "Reg Fee Paid"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69244; "Reg Fee Paid."; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(69245; ELoanApplicationNotAllowed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Name")
        {
        }
        key(Key3; "Customer Posting Group")
        {
        }
        key(Key4; "Currency Code")
        {
        }
        key(Key5; "Country/Region Code")
        {
        }
        key(Key6; "Gen. Bus. Posting Group")
        {
        }
        key(Key7; Name, Address, City)
        {
        }
        key(Key8; "VAT Registration No.")
        {
            Enabled = false;
        }
        key(Key9; Name)
        {
        }
        key(Key10; City)
        {
        }
        key(Key11; "Post Code")
        {
        }
        key(Key12; "Phone No.")
        {
        }
        key(Key13; Contact)
        {
        }
        key(Key14; "Employer Code")
        {
        }
        key(Key15; "Personal No", "Customer Type")
        {
        }
        key(Key16; "Personal No")
        {
        }
        key(Key17; "ID No.")
        {
        }
        key(Key18; "Mobile Phone No")
        {
        }
        key(Key19; "FOSA Account No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Name, "Personal No", "ID No.", "Mobile Phone No")
        {
        }
    }

    trigger OnDelete()
    var
        CampaignTargetGr: Record "Campaign Target Group";
        ContactBusRel: Record "Contact Business Relation";
        Job: Record Job;
        CreditCards: Record "Service Item";
        CampaignTargetGrMgmt: Codeunit "Campaign Target Group Mgt";
        StdCustSalesCode: Record "Standard Customer Sales Code";
    begin
        //CreditCards.DeleteByCustomer(Rec);

        ServiceItem.SetRange("Customer No.", "No.");
        if ServiceItem.Find('-') then
            if Confirm(
                 Text008,
                 false,
                 TableCaption,
                 "No.",
                 ServiceItem.FieldCaption("Customer No."))
            then
                ServiceItem.ModifyAll("Customer No.", '')
            else
                Error(Text009);

        Job.SetRange("Bill-to Customer No.", "No.");
        if Job.Find('-') then
            Error(Text015, TableCaption, "No.", Job.TableCaption);

        //MoveEntries.MoveMembEntries(Rec);

        CommentLine.SetRange("Table Name", CommentLine."table name"::Customer);
        CommentLine.SetRange("No.", "No.");
        CommentLine.DeleteAll;

        CustBankAcc.SetRange("Customer No.", "No.");
        CustBankAcc.DeleteAll;

        ShipToAddr.SetRange("Customer No.", "No.");
        ShipToAddr.DeleteAll;

        SalesPrice.SetRange("Sales Type", SalesPrice."sales type"::Customer);
        SalesPrice.SetRange("Sales Code", "No.");
        SalesPrice.DeleteAll;

        SalesLineDisc.SetRange("Sales Type", SalesLineDisc."sales type"::Customer);
        SalesLineDisc.SetRange("Sales Code", "No.");
        SalesLineDisc.DeleteAll;

        SalesPrepmtPct.SetCurrentkey("Sales Type", "Sales Code");
        SalesPrepmtPct.SetRange("Sales Type", SalesPrepmtPct."sales type"::Customer);
        SalesPrepmtPct.SetRange("Sales Code", "No.");
        SalesPrepmtPct.DeleteAll;

        StdCustSalesCode.SetRange("Customer No.", "No.");
        StdCustSalesCode.DeleteAll(true);

        ItemCrossReference.SetCurrentkey("Cross-Reference Type", "Cross-Reference Type No.");
        ItemCrossReference.SetRange("Cross-Reference Type", ItemCrossReference."cross-reference type"::Customer);
        ItemCrossReference.SetRange("Cross-Reference Type No.", "No.");
        ItemCrossReference.DeleteAll;

        SalesOrderLine.SetCurrentkey("Document Type", "Bill-to Customer No.");
        SalesOrderLine.SetFilter(
          "Document Type", '%1|%2',
          SalesOrderLine."document type"::Order,
          SalesOrderLine."document type"::"Return Order");
        SalesOrderLine.SetRange("Bill-to Customer No.", "No.");
        if SalesOrderLine.Find('-') then
            Error(
              Text000,
              TableCaption, "No.", SalesOrderLine."Document Type");

        SalesOrderLine.SetRange("Bill-to Customer No.");
        SalesOrderLine.SetRange("Sell-to Customer No.", "No.");
        if SalesOrderLine.Find('-') then
            Error(
              Text000,
              TableCaption, "No.", SalesOrderLine."Document Type");

        //CampaignTargetGr.SETRANGE("No.",Rec."No.");
        //CampaignTargetGr.SETRANGE(Type,CampaignTargetGr.Type::Customer);
        //IF CampaignTargetGr.FIND('-') THEN BEGIN
        //  ContactBusRel.SETRANGE("Link to Table",ContactBusRel."Link to Table"::Customer);
        //  ContactBusRel.SETRANGE("No.",Rec."No.");
        //  ContactBusRel.FIND('-');
        //  REPEAT
        //    CampaignTargetGrMgmt.ConverttoContact(Rec,ContactBusRel."Contact No.");
        //  UNTIL CampaignTargetGr.NEXT = 0;
        //END;

        ServContract.SetFilter(Status, '<>%1', ServContract.Status::Canceled);
        ServContract.SetRange("Customer No.", "No.");
        if ServContract.Find('-') then
            Error(
              Text007,
              TableCaption, "No.");

        ServContract.SetRange(Status);
        ServContract.ModifyAll("Customer No.", '');

        ServContract.SetFilter(Status, '<>%1', ServContract.Status::Canceled);
        ServContract.SetRange("Bill-to Customer No.", "No.");
        if ServContract.Find('-') then
            Error(
              Text007,
              TableCaption, "No.");

        ServContract.SetRange(Status);
        ServContract.ModifyAll("Bill-to Customer No.", '');

        ServHeader.SetCurrentkey("Customer No.", "Order Date");
        ServHeader.SetRange("Customer No.", "No.");
        if ServHeader.Find('-') then
            Error(
              Text013,
              TableCaption, "No.", ServHeader."Document Type");

        ServHeader.SetRange("Bill-to Customer No.");
        if ServHeader.Find('-') then
            Error(
              Text013,
              TableCaption, "No.", ServHeader."Document Type");

        //UpdateContFromCust.OnDelete(Rec);

        DimMgt.DeleteDefaultDim(Database::Customer, "No.");

        //MobSalesmgt.CustOnDelete(Rec);
        CalcFields("Current Shares", "Shares Retained");
        if ("Current Shares" * -1 > 0) or ("Shares Retained" * -1 > 0) then
            Error(Text001);
    end;

    trigger OnInsert()
    begin
        /*
        IF "No." = '' THEN BEGIN
          SalesSetup.GET;
          SalesSetup.TESTFIELD(SalesSetup."Members Nos");
          NoSeriesMgt.InitSeries(SalesSetup."Members Nos",xRec."No. Series",0D,"No.","No. Series");
        END;
           */

    end;

    trigger OnModify()
    begin
        /*
        "Last Date Modified" := TODAY;
        
        IF (Name <> xRec.Name) OR
           ("Search Name" <> xRec."Search Name") OR
           ("Name 2" <> xRec."Name 2") OR
           (Address <> xRec.Address) OR
           ("Address 2" <> xRec."Address 2") OR
           (City <> xRec.City) OR
           ("Phone No." <> xRec."Phone No.") OR
           ("Telex No." <> xRec."Telex No.") OR
           ("Territory Code" <> xRec."Territory Code") OR
           ("Currency Code" <> xRec."Currency Code") OR
           ("Language Code" <> xRec."Language Code") OR
           ("Salesperson Code" <> xRec."Salesperson Code") OR
           ("Country/Region Code" <> xRec."Country/Region Code") OR
           ("Fax No." <> xRec."Fax No.") OR
           ("Telex Answer Back" <> xRec."Telex Answer Back") OR
           ("VAT Registration No." <> xRec."VAT Registration No.") OR
           ("Post Code" <> xRec."Post Code") OR
           (County <> xRec.County) OR
           ("E-Mail" <> xRec."E-Mail") OR
           ("Home Page" <> xRec."Home Page") OR
           (Contact <> xRec.Contact)
        THEN BEGIN
          MODIFY;
          //UpdateContFromCust.OnModify(Rec);
        END;
             */

    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
        CalcFields("Current Shares", "Shares Retained");
    end;

    var
        Text000: label 'You cannot delete %1 %2 because there is at least one outstanding Sales %3 for this customer.';
        Text002: label 'Do you wish to create a contact for %1 %2?';
        SalesSetup: Record "Sacco No. Series";
        CommentLine: Record "Comment Line";
        SalesOrderLine: Record "Sales Line";
        CustBankAcc: Record "Customer Bank Account";
        ShipToAddr: Record "Ship-to Address";
        PostCode: Record "Post Code";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        ShippingAgentService: Record "Shipping Agent Services";
        ItemCrossReference: Record "Item Cross Reference";
        RMSetup: Record "Marketing Setup";
        SalesPrice: Record "Sales Price";
        SalesLineDisc: Record "Sales Line Discount";
        SalesPrepmtPct: Record "Sales Prepayment %";
        ServContract: Record "Service Contract Header";
        ServHeader: Record "Service Header";
        ServiceItem: Record "Service Item";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MoveEntries: Codeunit MoveEntries;
        UpdateContFromCust: Codeunit "CustCont-Update";
        DimMgt: Codeunit DimensionManagement;
        InsertFromContact: Boolean;
        Text003: label 'Contact %1 %2 is not related to customer %3 %4.';
        Text004: label 'post';
        Text005: label 'create';
        Text006: label 'You cannot %1 this type of document when Customer %2 is blocked with type %3';
        Text007: label 'You cannot delete %1 %2 because there is at least one not cancelled Service Contract for this customer.';
        Text008: label 'Deleting the %1 %2 will cause the %3 to be deleted for the associated Service Items. Do you want to continue?';
        Text009: label 'Cannot delete customer.';
        Text010: label 'The %1 %2 has been assigned to %3 %4.\The same %1 cannot be entered on more than one %3. Enter another code.';
        Text011: label 'Reconciling IC transactions may be difficult if you change IC Partner Code because this %1 has ledger entries in a fiscal year that has not yet been closed.\ Do you still want to change the IC Partner Code?';
        Text012: label 'You cannot change the contents of the %1 field because this %2 has one or more open ledger entries.';
        Text013: label 'You cannot delete %1 %2 because there is at least one outstanding Service %3 for this customer.';
        Text014: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text015: label 'You cannot delete %1 %2 because there is at least one %3 associated to this customer.';
        Loans: Record "Loans Register";
        GenSetUp: Record "Sacco General Set-Up";
        MinShares: Decimal;
        MovementTracker: Record "Movement Tracker";
        Cust: Record "Member Register";
        Vend: Record Vendor;
        CustFosa: Code[20];
        Vend2: Record Vendor;
        FOSAAccount: Record Vendor;
        StatusPermissions: Record "Status Change Permision";
        RefundsR: Record Refunds;
        Text001: label 'You cannot delete %1 %2 because there is at least one transaction %3 for this customer.';
        Approvalsetup: Record "Approvals Set Up";
        DataSheet: Record "Data Sheet Main";
        Employer: Record "Sacco Employers";
        Parishes: Record "Member's Parishes";
        SurestepFactory: Codeunit "SURESTEP Factory.";
        ObjCellGroup: Record "Member House Groups";
        CDays: Integer;
        EMaturity: Date;
        i: Integer;
        Memb: Record "Membership Applications";


    procedure TestNoEntriesExist(CurrentFieldName: Text[100]; GLNO: Code[20])
    var
        MemberLedgEntry: Record "Cust. Ledger Entry";
    begin
        //To prevent change of field
        MemberLedgEntry.SetCurrentkey(MemberLedgEntry."Customer No.");
        MemberLedgEntry.SetRange(MemberLedgEntry."Customer No.", "No.");
        if MemberLedgEntry.Find('-') then
            Error(
            Text000,
             CurrentFieldName);
    end;


    procedure AssistEdit(OldCust: Record "Member Register"): Boolean
    var
        Cust: Record "Member Register";
    begin
        with Cust do begin
            Cust := Rec;
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Members Nos");
            if NoSeriesMgt.SelectSeries(SalesSetup."Members Nos", OldCust."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := Cust;
                exit(true);
            end;
        end;
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::Customer, "No.", FieldNumber, ShortcutDimCode);
        Modify;
    end;


    procedure ShowContact()
    var
        ContBusRel: Record "Contact Business Relation";
        Cont: Record Contact;
    begin
        if "No." = '' then
            exit;

        ContBusRel.SetCurrentkey("Link to Table", "No.");
        ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Customer);
        ContBusRel.SetRange("No.", "No.");
        if not ContBusRel.FindFirst then begin
            if not Confirm(Text002, false, TableCaption, "No.") then
                exit;
            //UpdateContFromCust.InsertNewContactMemb(Rec,FALSE);
            ContBusRel.FindFirst;
        end;
        Commit;

        Cont.SetCurrentkey("Company Name", "Company No.", Type, Name);
        Cont.SetRange("Company No.", ContBusRel."Contact No.");
        Page.Run(Page::"Contact List", Cont);
    end;


    procedure SetInsertFromContact(FromContact: Boolean)
    begin
        InsertFromContact := FromContact;
    end;


    procedure CheckBlockedMembOnDocs(Cust2: Record "Member Register"; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; Shipment: Boolean; Transaction: Boolean)
    begin
        with Cust2 do begin
            if ((Blocked = Blocked::All) or
                ((Blocked = Blocked::Invoice) and (DocType in [Doctype::Quote, Doctype::Order, Doctype::Invoice, Doctype::"Blanket Order"])) or
                ((Blocked = Blocked::Ship) and (DocType in [Doctype::Quote, Doctype::Order, Doctype::"Blanket Order"]) and
                 (not Transaction)) or
                ((Blocked = Blocked::Ship) and (DocType in [Doctype::Quote, Doctype::Order, Doctype::Invoice, Doctype::"Blanket Order"]) and
                 Shipment and Transaction))
            then
                CustBlockedErrorMessage(Cust2, Transaction);
        end;
    end;


    procedure CheckBlockedMembOnJnls(Cust2: Record "Member Register"; DocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund; Transaction: Boolean)
    begin
        with Cust2 do begin
            if (Blocked = Blocked::All) or
               ((Blocked = Blocked::Invoice) and (DocType in [Doctype::Invoice, Doctype::" "]))
            then
                CustBlockedErrorMessage(Cust2, Transaction)
        end;
    end;


    procedure CheckBlockedCustOnJnls(Cust2: Record "Member Register"; DocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge",Reminder,Refund; Transaction: Boolean)
    begin
        with Cust2 do begin
            if (Blocked = Blocked::All) or
               ((Blocked = Blocked::Invoice) and (DocType in [Doctype::Invoice, Doctype::" "]))
            then
                CustBlockedErrorMessage(Cust2, Transaction)
        end;
    end;


    procedure CustBlockedErrorMessage(Cust2: Record "Member Register"; Transaction: Boolean)
    var
        "Action": Text[30];
    begin
        if Transaction then
            Action := Text004
        else
            Action := Text005;
        Error(Text006, Action, Cust2."No.", Cust2.Blocked);
    end;


    procedure DisplayMap()
    var
        MapPoint: Record "Online Map Setup";
        MapMgt: Codeunit "Online Map Management";
    begin
        if MapPoint.FindFirst then
            MapMgt.MakeSelection(Database::Customer, GetPosition)
        else
            Message(Text014);
    end;


    procedure GetTotalAmountLCY(): Decimal
    begin
        CalcFields("Balance (LCY)", "Outstanding Orders (LCY)", "Shipped Not Invoiced (LCY)", "Outstanding Invoices (LCY)",
          "Outstanding Serv. Orders (LCY)", "Serv Shipped Not Invoiced(LCY)", "Outstanding Serv.Invoices(LCY)");

        exit(GetTotalAmountLCYCommon);
    end;


    procedure GetTotalAmountLCYUI(): Decimal
    begin
        SetAutocalcFields("Balance (LCY)", "Outstanding Orders (LCY)", "Shipped Not Invoiced (LCY)", "Outstanding Invoices (LCY)",
          "Outstanding Serv. Orders (LCY)", "Serv Shipped Not Invoiced(LCY)", "Outstanding Serv.Invoices(LCY)");

        exit(GetTotalAmountLCYCommon);
    end;

    local procedure GetTotalAmountLCYCommon(): Decimal
    var
        SalesLine: Record "Sales Line";
        ServiceLine: Record "Service Line";
        SalesOutstandingAmountFromShipment: Decimal;
        ServOutstandingAmountFromShipment: Decimal;
        InvoicedPrepmtAmountLCY: Decimal;
    begin
        SalesOutstandingAmountFromShipment := SalesLine.OutstandingInvoiceAmountFromShipment("No.");
        ServOutstandingAmountFromShipment := ServiceLine.OutstandingInvoiceAmountFromShipment("No.");
        InvoicedPrepmtAmountLCY := GetInvoicedPrepmtAmountLCY;

        exit("Balance (LCY)" + "Outstanding Orders (LCY)" + "Shipped Not Invoiced (LCY)" + "Outstanding Invoices (LCY)" +
          "Outstanding Serv. Orders (LCY)" + "Serv Shipped Not Invoiced(LCY)" + "Outstanding Serv.Invoices(LCY)" -
          SalesOutstandingAmountFromShipment - ServOutstandingAmountFromShipment - InvoicedPrepmtAmountLCY);
    end;


    procedure GetSalesLCY(): Decimal
    var
        CustomerSalesYTD: Record "Member Register";
        AccountingPeriod: Record "Accounting Period";
        StartDate: Date;
        EndDate: Date;
    begin
        StartDate := AccountingPeriod.GetFiscalYearStartDate(WorkDate);
        EndDate := AccountingPeriod.GetFiscalYearEndDate(WorkDate);
        CustomerSalesYTD := Rec;
        CustomerSalesYTD."SECURITYFILTERING"("SECURITYFILTERING");
        CustomerSalesYTD.SetRange("Date Filter", StartDate, EndDate);
        CustomerSalesYTD.CalcFields("Sales (LCY)");
        exit(CustomerSalesYTD."Sales (LCY)");
    end;


    procedure CalcAvailableCredit(): Decimal
    begin
        exit(CalcAvailableCreditCommon(false));
    end;


    procedure CalcAvailableCreditUI(): Decimal
    begin
        exit(CalcAvailableCreditCommon(true));
    end;

    local procedure CalcAvailableCreditCommon(CalledFromUI: Boolean): Decimal
    begin
        if "Credit Limit (LCY)" = 0 then
            exit(0);
        if CalledFromUI then
            exit("Credit Limit (LCY)" - GetTotalAmountLCYUI);
        exit("Credit Limit (LCY)" - GetTotalAmountLCY);
    end;


    procedure CalcOverdueBalance() OverDueBalance: Decimal
    var
        [SecurityFiltering(Securityfilter::Filtered)]
        CustLedgEntryRemainAmtQuery: Query "Cust. Ledg. Entry Remain. Amt.";
    begin
        CustLedgEntryRemainAmtQuery.SetRange(Customer_No, "No.");
        CustLedgEntryRemainAmtQuery.SetRange(IsOpen, true);
        CustLedgEntryRemainAmtQuery.SetFilter(Due_Date, '<%1', WorkDate);
        CustLedgEntryRemainAmtQuery.Open;

        if CustLedgEntryRemainAmtQuery.Read then
            OverDueBalance := CustLedgEntryRemainAmtQuery.Sum_Remaining_Amt_LCY;
    end;


    procedure ValidateRFCNo(Length: Integer)
    begin

        /*
        IF STRLEN("RFC No.") <> Length THEN
          ERROR(Text10000,"RFC No.");
        */

    end;


    procedure GetLegalEntityType(): Text
    begin
        //EXIT(FORMAT("Tax Identification Type"));
    end;


    procedure GetLegalEntityTypeLbl(): Text
    begin
        //EXIT(FIELDCAPTION("Tax Identification Type"));
    end;


    procedure SetStyle(): Text
    begin
        if CalcAvailableCredit < 0 then
            exit('Unfavorable');
        exit('');
    end;


    procedure HasValidDDMandate(Date: Date): Boolean
    var
        SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
    begin
        exit(SEPADirectDebitMandate.GetDefaultMandate("No.", Date) <> '');
    end;


    procedure GetInvoicedPrepmtAmountLCY(): Decimal
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetCurrentkey("Document Type", "Bill-to Customer No.");
        SalesLine.SetRange("Document Type", SalesLine."document type"::Order);
        SalesLine.SetRange("Bill-to Customer No.", "No.");
        SalesLine.CalcSums("Prepmt. Amount Inv. (LCY)", "Prepmt. VAT Amount Inv. (LCY)");
        exit(SalesLine."Prepmt. Amount Inv. (LCY)" + SalesLine."Prepmt. VAT Amount Inv. (LCY)");
    end;


    procedure CalcCreditLimitLCYExpendedPct(): Decimal
    begin
        if "Credit Limit (LCY)" = 0 then
            exit(0);

        if "Balance (LCY)" / "Credit Limit (LCY)" < 0 then
            exit(0);

        if "Balance (LCY)" / "Credit Limit (LCY)" > 1 then
            exit(10000);

        exit(ROUND("Balance (LCY)" / "Credit Limit (LCY)" * 10000, 1));
    end;


    procedure CreateAndShowNewInvoice()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader."Document Type" := SalesHeader."document type"::Invoice;
        SalesHeader.SetRange("Sell-to Customer No.", "No.");
        SalesHeader.Insert(true);
        Commit;
        Page.RunModal(Page::Page1304, SalesHeader)
    end;


    procedure CreateAndShowNewCreditMemo()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader."Document Type" := SalesHeader."document type"::"Credit Memo";
        SalesHeader.SetRange("Sell-to Customer No.", "No.");
        SalesHeader.Insert(true);
        Commit;
        Page.RunModal(Page::Page1319, SalesHeader)
    end;


    procedure CreateAndShowNewQuote()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader."Document Type" := SalesHeader."document type"::Quote;
        SalesHeader.SetRange("Sell-to Customer No.", "No.");
        SalesHeader.Insert(true);
        Commit;
        Page.RunModal(Page::Page1324, SalesHeader)
    end;

    local procedure UpdatePaymentTolerance(UseDialog: Boolean)
    begin
        /*
        IF "Block Payment Tolerance" THEN BEGIN
          IF UseDialog THEN
            IF NOT CONFIRM(RemovePaymentRoleranceQst,FALSE) THEN
              EXIT;
          PaymentToleranceMgt.DelTolCustLedgEntry(Rec);
        END ELSE BEGIN
          IF UseDialog THEN
            IF NOT CONFIRM(AllowPaymentToleranceQst,FALSE) THEN
              EXIT;
          PaymentToleranceMgt.CalcTolCustLedgEntry(Rec);
        END;
        */

    end;


    procedure GetBillToCustomerNo(): Code[20]
    begin
        if "Bill-to Customer No." <> '' then
            exit("Bill-to Customer No.");
        exit("No.");
    end;
}

