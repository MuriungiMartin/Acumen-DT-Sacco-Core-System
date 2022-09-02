#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516110 "Item Groups"
{
    DrillDownPageID = "Item Groups";
    LookupPageID = "Item Groups";

    fields
    {
        field(1;"Code";Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(3;Description;Text[50])
        {
            Caption = 'Description';
        }
        field(4;"Def. Gen. Prod. Posting Group";Code[10])
        {
            Caption = 'Def. Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group".Code;
        }
        field(5;"Def. Inventory Posting Group";Code[10])
        {
            Caption = 'Def. Inventory Posting Group';
            TableRelation = "Inventory Posting Group".Code;
        }
        field(6;"Def. Tax Group Code";Code[10])
        {
            Caption = 'Def. Tax Group Code';
            TableRelation = "Tax Group".Code;
        }
        field(7;"Def. Costing Method";Option)
        {
            Caption = 'Def. Costing Method';
            OptionCaption = 'FIFO,LIFO,Specific,Average,Standard';
            OptionMembers = FIFO,LIFO,Specific,"Average",Standard;
        }
        field(8;"Def. VAT Prod. Posting Group";Code[10])
        {
            Caption = 'Def. VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group".Code;
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ItemCategory.SetRange(ItemCategory.Code);
        ItemCategory.DeleteAll;
    end;

    var
        ItemCategory: Record "Item Category";
}

