#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516458 "EFT Details"
{

    fields
    {
        field(1;No;Code[20])
        {

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                  NoSetup.Get();
                  NoSeriesMgt.TestManual(NoSetup."EFT Details Nos.");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Account No";Code[20])
        {
            NotBlank = true;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                if Accounts.Get("Account No") then begin
                //Block Payments
                if (Accounts.Blocked = Accounts.Blocked::Payment) or
                   (Accounts.Blocked = Accounts.Blocked::All) then
                Error('This account has been blocked from receiving payments. %1',"Account No");


                "Account Name":=Accounts.Name;
                "Destination Account Name":=CopyStr(Accounts.Name,1,28);
                "Account Type":=Accounts."Account Type";
                "Member No":=Accounts."BOSA Account No";
                "Staff No":=Accounts."Personal No.";
                Amount:=0;
                //Remarks:='STIMA';
                if AccountTypes.Get(Accounts."Account Type") then begin
                if "Destination Account Type" = "destination account type"::External then
                Charges:=AccountTypes."External EFT Charges"
                else
                Charges:=AccountTypes."Internal EFT Charges";

                AccountTypes.TestField(AccountTypes."EFT Charges Account");
                "EFT Charges Account":=AccountTypes."EFT Charges Account";

                if EFTHeader.Get("Header No") then begin
                if EFTHeader.RTGS = true then begin
                Charges:=AccountTypes."RTGS Charges";
                AccountTypes.TestField(AccountTypes."RTGS Charges Account");
                "EFT Charges Account":=AccountTypes."RTGS Charges Account";
                end;
                end;

                end;

                end;




                Validate("Destination Account Type");
            end;
        }
        field(3;"Account Name";Code[100])
        {
        }
        field(4;"Account Type";Code[20])
        {
        }
        field(7;Amount;Decimal)
        {

            trigger OnValidate()
            begin
                /*AvailableBal:=0;
                
                
                //Available Bal
                IF Accounts.GET("Account No") THEN BEGIN
                Accounts.CALCFIELDS(Accounts.Balance,Accounts."Uncleared Cheques",Accounts."ATM Transactions");
                IF AccountTypes.GET(Accounts."Account Type") THEN BEGIN
                AvailableBal:=Accounts.Balance-(Accounts."Uncleared Cheques"+Accounts."ATM Transactions"+Charges+AccountTypes."Minimum Balance");
                
                //Other EFT's
                {//PKK
                OtherEFT:=0;
                EFTDetails.RESET;
                EFTDetails.SETRANGE(EFTDetails."Header No","Header No");
                EFTDetails.SETRANGE(EFTDetails."Account No","Account No");
                IF EFTDetails.FIND('-') THEN BEGIN
                REPEAT
                IF EFTDetails.No <> No THEN
                OtherEFT:=OtherEFT+EFTDetails.Amount+EFTDetails.Charges;
                
                UNTIL EFTDetails.NEXT = 0;
                END;
                }//PKK
                
                AvailableBal:=AvailableBal-OtherEFT;
                
                
                IF Amount > AvailableBal THEN
                ERROR('EFT Amount cannot be more than the availble balance. %1 - %2',AvailableBal,"Account No");
                //Available Bal
                
                
                //Make EFT unavailable
                //{//PLEASE UNCOMMENT
                Transactions.RESET;
                Transactions.SETRANGE(Transactions."Cheque No",No);
                IF Transactions.FIND('-') THEN
                Transactions.DELETEALL;
                
                Transactions.No:='';
                Transactions."Account No":="Account No";
                Transactions.VALIDATE(Transactions."Account No");
                IF Accounts."Account Type" = 'TWIGA' THEN
                Transactions."Transaction Type":='EFTT'
                ELSE IF Accounts."Account Type" = 'OMEGA' THEN
                Transactions."Transaction Type":='EFTMGA'
                ELSE
                Transactions."Transaction Type":='EFT';
                //Transactions.VALIDATE(Transactions."Transaction Type");
                Transactions."Cheque No":=No;
                Transactions.Amount:=Amount;
                Transactions.Posted:=TRUE;
                Transactions.INSERT(TRUE);
                //}//PLEASE UNCOMMENT
                //Make EFT unavailable
                
                END ELSE
                ERROR('Account type not found.');
                END ELSE
                ERROR('Account No. not found.');
                 */

            end;
        }
        field(8;"No. Series";Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(11;"Destination Account No";Code[20])
        {
            TableRelation = if ("Destination Account Type"=const(Internal)) Vendor."No." where ("Creditor Type"=const("FOSA Account"));

            trigger OnValidate()
            begin
                if AccountHolders.Get("Destination Account No") then begin
                "Destination Account Name":=AccountHolders.Name;
                end;
            end;
        }
        field(12;"Destination Account Name";Text[50])
        {

            trigger OnValidate()
            begin
                if StrLen("Destination Account Name") > 28 then
                Error('Destintion account name cannot be more than 28 characters.');
            end;
        }
        field(13;"Destination Account Type";Option)
        {
            OptionMembers = External,Internal;

            trigger OnValidate()
            begin

                if Accounts.Get("Account No") then begin
                if AccountTypes.Get(Accounts."Account Type") then begin
                if "Destination Account Type" = "destination account type"::External then
                Charges:=AccountTypes."External EFT Charges"
                else
                Charges:=AccountTypes."Internal EFT Charges";
                AccountTypes.TestField(AccountTypes."EFT Charges Account");
                "EFT Charges Account":=AccountTypes."EFT Charges Account";


                if EFTHeader.Get("Header No") then begin
                if EFTHeader.RTGS = true then begin
                Charges:=AccountTypes."RTGS Charges";
                AccountTypes.TestField(AccountTypes."RTGS Charges Account");
                "EFT Charges Account":=AccountTypes."RTGS Charges Account";
                end;
                end;

                end;
                end;
            end;
        }
        field(14;Transferred;Boolean)
        {
        }
        field(15;"Date Transferred";Date)
        {
        }
        field(16;"Time Transferred";Time)
        {
        }
        field(17;"Transferred By";Text[60])
        {
        }
        field(18;"Date Entered";Date)
        {
        }
        field(19;"Time Entered";Time)
        {
        }
        field(20;"Entered By";Text[50])
        {
        }
        field(21;Remarks;Text[150])
        {
        }
        field(22;"Payee Bank Name";Text[200])
        {
        }
        field(23;"Bank No";Code[20])
        {
            TableRelation = Banks.Code;

            trigger OnValidate()
            begin
                BanksList.Reset;
                BanksList.SetRange(BanksList.Code,"Bank No");
                if BanksList.Find('-') then begin
                "Payee Bank Name":=BanksList."Bank Name";
                end;

                EFTHeader.Reset;
                EFTHeader.SetRange(EFTHeader.No,"Header No");
                if EFTHeader.Find('-') then begin
                if "Payee Bank Name"<>EFTHeader.Bank then
                EFTHeader.RTGS:=true;
                if AccTypes.Get("Account Type") then
                Charges:=AccTypes."RTGS Charges";
                EFTHeader.Modify;
                end;



                EFTHeader.Reset;
                EFTHeader.SetRange(EFTHeader.No,"Header No");
                if EFTHeader.Find('-') then begin
                if "Payee Bank Name"=EFTHeader.Bank then
                EFTHeader.RTGS:=false;
                EFTHeader.Modify;
                "Destination Account Type":="destination account type"::External;
                Validate("Destination Account Type");
                end;
            end;
        }
        field(24;Charges;Decimal)
        {
        }
        field(25;"Header No";Code[20])
        {
            TableRelation = "Bank Transfer Header Details".No;
        }
        field(26;"Member No";Code[20])
        {
        }
        field(27;"Amount Text";Text[20])
        {
        }
        field(28;ExportFormat;Text[78])
        {
        }
        field(29;EAccNo;Text[20])
        {
        }
        field(30;EBankCode;Text[6])
        {
        }
        field(31;EAccName;Text[32])
        {
        }
        field(32;EAmount;Text[10])
        {
        }
        field(33;EReff;Text[5])
        {
        }
        field(34;"Staff No";Code[20])
        {
        }
        field(35;"Over Drawn";Boolean)
        {
        }
        field(37;Primary;Decimal)
        {
        }
        field(38;"Standing Order No";Code[20])
        {
        }
        field(39;"EFT Type";Option)
        {
            OptionMembers = Normal,"ATM EFT";
        }
        field(40;"EFT Charges Account";Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(41;"Standing Order Register No";Code[20])
        {
        }
        field(42;"Don't Charge";Boolean)
        {
        }
        field(43;"Phone No.";Text[50])
        {
        }
        field(44;"Not Available";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Header No","Account No","Destination Account No",No)
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
        key(Key2;"Header No",No)
        {
        }
        key(Key3;"Staff No")
        {
        }
        key(Key4;"Account No","Not Available",Transferred)
        {
            SumIndexFields = Amount;
        }
        key(Key5;"Date Entered")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Transferred = true then
        Error('You cannot modify an already posted record.');

        Transactions.Reset;
        Transactions.SetRange(Transactions."Cheque No",No);
        //Transactions.SETRANGE(Transactions."Transaction Type",'EFT');
        //Transactions.SETRANGE(Transactions."Account No","Account No");
        if Transactions.Find('-') then
        Transactions.DeleteAll;

        Transactions.Reset;
        Transactions.SetRange(Transactions."Cheque No",No);
        //Transactions.SETRANGE(Transactions."Transaction Type",'EFTT');
        //Transactions.SETRANGE(Transactions."Account No","Account No");
        if Transactions.Find('-') then
        Transactions.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if No = '' then begin
        NoSetup.Get();
        NoSetup.TestField(NoSetup."EFT Details Nos.");
        NoSeriesMgt.InitSeries(NoSetup."EFT Details Nos.",xRec."No. Series",0D,No,"No. Series");
        end;

        "Date Entered":=Today;
        "Time Entered":=Time;
        "Entered By":=UserId;
    end;

    trigger OnModify()
    begin
        if Transferred = true then
        Error('You cannot modify an already posted record.');
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Accounts: Record Vendor;
        Members: Record Vendor;
        AccountHolders: Record Vendor;
        Banks: Record "Bank Account";
        BanksList: Record Banks;
        StLen: Integer;
        GenAmount: Text[50];
        FundsTransferDetails: Record "EFT Details";
        AccountTypes: Record "Account Types-Saving Products";
        MinimumAccBal: Decimal;
        EFTCHG: Decimal;
        GenLedgerSetup: Record "General Ledger Setup";
        ATMBalance: Decimal;
        TotalUnprocessed: Decimal;
        chqtransactions: Record Transactions;
        AccBal: Decimal;
        AvailableBal: Decimal;
        Transactions: Record Transactions;
        EFTDetails: Record "EFT Details";
        OtherEFT: Decimal;
        EFTHeader: Record "Bank Transfer Header Details";
        AccTypes: Record "Account Types-Saving Products";
}

