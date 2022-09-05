#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516484 "Funds Transfer Logs"
{

    fields
    {
        field(1; "Document No"; Code[50])
        {
        }
        field(2; "Source Account"; Code[100])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                Vendor.Reset;
                Vendor.SetRange(Vendor."No.", "Source Account");
                if Vendor.Find('-') then begin
                    //REPEAT
                    AccountTypes.Reset;
                    AccountTypes.SetRange(AccountTypes.Code, Vendor."Account Type");
                    if AccountTypes.Find('-') then begin

                        "Source Account Type" := "Source Account Type" + AccountTypes.Description;

                        //"Source Account Type":="Source Account Type"+Vendor."No."+' - '+AccountTypes.Description;
                    end;
                    //UNTIL Vendor.NEXT=0;
                end;
            end;
        }
        field(3; "Destination Account"; Code[100])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                Vendor.Reset;
                Vendor.SetRange(Vendor."No.", "Destination Account");
                if Vendor.Find('-') then begin
                    //REPEAT
                    "Destination Account Name" := "Destination Account Name" + Vendor.Name;
                end;
            end;
        }
        field(4; "Transaction Amount"; Decimal)
        {
        }
        field(5; "Transaction Date"; DateTime)
        {
        }
        field(6; "Member No"; Code[100])
        {
            TableRelation = Customer."No.";
        }
        field(7; "No. Series"; Code[100])
        {
            TableRelation = "No. Series";
        }
        field(8; "External Transfer"; Boolean)
        {
        }
        field(9; "Transaction Code"; Code[100])
        {
        }
        field(10; "Transfer Verified"; Boolean)
        {
        }
        field(11; "ID Number"; Code[40])
        {
        }
        field(12; "Posting Date"; DateTime)
        {
        }
        field(13; Posted; Boolean)
        {
        }
        field(14; "Reference No"; Code[100])
        {
        }
        field(15; Status; Option)
        {
            OptionCaption = 'Pending,Posted,Declined';
            OptionMembers = Pending,Posted,Declined;
        }
        field(16; Comments; Text[250])
        {
        }
        field(18; "Transaction Type"; Option)
        {
            OptionCaption = 'Account Transfer,Mpesa Withrawal';
            OptionMembers = "Account Transfer","Mpesa Withrawal";
        }
        field(19; Telephone; Code[50])
        {
        }
        field(20; Description; Text[250])
        {
        }
        field(21; "Source Account Type"; Code[100])
        {
        }
        field(22; "Destination Account Name"; Code[150])
        {
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Transaction Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Transaction Nos.", xRec."No. Series", 0D, "Document No", "No. Series");
        end;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Vendor: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
}

