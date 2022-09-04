#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516057 "Pending Vch. Surr. Line"
{

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "No."; Integer)
        {
            NotBlank = true;
        }
        field(3; "Voucher no."; Code[20])
        {
            NotBlank = false;
        }
        field(4; "Account No."; Code[20])
        {
            TableRelation = if ("Type Of Surrender" = const(Receipt)) "G/L Account"."No." where("Direct Posting" = const(true)) else
            if ("Type Of Surrender" = const(Cash)) Logos.Code;

            trigger OnValidate()
            begin
                //check the type of account selected by the system user
                if "Type Of Surrender" = "type of surrender"::Receipt then begin
                    TestField("Account No.");
                    Acc.Reset;
                    if Acc.Get("Account No.") then begin
                        //check the type of account selected by the user
                        if Acc."Account Type" <> Acc."account type"::Posting then begin
                            Error('Only accounts of Account Type Posting Can Be Selected ');
                        end;
                        if Acc."Direct Posting" = false then begin
                            Error('Direct Posting must be Enabled On Account ' + Format(Acc."No."));
                        end;
                        "Account Name" := Acc.Name;
                    end;
                end
                else begin
                    Emp.Reset;
                    Emp.Get("Account No.");
                    //  "Account Name":=Emp.FullName;
                end;
            end;
        }
        field(5; "Account Name"; Text[30])
        {
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(8; Amount; Decimal)
        {
        }
        field(9; Posted; Boolean)
        {
        }
        field(10; "Posted By"; Code[20])
        {
        }
        field(11; "Posted Date"; Date)
        {
        }
        field(12; "Posted Time"; Time)
        {
        }
        field(13; "Type Of Surrender"; Option)
        {
            OptionMembers = Receipt,Cash;
        }
        field(14; "Entry No."; Integer)
        {
            NotBlank = false;
        }
        field(15; "VAT Prod. Posting Group"; Code[20])
        {
            TableRelation = "VAT Product Posting Group".Code;
        }
    }

    keys
    {
        key(Key1; "Line No.", "No.", "Voucher no.", "Entry No.", "Type Of Surrender")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Header.Reset;
        // Header.SetRange(Header."No.","No.");
        // if Header.FindFirst then
        //   begin
        //     "Voucher no.":=Header."Voucher No.";
        //     "Entry No.":=Header."Entry No.";
        //     "Global Dimension 1 Code":=Header."Global Dimension 1 Code";
        //     "Global Dimension 2 Code":=Header."Global Dimension 2 Code";
        //   end;
    end;

    var
        Acc: Record "G/L Account";
        Header: Record "Interest Buffer";
        Emp: Record "Salary Processing Header";
}

