#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516054 "Job-Planning Line"
{
    Caption = 'Job Planning Line';
    DrillDownPageID = UnknownPage53955;
    LookupPageID = UnknownPage53955;
    PasteIsValid = false;
    Permissions = TableData UnknownTableData54351=rimd;

    fields
    {
        field(1;"Line No.";Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(2;"Grant No.";Code[50])
        {
            Caption = 'Grant No.';
            Editable = false;
            TableRelation = Jobs;
        }
        field(3;"Planning Date";Date)
        {
            Caption = 'Planning Date';

            trigger OnValidate()
            begin
                Validate("Document Date","Planning Date");
                if ("Currency Date" = 0D) or ("Currency Date" = xRec."Planning Date") then
                  Validate("Currency Date","Planning Date");
                if (Type <> Type::Text) and ("No." <> '') then
                  UpdateAllAmounts;
            end;
        }
        field(4;"Document No.";Code[20])
        {
            Caption = 'Document No.';
        }
        field(5;Type;Option)
        {
            Caption = 'Type';
            OptionCaption = 'Resource,Item,G/L Account,Text';
            OptionMembers = Resource,Item,"G/L Account",Text;

            trigger OnValidate()
            begin
                Validate("No.",'');
                if Type = Type::Item then begin
                  GetLocation("Location Code");
                  Location.TestField("Directed Put-away and Pick",false);
                end;
            end;
        }
        field(7;"No.";Code[20])
        {
            Caption = 'Expense Account';
            TableRelation = if (Type=const(Resource)) Resource else if (Type=const(Item)) Item else if (Type=const("G/L Account")) "G/L Account" where ("Donor defined Account"=filter(true)) else if (Type=const(Text)) "Standard Text";

            trigger OnValidate()
            begin
                if ("No." = '') or ("No." <> xRec."No.") then begin
                  Description := '';
                  "Unit of Measure Code" := '';
                  "Qty. per Unit of Measure" := 1;
                  "Variant Code" := '';
                  "Work Type Code" := '';
                  "Gen. Bus. Posting Group" := '';
                  "Gen. Prod. Posting Group" := '';
                  DeleteAmounts;
                  "Cost Factor" := 0;
                  CheckedAvailability := false;
                  if "No." <> '' then begin
                    // Preserve quantities after resetting all amounts:
                    Quantity := xRec.Quantity;
                    "Quantity (Base)" := xRec."Quantity (Base)";
                  end else
                    exit;
                end;

                GetJob;
                "Customer Price Group" := Job."Customer Price Group";

                case Type of
                  Type::Resource:
                    begin
                      Res.Get("No.");
                      Res.TestField(Blocked,false);
                      GetCostAllocation;
                      Quantity:=1;
                      Description := Res.Name;
                      "Description 2" := Res."Name 2";
                      "Gen. Prod. Posting Group" := Res."Gen. Prod. Posting Group";
                      "Resource Group No." := Res."Resource Group No.";
                      //VALIDATE("Unit of Measure Code",Res."Base Unit of Measure");
                       exit;
                    end;
                  Type::Item:
                    begin
                      GetItem;
                      Item.TestField(Blocked,false);
                      Description := Item.Description;
                      "Description 2" := Item."Description 2";
                      if Job."Language Code" <> '' then
                        GetItemTranslation;
                      "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                      Validate("Unit of Measure Code",Item."Base Unit of Measure");
                    end;
                  Type::"G/L Account":
                    begin
                      GLAcc.Get("No.");
                      GLAcc.CheckGLAcc;
                      GLAcc.TestField("Direct Posting",true);
                      Description := GLAcc.Name;
                      "Gen. Bus. Posting Group" := GLAcc."Gen. Bus. Posting Group";
                      "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
                      "Unit of Measure Code" := '';
                      "Direct Unit Cost (LCY)" := 0;
                      "Unit Cost (LCY)" := 0;
                      "Unit Price" := 0;
                    end;
                  Type::Text:
                    begin
                      StdTxt.Get("No.");
                      Description := StdTxt.Description;
                    end;
                end;

                if Type <> Type::Text then
                  Validate(Quantity);
            end;
        }
        field(8;Description;Text[50])
        {
            Caption = 'Description';
        }
        field(9;Quantity;Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0:5;

            trigger OnValidate()
            begin

                case Type of
                  Type::Item:
                    begin
                      if not Item.Get("No.") then
                        Error(Text004,Type,Item.FieldCaption("No."));
                      CheckItemAvailable;
                    end;
                  Type::Resource:
                    if not Res.Get("No.") then
                      Error(Text004,Type,Res.FieldCaption("No."));
                  Type::"G/L Account":
                    if not GLAcc.Get("No.") then
                      Error(Text004,Type,GLAcc.FieldCaption("No."));

                end;

                "Quantity (Base)" := CalcBaseQty(Quantity);
                UpdateAllAmounts;
            end;
        }
        field(11;"Direct Unit Cost (LCY)";Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost (LCY)';
        }
        field(12;"Unit Cost (LCY)";Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                if (Type = Type::Item) and
                   Item.Get("No.") and
                   (Item."Costing Method" = Item."costing method"::Standard) then
                  UpdateAllAmounts
                else begin
                  GetJob;
                  "Unit Cost" := ROUND(
                      CurrExchRate.ExchangeAmtLCYToFCY(
                        "Currency Date","Currency Code",
                        "Unit Cost (LCY)","Currency Factor"),
                      UnitAmountRoundingPrecision);
                  UpdateAllAmounts;
                end;
                TestField("Unit Cost (LCY)");
            end;
        }
        field(13;"Total Cost (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Cost (LCY)';
            Editable = false;
        }
        field(14;"Unit Price (LCY)";Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price (LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                GetJob;
                "Unit Price" := ROUND(
                    CurrExchRate.ExchangeAmtLCYToFCY(
                      "Currency Date","Currency Code",
                      "Unit Price (LCY)","Currency Factor"),
                    UnitAmountRoundingPrecision);
                UpdateAllAmounts;
            end;
        }
        field(15;"Total Price (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price (LCY)';
            Editable = false;
        }
        field(16;"Resource Group No.";Code[20])
        {
            Caption = 'Resource Group No.';
            Editable = false;
            TableRelation = "Resource Group";
        }
        field(17;"Unit of Measure Code";Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = if (Type=const(Item)) "Item Unit of Measure".Code where ("Item No."=field("No.")) else if (Type=const(Resource)) "Resource Unit of Measure".Code where ("Resource No."=field("No.")) else "Unit of Measure";

            trigger OnValidate()
            var
                Resource: Record Resource;
            begin
                GetGLSetup;
                case Type of
                  Type::Item:
                    begin
                      Item.Get("No.");
                      "Qty. per Unit of Measure" :=
                        UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
                    end;


                  Type::Resource:
                    begin
                      if CurrFieldNo <> FieldNo("Work Type Code") then
                        if "Work Type Code" <> '' then begin
                          WorkType.Get("Work Type Code");
                          if WorkType."Unit of Measure Code" <> '' then
                            TestField("Unit of Measure Code",WorkType."Unit of Measure Code");
                        end else TestField("Work Type Code",'');
                      if "Unit of Measure Code" = '' then begin
                        Resource.Get("No.");
                        "Unit of Measure Code" := Resource."Base Unit of Measure";
                      end;
                      ResUnitofMeasure.Get("No.","Unit of Measure Code");
                      "Qty. per Unit of Measure" := ResUnitofMeasure."Qty. per Unit of Measure";
                      "Quantity (Base)" := Quantity * "Qty. per Unit of Measure";
                    end;

                  Type::"G/L Account":
                    begin
                      "Qty. per Unit of Measure" := 1;
                    end;
                end;
                Validate(Quantity);
            end;
        }
        field(20;"Location Code";Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where ("Use As In-Transit"=const(false));

            trigger OnValidate()
            begin
                "Bin Code" := '';
                if Type = Type::Item then begin
                  GetLocation("Location Code");
                  Location.TestField("Directed Put-away and Pick",false);
                  Validate(Quantity);
                end;
            end;
        }
        field(29;"Last Date Modified";Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(30;"User ID";Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(32;"Work Type Code";Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";

            trigger OnValidate()
            begin
                TestField(Type,Type::Resource);
                Validate("Line Discount %",0);
                if (Rec."Work Type Code" = '') and (xRec."Work Type Code" <> '') then begin
                  Res.Get("No.");
                  "Unit of Measure Code" := Res."Base Unit of Measure";
                  Validate("Unit of Measure Code");
                end;
                if WorkType.Get("Work Type Code") then begin
                  if WorkType."Unit of Measure Code" <> '' then begin
                    "Unit of Measure Code" := WorkType."Unit of Measure Code";
                    if ResUnitofMeasure.Get("No.","Unit of Measure Code") then
                      "Qty. per Unit of Measure" := ResUnitofMeasure."Qty. per Unit of Measure";
                  end else begin
                    Res.Get("No.");
                    "Unit of Measure Code" := Res."Base Unit of Measure";
                    Validate("Unit of Measure Code");
                  end;
                end;
                Validate(Quantity);
            end;
        }
        field(33;"Customer Price Group";Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";

            trigger OnValidate()
            begin
                if (Type = Type::Item) and ("No." <> '') then begin
                  UpdateAllAmounts;
                end;
            end;
        }
        field(60;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(61;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(79;"Country/Region Code";Code[10])
        {
            Caption = 'Country/Region Code';
            Editable = false;
            TableRelation = "Country/Region";
        }
        field(80;"Gen. Bus. Posting Group";Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            Editable = false;
            TableRelation = "Gen. Business Posting Group";
        }
        field(81;"Gen. Prod. Posting Group";Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            Editable = false;
            TableRelation = "Gen. Product Posting Group";
        }
        field(83;"Document Date";Date)
        {
            Caption = 'Document Date';
        }
        field(1000;"Grant Task No.";Code[20])
        {
            Caption = 'Job Task No.';
            Editable = false;
            TableRelation = "Job-Task"."Grant Task No." where ("Grant No."=field("Grant No."));
        }
        field(1001;"Line Amount (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Amount (LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                GetJob;
                "Line Amount" := ROUND(
                    CurrExchRate.ExchangeAmtLCYToFCY(
                      "Currency Date","Currency Code",
                      "Line Amount (LCY)","Currency Factor"),
                    AmountRoundingPrecision);
                UpdateAllAmounts;
            end;
        }
        field(1002;"Unit Cost";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';

            trigger OnValidate()
            begin
                UpdateAllAmounts;
                //Check if unit cost is less than zero
                if ("Unit Cost"<=0) then
                Error('Unit Cost should not be less than 0');
                // END
            end;
        }
        field(1003;"Total Cost";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Total Cost';
            Editable = false;
        }
        field(1004;"Unit Price";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price';

            trigger OnValidate()
            begin
                UpdateAllAmounts;
            end;
        }
        field(1005;"Total Price";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Total Price';
            Editable = false;
        }
        field(1006;"Line Amount";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Amount';

            trigger OnValidate()
            begin
                UpdateAllAmounts;
            end;
        }
        field(1007;"Line Discount Amount";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';

            trigger OnValidate()
            begin
                UpdateAllAmounts;
            end;
        }
        field(1008;"Line Discount Amount (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Discount Amount (LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                GetJob;
                "Line Discount Amount" := ROUND(
                    CurrExchRate.ExchangeAmtLCYToFCY(
                      "Currency Date","Currency Code",
                      "Line Discount Amount (LCY)","Currency Factor"),
                    AmountRoundingPrecision);
                UpdateAllAmounts;
            end;
        }
        field(1015;"Cost Factor";Decimal)
        {
            Caption = 'Cost Factor';
            Editable = false;

            trigger OnValidate()
            begin
                UpdateAllAmounts;
            end;
        }
        field(1019;"Serial No.";Code[20])
        {
            Caption = 'Serial No.';
            Editable = false;
        }
        field(1020;"Lot No.";Code[20])
        {
            Caption = 'Lot No.';
            Editable = false;
        }
        field(1021;"Line Discount %";Decimal)
        {
            BlankZero = true;
            Caption = 'Line Discount %';

            trigger OnValidate()
            begin
                UpdateAllAmounts;
            end;
        }
        field(1022;"Line Type";Option)
        {
            Caption = 'Line Type';
            OptionCaption = 'Schedule,Contract,Both Schedule and Contract';
            OptionMembers = Schedule,Contract,"Both Schedule and Contract";

            trigger OnValidate()
            begin
                "Schedule Line" := true;
                "Contract Line" := true;
                if "Line Type" = "line type"::Schedule then
                  "Contract Line" := false;
                if "Line Type" = "line type"::Contract then
                  "Schedule Line" := false;
            end;
        }
        field(1023;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                UpdateCurrencyFactor;
                UpdateAllAmounts;
            end;
        }
        field(1024;"Currency Date";Date)
        {
            Caption = 'Currency Date';

            trigger OnValidate()
            begin
                UpdateCurrencyFactor;
                if (CurrFieldNo <> FieldNo("Planning Date")) and ("No." <> '') then
                  UpdateFromCurrency;
            end;
        }
        field(1025;"Currency Factor";Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0:15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                if ("Currency Code" = '') and ("Currency Factor" <> 0) then
                  FieldError("Currency Factor",StrSubstNo(Text001,FieldCaption("Currency Code")));
                UpdateAllAmounts;
            end;
        }
        field(1026;"Schedule Line";Boolean)
        {
            Caption = 'Schedule Line';
            Editable = false;
            InitValue = true;
        }
        field(1027;"Contract Line";Boolean)
        {
            Caption = 'Contract Line';
            Editable = false;
        }
        field(1028;Invoiced;Boolean)
        {
            Caption = 'Invoiced';
            Editable = false;
        }
        field(1029;Transferred;Boolean)
        {
            Caption = 'Transferred';
            Editable = false;
        }
        field(1030;"Grant Contract Entry No.";Integer)
        {
            Caption = 'Grant Contract Entry No.';
            Editable = false;
        }
        field(1031;"Invoice Type";Option)
        {
            Caption = 'Invoice Type';
            Editable = false;
            OptionCaption = ' ,Invoice,Credit Memo,Posted Invoice,Posted Credit Memo';
            OptionMembers = " ",Invoice,"Credit Memo","Posted Invoice","Posted Credit Memo";
        }
        field(1032;"Invoice No.";Code[20])
        {
            Caption = 'Invoice No.';
            Editable = false;
            TableRelation = if ("Invoice Type"=const(Invoice),"Invoice Type"=const("Credit Memo")) "Sales Invoice Header" else if ("Invoice Type"=const("Credit Memo")) "Sales Cr.Memo Header";

            trigger OnLookup()
            var
                JobCreateInvoice: Codeunit "HR Leave Jnl.-Postt";
            begin
                //JobCreateInvoice.GetSalesInvoice(Rec);
            end;
        }
        field(1033;"Transferred Date";Date)
        {
            Caption = 'Transferred Date';
            Editable = false;
        }
        field(1034;"Invoiced Date";Date)
        {
            Caption = 'Invoiced Date';
            Editable = false;
        }
        field(1035;"Invoiced Amount (LCY)";Decimal)
        {
            Caption = 'Invoiced Amount (LCY)';
            Editable = false;
        }
        field(1036;"Invoiced Cost Amount (LCY)";Decimal)
        {
            Caption = 'Invoiced Cost Amount (LCY)';
            Editable = false;
        }
        field(1037;"VAT Unit Price";Decimal)
        {
            Caption = 'VAT Unit Price';
        }
        field(1038;"VAT Line Discount Amount";Decimal)
        {
            Caption = 'VAT Line Discount Amount';
        }
        field(1039;"VAT Line Amount";Decimal)
        {
            Caption = 'VAT Line Amount';
        }
        field(1041;"VAT %";Decimal)
        {
            Caption = 'VAT %';
        }
        field(1042;"Description 2";Text[50])
        {
            Caption = 'Description 2';
        }
        field(1043;"Grant Ledger Entry No.";Integer)
        {
            BlankZero = true;
            Caption = 'Job Ledger Entry No.';
            Editable = false;
            TableRelation = "Job-Ledger Entry";
        }
        field(1044;"Inv. Curr. Unit Price";Decimal)
        {
            AutoFormatExpression = "Invoice Currency Code";
            AutoFormatType = 2;
            Caption = 'Inv. Curr. Unit Price';
            Editable = false;
        }
        field(1045;"Inv. Curr. Line Amount";Decimal)
        {
            AutoFormatExpression = "Invoice Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Curr. Line Amount';
            Editable = false;
        }
        field(1046;"Invoice Currency";Boolean)
        {
            Caption = 'Invoice Currency';
            Editable = false;
        }
        field(1047;"Invoice Currency Code";Code[10])
        {
            Caption = 'Invoice Currency Code';
            TableRelation = Currency;
        }
        field(1048;Status;Option)
        {
            Caption = 'Status';
            Editable = false;
            InitValue = "Order";
            OptionCaption = 'Planning,Quote,Order,Completed';
            OptionMembers = Planning,Quote,"Order",Completed;
        }
        field(1049;"Invoice Currency Factor";Decimal)
        {
            Caption = 'Invoice Currency Factor';
            Editable = false;
        }
        field(1050;"Ledger Entry Type";Option)
        {
            Caption = 'Ledger Entry Type';
            OptionCaption = ' ,Resource,Item,G/L Account';
            OptionMembers = " ",Resource,Item,"G/L Account";
        }
        field(1051;"Ledger Entry No.";Integer)
        {
            BlankZero = true;
            Caption = 'Ledger Entry No.';
            TableRelation = if ("Ledger Entry Type"=const(Resource)) "Res. Ledger Entry" else if ("Ledger Entry Type"=const(Item)) "Item Ledger Entry" else if ("Ledger Entry Type"=const("G/L Account")) "G/L Entry";
        }
        field(1052;"System-Created Entry";Boolean)
        {
            Caption = 'System-Created Entry';
        }
        field(1053;"Usage Link";Boolean)
        {
            Caption = 'Usage Link';

            trigger OnValidate()
            begin
                if "Usage Link" and ("Line Type" = "line type"::Contract) then
                  Error(Text014,FieldCaption("Usage Link"),TableCaption,FieldCaption("Line Type"),"Line Type");

                //ControlUsageLink;

                CheckItemAvailable();
                //UpdateReservation(FIELDNO("Usage Link"));  //Dennos comments to relook
            end;
        }
        field(5402;"Variant Code";Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = if (Type=const(Item)) "Item Variant".Code where ("Item No."=field("No."));

            trigger OnValidate()
            begin
                if "Variant Code" = '' then begin
                  if Type = Type::Item then begin
                    Item.Get("No.");
                    Description := Item.Description;
                    "Description 2" := Item."Description 2";
                    GetItemTranslation;
                  end;
                  exit;
                end;

                TestField(Type,Type::Item);

                ItemVariant.Get("No.","Variant Code");
                Description := ItemVariant.Description;
                "Description 2" := ItemVariant."Description 2";

                Validate(Quantity);
            end;
        }
        field(5403;"Bin Code";Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code where ("Location Code"=field("Location Code"));

            trigger OnValidate()
            begin
                TestField("Location Code");
                CheckItemAvailable;
            end;
        }
        field(5404;"Qty. per Unit of Measure";Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0:5;
            Editable = false;
            InitValue = 1;
        }
        field(5410;"Quantity (Base)";Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0:5;

            trigger OnValidate()
            begin
                TestField("Qty. per Unit of Measure",1);
                Validate(Quantity,"Quantity (Base)");
            end;
        }
        field(5900;"Service Order No.";Code[20])
        {
            Caption = 'Service Order No.';
        }
        field(50000;"Grant Phase";Code[10])
        {
            CalcFormula = lookup("Job-Task"."Grant Phase" where ("Grant Task No."=field("Grant Task No.")));
            FieldClass = FlowField;
        }
        field(50001;"Accounted Amount";Decimal)
        {
            CalcFormula = sum("Grant Surrender Details"."Actual Spent" where ("Job-Planning Line No"=field("Line No."),Partner=field(Partner),"Grant No"=field("Grant No."),Posted=const(Yes)));
            FieldClass = FlowField;
        }
        field(50002;"Income Account";Code[20])
        {
            TableRelation = if (Type=const(Resource)) Resource else if (Type=const(Item)) Item else if (Type=const("G/L Account")) "G/L Account" else if (Type=const(Text)) "Standard Text";

            trigger OnValidate()
            begin
                if ("No." = '') or ("No." <> xRec."No.") then begin
                  "Description 3" := '';
                  "Unit of Measure Code" := '';
                  "Qty. per Unit of Measure" := 1;
                  "Variant Code" := '';
                  "Work Type Code" := '';
                  "Gen. Bus. Posting Group" := '';
                  "Gen. Prod. Posting Group" := '';
                  DeleteAmounts;
                  "Cost Factor" := 0;
                  CheckedAvailability := false;
                  if "No." <> '' then begin
                    // Preserve quantities after resetting all amounts:
                    Quantity := xRec.Quantity;
                    "Quantity (Base)" := xRec."Quantity (Base)";
                  end else
                    exit;
                end;

                GetJob;
                "Customer Price Group" := Job."Customer Price Group";

                case Type of
                  Type::Resource:
                    begin
                      Res.Get("No.");
                      Res.TestField(Blocked,false);
                      Description := Res.Name;
                      "Description 2" := Res."Name 2";
                      "Gen. Prod. Posting Group" := Res."Gen. Prod. Posting Group";
                      "Resource Group No." := Res."Resource Group No.";
                      Validate("Unit of Measure Code",Res."Base Unit of Measure");
                    end;
                  Type::Item:
                    begin
                      GetItem;
                      Item.TestField(Blocked,false);
                      Description := Item.Description;
                      "Description 2" := Item."Description 2";
                      if Job."Language Code" <> '' then
                        GetItemTranslation;
                      "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                      Validate("Unit of Measure Code",Item."Base Unit of Measure");
                    end;
                  Type::"G/L Account":
                    begin
                      GLAcc.Get("Income Account");
                      GLAcc.CheckGLAcc;
                      GLAcc.TestField("Direct Posting",true);
                      "Description 3" := GLAcc.Name;
                      "Gen. Bus. Posting Group" := GLAcc."Gen. Bus. Posting Group";
                      "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
                      "Unit of Measure Code" := '';
                      "Direct Unit Cost (LCY)" := 0;
                      "Unit Cost (LCY)" := 0;
                      "Unit Price" := 0;
                    end;
                  Type::Text:
                    begin
                      StdTxt.Get("No.");
                      Description := StdTxt.Description;
                    end;
                end;

                if Type <> Type::Text then
                  Validate(Quantity);
            end;
        }
        field(50003;"Description 3";Text[50])
        {
        }
        field(50004;"Audit Provision";Code[30])
        {
            TableRelation = "Audit provision";
        }
        field(50005;"Special Condition for Travel";Code[30])
        {
            TableRelation = "Special Conditions for Travel";
        }
        field(50006;"Pending donor Issues";Code[10])
        {
            TableRelation = "Pending Donor Issues";
        }
        field(50007;"Disbursment Due dates";Date)
        {
        }
        field(50008;Partner;Code[20])
        {
            TableRelation = "Project Partners".PartnerID where ("Grant No"=field("Grant No."));
        }
        field(50009;"Budget Period";Code[10])
        {
            TableRelation = "Grant Phases";
        }
        field(50010;"Total Year 1";Decimal)
        {
            CalcFormula = sum("Job-Planning Line"."Total Cost (LCY)" where ("Budget Period"=const('YEAR 1'),Partner=field(Partner),Description=field(Description),"Grant No."=field("Grant No.")));
            FieldClass = FlowField;
        }
        field(50011;"Total Year 2";Decimal)
        {
            CalcFormula = sum("Job-Planning Line"."Total Cost (LCY)" where ("Budget Period"=const('YEAR 2'),Partner=field(Partner),Description=field(Description),"Grant No."=field("Grant No.")));
            FieldClass = FlowField;
        }
        field(50012;"Total Year 3";Decimal)
        {
            CalcFormula = sum("Job-Planning Line"."Total Cost (LCY)" where ("Budget Period"=const('YEAR 3'),Partner=field(Partner),Description=field(Description),"Grant No."=field("Grant No.")));
            FieldClass = FlowField;
        }
        field(50013;"Transfered To Budget";Boolean)
        {
        }
        field(50014;"Budget Grouping Code";Code[30])
        {
            TableRelation = "Budget Grouping Codes";
        }
        field(50015;"ICIPE Contribution";Decimal)
        {
        }
        field(50017;"Unaccounted Amount";Decimal)
        {
        }
        field(50018;"Disbursed Amount";Decimal)
        {
            CalcFormula = sum("Payment Line"."NetAmount LCY" where ("Grant No"=field("Grant No."),"Account No."=field(Partner),"Job-Planning Line No"=field("Line No.")));
            FieldClass = FlowField;
        }
        field(50019;Restriction;Option)
        {
            OptionCaption = ' ,Restricted,Unrestricted';
            OptionMembers = " ",Restricted,Unrestricted;
        }
        field(50020;"Donor Expense Code";Code[10])
        {
            TableRelation = "Donor IC G/L Account";

            trigger OnValidate()
            begin
                 DEC.Reset;
                 DEC.SetRange(DEC."No.","Donor Expense Code");
                 if DEC.Find('-')then begin
                 "No.":=DEC."Map-to G/L Acc. No.";
                 Validate("No.");
                 end;
            end;
        }
        field(50021;"Total Year 4";Decimal)
        {
            CalcFormula = sum("Job-Planning Line"."Total Cost (LCY)" where ("Budget Period"=const('YEAR 4'),Partner=field(Partner),Description=field(Description),"Grant No."=field("Grant No.")));
            FieldClass = FlowField;
        }
        field(50022;"Total Year 5";Decimal)
        {
            CalcFormula = sum("Job-Planning Line"."Total Cost (LCY)" where ("Budget Period"=const('YEAR 5'),Partner=field(Partner),Description=field(Description),"Grant No."=field("Grant No.")));
            FieldClass = FlowField;
        }
        field(50023;"Total Year 6";Decimal)
        {
            CalcFormula = sum("Job-Planning Line"."Total Cost (LCY)" where ("Budget Period"=const('YEAR 6'),Partner=field(Partner),Description=field(Description),"Grant No."=field("Grant No.")));
            FieldClass = FlowField;
        }
        field(50024;"Budget in use";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Grant No.","Grant Task No.","Line No.")
        {
            Clustered = true;
            SumIndexFields = "Total Cost (LCY)","Total Cost";
        }
        key(Key2;"Grant No.","Grant Task No.","Schedule Line","Planning Date")
        {
            SumIndexFields = "Total Price (LCY)","Total Cost (LCY)","Line Amount (LCY)";
        }
        key(Key3;"Grant No.","Grant Task No.","Contract Line","Planning Date")
        {
            SumIndexFields = "Line Amount (LCY)","Total Price (LCY)","Total Cost (LCY)","Invoiced Amount (LCY)","Invoiced Cost Amount (LCY)";
        }
        key(Key4;"Grant No.","Grant Task No.","Schedule Line","Currency Date")
        {
        }
        key(Key5;"Grant No.","Grant Task No.","Contract Line","Currency Date")
        {
        }
        key(Key6;"Grant No.","Schedule Line",Type,"No.","Planning Date")
        {
            SumIndexFields = "Quantity (Base)";
        }
        key(Key7;"Grant No.","Schedule Line",Type,"Resource Group No.","Planning Date")
        {
            SumIndexFields = "Quantity (Base)";
        }
        key(Key8;Status,"Schedule Line",Type,"No.","Planning Date")
        {
            SumIndexFields = "Quantity (Base)";
        }
        key(Key9;Status,"Schedule Line",Type,"Resource Group No.","Planning Date")
        {
            SumIndexFields = "Quantity (Base)";
        }
        key(Key10;"Grant Contract Entry No.")
        {
        }
        key(Key11;Type,"No.")
        {
        }
        key(Key12;"Income Account")
        {
        }
        key(Key13;"Budget Period",Partner,Description,"Grant No.")
        {
            SumIndexFields = "Total Cost (LCY)";
        }
        key(Key14;"Budget Grouping Code","Grant No.","Budget Period","Grant Contract Entry No.")
        {
            SumIndexFields = "Total Cost (LCY)";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        TestField(Transferred,false);
        Job.Get("Grant No.");

        if Job."Approval Status"<>Job."approval status"::Open then
        Error('Grant %1 cannot be deleted as its status is %2',Job."No.",Job."Approval Status");
    end;

    trigger OnInsert()
    begin
        LockTable;
        GetJob;
        if Job.Blocked = Job.Blocked::All then
          Job.TestBlocked;
        JT.Get("Grant No.","Grant Task No.");
        JT.TestField("Grant Task Type",JT."grant task type"::Posting);
        "Grant Contract Entry No." := JobEntryNo.GetNextEntryNo;
        InitJobPlanningLine;
        "User ID" := UserId;
        "Last Date Modified" := 0D;
        Status := Job.Status;
        Job.Get("Grant No.");


        if Job."Approval Status"<>Job."approval status"::Open then
         Error('Grant %1 cannot be modified as its status is %2',Job."No.",Job."Approval Status");
    end;

    trigger OnModify()
    begin

        "Last Date Modified" := Today;
        "User ID" := UserId;
        Job.Get("Grant No.");



        //IF Job."Approval Status"<>Job."Approval Status"::Open THEN
        //ERROR('Grant %1 cannot be modified as its status is %2',Job."No.",Job."Approval Status");
        AllowUpdate  ;
    end;

    trigger OnRename()
    begin
        Error(Text002,TableCaption);
    end;

    var
        GLAcc: Record "G/L Account";
        Location: Record Location;
        Item: Record Item;
        JobEntryNo: Record "HR Leave Family Employees";
        JT: Record "HR Transport Requisition";
        ItemVariant: Record "Item Variant";
        Res: Record Resource;
        ResCost: Record "Resource Cost";
        WorkType: Record "Work Type";
        Job: Record "Loan Sub-Sector";
        ResUnitofMeasure: Record "Resource Unit of Measure";
        ItemJnlLine: Record "Item Journal Line";
        CurrExchRate: Record "Currency Exchange Rate";
        SKU: Record "Stockkeeping Unit";
        StdTxt: Record "Standard Text";
        Currency: Record Currency;
        ItemTranslation: Record "Item Translation";
        GLSetup: Record "General Ledger Setup";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        UOMMgt: Codeunit "Unit of Measure Management";
        ResFindUnitCost: Codeunit "Resource-Find Cost";
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        Text001: label 'cannot be specified without %1';
        Text002: label 'You cannot rename a %1.';
        CurrencyDate: Date;
        Text004: label 'You must specify %1 %2 in planning line.';
        HasGotGLSetup: Boolean;
        UnitAmountRoundingPrecision: Decimal;
        AmountRoundingPrecision: Decimal;
        CheckedAvailability: Boolean;
        DimMgt: Codeunit DimensionManagement;
        ProjPersonnel: Record "HR Appraisal Assignment";
        PRSalaryCard: Record UnknownRecord51516303;
        DEC: Record "HR Notice Board Info Setup";
        UnitAmountRoundingPrecisionFCY: Decimal;
        AmountRoundingPrecisionFCY: Decimal;
        Text005: label '%1 cannot be less than %2.';
        Text006: label 'The %1 must be a %2 and %3 must be enabled, because linked Job Ledger Entries exist.';
        Text007: label 'This %1 cannot be deleted because linked job ledger entries exist.';
        Text008: label 'You cannot change this value because linked job ledger entries exist.';
        Text009: label 'The %1 cannot be of %2 %3 because it is transferred to an invoice.', Comment='The Job Planning Line cannot be of Line Type Schedule, because it is transferred to an invoice.';
        Text010: label '%1 may not be lower than %2 and may not exceed %3.';
        Text011: label 'Automatic reservation is not possible.\Do you want to reserve items manually?';
        Text012: label '%1 cannot be set on a %2 of type %3.';
        Text013: label 'The %1 has already been completely transferred.';
        Text014: label '%1 cannot be enabled on a %2 with %3 %4.', Comment='Usage Link cannot be enabled on a Job Planning Line with Line Type Schedule';
        Text015: label '%1 cannot be higher than %2.';
        Text028: label 'You cannot change the %1 when the %2 has been filled in.';

    local procedure CalcBaseQty(Qty: Decimal): Decimal
    begin
        TestField("Qty. per Unit of Measure");
        exit(ROUND(Qty * "Qty. per Unit of Measure",0.00001));
    end;

    local procedure CheckItemAvailable()
    begin
        if (CurrFieldNo <> 0) and (Type = Type::Item) and (Quantity > 0) and not CheckedAvailability then begin
          ItemJnlLine."Item No." := "No.";
          ItemJnlLine."Entry Type" := ItemJnlLine."entry type"::"Negative Adjmt.";
          ItemJnlLine."Location Code" := "Location Code";
          ItemJnlLine."Variant Code" := "Variant Code";
          ItemJnlLine."Bin Code" := "Bin Code";
          ItemJnlLine."Unit of Measure Code" := "Unit of Measure Code";
          ItemJnlLine."Qty. per Unit of Measure" := "Qty. per Unit of Measure";
          ItemJnlLine.Quantity := Quantity;
          ItemCheckAvail.ItemJnlCheckLine(ItemJnlLine);
          CheckedAvailability := true;
        end;
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
          Clear(Location)
        else
          if Location.Code <> LocationCode then
            Location.Get(LocationCode);
    end;


    procedure GetJob()
    begin
        TestField("Grant No.");
        if "Grant No." <> Job."No." then begin
          Job.Get("Grant No.");
          if Job."Currency Code" = '' then begin
            GetGLSetup;
            Currency.InitRoundingPrecision;
            AmountRoundingPrecision := GLSetup."Amount Rounding Precision";
            UnitAmountRoundingPrecision := GLSetup."Unit-Amount Rounding Precision";
          end else begin
            GetCurrency;
            Currency.Get(Job."Currency Code");
            Currency.TestField("Amount Rounding Precision");
            AmountRoundingPrecision := Currency."Amount Rounding Precision";
            UnitAmountRoundingPrecision := Currency."Unit-Amount Rounding Precision";
          end;
        end;
    end;


    procedure UpdateCurrencyFactor()
    begin
        if "Currency Code" <> '' then begin
          if "Currency Date" = 0D then
            CurrencyDate := WorkDate
          else
            CurrencyDate := "Currency Date";
          "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate,"Currency Code");
        end else
          "Currency Factor" := 0;
    end;

    local procedure GetItem()
    begin
        TestField("No.");
        if "No." <> Item."No." then
          Item.Get("No.");
    end;

    local procedure GetSKU(): Boolean
    begin
        if (SKU."Location Code" = "Location Code") and
           (SKU."Item No." = "No.") and
           (SKU."Variant Code" = "Variant Code")
        then
          exit(true);

        if SKU.Get("Location Code","No.","Variant Code") then
          exit(true);

        exit(false);
    end;

    local procedure GetCurrency()
    begin
        if "Currency Code" = '' then begin
          Clear(Currency);
          Currency.InitRoundingPrecision
        end else begin
          Currency.Get("Currency Code");
          Currency.TestField("Amount Rounding Precision");
          Currency.TestField("Unit-Amount Rounding Precision");
        end;
    end;


    procedure Caption(): Text[250]
    var
        Job: Record "Loan Sub-Sector";
        JT: Record "HR Transport Requisition";
    begin
        if not Job.Get("Grant No.") then
          exit('');
        if not JT.Get("Grant No.","Grant Task No.") then
          exit('');
        exit(StrSubstNo('%1 %2 %3 %4',
            Job."No.",
            Job.Description,
            JT."Grant Task No.",
            JT.Description));
    end;


    procedure SetUpNewLine(LastJobPlanningLine: Record "HR Journal Line")
    begin
        "Document Date" := LastJobPlanningLine."Planning Date";
        "Document No." := LastJobPlanningLine."Document No.";
        Type := LastJobPlanningLine.Type;
        Validate("Line Type",LastJobPlanningLine."Line Type");
        GetJob;
        "Currency Code" := Job."Currency Code";
        if LastJobPlanningLine."Planning Date" <> 0D then
          Validate("Planning Date",LastJobPlanningLine."Planning Date");
    end;


    procedure InitJobPlanningLine()
    begin
        Transferred := false;
        Invoiced := false;
        "Invoiced Amount (LCY)" := 0;
        "Invoiced Cost Amount (LCY)" := 0;
        "Invoice Type" := 0;
        "Invoice No." := '';
        "Transferred Date" := 0D;
        "Invoiced Date" := 0D;
        "VAT Unit Price" := 0;
        "VAT Line Discount Amount" := 0;
        "VAT Line Amount" := 0;
        "VAT %" := 0;
        "Grant Ledger Entry No." := 0;
        "Inv. Curr. Unit Price" := 0;
        "Inv. Curr. Line Amount" := 0;
        "Invoice Currency Code" := '';
        "Invoice Currency" := false;
    end;


    procedure DeleteAmounts()
    begin
        Quantity := 0;
        "Quantity (Base)" := 0;

        "Direct Unit Cost (LCY)" := 0;
        "Unit Cost (LCY)" := 0;
        "Unit Cost" := 0;

        "Total Cost (LCY)" := 0;
        "Total Cost" := 0;

        "Unit Price (LCY)" := 0;
        "Unit Price" := 0;

        "Total Price (LCY)" := 0;
        "Total Price" := 0;

        "Line Amount (LCY)" := 0;
        "Line Amount" := 0;

        "Line Discount %" := 0;

        "Line Discount Amount (LCY)" := 0;
        "Line Discount Amount" := 0;
    end;


    procedure UpdateFromCurrency()
    begin
        GetJob;
        UpdateAllAmounts;
    end;


    procedure GetItemTranslation()
    begin
        GetJob;
        if ItemTranslation.Get("No.","Variant Code",Job."Language Code") then begin
          Description := ItemTranslation.Description;
          "Description 2" := ItemTranslation."Description 2";
        end;
    end;


    procedure GetGLSetup()
    begin
        if HasGotGLSetup then
          exit;
        GLSetup.Get;
        HasGotGLSetup := true;
    end;


    procedure UpdateAllAmounts()
    begin
        GetJob;

        UpdateUnitCost;
        UpdateTotalCost;
        FindPriceAndDiscount(Rec,CurrFieldNo);
        HandleCostFactor;
        UpdateUnitPrice;
        UpdateTotalPrice;
        UpdateAmountsAndDiscounts;
    end;

    local procedure UpdateUnitCost()
    var
        RetrievedCost: Decimal;
    begin
        if (Type = Type::Item) and Item.Get("No.") then begin
          if Item."Costing Method" = Item."costing method"::Standard then begin
            if RetrieveCostPrice then begin
              if GetSKU then
                "Unit Cost (LCY)" := SKU."Unit Cost" * "Qty. per Unit of Measure"
              else
                "Unit Cost (LCY)" := Item."Unit Cost" * "Qty. per Unit of Measure";
              "Unit Cost" := ROUND(
                  CurrExchRate.ExchangeAmtLCYToFCY(
                    "Currency Date","Currency Code",
                    "Unit Cost (LCY)","Currency Factor"),
                  UnitAmountRoundingPrecision);
            end else begin
              if "Unit Cost" <> xRec."Unit Cost" then
                "Unit Cost (LCY)" := ROUND(
                    CurrExchRate.ExchangeAmtFCYToLCY(
                      "Currency Date","Currency Code",
                      "Unit Cost","Currency Factor"),
                    UnitAmountRoundingPrecision)
              else
                "Unit Cost" := ROUND(
                    CurrExchRate.ExchangeAmtLCYToFCY(
                      "Currency Date","Currency Code",
                      "Unit Cost (LCY)","Currency Factor"),
                    UnitAmountRoundingPrecision);
            end;
          end else begin
            if RetrieveCostPrice then begin
              if GetSKU then
                RetrievedCost := SKU."Unit Cost" * "Qty. per Unit of Measure"
              else
                RetrievedCost := Item."Unit Cost" * "Qty. per Unit of Measure";
              "Unit Cost" := ROUND(
                  CurrExchRate.ExchangeAmtLCYToFCY(
                    "Currency Date","Currency Code",
                    RetrievedCost,"Currency Factor"),
                  UnitAmountRoundingPrecision);
              "Unit Cost (LCY)" := ROUND(
                  CurrExchRate.ExchangeAmtFCYToLCY(
                    "Currency Date","Currency Code",
                    "Unit Cost","Currency Factor"),
                  UnitAmountRoundingPrecision);
            end else begin
              "Unit Cost (LCY)" := ROUND(
                  CurrExchRate.ExchangeAmtFCYToLCY(
                    "Currency Date","Currency Code",
                    "Unit Cost","Currency Factor"),
                  UnitAmountRoundingPrecision);
            end;
          end;
        end else
          if (Type = Type::Resource) and Res.Get("No.") then begin
            if RetrieveCostPrice then begin
              ResCost.Init;
              ResCost.Code := "No.";
              ResCost."Work Type Code" := "Work Type Code";
              ResFindUnitCost.Run(ResCost);
              "Direct Unit Cost (LCY)" := ResCost."Direct Unit Cost" * "Qty. per Unit of Measure";
              RetrievedCost := ROUND(ResCost."Unit Cost" * "Qty. per Unit of Measure",UnitAmountRoundingPrecision);
              "Unit Cost" := ROUND(
                  CurrExchRate.ExchangeAmtLCYToFCY(
                    "Currency Date","Currency Code",
                    RetrievedCost,"Currency Factor"),
                  UnitAmountRoundingPrecision);
              "Unit Cost (LCY)" := ROUND(
                  CurrExchRate.ExchangeAmtFCYToLCY(
                    "Currency Date","Currency Code",
                    "Unit Cost","Currency Factor"),
                  UnitAmountRoundingPrecision);
            end else begin
              "Unit Cost (LCY)" := ROUND(
                  CurrExchRate.ExchangeAmtFCYToLCY(
                    "Currency Date","Currency Code",
                    "Unit Cost","Currency Factor"),
                  UnitAmountRoundingPrecision);
            end;
          end else begin
            "Unit Cost (LCY)" := ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  "Currency Date","Currency Code",
                  "Unit Cost","Currency Factor"),
                UnitAmountRoundingPrecision);
          end;
    end;


    procedure RetrieveCostPrice(): Boolean
    begin
        case Type of
          Type::Item:
            if ("No." <> xRec."No.") or
               ("Location Code" <> xRec."Location Code") or
               ("Variant Code" <> xRec."Variant Code") or
               ("Unit of Measure Code" <> xRec."Unit of Measure Code") then
              exit(true);
          Type::Resource:
            if ("No." <> xRec."No.") or
               ("Work Type Code" <> xRec."Work Type Code") or
               ("Unit of Measure Code" <> xRec."Unit of Measure Code") then
              exit(true);
          Type::"G/L Account":
            if "No." <> xRec."No." then
              exit(true);
          else
            exit(false);
        end;
        exit(false);
    end;

    local procedure UpdateTotalCost()
    begin
        "Total Cost" := ROUND("Unit Cost" * Quantity,AmountRoundingPrecision);
        "Total Cost (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Currency Date","Currency Code",
              "Total Cost","Currency Factor"),
            AmountRoundingPrecision);
    end;


    procedure FindPriceAndDiscount(var JobPlanningLine: Record "HR Journal Line";CalledByFieldNo: Integer)
    begin
        if RetrieveCostPrice and ("No." <> '') then begin
        //  SalesPriceCalcMgt.FindJobPlanningLinePrice(JobPlanningLine,CalledByFieldNo);

         // IF Type <> Type::"G/L Account" THEN
        //    PurchPriceCalcMgt.FindJobPlanningLinePrice(JobPlanningLine,CalledByFieldNo)
         // ELSE BEGIN
            // Because the SalesPriceCalcMgt.FindJobJnlLinePrice function also retrieves costs for G/L Account,
            // cost and total cost need to get updated again.
            UpdateUnitCost;
            UpdateTotalCost;
          end;

        //END;
    end;

    local procedure HandleCostFactor()
    begin
        if ("Unit Cost" <> xRec."Unit Cost") or ("Cost Factor" <> xRec."Cost Factor") then begin
          if "Cost Factor" <> 0 then
            "Unit Price" := ROUND("Unit Cost" * "Cost Factor",UnitAmountRoundingPrecision)
          else
            if xRec."Cost Factor" <> 0 then
              "Unit Price" := 0;
        end;
    end;

    local procedure UpdateUnitPrice()
    begin
        "Unit Price (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Currency Date","Currency Code",
              "Unit Price","Currency Factor"),
            UnitAmountRoundingPrecision);
    end;

    local procedure UpdateTotalPrice()
    begin
        "Total Price" := ROUND(Quantity * "Unit Price",AmountRoundingPrecision);
        "Total Price (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Currency Date","Currency Code",
              "Total Price","Currency Factor"),
            AmountRoundingPrecision);
    end;

    local procedure UpdateAmountsAndDiscounts()
    begin
        if "Total Price" <> 0 then begin
          if ("Line Amount" <> xRec."Line Amount") and ("Line Discount Amount" = xRec."Line Discount Amount") then begin
            "Line Amount" := ROUND("Line Amount",AmountRoundingPrecision);
            "Line Discount Amount" := "Total Price" - "Line Amount";
            "Line Discount %" :=
              ROUND("Line Discount Amount" / "Total Price" * 100);
          end else
            if ("Line Discount Amount" <> xRec."Line Discount Amount") and ("Line Amount" = xRec."Line Amount") then begin
              "Line Discount Amount" := ROUND("Line Discount Amount",AmountRoundingPrecision);
              "Line Amount" := "Total Price" - "Line Discount Amount";
              "Line Discount %" :=
                ROUND("Line Discount Amount" / "Total Price" * 100);
            end else begin
              "Line Discount Amount" :=
                ROUND("Total Price" * "Line Discount %" / 100,AmountRoundingPrecision);
              "Line Amount" := "Total Price" - "Line Discount Amount";
            end;
        end else begin
          "Line Amount" := 0;
          "Line Discount Amount" := 0;
        end;

        "Line Amount (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Currency Date","Currency Code",
              "Line Amount","Currency Factor"),
            AmountRoundingPrecision);

        "Line Discount Amount (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Currency Date","Currency Code",
              "Line Discount Amount","Currency Factor"),
            AmountRoundingPrecision);
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer;ShortcutDimCode: Code[20])
    var
        JobTask2: Record "HR Journal Line";
    begin
        DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        if JobTask2.Get("Grant No.","Grant Task No.") then begin
          DimMgt.SaveJobTaskDim("Grant No.","Grant Task No.",FieldNumber,ShortcutDimCode);
          Modify;
        end else
          DimMgt.SaveJobTaskTempDim(FieldNumber,ShortcutDimCode);
    end;


    procedure GetCostAllocation()
    begin
        ProjPersonnel.Reset;
        ProjPersonnel.SetRange(ProjPersonnel.Project,"Grant No.");
        ProjPersonnel.SetRange(ProjPersonnel."Employee No","No.");
        if ProjPersonnel.Find('-') then
        begin
            Res.Reset;
            Res.Get("No.");
            Res.TestField(Res."Employee No");

            if PRSalaryCard.Get(Res."Employee No") then begin
             PRSalaryCard.CalcFields(PRSalaryCard."Cumm GrossPay");
            "Unit Cost":=PRSalaryCard."Cumm GrossPay" * (ProjPersonnel."% Allocation Value"/100);
            "Unit Cost (LCY)":="Unit Cost";
            "Total Cost":="Unit Cost";
            "Total Cost (LCY)":="Unit Cost";

            //VALIDATE("Unit Cost");
            end

        end else begin
        Error('The resource you have entered is not setup as personnel for this project');
        end
    end;


    procedure UpdateQtyToInvoice()
    begin
        if "Contract Line" then begin
          CalcFields(Quantity);
          Validate(Quantity)
        end else
          Validate(Quantity,0);
    end;


    procedure UpdatePostedTotalCost(var JobLedgerEntry: Record "Loan Specific-Secto")
    begin
        if "Usage Link" then begin
          InitRoundingPrecisions;

          "Total Cost" := ROUND(Quantity * JobLedgerEntry."Unit Cost",AmountRoundingPrecisionFCY);
          "Total Cost (LCY)" := ROUND(Quantity * JobLedgerEntry."Unit Cost (LCY)",AmountRoundingPrecision);
        end;
    end;

    local procedure InitRoundingPrecisions()
    var
        Currency: Record Currency;
    begin
        if (AmountRoundingPrecision = 0) or
           (UnitAmountRoundingPrecision = 0) or
           (AmountRoundingPrecisionFCY = 0) or
           (UnitAmountRoundingPrecisionFCY = 0)
        then begin
          Clear(Currency);
          Currency.InitRoundingPrecision;
          AmountRoundingPrecision := Currency."Amount Rounding Precision";
          UnitAmountRoundingPrecision := Currency."Unit-Amount Rounding Precision";

          if "Currency Code" <> '' then begin
            Currency.Get("Currency Code");
            Currency.TestField("Amount Rounding Precision");
            Currency.TestField("Unit-Amount Rounding Precision");
          end;

          AmountRoundingPrecisionFCY := Currency."Amount Rounding Precision";
          UnitAmountRoundingPrecisionFCY := Currency."Unit-Amount Rounding Precision";
        end;
    end;


    procedure AllowUpdate()
    begin
        if "Planning Date"<>xRec."Planning Date" then begin
         if Job."Approval Status"<>Job."approval status"::Open then
          Error('Grant %1 cannot be modified as its status is %2',Job."No.",Job."Approval Status");
        end else if Type<>xRec.Type then begin
         if Job."Approval Status"<>Job."approval status"::Open then
          Error('Grant %1 cannot be modified as its status is %2',Job."No.",Job."Approval Status");
        end else if "Donor Expense Code"<>xRec."Donor Expense Code" then begin
         if Job."Approval Status"<>Job."approval status"::Open then
          Error('Grant %1 cannot be modified as its status is %2',Job."No.",Job."Approval Status");
        end else if "Budget Period"<>xRec."Budget Period" then begin
         if Job."Approval Status"<>Job."approval status"::Open then
          Error('Grant %1 cannot be modified as its status is %2',Job."No.",Job."Approval Status")
        end else if "No."<>xRec."No." then begin
         if Job."Approval Status"<>Job."approval status"::Open then
          Error('Grant %1 cannot be modified as its status is %2',Job."No.",Job."Approval Status");
        end else if Description<>xRec.Description then begin
         if Job."Approval Status"<>Job."approval status"::Open then
          Error('Grant %1 cannot be modified as its status is %2',Job."No.",Job."Approval Status");
        end else if Quantity<>xRec.Quantity then begin
         if Job."Approval Status"<>Job."approval status"::Open then
          Error('Grant %1 cannot be modified as its status is %2',Job."No.",Job."Approval Status");
        end;
    end;
}

