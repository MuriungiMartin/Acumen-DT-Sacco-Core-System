#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516270 "Journal Line Dimension"
{
    Caption = 'Journal Line Dimension';

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
        }
        field(2; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = if ("Table ID" = filter(81 | 221)) "Gen. Journal Template".Name
            else
            if ("Table ID" = const(83)) "Item Journal Template".Name
            //else if ("Table ID"=const(89)) Table88.Field1
            else
            if ("Table ID" = const(207)) "Res. Journal Template".Name
            else
            if ("Table ID" = const(54334)) "Job-Journal Line"."Journal Template Name"
            else
            if ("Table ID" = const(246)) "Req. Wksh. Template".Name
            else
            if ("Table ID" = const(5621)) "FA Journal Template".Name
            else
            if ("Table ID" = const(5635)) "Insurance Journal Template".Name;
        }
        field(3; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = if ("Table ID" = filter(81 | 221)) "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"))
            else
            if ("Table ID" = const(83)) "Item Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"))
            //    else if ("Table ID"=const(89)) Table234.Field2 where (Field1=field("Journal Template Name"))
            else
            if ("Table ID" = const(207)) "Res. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"))
            else
            if ("Table ID" = const(54334)) "Job-Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"))
            else
            if ("Table ID" = const(246)) "Requisition Wksh. Name".Name where("Worksheet Template Name" = field("Journal Template Name"))
            else
            if ("Table ID" = const(5621)) "FA Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"))
            else
            if ("Table ID" = const(5635)) "Insurance Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(4; "Journal Line No."; Integer)
        {
            Caption = 'Journal Line No.';
        }
        field(5; "Allocation Line No."; Integer)
        {
            Caption = 'Allocation Line No.';
        }
        field(6; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            NotBlank = true;
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                if not DimMgt.CheckDim("Dimension Code") then
                    Error(DimMgt.GetDimErr);
                "Dimension Value Code" := '';
            end;
        }
        field(7; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Dimension Code"));

            trigger OnValidate()
            begin
                if not DimMgt.CheckDimValue("Dimension Code", "Dimension Value Code") then
                    Error(DimMgt.GetDimErr);
            end;
        }
        field(8; "New Dimension Value Code"; Code[20])
        {
            Caption = 'New Dimension Value Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Dimension Code"));

            trigger OnValidate()
            begin
                if not DimMgt.CheckDimValue("Dimension Code", "New Dimension Value Code") then
                    Error(DimMgt.GetDimErr);
            end;
        }
    }

    keys
    {
        key(Key1; "Table ID", "Journal Template Name", "Journal Batch Name", "Journal Line No.", "Allocation Line No.", "Dimension Code")
        {
            Clustered = true;
        }
        key(Key2; "Dimension Code", "Dimension Value Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        GLSetup.Get;
        if "Dimension Code" = GLSetup."Global Dimension 1 Code" then
            UpdateGlobalDimCode(
              1, "Table ID", "Journal Template Name", "Journal Batch Name",
              "Journal Line No.", "Allocation Line No.", '', '');
        if "Dimension Code" = GLSetup."Global Dimension 2 Code" then
            UpdateGlobalDimCode(
              2, "Table ID", "Journal Template Name", "Journal Batch Name",
              "Journal Line No.", "Allocation Line No.", '', '');
    end;

    trigger OnInsert()
    begin
        if ("Dimension Value Code" = '') and ("New Dimension Value Code" = '') then
            Error(Text001, TableCaption);

        GLSetup.Get;
        if "Dimension Code" = GLSetup."Global Dimension 1 Code" then
            UpdateGlobalDimCode(
              1, "Table ID", "Journal Template Name", "Journal Batch Name",
              "Journal Line No.", "Allocation Line No.", "Dimension Value Code"
              , "New Dimension Value Code");
        if "Dimension Code" = GLSetup."Global Dimension 2 Code" then
            UpdateGlobalDimCode(
              2, "Table ID", "Journal Template Name", "Journal Batch Name",
              "Journal Line No.", "Allocation Line No.", "Dimension Value Code"
              , "New Dimension Value Code");
    end;

    trigger OnModify()
    begin
        if ("Dimension Value Code" = '') and ("New Dimension Value Code" = '') then
            Error(Text001, TableCaption);

        GLSetup.Get;
        if "Dimension Code" = GLSetup."Global Dimension 1 Code" then
            UpdateGlobalDimCode(
              1, "Table ID", "Journal Template Name", "Journal Batch Name",
              "Journal Line No.", "Allocation Line No.", "Dimension Value Code",
              "New Dimension Value Code");
        if "Dimension Code" = GLSetup."Global Dimension 2 Code" then
            UpdateGlobalDimCode(
              2, "Table ID", "Journal Template Name", "Journal Batch Name",
              "Journal Line No.", "Allocation Line No.", "Dimension Value Code"
              , "New Dimension Value Code");
    end;

    trigger OnRename()
    begin
        Error(Text000, TableCaption);
    end;

    var
        Text000: label 'You can''t rename a %1.';
        GLSetup: Record "General Ledger Setup";
        DimMgt: Codeunit DimensionManagement;
        Text001: label 'At least one dimension value code must have a value. Enter a value or delete the %1. ';


    procedure UpdateGlobalDimCode(GlobalDimCodeNo: Integer; "Table ID": Integer; "Journal Template Name": Code[10]; "Journal Batch Name": Code[10]; "Journal Line No.": Integer; "Allocation Line No.": Integer; NewDimValue: Code[20]; NewNewDimValue: Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
        ItemJnlLine: Record "Item Journal Line";
        ResJnlLine: Record "Res. Journal Line";
        JobJnlLine: Record "Job-Journal Line";
        GenJnlAlloc: Record "Gen. Jnl. Allocation";
        ReqLine: Record "Requisition Line";
        FAJnlLine: Record "FA Journal Line";
        InsuranceJnlLine: Record "Insurance Journal Line";
        PlanningComponent: Record "Planning Component";
        StdGenJnlLine: Record "Standard General Journal Line";
        StdItemJnlLine: Record "Standard Item Journal Line";
    begin
        case "Table ID" of
            Database::"Gen. Journal Line":
                begin
                    if GenJnlLine.Get("Journal Template Name", "Journal Batch Name", "Journal Line No.") then begin
                        case GlobalDimCodeNo of
                            1:
                                GenJnlLine."Shortcut Dimension 1 Code" := NewDimValue;
                            2:
                                GenJnlLine."Shortcut Dimension 2 Code" := NewDimValue;
                        end;
                        GenJnlLine.Modify(true);
                    end;
                end;
            Database::"Item Journal Line":
                begin
                    if ItemJnlLine.Get("Journal Template Name", "Journal Batch Name", "Journal Line No.") then begin
                        case GlobalDimCodeNo of
                            1:
                                begin
                                    ItemJnlLine."Shortcut Dimension 1 Code" := NewDimValue;
                                    ItemJnlLine."New Shortcut Dimension 1 Code" := NewNewDimValue;
                                end;
                            2:
                                begin
                                    ItemJnlLine."Shortcut Dimension 2 Code" := NewDimValue;
                                    ItemJnlLine."New Shortcut Dimension 2 Code" := NewNewDimValue;
                                end;
                        end;
                        ItemJnlLine.Modify(true);
                    end;
                end;
            /*----------------denno DATABASE::"BOM Journal Line":
               BEGIN
                 IF BOMJnlLine.GET("Journal Template Name","Journal Batch Name","Journal Line No.") THEN BEGIN
                   CASE GlobalDimCodeNo OF
                     1:
                       BOMJnlLine."Shortcut Dimension 1 Code" := NewDimValue;
                     2:
                       BOMJnlLine."Shortcut Dimension 2 Code" := NewDimValue;
                   END;
                   BOMJnlLine.MODIFY(TRUE);
                 END;
               END;
               ----------------*/
            Database::"Res. Journal Line":
                begin
                    if ResJnlLine.Get("Journal Template Name", "Journal Batch Name", "Journal Line No.") then begin
                        case GlobalDimCodeNo of
                            1:
                                ResJnlLine."Shortcut Dimension 1 Code" := NewDimValue;
                            2:
                                ResJnlLine."Shortcut Dimension 2 Code" := NewDimValue;
                        end;
                        ResJnlLine.Modify(true);
                    end;
                end;
            Database::"Job Journal Line":
                begin
                    if JobJnlLine.Get("Journal Template Name", "Journal Batch Name", "Journal Line No.") then begin
                        case GlobalDimCodeNo of
                            1:
                                JobJnlLine."Shortcut Dimension 1 Code" := NewDimValue;
                            2:
                                JobJnlLine."Shortcut Dimension 2 Code" := NewDimValue;
                        end;
                        JobJnlLine.Modify(true);
                    end;
                end;
            Database::"Gen. Jnl. Allocation":
                begin
                    if GenJnlAlloc.Get(
                         "Journal Template Name", "Journal Batch Name", "Journal Line No.", "Allocation Line No.")
                    then begin
                        case GlobalDimCodeNo of
                            1:
                                GenJnlAlloc."Shortcut Dimension 1 Code" := NewDimValue;
                            2:
                                GenJnlAlloc."Shortcut Dimension 2 Code" := NewDimValue;
                        end;
                        GenJnlAlloc.Modify(true);
                    end;
                end;
            Database::"Requisition Line":
                begin
                    if ReqLine.Get("Journal Template Name", "Journal Batch Name", "Journal Line No.") then begin
                        case GlobalDimCodeNo of
                            1:
                                ReqLine."Shortcut Dimension 1 Code" := NewDimValue;
                            2:
                                ReqLine."Shortcut Dimension 2 Code" := NewDimValue;
                        end;
                        ReqLine.Modify(true);
                    end;
                end;
            Database::"FA Journal Line":
                begin
                    if FAJnlLine.Get("Journal Template Name", "Journal Batch Name", "Journal Line No.") then begin
                        case GlobalDimCodeNo of
                            1:
                                FAJnlLine."Shortcut Dimension 1 Code" := NewDimValue;
                            2:
                                FAJnlLine."Shortcut Dimension 2 Code" := NewDimValue;
                        end;
                        FAJnlLine.Modify(true);
                    end;
                end;
            Database::"Insurance Journal Line":
                begin
                    if InsuranceJnlLine.Get("Journal Template Name", "Journal Batch Name", "Journal Line No.") then begin
                        case GlobalDimCodeNo of
                            1:
                                InsuranceJnlLine."Shortcut Dimension 1 Code" := NewDimValue;
                            2:
                                InsuranceJnlLine."Shortcut Dimension 2 Code" := NewDimValue;
                        end;
                        InsuranceJnlLine.Modify(true);
                    end;
                end;
            Database::"Planning Component":
                begin
                    if PlanningComponent.Get("Journal Template Name", "Journal Batch Name", "Journal Line No.", "Allocation Line No.") then begin
                        case GlobalDimCodeNo of
                            1:
                                PlanningComponent."Shortcut Dimension 1 Code" := NewDimValue;
                            2:
                                PlanningComponent."Shortcut Dimension 2 Code" := NewDimValue;
                        end;
                        PlanningComponent.Modify(true);
                    end;
                end;
            Database::"Standard General Journal Line":
                begin
                    if StdGenJnlLine.Get("Journal Template Name", "Journal Batch Name", "Journal Line No.") then begin
                        case GlobalDimCodeNo of
                            1:
                                StdGenJnlLine."Shortcut Dimension 1 Code" := NewDimValue;
                            2:
                                StdGenJnlLine."Shortcut Dimension 2 Code" := NewDimValue;
                        end;
                        StdGenJnlLine.Modify(true);
                    end;
                end;
            Database::"Standard Item Journal Line":
                begin
                    if StdItemJnlLine.Get("Journal Template Name", "Journal Batch Name", "Journal Line No.") then begin
                        case GlobalDimCodeNo of
                            1:
                                StdItemJnlLine."Shortcut Dimension 1 Code" := NewDimValue;
                            2:
                                StdItemJnlLine."Shortcut Dimension 2 Code" := NewDimValue;
                        end;
                        StdItemJnlLine.Modify(true);
                    end;
                end;
        end;

    end;
}

