#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516443 "Treasury Transactions"
{
    DrillDownPageID = "Teller & Treasury Trans List";
    LookupPageID = "Teller & Treasury Trans List";

    fields
    {
        field(1;No;Code[20])
        {

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                  NoSetup.Get( );
                  NoSeriesMgt.TestManual(NoSetup."Treasury Transactions No");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Transaction Date";Date)
        {
        }
        field(3;"Transaction Type";Option)
        {
            OptionCaption = 'Issue To Teller,Return To Treasury,Issue From Bank,Return To Bank,Inter Teller Transfers,End of Day Return to Treasury,Branch Treasury Transactions,Teller to Intra-Day,Intra-Day to Treasury,Treasury to Intra-Day,Intra-Day to Teller';
            OptionMembers = "Issue To Teller","Return To Treasury","Issue From Bank","Return To Bank","Inter Teller Transfers","End of Day Return to Treasury","Branch Treasury Transactions","Teller to Intra-Day","Intra-Day to Treasury","Treasury to Intra-Day","Intra-Day to Teller";

            trigger OnValidate()
            begin
                if "Transaction Type"="transaction type"::"Issue To Teller" then
                Description:='ISSUE TO TELLER';

                if "Transaction Type"="transaction type"::"Return To Treasury" then
                Description:='RETURN TO TREASURY';

                if "Transaction Type"="transaction type"::"Inter Teller Transfers" then
                Description:='INTER TELLER TRANSFERS';

                if "Transaction Type"="transaction type"::"Issue From Bank" then
                Description:='ISSUE FROM BANK';

                if "Transaction Type"="transaction type"::"Return To Bank" then
                Description:='RETURN TO BANK';

                if "Transaction Type"="transaction type"::"End of Day Return to Treasury" then
                Description:='END OF DAY RETURN TO TREASURY';


                if "Transaction Type"="transaction type"::"Branch Treasury Transactions" then
                Description:='BRANCH TREASURY TRANSACTIONS';

                if "Transaction Type"="transaction type"::"Teller to Intra-Day" then
                Description:='TELLER TO BULK CASH';

                if "Transaction Type"="transaction type"::"Intra-Day to Treasury" then
                Description:='BULK CASH TO TELLER';

                if "Transaction Type"="transaction type"::"Treasury to Intra-Day" then
                Description:='TELLER TO CASH HELD OVERNIGHT';

                if "Transaction Type"="transaction type"::"Intra-Day to Teller" then
                Description:='CASH HELD OVERNIGHT TO TELLER';

                if "Transaction Type"="transaction type"::"11" then
                Description:='TELLER TO PETTY CASH';

                if "Transaction Type"="transaction type"::"12" then
                Description:='PETTY CASH TO TELLER';




                "From Account":='';
                "To Account":='';
            end;
        }
        field(4;"From Account";Code[20])
        {
            TableRelation = if ("Transaction Type"=filter("Issue To Teller"|"Return To Bank"|"Branch Treasury Transactions"|"Intra-Day to Teller"|"Treasury to Intra-Day"|"Intra-Day to Treasury")) "Bank Account"."No." where ("Account Type"=const(Treasury))
                            else if ("Transaction Type"=filter("Return To Treasury"|"Return To Treasury"|"Inter Teller Transfers"|"End of Day Return to Treasury"|"Teller to Intra-Day")) "Bank Account"."No." where ("Account Type"=const(Cashier))
                            else if ("Transaction Type"=filter("Issue From Bank")) "Bank Account"."No." where ("Account Type"=const(" "));

            trigger OnValidate()
            begin
                BankAcc.Reset;
                BankAcc.SetRange(BankAcc."No.","From Account");
                BankAcc.CalcFields(BankAcc.Balance);
                if BankAcc.Find('-') then begin
                "From Account Name":=BankAcc.Name;
                "From Account User":=BankAcc.CashierID;
                "Source Account Balance":=BankAcc.Balance;
                Modify;
                end;



                "From Teller":="From Account";
                Validate("From Teller");

                if ObjBanks.Get("From Account") then
                  begin
                    ObjBanks.CalcFields(ObjBanks.Balance);
                    "Actual Teller Till Balance":=ObjBanks.Balance
                    end;
            end;
        }
        field(5;"To Account";Code[20])
        {
            TableRelation = if ("Transaction Type"=filter("Return To Treasury"|"Issue From Bank"|"Branch Treasury Transactions"|"End of Day Return to Treasury"|"Intra-Day to Treasury"|"Teller to Intra-Day"|"Treasury to Intra-Day")) "Bank Account"."No." where ("Account Type"=const(Treasury))
                            else if ("Transaction Type"=filter("Issue To Teller"|"Inter Teller Transfers"|"Intra-Day to Teller")) "Bank Account"."No." where ("Account Type"=const(Cashier))
                            else if ("Transaction Type"=filter("Return To Bank")) "Bank Account"."No." where ("Account Type"=const(" "));

            trigger OnValidate()
            begin
                BankAcc.Reset;
                BankAcc.SetRange(BankAcc."No.","To Account");
                BankAcc.CalcFields(BankAcc.Balance);
                if BankAcc.Find('-') then begin
                "To Account Name":=BankAcc.Name;
                  "To Account User":=BankAcc.CashierID;
                  "Destination Account Balance":=BankAcc.Balance;
                  Validate("Destination Account Balance");
                Modify;
                end;

                "To Teller":="To Account";
                Validate("To Teller");
            end;
        }
        field(6;Description;Text[100])
        {
        }
        field(7;Amount;Decimal)
        {

            trigger OnValidate()
            begin
                ObjBanks.Reset;
                ObjBanks.SetRange(ObjBanks."No.","From Account");
                if ObjBanks.Find('-') then begin
                ObjBanks.CalcFields(ObjBanks.Balance);
                AvailableBal:=(ObjBanks.Balance);

                if AvailableBal<Amount then
                  begin
                    Error('The teller/treasury/Bank account has Less than the amount specified,account balance is %1,till account %2',AvailableBal,"From Account Name");
                    end;
                end;
            end;
        }
        field(8;Posted;Boolean)
        {
        }
        field(9;"Date Posted";Date)
        {
        }
        field(10;"Time Posted";Time)
        {
        }
        field(11;"Posted By";Text[80])
        {
        }
        field(12;"No. Series";Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(13;"Transaction Time";Time)
        {
        }
        field(14;"Coinage Amount";Decimal)
        {
        }
        field(15;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(16;Issued;Option)
        {
            OptionMembers = No,Yes,"N/A";
        }
        field(17;"Date Issued";Date)
        {
        }
        field(18;"Time Issued";Time)
        {
        }
        field(19;"Issue Received";Option)
        {
            Editable = false;
            OptionMembers = No,Yes,"N/A";
        }
        field(20;"Date Received";Date)
        {
            Editable = true;
        }
        field(21;"Time Received";Time)
        {
            Editable = false;
        }
        field(22;"Issued By";Text[80])
        {
            Editable = false;
        }
        field(23;"Received By";Text[80])
        {
            Editable = false;
        }
        field(24;Received;Option)
        {
            Editable = false;
            OptionCaption = 'No,Yes';
            OptionMembers = No,Yes;
        }
        field(32;"Request No";Code[20])
        {
        }
        field(33;"Bank No";Code[20])
        {
            TableRelation = "Bank Account"."No." where (Text=const('0'));
        }
        field(34;"Denomination Total";Decimal)
        {
        }
        field(35;"External Document No.";Code[20])
        {
        }
        field(36;"Cheque No.";Code[20])
        {
        }
        field(37;"Transacting Branch";Code[20])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(38;Approved;Boolean)
        {
        }
        field(39;"End of Day Trans Time";Time)
        {
        }
        field(40;"End of Day";Date)
        {
        }
        field(41;"Last Transaction";Code[20])
        {
            CalcFormula = min("Treasury Transactions".No where ("Transaction Type"=filter("End of Day Return to Treasury"),
                                                                "To Account"=field("To Account")));
            FieldClass = FlowField;
        }
        field(42;"Total Cash on Treasury Coinage";Decimal)
        {
            CalcFormula = sum("Treasury Coinage"."Total Amount" where (No=field(No)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(43;"Till/Treasury Balance";Decimal)
        {
        }
        field(44;"Excess/Shortage Amount";Decimal)
        {
        }
        field(45;"From Account Name";Text[80])
        {
        }
        field(46;"To Account Name";Text[80])
        {
        }
        field(47;"Actual Cash At Hand";Decimal)
        {
            CalcFormula = sum("Treasury Coinage"."Total Amount" where (No=field(No)));
            FieldClass = FlowField;
        }
        field(48;"To Account User";Text[100])
        {
        }
        field(49;"From Account User";Text[100])
        {
        }
        field(50;"Source Account Balance";Decimal)
        {
        }
        field(51;"Destination Account Balance";Decimal)
        {
        }
        field(52;"Excess Amount";Decimal)
        {
            Editable = false;
        }
        field(53;"Shortage Amount";Decimal)
        {
            Editable = false;
        }
        field(54;"From Teller";Code[80])
        {

            trigger OnValidate()
            begin
                /*BankAcc.RESET;
                BankAcc.SETRANGE(BankAcc."No.","From Teller");
                BankAcc.CALCFIELDS(BankAcc.Balance);
                IF BankAcc.FIND('-') THEN BEGIN
                "From Account Name":=BankAcc.Name;
                "From Account User":=BankAcc.CashierID;
                "Source Account Balance":=BankAcc.Balance;
                
                //VALIDATE("Source Account Balance");
                MODIFY;
                END;*/
                
                if Teller.Get("From Teller") then begin
                  Teller.CalcFields(Teller."Teller Balance");
                  TillBalance:=Teller."Teller Balance";
                  "Source Account Balance":=TillBalance;
                  //"Actual Cash At Hand":=TillBalance;
                  end;

            end;
        }
        field(55;"To Teller";Code[80])
        {

            trigger OnValidate()
            begin
                if Teller.Get("To Teller") then begin
                  Teller.CalcFields(Teller."Teller Balance");
                  TillBalance:=Teller."Teller Balance";
                  "Destination Account Balance":=TillBalance;
                  end;
            end;
        }
        field(56;Status;Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(57;"Actual Teller Till Balance";Decimal)
        {
        }
        field(58;"Custodian 1 Confirm Issue";Boolean)
        {
        }
        field(59;"Custodian 1 Name_Issue";Code[30])
        {
        }
        field(60;"Custodian 2 Confirm Issue";Boolean)
        {
        }
        field(61;"Custodian 2 Name_Issue";Code[30])
        {
        }
        field(62;"Custodian 1 Confirm Receipt";Boolean)
        {
        }
        field(63;"Custodian 1 Name_Receipt";Code[30])
        {
        }
        field(64;"Custodian 2 Confirm Receipt";Boolean)
        {
        }
        field(65;"Custodian 2 Name_Receipt";Code[30])
        {
        }
    }

    keys
    {
        key(Key1;No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Posted then begin
        Error('The transaction has been posted and therefore cannot be deleted.');
        exit;
        end;
    end;

    trigger OnInsert()
    begin
        if No = '' then begin
        NoSetup.Get();
        NoSetup.TestField(NoSetup."Treasury Transactions No");
        NoSeriesMgt.InitSeries(NoSetup."Treasury Transactions No",xRec."No. Series",0D,No,"No. Series");
        end;

        if "Transaction Type"="transaction type"::"Issue To Teller" then
        Description:='ISSUE TO TELLER'
        else if "Transaction Type"="transaction type"::"Issue From Bank" then
        Description:='ISSUE FROM BANK'
        else
        Description:='RETURN TO TREASURY';

        //IF UsersID.GET(USERID) THEN
        //"Transacting Branch":=UsersID.Branch;


        "Transaction Date":=Today;
        "Transaction Time":=Time;

        Denominations.Reset;
        TransactionCoinage.Reset;
        Denominations.Init;
        TransactionCoinage.Init;

        if Denominations.Find('-') then begin

        repeat
        TransactionCoinage.No:=No;
        TransactionCoinage.Code:=Denominations.Code;
        TransactionCoinage.Description:=Denominations.Description;
        TransactionCoinage.Type:=Denominations.Type;
        TransactionCoinage.Value:=Denominations.Value;
        TransactionCoinage.Quantity:=0;
        TransactionCoinage.Insert;
        until Denominations.Next = 0;

        end;
    end;

    trigger OnModify()
    begin
        if Posted then begin
        Error('The transaction has been posted and therefore cannot be modified.');
        exit;
        end;
    end;

    trigger OnRename()
    begin
        if Posted then begin
        Error('The transaction has been posted and therefore cannot be modified.');
        exit;
        end;
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Denominations: Record Denominations;
        TransactionCoinage: Record "Treasury Coinage";
        UsersID: Record User;
        BankAcc: Record "Bank Account";
        Teller: Record "Bank Account";
        TillBalance: Decimal;
        ObjBanks: Record "Bank Account";
        AvailableBal: Decimal;
}

