#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516167 "Salary Step/Notch Transactions"
{
    // DrillDownPageID = UnknownPage55534;
    // LookupPageID = UnknownPage55534;

    fields
    {
        field(1; "Salary Grade"; Code[20])
        {
            TableRelation = "HR Salary Grades"."Salary Grade";
        }
        field(2; "Salary Step/Notch"; Code[20])
        {
            TableRelation = "HR Salary Notch"."Salary Notch" where("Salary Grade" = field("Salary Grade"));
        }
        field(3; "Transaction Code"; Code[20])
        {
            TableRelation = "prTransaction Codes"."Transaction Code";

            trigger OnValidate()
            begin
                // if Trans.Get("Transaction Code") then begin
                //     "Transaction Name" := Trans."Transaction Name";
                //     "Transaction Type" := Trans."Transaction Type";
                //     Formula := Trans.Formula;
                // end;
            end;
        }
        field(4; "Transaction Name"; Text[100])
        {
        }
        field(5; "Transaction Type"; Option)
        {
            OptionMembers = Income,Deduction;
        }
        field(6; Amount; Decimal)
        {

            trigger OnValidate()
            begin
                "Annual Amount" := Amount * 12;
            end;
        }
        field(7; "% of Basic Pay"; Decimal)
        {
        }
        field(8; Formula; Code[100])
        {
        }
        field(9; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(10; "Annual Amount"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Annual Amount" > 0 then
                    Amount := "Annual Amount" / 12;
            end;
        }
    }

    keys
    {
        key(Key1; "Salary Grade", "Salary Step/Notch", "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
    // Trans: Record UnknownRecord55507;
}

