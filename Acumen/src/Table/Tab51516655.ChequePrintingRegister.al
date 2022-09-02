#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516655 "Cheque Printing Register"
{

    fields
    {
        field(1;"Reference No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Date;Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Cheque Bank";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin

                BankAccount.Reset;
                BankAccount.SetRange(BankAccount."No.","Cheque Bank");
                if BankAccount.Find('-') then begin
                "Bank Name":=BankAccount.Name;

                end;
            end;
        }
        field(4;"Payment to";Text[35])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                 "Payment to":=UpperCase("Payment to");
            end;
        }
        field(5;"Payment Naration";Text[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Payment Naration":=UpperCase("Payment Naration");
            end;
        }
        field(6;Amount;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Cheque No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Cheque Nos Generation"."Cheque No." where ("Bank Code"=field("Cheque Bank"),
                                                                        Issued=filter(false));
        }
        field(8;"Cheque Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Created By";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Printed By";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Bank Name";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(12;"No. Series";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Cheque Printing Status";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Created,Issued';
            OptionMembers = Created,Issued;
        }
    }

    keys
    {
        key(Key1;"Reference No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin


          if "Reference No" = '' then begin
           GenLedgerSetup.Get;
           GenLedgerSetup.TestField(GenLedgerSetup."Cheque Printing Ref No.");
           NoSeriesMgt.InitSeries(GenLedgerSetup."Cheque Printing Ref No.",xRec."No. Series",0D,"Reference No","No. Series");
          end;

        Date:=Today;
    end;

    var
        BankAccount: Record "Bank Account";
        BankName: Text[30];
        GenLedgerSetup: Record "Funds General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

