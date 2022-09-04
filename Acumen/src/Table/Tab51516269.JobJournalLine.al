#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516269 "Job-Journal Line"
{
    Caption = 'Job Journal Line';

    fields
    {
        field(1;"Journal Template Name";Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Job-Journal Template";
        }
        field(2;"Line No.";Integer)
        {
            Caption = 'Line No.';
        }
        field(3;"Job No.";Code[20])
        {
            Caption = 'Job No.';
           // TableRelation = Jobs;

            trigger OnValidate()
            begin
                if "Job No." = '' then begin
                  Validate("Currency Code",'');
                  Validate("Job Task No.",'');
                  CreateDim(
                    Database::Job,"Job No.",
                    DimMgt.TypeToTableID2(Type),"No.",
                    Database::"Resource Group","Resource Group No.");
                  exit;
                end;

              //  //;
                // Job.TestBlocked;
                // //Job.TESTFIELD("Bill-to Partner No.");
                // //Cust.GET(Job."Bill-to Partner No.");
                // Validate("Job Task No.",'');
                // "Customer Price Group" := Job."Customer Price Group";
                // Validate("Currency Code",Job."Currency Code");
                // CreateDim(
                //   Database::Job,"Job No.",
                //   DimMgt.TypeToTableID2(Type),"No.",
                //   Database::"Resource Group","Resource Group No.");
                // Validate("Country/Region Code",Cust."Country/Region Code");
            end;
        }
        field(4;"Posting Date";Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                Validate("Document Date","Posting Date");
                if "Currency Code" <> '' then begin
                  UpdateCurrencyFactor;
                  UpdateAllAmounts;
                end
            end;
        }
        field(5;"Document No.";Code[20])
        {
            Caption = 'Document No.';
        }
        field(6;Type;Option)
        {
            Caption = 'Type';
            OptionCaption = 'Resource,Item,G/L Account';
            OptionMembers = Resource,Item,"G/L Account";

            trigger OnValidate()
            begin
                Validate("No.",'');
                if Type = Type::Item then begin
              //   //("Location Code");
                  Location.TestField("Directed Put-away and Pick",false);
                end;
            end;
        }
        field(8;"No.";Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type=const(Resource)) Resource else if (Type=const(Item)) Item else if (Type=const("G/L Account")) "G/L Account";

            trigger OnValidate()
            begin
                if ("No." = '') or ("No." <> xRec."No.") then begin
                  Description := '';
                  "Unit of Measure Code" := '';
                  "Qty. per Unit of Measure" := 1;
                  "Variant Code" := '';
                  "Work Type Code" := '';
                  DeleteAmounts;
                  "Cost Factor" := 0;
                  "Applies-to Entry" := 0;
                  "Applies-from Entry" := 0;
                  CheckedAvailability := false;
                  if "No." = '' then begin
                    CreateDim(
                      DimMgt.TypeToTableID2(Type),"No.",
                      Database::Job,"Job No.",
                      Database::"Resource Group","Resource Group No.");
                    exit;
                  end else begin
                    // Preserve quantities after resetting all amounts:
                    Quantity := xRec.Quantity;
                    "Quantity (Base)" := xRec."Quantity (Base)";
                  end;
                end;

                case Type of
                  Type::Resource:
                    begin
                      Res.Get("No.");
                      Res.TestField(Blocked,false);
                      Description := Res.Name;
                      "Description 2" := Res."Name 2";
                      "Resource Group No." := Res."Resource Group No.";
                      "Gen. Prod. Posting Group" := Res."Gen. Prod. Posting Group";
                      Validate("Unit of Measure Code",Res."Base Unit of Measure");
                    end;
                  Type::Item:
                    begin
                      GetItem;
                      Item.TestField(Blocked,false);
                      Description := Item.Description;
                      "Description 2" := Item."Description 2";
                    //   if Job."Language Code" <> '' then
                    //     GetItemTranslation;
                    //   "Posting Group" := Item."Inventory Posting Group";
                    //   "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                    //   Validate("Unit of Measure Code",Item."Base Unit of Measure");
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
                end;

                Validate(Quantity);

                CreateDim(
                  DimMgt.TypeToTableID2(Type),"No.",
                  Database::Job,"Job No.",
                  Database::"Resource Group","Resource Group No.");
            end;
        }
        field(9;Description;Text[50])
        {
            Caption = 'Description';
        }
        field(10;Quantity;Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0:5;

            trigger OnValidate()
            begin
                CheckItemAvailable;

                //IF Item."Item Tracking Code" <> '' THEN
                //  ReserveJobJnlLine.VerifyQuantity(Rec,xRec);

                "Quantity (Base)" := CalcBaseQty(Quantity);
                UpdateAllAmounts;
            end;
        }
        field(12;"Direct Unit Cost (LCY)";Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost (LCY)';
            MinValue = 0;
        }
        field(13;"Unit Cost (LCY)";Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                if (Type = Type::Item) and
                   Item.Get("No.") and
                   (Item."Costing Method" = Item."costing method"::Standard) then
                  UpdateAllAmounts
                else begin
                  //;
                  "Unit Cost" := ROUND(
                      CurrExchRate.ExchangeAmtLCYToFCY(
                        "Posting Date","Currency Code",
                        "Unit Cost (LCY)","Currency Factor"),
                      UnitAmountRoundingPrecision);
                  UpdateAllAmounts;
                end;
            end;
        }
        field(14;"Total Cost (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Cost (LCY)';
            Editable = false;
        }
        field(15;"Unit Price (LCY)";Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price (LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                //;
                "Unit Price" := ROUND(
                    CurrExchRate.ExchangeAmtLCYToFCY(
                      "Posting Date","Currency Code",
                      "Unit Price (LCY)","Currency Factor"),
                    UnitAmountRoundingPrecision);
                UpdateAllAmounts;
            end;
        }
        field(16;"Total Price (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price (LCY)';
            Editable = false;
        }
        field(17;"Resource Group No.";Code[20])
        {
            Caption = 'Resource Group No.';
            Editable = false;
            TableRelation = "Resource Group";

            trigger OnValidate()
            begin
                CreateDim(
                  Database::"Resource Group","Resource Group No.",
                  Database::Job,"Job No.",
                  DimMgt.TypeToTableID2(Type),"No.");
            end;
        }
        field(18;"Unit of Measure Code";Code[10])
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
        field(21;"Location Code";Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where ("Use As In-Transit"=const(false));

            trigger OnValidate()
            begin
                "Bin Code" := '';
                if Type = Type::Item then begin
                  //("Location Code");
                  Location.TestField("Directed Put-away and Pick",false);
                  Validate(Quantity);
                end;
            end;
        }
        field(22;Chargeable;Boolean)
        {
            Caption = 'Chargeable';
            InitValue = true;

            trigger OnValidate()
            begin
                if Chargeable <> xRec.Chargeable then
                  if Chargeable = false then
                    Validate("Unit Price",0)
                  else
                    Validate("No.");
            end;
        }
        field(30;"Posting Group";Code[20])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = if (Type=const(Item)) "Inventory Posting Group" else if (Type=const("G/L Account")) "G/L Account";
        }
        field(31;"Shortcut Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));

            trigger OnValidate()
            begin
                //(1,"Shortcut Dimension 1 Code");
            end;
        }
        field(32;"Shortcut Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));

            trigger OnValidate()
            begin
                //(2,"Shortcut Dimension 2 Code");
            end;
        }
        field(33;"Work Type Code";Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";

            trigger OnValidate()
            begin
                TestField(Type,Type::Resource);
                Validate("Line Discount %",0);
                if ("Work Type Code" = '') and (xRec."Work Type Code" <> '') then begin
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
        field(34;"Customer Price Group";Code[10])
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
        field(37;"Applies-to Entry";Integer)
        {
            Caption = 'Applies-to Entry';

            trigger OnLookup()
            begin
                SelectItemEntry(FieldNo("Applies-to Entry"));
            end;

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
                //;
                TestField(Type,Type::Item);
                if "Applies-to Entry" <> 0 then begin
                  ItemLedgEntry.Get("Applies-to Entry");
                  TestField(Quantity);
                  if Quantity < 0 then
                    FieldError(Quantity,Text002);
                  ItemLedgEntry.TestField(Open,true);
                  ItemLedgEntry.TestField(Positive,true);
                  "Location Code" := ItemLedgEntry."Location Code";
                  "Variant Code" := ItemLedgEntry."Variant Code";
                  GetItem;
                  if Item."Costing Method" <> Item."costing method"::Standard then begin
                    "Unit Cost" := ROUND(
                        CurrExchRate.ExchangeAmtLCYToFCY(
                          "Posting Date","Currency Code",
                          CalcUnitCost(ItemLedgEntry),"Currency Factor"),
                        UnitAmountRoundingPrecision);
                    UpdateAllAmounts;
                  end;
                end;
            end;
        }
        field(61;"Entry Type";Option)
        {
            Caption = 'Entry Type';
            Editable = false;
            OptionCaption = 'Usage,Sale';
            OptionMembers = Usage,Sale;
        }
        field(62;"Source Code";Code[10])
        {
            Caption = 'Source Code';
            Editable = false;
            TableRelation = "Source Code";
        }
        field(73;"Journal Batch Name";Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Job-Journal Batch".Name where ("Journal Template Name"=field("Journal Template Name"));
        }
        field(74;"Reason Code";Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(75;"Recurring Method";Option)
        {
            BlankZero = true;
            Caption = 'Recurring Method';
            OptionCaption = ',Fixed,Variable';
            OptionMembers = ,"Fixed",Variable;
        }
        field(76;"Expiration Date";Date)
        {
            Caption = 'Expiration Date';
        }
        field(77;"Recurring Frequency";DateFormula)
        {
            Caption = 'Recurring Frequency';
        }
        field(79;"Gen. Bus. Posting Group";Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(80;"Gen. Prod. Posting Group";Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(81;"Transaction Type";Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(82;"Transport Method";Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(83;"Country/Region Code";Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(86;"Entry/Exit Point";Code[10])
        {
            Caption = 'Entry/Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(87;"Document Date";Date)
        {
            Caption = 'Document Date';
        }
        field(88;"External Document No.";Code[20])
        {
            Caption = 'External Document No.';
        }
        field(89;"Area";Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(90;"Transaction Specification";Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(91;"Serial No.";Code[20])
        {
            Caption = 'Serial No.';

            trigger OnLookup()
            begin
                TestField(Type,Type::Item);
                SelectItemEntry(FieldNo("Serial No."));
            end;
        }
        field(92;"Posting No. Series";Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(93;"Source Currency Code";Code[10])
        {
            Caption = 'Source Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(94;"Source Currency Total Cost";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Source Currency Total Cost';
            Editable = false;
        }
        field(95;"Source Currency Total Price";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Source Currency Total Price';
            Editable = false;
        }
        field(96;"Source Currency Line Amount";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Source Currency Line Amount';
            Editable = false;
        }
        field(480;"Dimension Set ID";Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
        field(1000;"Job Task No.";Code[20])
        {
            Caption = 'Job Task No.';
           // TableRelation = "Job-Task"."Grant Task No." where ("Grant No."=field("Job No."));

            trigger OnValidate()
            var
             //   JobTask: Record UnknownRecord53926;
            begin
                if ("Job Task No." = '') or (("Job Task No." <> xRec."Job Task No.") and (xRec."Job Task No." <> '')) then begin
                  Validate("No.",'');
                  exit;
                end;

                TestField("Job No.");
                // JobTask.Get("Job No.","Job Task No.");
                // JobTask.TestField("Grant Task Type",JobTask."grant task type"::Posting);
            end;
        }
        field(1001;"Total Cost";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Total Cost';
            Editable = false;
        }
        field(1002;"Unit Price";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price';
            MinValue = 0;

            trigger OnValidate()
            begin
                UpdateAllAmounts;
            end;
        }
        field(1003;"Line Type";Option)
        {
            Caption = 'Line Type';
            OptionCaption = ' ,Schedule,Contract,Both Schedule and Contract';
            OptionMembers = " ",Schedule,Contract,"Both Schedule and Contract";
        }
        field(1004;"Applies-from Entry";Integer)
        {
            Caption = 'Applies-from Entry';
            MinValue = 0;

            trigger OnLookup()
            begin
                SelectItemEntry(FieldNo("Applies-from Entry"));
            end;

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
                //;
                TestField(Type,Type::Item);
                if "Applies-from Entry" <> 0 then begin
                  TestField(Quantity);
                  if Quantity > 0 then
                    FieldError(Quantity,Text003);
                  ItemLedgEntry.Get("Applies-from Entry");
                  ItemLedgEntry.TestField(Positive,false);
                  if Item."Costing Method" <> Item."costing method"::Standard then begin
                    "Unit Cost" := ROUND(
                        CurrExchRate.ExchangeAmtLCYToFCY(
                          "Posting Date","Currency Code",
                          CalcUnitCostFrom(ItemLedgEntry."Entry No."),"Currency Factor"),
                        UnitAmountRoundingPrecision);
                    UpdateAllAmounts;
                  end;
                end;
            end;
        }
        field(1005;"Job Posting Only";Boolean)
        {
            Caption = 'Job Posting Only';
        }
        field(1006;"Line Discount %";Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0:5;
            MaxValue = 100;
            MinValue = 0;

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
        field(1008;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                UpdateCurrencyFactor;
            end;
        }
        field(1009;"Line Amount";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Amount';

            trigger OnValidate()
            begin
                UpdateAllAmounts;
            end;
        }
        field(1010;"Currency Factor";Decimal)
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
        field(1011;"Unit Cost";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';

            trigger OnValidate()
            begin
                UpdateAllAmounts;
            end;
        }
        field(1012;"Line Amount (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Amount (LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                //;
                "Line Amount" := ROUND(
                    CurrExchRate.ExchangeAmtLCYToFCY(
                      "Posting Date","Currency Code",
                      "Line Amount (LCY)","Currency Factor"),
                    AmountRoundingPrecision);
                UpdateAllAmounts;
            end;
        }
        field(1013;"Line Discount Amount (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Discount Amount (LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                //;
                "Line Discount Amount" := ROUND(
                    CurrExchRate.ExchangeAmtLCYToFCY(
                      "Posting Date","Currency Code",
                      "Line Discount Amount (LCY)","Currency Factor"),
                    AmountRoundingPrecision);
                UpdateAllAmounts;
            end;
        }
        field(1014;"Total Price";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Total Price';
            Editable = false;
        }
        field(1015;"Cost Factor";Decimal)
        {
            Caption = 'Cost Factor';
            Editable = false;
        }
        field(1016;"Description 2";Text[50])
        {
            Caption = 'Description 2';
        }
        field(1017;"Ledger Entry Type";Option)
        {
            Caption = 'Ledger Entry Type';
            OptionCaption = ' ,Resource,Item,G/L Account';
            OptionMembers = " ",Resource,Item,"G/L Account";
        }
        field(1018;"Ledger Entry No.";Integer)
        {
            BlankZero = true;
            Caption = 'Ledger Entry No.';
            TableRelation = if ("Ledger Entry Type"=const(Resource)) "Res. Ledger Entry" else if ("Ledger Entry Type"=const(Item)) "Item Ledger Entry" else if ("Ledger Entry Type"=const("G/L Account")) "G/L Entry";
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
        field(5468;"Reserved Qty. (Base)";Decimal)
        {
            CalcFormula = sum("Reservation Entry"."Quantity (Base)" where ("Source ID"=field("Journal Template Name"),"Source Ref. No."=field("Line No."),"Source Type"=const(1011),"Source Subtype"=field("Entry Type"),"Source Batch Name"=field("Journal Batch Name"),"Source Prod. Order Line"=const(0),"Reservation Status"=const(Reservation)));
            Caption = 'Reserved Qty. (Base)';
            DecimalPlaces = 0:5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5900;"Service Order No.";Code[20])
        {
            Caption = 'Service Order No.';
        }
        field(5901;"Posted Service Shipment No.";Code[20])
        {
            Caption = 'Posted Service Shipment No.';
        }
        field(6501;"Lot No.";Code[20])
        {
            Caption = 'Lot No.';
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Journal Template Name","Journal Batch Name","Line No.")
        {
            Clustered = true;
        }
        key(Key2;"Journal Template Name","Journal Batch Name",Type,"No.","Unit of Measure Code","Work Type Code")
        {
            MaintainSQLIndex = false;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Type = Type::Item then
;
    end;

    trigger OnInsert()
    begin
        LockTable;
        // JobJnlTemplate.Get("Journal Template Name");
        // JobJnlBatch.Get("Journal Template Name","Journal Batch Name");

        //(1,"Shortcut Dimension 1 Code");
        //(2,"Shortcut Dimension 2 Code");
        //DimMgt.InsertJnlLineDim(
        //  DATABASE::"Job Journal Line",
        //  "Journal Template Name","Journal Batch Name","Line No.",0,
        //  "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
    end;

    trigger OnModify()
    begin
        //IF (Rec.Type = Type::Item) AND (xRec.Type = Type::Item) THEN
        //  ReserveJobJnlLine.VerifyChange(Rec,xRec)
        //ELSE
          //IF (Rec.Type <> Type::Item) AND (xRec.Type = Type::Item) THEN
        //    ReserveJobJnlLine.DeleteLine(xRec);
    end;

    trigger OnRename()
    begin
        //ReserveJobJnlLine.RenameLine(Rec,xRec);
    end;

    var
        Text000: label 'You cannot change %1 when %2 is %3.';
        Location: Record Location;
        Item: Record Item;
        Res: Record Resource;
        Cust: Record Vendor;
        ItemJnlLine: Record "Item Journal Line";
        GLAcc: Record "G/L Account";
        //Job: Record UnknownRecord53913;
        WorkType: Record "Work Type";
        // JobJnlTemplate: Record UnknownRecord53916;
        // JobJnlBatch: Record UnknownRecord53922;
        // JobJnlLine: Record UnknownRecord53917;
        ItemVariant: Record "Item Variant";
        ResUnitofMeasure: Record "Resource Unit of Measure";
        ResCost: Record "Resource Cost";
        ItemTranslation: Record "Item Translation";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        SKU: Record "Stockkeeping Unit";
        GLSetup: Record "General Ledger Setup";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        ResFindUnitCost: Codeunit "Resource-Find Cost";
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UOMMgt: Codeunit "Unit of Measure Management";
        DimMgt: Codeunit DimensionManagement;
        ReserveJobJnlLine: Codeunit "Job Jnl. Line-Reserve";
        DontCheckStandardCost: Boolean;
        Text001: label 'cannot be specified without %1';
        Text002: label 'must be positive';
        Text003: label 'must be negative';
        HasGotGLSetup: Boolean;
        CurrencyDate: Date;
        UnitAmountRoundingPrecision: Decimal;
        AmountRoundingPrecision: Decimal;
        CheckedAvailability: Boolean;

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


    procedure EmptyLine(): Boolean
    begin
        exit(("Job No." = '') and ("No." = '') and (Quantity = 0));
    end;


    // procedure SetUpNewLine(LastJobJnlLine: Record UnknownRecord53917)
    // begin
    //     JobJnlTemplate.Get("Journal Template Name");
    //     JobJnlBatch.Get("Journal Template Name","Journal Batch Name");
    //     JobJnlLine.SetRange("Journal Template Name","Journal Template Name");
    //     JobJnlLine.SetRange("Journal Batch Name","Journal Batch Name");
    //     if JobJnlLine.Find('-') then begin
    //       "Posting Date" := LastJobJnlLine."Posting Date";
    //       "Document Date" := LastJobJnlLine."Posting Date";
    //       "Document No." := LastJobJnlLine."Document No.";
    //       Type := LastJobJnlLine.Type;
    //       Validate("Line Type",LastJobJnlLine."Line Type");
    //     end else begin
    //       "Posting Date" := WorkDate;
    //       "Document Date" := WorkDate;
    //       if JobJnlBatch."No. Series" <> '' then begin
    //         Clear(NoSeriesMgt);
    //         "Document No." := NoSeriesMgt.TryGetNextNo(JobJnlBatch."No. Series","Posting Date");
    //       end;
    //     end;
    //     "Recurring Method" := LastJobJnlLine."Recurring Method";
    //     "Entry Type" := "entry type"::Usage;
    //     "Source Code" := JobJnlTemplate."Source Code";
    //     "Reason Code" := JobJnlBatch."Reason Code";
    //     "Posting No. Series" := JobJnlBatch."Posting No. Series";
    // end;


    procedure CreateDim(Type1: Integer;No1: Code[20];Type2: Integer;No2: Code[20];Type3: Integer;No3: Code[20])
    var
        TableID: array [10] of Integer;
        No: array [10] of Code[20];
    begin
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        //DimMgt.GetDefaultDim(
        //  TableID,No,"Source Code",
        //  "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        if "Line No." <> 0 then
;


//     procedure //(FieldNumber: Integer;var ShortcutDimCode: Code[20])
//     begin
//         DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
//         if "Line No." <> 0 then
//           DimMgt.SaveJnlLineDim(
//             Database::"Job Journal Line","Journal Template Name",
//             "Journal Batch Name","Line No.",0,FieldNumber,ShortcutDimCode)
//         else
// ;


//     procedure LookupShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
//     begin
//         DimMgt.LookupDimValueCode(FieldNumber,ShortcutDimCode);
//         if "Line No." <> 0 then
//           DimMgt.SaveJnlLineDim(
//             Database::"Job Journal Line","Journal Template Name",
//             "Journal Batch Name","Line No.",0,FieldNumber,ShortcutDimCode)
//         else
// ;


//     procedure ShowShortcutDimCode(var ShortcutDimCode: array [8] of Code[20])
//     begin
//         /*IF "Line No." <> 0 THEN
//           DimMgt.GetDimSetIDsForFilter(
//             DATABASE::"Job Journal Line","Journal Template Name",
//             "Journal Batch Name","Line No.",0,ShortcutDimCode)
//         ELSE
//           DimMgt.ClearDimSetFilter(ShortcutDimCode);
//          */

//     end;

    // local procedure //(LocationCode: Code[10])
    // begin
    //     if LocationCode = '' then
    //       Clear(Location)
    //     else
    //       if Location.Code <> LocationCode then
    //         Location.Get(LocationCode);
    // end;


    // procedure //()
    // begin
    //     TestField("Job No.");
    //     if "Job No." <> Job."No." then begin
    //       Job.Get("Job No.");
    //       if Job."Currency Code" = '' then begin
    //         GetGLSetup;
    //         Currency.InitRoundingPrecision;
    //         AmountRoundingPrecision := GLSetup."Amount Rounding Precision";
    //         UnitAmountRoundingPrecision := GLSetup."Unit-Amount Rounding Precision";
    //       end else begin
    //         GetCurrency;
    //         Currency.Get(Job."Currency Code");
    //         Currency.TestField("Amount Rounding Precision");
    //         AmountRoundingPrecision := Currency."Amount Rounding Precision";
    //         UnitAmountRoundingPrecision := Currency."Unit-Amount Rounding Precision";
    //       end;
    //     end;
    // end;
    end;

    local procedure UpdateCurrencyFactor()
    begin
        if "Currency Code" <> '' then begin
          if "Posting Date" = 0D then
            CurrencyDate := WorkDate
          else
            CurrencyDate := "Posting Date";
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


    procedure OpenItemTrackingLines(IsReclass: Boolean)
    begin
        TestField(Type,Type::Item);
        TestField("No.");
        ///ReserveJobJnlLine.CallItemTracking(Rec,IsReclass);
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


    procedure DontCheckStdCost()
    begin
        DontCheckStandardCost := true;
    end;

    local procedure CalcUnitCost(ItemLedgEntry: Record "Item Ledger Entry"): Decimal
    var
        ValueEntry: Record "Value Entry";
        UnitCost: Decimal;
    begin
        ValueEntry.SetCurrentkey("Item Ledger Entry No.");
        ValueEntry.SetRange("Item Ledger Entry No.",ItemLedgEntry."Entry No.");
        ValueEntry.CalcSums("Cost Amount (Actual)","Cost Amount (Expected)");
        UnitCost :=
          (ValueEntry."Cost Amount (Expected)" + ValueEntry."Cost Amount (Actual)") / ItemLedgEntry.Quantity;

        exit(Abs(UnitCost * "Qty. per Unit of Measure"));
    end;

    local procedure CalcUnitCostFrom(ItemLedgEntryNo: Integer): Decimal
    var
        ValueEntry: Record "Value Entry";
        InvoicedQty: Decimal;
        CostAmount: Decimal;
    begin
        InvoicedQty := 0;
        CostAmount := 0;
        ValueEntry.Reset;
        ValueEntry.SetCurrentkey("Item Ledger Entry No.");
        ValueEntry.SetRange("Item Ledger Entry No.",ItemLedgEntryNo);
        ValueEntry.SetRange("Expected Cost",false);
        if ValueEntry.Find('-') then
          repeat
            InvoicedQty += ValueEntry."Invoiced Quantity";
            CostAmount += ValueEntry."Cost Amount (Actual)";
          until ValueEntry.Next = 0;
        exit(CostAmount / InvoicedQty * "Qty. per Unit of Measure");
    end;

    local procedure SelectItemEntry(CurrentFieldNo: Integer)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
      //  JobJnlLine2: Record UnknownRecord53917;
    begin
        ItemLedgEntry.SetCurrentkey("Item No.",Open,"Variant Code");
        ItemLedgEntry.SetRange("Item No.","No.");
        ItemLedgEntry.SetRange(Correction,false);

        if "Location Code" <> '' then
          ItemLedgEntry.SetRange("Location Code","Location Code");

        if CurrentFieldNo = FieldNo("Applies-to Entry") then begin
          ItemLedgEntry.SetRange(Positive,true);
          ItemLedgEntry.SetRange(Open,true);
        end else
          ItemLedgEntry.SetRange(Positive,false);

        //IF FORM.RUNMODAL(FORM::"Item Ledger Entries",ItemLedgEntry) = ACTION::LookupOK THEN BEGIN
          // JobJnlLine2 := Rec;
          // if CurrentFieldNo = FieldNo("Applies-to Entry") then
          //   JobJnlLine2.Validate("Applies-to Entry",ItemLedgEntry."Entry No.")
          // else
          //   JobJnlLine2.Validate("Applies-from Entry",ItemLedgEntry."Entry No.");
          // Rec := JobJnlLine2;
        //END;
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


    procedure SetCurrencyFactor(Factor: Decimal)
    begin
        "Currency Factor" := Factor;
    end;


    procedure GetItemTranslation()
    begin
        //;
        // if ItemTranslation.Get("No.","Variant Code",Job."Language Code") then begin
        //   Description := ItemTranslation.Description;
        //   "Description 2" := ItemTranslation."Description 2";
        // end;
    end;

    local procedure GetGLSetup()
    begin
        if HasGotGLSetup then
          exit;
        GLSetup.Get;
        HasGotGLSetup := true;
    end;


    procedure UpdateAllAmounts()
    begin
        //;

        UpdateUnitCost;
        UpdateTotalCost;
       // FindPriceAndDiscount(Rec,CurrFieldNo);
        // HandleCostFactor;
        // UpdateUnitPrice;
        // UpdateTotalPrice;
        // UpdateAmountsAndDiscounts;
    end;

    local procedure UpdateUnitCost()
    var
        RetrievedCost: Decimal;
    begin
        if (Type = Type::Item) and Item.Get("No.") then begin
          if Item."Costing Method" = Item."costing method"::Standard then begin
            if not DontCheckStandardCost then begin
              // Prevent manual change of unit cost on items with standard cost
              if (("Unit Cost" <> xRec."Unit Cost") or ("Unit Cost (LCY)" <> xRec."Unit Cost (LCY)")) and
                 (("No." = xRec."No.") and ("Location Code" = xRec."Location Code") and
                  ("Variant Code" = xRec."Variant Code") and ("Unit of Measure Code" = xRec."Unit of Measure Code")) then
                Error(
                  Text000,
                  FieldCaption("Unit Cost"),Item.FieldCaption("Costing Method"),Item."Costing Method");
            end;
            if RetrieveCostPrice then begin
              if GetSKU then
                "Unit Cost (LCY)" := SKU."Unit Cost" * "Qty. per Unit of Measure"
              else
                "Unit Cost (LCY)" := Item."Unit Cost" * "Qty. per Unit of Measure";
              "Unit Cost" := ROUND(
                  CurrExchRate.ExchangeAmtLCYToFCY(
                    "Posting Date","Currency Code",
                    "Unit Cost (LCY)","Currency Factor"),
                  UnitAmountRoundingPrecision);
            end else begin
              if "Unit Cost" <> xRec."Unit Cost" then
                "Unit Cost (LCY)" := ROUND(
                    CurrExchRate.ExchangeAmtFCYToLCY(
                      "Posting Date","Currency Code",
                      "Unit Cost","Currency Factor"),
                    UnitAmountRoundingPrecision)
              else
                "Unit Cost" := ROUND(
                    CurrExchRate.ExchangeAmtLCYToFCY(
                      "Posting Date","Currency Code",
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
                    "Posting Date","Currency Code",
                    RetrievedCost,"Currency Factor"),
                  UnitAmountRoundingPrecision);
              "Unit Cost (LCY)" := ROUND(
                  CurrExchRate.ExchangeAmtFCYToLCY(
                    "Posting Date","Currency Code",
                    "Unit Cost","Currency Factor"),
                  UnitAmountRoundingPrecision);
            end else begin
              "Unit Cost (LCY)" := ROUND(
                  CurrExchRate.ExchangeAmtFCYToLCY(
                    "Posting Date","Currency Code",
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
                    "Posting Date","Currency Code",
                    RetrievedCost,"Currency Factor"),
                  UnitAmountRoundingPrecision);
              "Unit Cost (LCY)" := ROUND(
                  CurrExchRate.ExchangeAmtFCYToLCY(
                    "Posting Date","Currency Code",
                    "Unit Cost","Currency Factor"),
                  UnitAmountRoundingPrecision);
            end else begin
              "Unit Cost (LCY)" := ROUND(
                  CurrExchRate.ExchangeAmtFCYToLCY(
                    "Posting Date","Currency Code",
                    "Unit Cost","Currency Factor"),
                  UnitAmountRoundingPrecision);
            end;
          end else begin
            "Unit Cost (LCY)" := ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  "Posting Date","Currency Code",
                  "Unit Cost","Currency Factor"),
                UnitAmountRoundingPrecision);
          end;
    end;

    local procedure RetrieveCostPrice(): Boolean
    begin
        case Type of
          Type::Item:
            if ("No." <> xRec."No.") or
               ("Location Code" <> xRec."Location Code") or
               ("Variant Code" <> xRec."Variant Code") or
               ("Unit of Measure Code" <> xRec."Unit of Measure Code") and
               (("Applies-to Entry" = 0) and ("Applies-from Entry" = 0)) then
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
              "Posting Date","Currency Code",
              "Total Cost","Currency Factor"),
            AmountRoundingPrecision);
    end;

   // local procedure FindPriceAndDiscount(var JobJnlLine: Record UnknownRecord53917;CalledByFieldNo: Integer)
    // begin
    //     if RetrieveCostPrice and ("No." <> '') then begin
    //     //  SalesPriceCalcMgt.FindJobJnlLinePrice(JobJnlLine,CalledByFieldNo);

    //      // IF Type <> Type::"G/L Account" THEN
    //     //    PurchPriceCalcMgt.FindJobJnlLinePrice(JobJnlLine,CalledByFieldNo)
    //       //ELSE BEGIN
    //         // Because the SalesPriceCalcMgt.FindJobJnlLinePrice function also retrieves costs for G/L Account,
    //         // cost and total cost need to get updated again.
    //         UpdateUnitCost;
    //         UpdateTotalCost;
    //       end;
    //     //END;
    // end;

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
              "Posting Date","Currency Code",
              "Unit Price","Currency Factor"),
            UnitAmountRoundingPrecision);
    end;

    local procedure UpdateTotalPrice()
    begin
        "Total Price" := ROUND(Quantity * "Unit Price",AmountRoundingPrecision);
        "Total Price (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Posting Date","Currency Code",
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
              "Posting Date","Currency Code",
              "Line Amount","Currency Factor"),
            AmountRoundingPrecision);

        "Line Discount Amount (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Posting Date","Currency Code",
              "Line Discount Amount","Currency Factor"),
            AmountRoundingPrecision);
    end;


    procedure IsInbound(): Boolean
    begin
        if "Entry Type" in ["entry type"::Usage,"entry type"::Sale] then
          exit("Quantity (Base)" < 0);

        exit(false);
    end;


    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID",StrSubstNo('%1 %2 %3',"Journal Template Name","Journal Batch Name","Line No."));
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
    end;
}

