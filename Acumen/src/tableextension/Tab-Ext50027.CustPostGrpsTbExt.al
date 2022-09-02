tableextension 50027 "CustPostGrpsTbExt" extends "Customer Posting Group"
{
    fields
    {
        // Add changes to table fields here
        field(51516110; "Shares Deposits Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                TestNoEntriesExist(FieldCaption("Shares Deposits Account"), "Shares Deposits Account");
            end;
        }
        field(51516112; "Registration Fees Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                TestNoEntriesExist(FieldCaption("Registration Fees Account"), "Registration Fees Account");
            end;
        }
        field(51516113; "Dividend Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                TestNoEntriesExist(FieldCaption("Dividend Account"), "Dividend Account");
            end;
        }
        field(51516114; "Withdrawal Fee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                TestNoEntriesExist(FieldCaption("Withdrawal Fee"), "Withdrawal Fee");
            end;
        }
        field(51516115; "Investment Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                TestNoEntriesExist(FieldCaption("Investment Account"), "Investment Account");
            end;
        }
        field(51516116; "Un-allocated Funds Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                TestNoEntriesExist(FieldCaption("Un-allocated Funds Account"), "Un-allocated Funds Account");
            end;
        }
        field(51516120; "Prepayment Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51516121; "Withdrawable Deposits"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                //Prevent Changing once entries exist
                TestNoEntriesExist(FieldCaption("Withdrawable Deposits"), "Withdrawable Deposits");
            end;
        }
        field(51516125; "Loan Form Fee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51516126; "Passbook Fee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51516127; "Risk Fund Charged Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51516128; "Risk Fund Paid Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51516131; "Group Shares"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51516132; "Savings Account"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51516134; "Shares Capital Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51516135; "Insurance Fund Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51516136; "Benevolent Fund Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51516137; "Recovery Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51516138; "FOSA Shares"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51516139; "Additional Shares"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51516140; "Junior Savings Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51516141; "Safari Savings Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(51516142; "Silver Savings Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }

    }

    var
        myInt: Integer;

    procedure TestNoEntriesExist(CurrentFieldName: Text[100]; GLNO: Code[20])
    var
        MembLedgEntry: Record "Cust. Ledger Entry";
    begin
        /*
          //**To prevent change of field
         MembLedgEntry.SETCURRENTKEY(MembLedgEntry."Customer Posting Group");
         MembLedgEntry.SETRANGE(MembLedgEntry."Customer Posting Group");
         IF MembLedgEntry.FIND('-') THEN
          ERROR(
          Text000,   CurrentFieldName);
          */

    end;
}