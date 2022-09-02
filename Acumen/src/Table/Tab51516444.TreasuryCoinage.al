#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516444 "Treasury Coinage"
{

    fields
    {
        field(1;No;Code[20])
        {
            TableRelation = "Treasury Transactions" where (No=field(No));
        }
        field(2;"Code";Code[20])
        {
            NotBlank = true;
            TableRelation = Denominations.Code;

            trigger OnValidate()
            begin
                if Coinage.Get(Code) then begin
                Description:=Coinage.Description;
                Type:=Coinage.Type;
                Value:=Coinage.Value;
                end;
            end;
        }
        field(3;Description;Text[50])
        {
        }
        field(4;Type;Option)
        {
            OptionMembers = Note,Coin;
        }
        field(5;Value;Decimal)
        {
        }
        field(6;Quantity;Integer)
        {

            trigger OnValidate()
            begin
                TotalDN:=0;
                AddVarDN:=0;
                "Excess/Shortage":=0;

                //

                TransactionDetails.Reset;

                TransactionDetails.SetRange(TransactionDetails.No,No);

                if TransactionDetails.Find('-') then begin
                repeat

                AddVarDN:=0;

                AddVarDN:=TransactionDetails.Value*TransactionDetails.Quantity;
                TotalDN:=TotalDN+AddVarDN;


                until TransactionDetails.Next=0;
                end;


                Transactions.Reset;
                if Transactions.Get(No) then begin;
                Transactions."Coinage Amount":=TotalDN;
                Transactions."Excess/Shortage Amount":=Transactions."Excess/Shortage Amount"-TotalDN;
                Transactions.Modify;
                end;



                if Quantity<>0 then
                "Total Amount":=Quantity*Value;
                Modify;
            end;
        }
        field(7;"Total Amount";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;No,"Code")
        {
            Clustered = true;
            SumIndexFields = "Total Amount";
        }
        key(Key2;Value)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Coinage: Record Denominations;
        TotalDN: Decimal;
        AddVarDN: Decimal;
        Transactions: Record "Treasury Transactions";
        TransactionDetails: Record "Treasury Coinage";
        "Excess/Shortage": Decimal;
}

