#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50001 "Document Dimension09"
{
    Caption = 'Document Dimension';

    fields
    {
        field(1;"Table ID";Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            TableRelation = AllObj."Object ID" where ("Object Type"=const(Table));
        }
        field(2;"Document Type";Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order, ';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ";
        }
        field(3;"Document No.";Code[20])
        {
            Caption = 'Document No.';
        }
        field(4;"Line No.";Integer)
        {
            Caption = 'Line No.';
        }
        field(5;"Dimension Code";Code[20])
        {
            Caption = 'Dimension Code';
            NotBlank = true;
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                if not DimMgt.CheckDim("Dimension Code") then
                  Error(DimMgt.GetDimErr);
            end;
        }
        field(6;"Dimension Value Code";Code[20])
        {
            Caption = 'Dimension Value Code';
            NotBlank = true;
            TableRelation = "Dimension Value".Code where ("Dimension Code"=field("Dimension Code"));

            trigger OnValidate()
            begin
                if not DimMgt.CheckDimValue("Dimension Code","Dimension Value Code") then
                  Error(DimMgt.GetDimErr);
            end;
        }
    }

    keys
    {
        key(Key1;"Table ID","Document Type","Document No.","Line No.","Dimension Code")
        {
            Clustered = true;
        }
        key(Key2;"Dimension Code","Dimension Value Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        GLSetup.Get;
        UpdateLineDim(Rec,true);
        if "Dimension Code" = GLSetup."Global Dimension 1 Code" then
          UpdateGlobalDimCode(
            1,"Table ID","Document Type","Document No.","Line No.",'');
        if "Dimension Code" = GLSetup."Global Dimension 2 Code" then
          UpdateGlobalDimCode(
            2,"Table ID","Document Type","Document No.","Line No.",'');
    end;

    trigger OnInsert()
    begin
        TestField("Dimension Value Code");
        GLSetup.Get;
        UpdateLineDim(Rec,false);
        if "Dimension Code" = GLSetup."Global Dimension 1 Code" then
          UpdateGlobalDimCode(
            1,"Table ID","Document Type","Document No.","Line No.","Dimension Value Code");
        if "Dimension Code" = GLSetup."Global Dimension 2 Code" then
          UpdateGlobalDimCode(
            2,"Table ID","Document Type","Document No.","Line No.","Dimension Value Code");
    end;

    trigger OnModify()
    begin
        GLSetup.Get;
        UpdateLineDim(Rec,false);
        if "Dimension Code" = GLSetup."Global Dimension 1 Code" then
          UpdateGlobalDimCode(
            1,"Table ID","Document Type","Document No.","Line No.","Dimension Value Code");
        if "Dimension Code" = GLSetup."Global Dimension 2 Code" then
          UpdateGlobalDimCode(
            2,"Table ID","Document Type","Document No.","Line No.","Dimension Value Code");
    end;

    trigger OnRename()
    begin
        Error(Text000,TableCaption);
    end;

    var
        Text000: label 'You can not rename a %1.';
        Text001: label 'You have changed a dimension.\\';
        Text002: label 'Do you want to update the lines?';
        Text003: label 'You may have changed a dimension.\\Do you want to update the lines?';
        GLSetup: Record "General Ledger Setup";
        DimMgt: Codeunit DimensionManagement;
        UpdateLine: Option NotSet,Update,DoNotUpdate;


    procedure UpdateGlobalDimCode(GlobalDimCodeNo: Integer;"Table ID": Integer;"Document Type": Option;"Document No.": Code[20];"Line No.": Integer;NewDimValue: Code[20])
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        ReminderHeader: Record "Reminder Header";
        FinChrgMemoHeader: Record "Finance Charge Memo Header";
        TransHeader: Record "Transfer Header";
        TransLine: Record "Transfer Line";
        ServHeader: Record "Service Header";
        ServLine: Record "Service Line";
        ServItemLine: Record "Service Item Line";
        StdSalesLine: Record "Standard Sales Line";
        StdPurchLine: Record "Standard Purchase Line";
        StdServLine: Record "Standard Service Line";
    begin
        case "Table ID" of
          Database::"Sales Header":
            begin
              if SalesHeader.Get("Document Type","Document No.") then begin
                case GlobalDimCodeNo of
                  1:
                    SalesHeader."Shortcut Dimension 1 Code" := NewDimValue;
                  2:
                    SalesHeader."Shortcut Dimension 2 Code" := NewDimValue;
                end;
                SalesHeader.Modify(true);
              end;
            end;
          Database::"Sales Line":
            begin
              if SalesLine.Get("Document Type","Document No.","Line No.") then begin
                case GlobalDimCodeNo of
                  1:
                    SalesLine."Shortcut Dimension 1 Code" := NewDimValue;
                  2:
                    SalesLine."Shortcut Dimension 2 Code" := NewDimValue;
                end;
                SalesLine.Modify(true);
              end;
            end;
          Database::"Purchase Header":
            begin
              if PurchHeader.Get("Document Type","Document No.") then begin
                case GlobalDimCodeNo of
                  1:
                    PurchHeader."Shortcut Dimension 1 Code" := NewDimValue;
                  2:
                    PurchHeader."Shortcut Dimension 2 Code" := NewDimValue;
                end;
                PurchHeader.Modify(true);
              end;
            end;
          Database::"Purchase Line":
            begin
              if PurchLine.Get("Document Type","Document No.","Line No.") then begin
                case GlobalDimCodeNo of
                  1:
                    PurchLine."Shortcut Dimension 1 Code" := NewDimValue;
                  2:
                    PurchLine."Shortcut Dimension 2 Code" := NewDimValue;
                end;
                PurchLine.Modify(true);
              end;
            end;
          Database::"Reminder Header":
            begin
              if ReminderHeader.Get("Document No.") then begin
                case GlobalDimCodeNo of
                  1:
                    ReminderHeader."Shortcut Dimension 1 Code" := NewDimValue;
                  2:
                    ReminderHeader."Shortcut Dimension 2 Code" := NewDimValue;
                end;
                ReminderHeader.Modify(true);
              end;
            end;
          Database::"Finance Charge Memo Header":
            begin
              if FinChrgMemoHeader.Get("Document No.") then begin
                case GlobalDimCodeNo of
                  1:
                    FinChrgMemoHeader."Shortcut Dimension 1 Code" := NewDimValue;
                  2:
                    FinChrgMemoHeader."Shortcut Dimension 2 Code" := NewDimValue;
                end;
                FinChrgMemoHeader.Modify(true);
              end;
            end;
          Database::"Transfer Header":
            begin
              if TransHeader.Get("Document No.") then begin
                case GlobalDimCodeNo of
                  1:
                    TransHeader."Shortcut Dimension 1 Code" := NewDimValue;
                  2:
                    TransHeader."Shortcut Dimension 2 Code" := NewDimValue;
                end;
                TransHeader.Modify(true);
              end;
            end;
          Database::"Transfer Line":
            begin
              if TransLine.Get("Document No.","Line No.") then begin
                case GlobalDimCodeNo of
                  1:
                    TransLine."Shortcut Dimension 1 Code" := NewDimValue;
                  2:
                    TransLine."Shortcut Dimension 2 Code" := NewDimValue;
                end;
                TransLine.Modify(true);
              end;
            end;
          Database::"Service Header":
            begin
              if ServHeader.Get("Document Type","Document No.") then begin
                case GlobalDimCodeNo of
                  1:
                    ServHeader."Shortcut Dimension 1 Code" := NewDimValue;
                  2:
                    ServHeader."Shortcut Dimension 2 Code" := NewDimValue;
                end;
                ServHeader.Modify(true);
              end;
            end;
          Database::"Service Line":
            begin
              if ServLine.Get("Document Type","Document No.","Line No.") then begin
                case GlobalDimCodeNo of
                  1:
                    ServLine."Shortcut Dimension 1 Code" := NewDimValue;
                  2:
                    ServLine."Shortcut Dimension 2 Code" := NewDimValue;
                end;
                ServLine.Modify(true);
              end;
            end;
          Database::"Service Item Line":
            begin
              if ServItemLine.Get("Document Type","Document No.","Line No.") then begin
                case GlobalDimCodeNo of
                  1:
                    ServItemLine."Shortcut Dimension 1 Code" := NewDimValue;
                  2:
                    ServItemLine."Shortcut Dimension 2 Code" := NewDimValue;
                end;
                ServItemLine.Modify(true);
              end;
            end;
          Database::"Standard Sales Line":
            begin
              if StdSalesLine.Get("Document No.","Line No.") then begin
                case GlobalDimCodeNo of
                  1:
                    StdSalesLine."Shortcut Dimension 1 Code" := NewDimValue;
                  2:
                    StdSalesLine."Shortcut Dimension 2 Code" := NewDimValue;
                end;
                StdSalesLine.Modify(true);
              end;
            end;
          Database::"Standard Purchase Line":
            begin
              if StdPurchLine.Get("Document No.","Line No.") then begin
                case GlobalDimCodeNo of
                  1:
                    StdPurchLine."Shortcut Dimension 1 Code" := NewDimValue;
                  2:
                    StdPurchLine."Shortcut Dimension 2 Code" := NewDimValue;
                end;
                StdPurchLine.Modify(true);
              end;
            end;
          Database::"Standard Service Line":
            begin
              if StdServLine.Get("Document No.","Line No.") then begin
                case GlobalDimCodeNo of
                  1:
                    StdServLine."Shortcut Dimension 1 Code" := NewDimValue;
                  2:
                    StdServLine."Shortcut Dimension 2 Code" := NewDimValue;
                end;
                StdServLine.Modify(true);
              end;
            end;
        end;
    end;


    procedure UpdateLineDim(var DocDim: Record "Gen. Jnl. Dim. Filter";FromOnDelete: Boolean)
    var
        NewDocDim: Record "Gen. Jnl. Dim. Filter";
        SalesLine: Record "Sales Line";
        PurchaseLine: Record "Purchase Line";
        TransLine: Record "Transfer Line";
        ServItemLine: Record "Service Item Line";
        ServLine: Record "Service Line";
        Question: Text[250];
        UpdateDim: Boolean;
    begin
        with DocDim do begin
          if ("Table ID" = Database::"Sales Header") or
             ("Table ID" = Database::"Purchase Header") or
             ("Table ID" = Database::"Transfer Header") or
             ("Table ID" = Database::"Service Header") or
             ("Table ID" = Database::"Service Item Line")
          then begin
            Question := StrSubstNo(Text001 + Text002);
            case "Table ID" of
              Database::"Sales Header":
                NewDocDim.SetRange("Table ID",Database::"Sales Line");
              Database::"Purchase Header":
                NewDocDim.SetRange("Table ID",Database::"Purchase Line");
              Database::"Transfer Header":
                NewDocDim.SetRange("Table ID",Database::"Transfer Line");
              Database::"Service Header":
                begin
                  if ("Document Type" = ServItemLine."document type"::Order) or
                     ("Document Type" = ServItemLine."document type"::Quote)
                  then
                    NewDocDim.SetRange("Table ID",Database::"Service Item Line")
                  else
                    NewDocDim.SetRange("Table ID",Database::"Service Line");
                end;
              Database::"Service Item Line":
                NewDocDim.SetRange("Table ID",Database::"Service Line");
            end;
            NewDocDim.SetRange("Document Type","Document Type");
            NewDocDim.SetRange("Document No.","Document No.");
            NewDocDim.SetRange("Dimension Code","Dimension Code");
            if FromOnDelete then
              if not NewDocDim.FindFirst then
                exit;
            case "Table ID" of
              Database::"Sales Header":
                begin
                  SalesLine.SetRange("Document Type","Document Type");
                  SalesLine.SetRange("Document No.","Document No.");
                  SalesLine.SetFilter("No.",'<>%1','');
                  if SalesLine.FindSet then begin
                    if GuiAllowed then begin
                      if Dialog.Confirm(Question,true) then begin
                        NewDocDim.DeleteAll(true);
                        if not FromOnDelete then
                          repeat
                            InsertNew(DocDim,Database::"Sales Line",SalesLine."Line No.");
                          until SalesLine.Next = 0;
                      end
                    end else begin
                      NewDocDim.DeleteAll(true);
                      if not FromOnDelete then
                        repeat
                          InsertNew(DocDim,Database::"Sales Line",SalesLine."Line No.");
                        until SalesLine.Next = 0;
                    end;
                  end;
                end;
              Database::"Purchase Header":
                begin
                  PurchaseLine.SetRange("Document Type","Document Type");
                  PurchaseLine.SetRange("Document No.","Document No.");
                  PurchaseLine.SetFilter("No.",'<>%1','');
                  if PurchaseLine.FindSet then begin
                    if GuiAllowed then begin
                      if Dialog.Confirm(Question,true) then begin
                        NewDocDim.DeleteAll(true);
                        if not FromOnDelete then
                          repeat
                            InsertNew(DocDim,Database::"Purchase Line",PurchaseLine."Line No.");
                          until PurchaseLine.Next = 0;
                      end;
                    end else begin
                      NewDocDim.DeleteAll(true);
                      if not FromOnDelete then
                        repeat
                          InsertNew(DocDim,Database::"Purchase Line",PurchaseLine."Line No.");
                        until PurchaseLine.Next = 0;
                    end;
                  end;
                end;
              Database::"Transfer Header":
                begin
                  TransLine.SetRange("Document No.","Document No.");
                  TransLine.SetRange("Derived From Line No.",0);
                  if TransLine.FindSet then begin
                    if GuiAllowed then begin
                      if Dialog.Confirm(Question,true) then begin
                        NewDocDim.DeleteAll(true);
                        if not FromOnDelete then
                          repeat
                            InsertNew(DocDim,Database::"Transfer Line",TransLine."Line No.");
                          until TransLine.Next = 0;
                      end;
                    end else begin
                      NewDocDim.DeleteAll(true);
                      if not FromOnDelete then
                        repeat
                          InsertNew(DocDim,Database::"Transfer Line",TransLine."Line No.");
                        until TransLine.Next = 0;
                    end;
                  end;
                end;

              Database::"Service Header":
                begin
                  if ("Document Type" = "document type"::Order) or
                     ("Document Type" = "document type"::Quote)
                  then begin
                    ServItemLine.SetRange("Document Type","Document Type");
                    ServItemLine.SetRange("Document No.","Document No.");

                    if ServItemLine.Find('-') then
                      if GuiAllowed = false or (UpdateLine = Updateline::Update) then
                        UpdateDim := true
                      else
                        if Dialog.Confirm(Question,true) then
                          UpdateDim := true
                        else
                          UpdateDim := false
                    else
                      UpdateDim := false;

                    if UpdateDim then begin
                      GLSetup.Get;
                      repeat
                        NewDocDim.SetRange("Line No.",ServItemLine."Line No.");
                        if NewDocDim.Find('-') then begin
                          NewDocDim.SetRecursiveValue(true);
                          NewDocDim.Delete(true);
                        end;
                      until ServItemLine.Next = 0;

                      if not FromOnDelete then begin
                        ServItemLine.Find('-');
                        repeat
                          SetRecursiveValue(true);
                          InsertNew(DocDim,Database::"Service Item Line",ServItemLine."Line No.");
                        until ServItemLine.Next = 0;
                      end;
                    end;

                    ServLine.SetRange("Document Type","Document Type");
                    ServLine.SetRange("Document No.","Document No.");
                    ServLine.SetRange("Service Item Line No.",0);
                    if ServLine.Find('-') then begin
                      if UpdateDim then begin
                        NewDocDim.SetRange("Table ID",Database::"Service Line");
                        repeat
                          NewDocDim.SetRange("Line No.",ServLine."Line No.");
                          if NewDocDim.Find('-') then begin
                            NewDocDim.SetRecursiveValue(true);
                            NewDocDim.Delete(true);
                          end;
                        until ServItemLine.Next = 0;
                        if not FromOnDelete then begin
                          ServLine.FindFirst;
                          repeat
                            SetRecursiveValue(true);
                            InsertNew(DocDim,Database::"Service Line",ServLine."Line No.");
                          until ServLine.Next = 0;
                        end;
                      end;
                    end;

                  end else begin
                    ServLine.SetRange("Document Type","Document Type");
                    ServLine.SetRange("Document No.","Document No.");
                    ServItemLine.SetRange("Document Type","Document Type");
                    ServItemLine.SetRange("Document No.","Document No.");

                    if ServLine.Find('-') or ServItemLine.Find('-') then
                      if Dialog.Confirm(Question,true) then
                        UpdateDim := true;

                    if ServLine.Find('-') then begin
                      NewDocDim.SetRange("Table ID",Database::"Service Line");
                      if GuiAllowed then begin
                        if UpdateDim then begin
                          NewDocDim.DeleteAll(true);
                          if not FromOnDelete then
                            repeat
                              InsertNew(DocDim,Database::"Service Line",ServLine."Line No.");
                            until ServLine.Next = 0;
                        end;
                      end else begin
                        NewDocDim.DeleteAll(true);
                        if not FromOnDelete then
                          repeat
                            InsertNew(DocDim,Database::"Service Line",ServLine."Line No.");
                          until ServLine.Next = 0;
                      end;
                    end;

                    if ServItemLine.Find('-') then begin
                      NewDocDim.SetRange("Table ID",Database::"Service Item Line");
                      if GuiAllowed then begin
                        if UpdateDim then begin
                          NewDocDim.DeleteAll(true);
                          if not FromOnDelete then
                            repeat
                              InsertNew(DocDim,Database::"Service Item Line",ServItemLine."Line No.");
                            until ServItemLine.Next = 0;
                        end;
                      end else begin
                        NewDocDim.DeleteAll(true);
                        if not FromOnDelete then
                          repeat
                            InsertNew(DocDim,Database::"Service Item Line",ServItemLine."Line No.");
                          until ServItemLine.Next = 0;
                      end;
                    end;
                  end;
                end;
              Database::"Service Item Line":
                begin
                  if UpdateLine = Updateline::Update then
                    SetRecursiveValue(true);
                  UpdateServLineDim(DocDim,FromOnDelete);
                end
            end;
          end;
        end;
    end;


    procedure GetDimensions(TableNo: Integer;DocType: Option;DocNo: Code[20];DocLineNo: Integer;var TempDocDim: Record "Gen. Jnl. Dim. Filter")
    var
        DocDim: Record "Gen. Jnl. Dim. Filter";
    begin
        TempDocDim.DeleteAll;

        with DocDim do begin
          Reset;
          SetRange("Table ID",TableNo);
          SetRange("Document Type",DocType);
          SetRange("Document No.",DocNo);
          SetRange("Line No.",DocLineNo);
          if FindSet then
            repeat
              TempDocDim := DocDim;
              TempDocDim.Insert;
            until Next = 0;
        end;
    end;


    procedure UpdateAllLineDim(TableNo: Integer;DocType: Option;DocNo: Code[20];var OldDocDimHeader: Record "Gen. Jnl. Dim. Filter")
    var
        DocDimHeader: Record "Gen. Jnl. Dim. Filter";
        DocDimLine: Record "Gen. Jnl. Dim. Filter";
        SalesLine: Record "Sales Line";
        PurchaseLine: Record "Purchase Line";
        LineTableNo: Integer;
    begin
        case TableNo of
          Database::"Sales Header":
            begin
              LineTableNo := Database::"Sales Line";
              SalesLine.SetRange("Document Type",DocType);
              SalesLine.SetRange("Document No.",DocNo);
              if not SalesLine.FindFirst then
                exit;
            end;
          Database::"Purchase Header":
            begin
              LineTableNo := Database::"Purchase Line";
              PurchaseLine.SetRange("Document Type",DocType);
              PurchaseLine.SetRange("Document No.",DocNo);
              if not PurchaseLine.FindFirst then
                exit;
            end;
          Database::"Service Header":
            begin
              UpdateAllServLineDim(TableNo,DocType,DocNo,OldDocDimHeader,0);
              exit;
            end;
        end;

        DocDimHeader.SetRange("Table ID",TableNo);
        DocDimHeader.SetRange("Document Type",DocType);
        DocDimHeader.SetRange("Document No.",DocNo);
        DocDimHeader.SetRange("Line No.",0);

        DocDimLine.SetRange("Document Type",DocType);
        DocDimLine.SetRange("Document No.",DocNo);
        DocDimLine.SetFilter("Line No.",'<>0');

        if not (DocDimHeader.FindFirst or OldDocDimHeader.FindFirst) then
          exit;

        if UpdateLine <> Updateline::Update then
          if GuiAllowed then
            if not Confirm(Text003,true) then
              exit;

        // Going through all the dimensions on the Header AFTER they have been updated
        with DocDimHeader do
          if FindSet then
            repeat
              if not OldDocDimHeader.Get("Table ID","Document Type","Document No.","Line No.","Dimension Code") or
                 (OldDocDimHeader."Dimension Value Code" <> "Dimension Value Code")
              then begin
                DocDimLine.SetRange("Dimension Code","Dimension Code");
                case TableNo of
                  Database::"Sales Header":
                    begin
                      DocDimLine.SetRange("Table ID",LineTableNo);
                      DocDimLine.DeleteAll(true);

                      SalesLine.SetRange("Document Type",DocType);
                      SalesLine.SetRange("Document No.",DocNo);
                      if SalesLine.FindSet then
                        repeat
                          InsertNew(DocDimHeader,LineTableNo,SalesLine."Line No.");
                        until SalesLine.Next = 0;
                    end;
                  Database::"Purchase Header":
                    begin
                      DocDimLine.SetRange("Table ID",LineTableNo);
                      DocDimLine.DeleteAll(true);

                      PurchaseLine.SetRange("Document Type",DocType);
                      PurchaseLine.SetRange("Document No.",DocNo);
                      if PurchaseLine.Find('-') then
                        repeat
                          InsertNew(DocDimHeader,LineTableNo,PurchaseLine."Line No.");
                        until PurchaseLine.Next = 0;
                    end;
                end;
              end;
            until Next = 0;

        // Going through all the dimensions on the Header BEFORE they have been updated
        // If the DimCode were there before but not anymore, all DimLines with the DimCode are deleted
        with OldDocDimHeader do
          if Find('-') then
            repeat
              if not DocDimHeader.Get("Table ID","Document Type","Document No.","Line No.","Dimension Code") then begin
                DocDimLine.SetRange("Dimension Code","Dimension Code");
                DocDimLine.DeleteAll(true);
              end;
            until Next = 0;
    end;

    local procedure InsertNew(var DocDim: Record "Gen. Jnl. Dim. Filter";TableNo: Integer;LineNo: Integer)
    var
        NewDocDim: Record "Gen. Jnl. Dim. Filter";
    begin
        with DocDim do begin
          NewDocDim."Table ID" := TableNo;
          NewDocDim."Document Type" := "Document Type";
          NewDocDim."Document No." := "Document No.";
          NewDocDim."Line No." := LineNo;
          NewDocDim."Dimension Code" := "Dimension Code";
          NewDocDim."Dimension Value Code" := "Dimension Value Code";
          if UpdateLine = Updateline::Update then
            NewDocDim.SetRecursiveValue(true)
          else
            if UpdateLine = Updateline::DoNotUpdate then
              NewDocDim.SetRecursiveValue(false);
          NewDocDim.Insert(true);
        end;
    end;


    procedure OnDeleteServRec()
    begin
        GLSetup.Get;
        UpdateLineDim(Rec,true);
        if "Dimension Code" = GLSetup."Global Dimension 1 Code" then
          UpdateGlobalDimCode(
            1,"Table ID","Document Type","Document No.","Line No.",'');
        if "Dimension Code" = GLSetup."Global Dimension 2 Code" then
          UpdateGlobalDimCode(
            2,"Table ID","Document Type","Document No.","Line No.",'');
    end;


    procedure UpdateServLineDim(var DocDim: Record "Gen. Jnl. Dim. Filter";FromOnDelete: Boolean)
    var
        NewDocDim: Record "Gen. Jnl. Dim. Filter";
        ServLine: Record "Service Line";
        ServItemLine: Record "Service Item Line";
        Question: Text[250];
        UpdateDim: Boolean;
    begin
        with DocDim do begin
          if "Table ID" = Database::"Service Item Line" then begin
            Question := StrSubstNo(Text001 + Text002);
            NewDocDim.SetRange("Table ID",Database::"Service Line");
            NewDocDim.SetRange("Document Type","Document Type");
            NewDocDim.SetRange("Document No.","Document No.");
            NewDocDim.SetRange("Dimension Code","Dimension Code");

            if FromOnDelete then
              if not NewDocDim.Find('-') then
                exit;

            ServItemLine.SetRange("Document Type","Document Type");
            ServItemLine.SetRange("Document No.","Document No.");
            ServItemLine.SetRange("Line No.","Line No.");

            if ServItemLine.Find('-') then begin

              ServLine.SetRange("Document Type","Document Type");
              ServLine.SetRange("Document No.","Document No.");
              ServLine.SetRange("Service Item Line No.",ServItemLine."Line No.");
              if ServLine.Find('-') then begin
                if GuiAllowed = false or (UpdateLine = Updateline::Update) then
                  UpdateDim := true;

                if UpdateDim = false then
                  if Dialog.Confirm(Question,true) then begin
                    SetRecursiveValue(true);
                    UpdateDim := true;
                  end else
                    SetRecursiveValue(false);

                if UpdateDim then begin
                  ServLine.Find('-');
                  repeat
                    NewDocDim.SetRange("Line No.",ServLine."Line No.");
                    if NewDocDim.Find('-') then begin
                      NewDocDim.SetRecursiveValue(true);
                      NewDocDim.DeleteAll(true);
                    end;
                  until ServLine.Next = 0;
                  if not FromOnDelete then begin
                    ServLine.Find('-');
                    repeat
                      SetRecursiveValue(true);
                      InsertNew(DocDim,Database::"Service Line",ServLine."Line No.");
                    until ServLine.Next = 0;
                  end;
                end;
              end;
            end;
          end;
        end;
    end;


    procedure SetRecursiveValue(Recursive: Boolean)
    begin
        if Recursive then
          UpdateLine := Updateline::Update
        else
          UpdateLine := Updateline::DoNotUpdate;
    end;


    procedure UpdateAllServLineDim(TableNo: Integer;DocType: Option;DocNo: Code[20];var OldDocDimHeader: Record "Gen. Jnl. Dim. Filter";DocLineNo: Integer)
    var
        DocDimHeader: Record "Gen. Jnl. Dim. Filter";
        DocDimLine: Record "Gen. Jnl. Dim. Filter";
        ServLine: Record "Service Line";
        ServItemLine: Record "Service Item Line";
    begin
        case TableNo of
          Database::"Service Header":
            begin
              ServLine.SetRange("Document Type",DocType);
              ServLine.SetRange("Document No.",DocNo);
              ServItemLine.SetRange("Document Type",DocType);
              ServItemLine.SetRange("Document No.",DocNo);
              if not ServLine.Find('-') and not ServItemLine.Find('-') then
                exit;
            end;
          Database::"Service Item Line":
            begin
              ServItemLine.SetRange("Document Type",DocType);
              ServItemLine.SetRange("Document No.",DocNo);
              ServItemLine.SetRange("Line No.",DocLineNo);
              if ServItemLine.FindFirst then;

              ServLine.SetRange("Document Type",DocType);
              ServLine.SetRange("Document No.",DocNo);
              ServLine.SetRange("Service Item Line No.",ServItemLine."Line No.");
              if not ServLine.Find('-') then
                exit;

              DocDimLine.SetRange("Table ID",Database::"Service Line");
            end;
          else
            exit;
        end;

        DocDimHeader.SetRange("Table ID",TableNo);
        DocDimHeader.SetRange("Document Type",DocType);
        DocDimHeader.SetRange("Document No.",DocNo);
        DocDimHeader.SetRange("Line No.",DocLineNo);

        DocDimLine.SetRange("Document Type",DocType);
        DocDimLine.SetRange("Document No.",DocNo);


        if not (DocDimHeader.Find('-') or OldDocDimHeader.Find('-')) then
          exit;

        if UpdateLine <> Updateline::Update then
          if GuiAllowed then
            if not Confirm(Text003,true) then
              exit;

        // Going through all the dimensions on the Header AFTER they have been updated
        with DocDimHeader do
          if Find('-') then
            repeat
              if not OldDocDimHeader.Get("Table ID","Document Type","Document No.","Line No.","Dimension Code") or
                 (OldDocDimHeader."Dimension Value Code" <> "Dimension Value Code")
              then begin
                DocDimLine.SetRange("Dimension Code","Dimension Code");
                case TableNo of
                  Database::"Service Header":
                    begin
                      DocDimLine.SetFilter("Line No.",'<>0');
                      DocDimLine.SetRange("Table ID",Database::"Service Item Line");
                      if DocDimLine.FindSet then
                        repeat
                          DocDimLine.SetRecursiveValue(true);
                          DocDimLine.Delete(true);
                        until DocDimLine.Next = 0;

                      DocDimLine.SetRange("Table ID",Database::"Service Line");
                      if DocDimLine.Find('-') then
                        repeat
                          DocDimLine.SetRecursiveValue(true);
                          DocDimLine.Delete(true);
                        until DocDimLine.Next = 0;

                      if (DocType = ServLine."document type"::Order) or
                         (DocType = ServLine."document type"::Quote)
                      then begin
                        if ServItemLine.Find('-') then
                          repeat
                            Rec.SetRecursiveValue(true);
                            InsertNew(DocDimHeader,Database::"Service Item Line",ServItemLine."Line No.");
                          until ServItemLine.Next = 0;
                        ServLine.SetRange("Service Item Line No.",0);
                        if ServLine.Find('-') then
                          repeat
                            Rec.SetRecursiveValue(true);
                            InsertNew(DocDimHeader,Database::"Service Line",ServLine."Line No.");
                          until ServLine.Next = 0;
                      end else
                        if ServLine.Find('-') then
                          repeat
                            Rec.SetRecursiveValue(true);
                            InsertNew(DocDimHeader,Database::"Service Line",ServLine."Line No.");
                          until ServLine.Next = 0;
                    end;
                  Database::"Service Item Line":
                    begin
                      if ServItemLine.FindFirst then
                        repeat
                          ServLine.SetRange("Service Item Line No.",ServItemLine."Line No.");
                          if ServLine.Find('-') then begin
                            repeat
                              DocDimLine.SetRange("Line No.",ServLine."Line No.");
                              if DocDimLine.Find('-') then
                                repeat
                                  Rec.SetRecursiveValue(true);
                                  DocDimLine.Delete(true);
                                until DocDimLine.Next = 0;
                            until ServLine.Next = 0;

                            ServLine.Find('-');
                            repeat
                              Rec.SetRecursiveValue(true);
                              InsertNew(DocDimHeader,Database::"Service Line",ServLine."Line No.");
                            until ServLine.Next = 0;
                          end;
                        until ServItemLine.Next = 0;
                    end;
                end;
              end;
            until Next = 0;

        // Going through all the dimensions on the Header BEFORE they have been updated
        // If the DimCode were there before but not anymore, all DimLines with the DimCode are deleted
        with OldDocDimHeader do
          if FindSet then
            repeat
              if not DocDimHeader.Get("Table ID","Document Type","Document No.","Line No.","Dimension Code") then begin
                DocDimLine.SetRange("Dimension Code","Dimension Code");
                DocDimLine.SetRecursiveValue(true);
                DocDimLine.DeleteAll(true);
              end;
            until Next = 0;
    end;
}

