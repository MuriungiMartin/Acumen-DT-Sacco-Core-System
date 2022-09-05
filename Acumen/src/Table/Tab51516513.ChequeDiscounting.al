#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516513 "Cheque Discounting"
{

    fields
    {
        field(1; "Transaction No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Transaction No" <> xRec."Transaction No" then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Transaction Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Created By"; Code[20])
        {
        }
        field(3; "Date Created"; Date)
        {
        }
        field(4; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Member No");
                if Cust.Find('-') then begin
                    "Member Name" := Cust.Name;
                end;
            end;
        }
        field(5; "Member Name"; Text[50])
        {
        }
        field(6; "Account No"; Code[20])
        {
            NotBlank = true;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin

                //INSERT IMAGE & SIGNATURE
                CustM.Reset;
                CustM.SetRange(CustM."No.", "Account No");
                if CustM.Find('-') then begin
                    //CustM.CALCFIELDS(CustM.Picture,CustM.Signature);
                    //Picture:=CustM.Picture;
                    //Signature:=CustM.Signature;
                end;

                //CHECK ACCOUNT ACTIVITY
                Account.Reset;
                if Account.Get("Account No") then begin
                    if Account.Status = Account.Status::Dormant then begin
                        Account.Status := Account.Status::Active;
                        Account.Modify;
                    end;
                    if Account.Status = Account.Status::New then begin
                    end
                    else begin
                        /*IF Account.Status<>Account.Status::Active THEN
                        ERROR('The account is not active and therefore cannot be transacted upon.');*/
                    end;

                    Account.CalcFields(Account.Balance);//,Account.Picture,Account.Signature
                    "Account Name" := Account.Name;
                    //Payee:=Account.Name;
                    "Account Type" := Account."Account Type";
                    //"Currency Code":=Account."Currency Code";
                    //"Staff/Payroll No":=Account."Personal No.";
                    //"ID No":=Account."ID No.";
                    //Picture:=Account.Picture;
                    //Signature:=Account.Signature;
                    if (Account.Balance <> 0) and (Account.Status = Account.Status::New) then begin
                        Account.Status := Account.Status::Active;
                        Account.Modify;
                    end;


                    if AccountTypes.Get("Account Type") then begin
                        Account.CalcFields(Account.Balance);//,Account.Picture,Account.Signature

                        //Picture:=Account.Picture;
                        //Signature:=Account.Signature;

                    end;
                    ATMApp.Reset;
                    ATMApp.SetRange(ATMApp."No.", "Account No");
                    if ATMApp.Find('-') then begin
                        if ATMApp.Collected = true then
                            Message('The ATM card for this Memer is ready for collection');
                    end;
                end;

            end;
        }
        field(7; "Account Name"; Text[200])
        {
        }
        field(8; "Savings Product"; Code[20])
        {
            TableRelation = "Account Types-Saving Products".Code;

            trigger OnValidate()
            begin
                Account.Reset;
                Account.SetRange(Account."BOSA Account No", "Member No");
                Account.SetRange(Account."Account Type", "Savings Product");
                if Account.Find('-') then begin
                    "Account No" := Account."No.";
                    "Account Name" := Account.Name;
                    Validate("Account No");
                end;
            end;
        }
        field(9; Picture; Blob)
        {
            SubType = Bitmap;
        }
        field(10; Signature; Blob)
        {
            SubType = Bitmap;
        }
        field(11; "Cheque to Discount"; Code[20])
        {
            TableRelation = Transactions.No where("Account No" = field("Account No"),
                                                   Type = filter('Cheque Deposit'),
                                                   Posted = filter(true),
                                                   "Cheque Processed" = filter(false));

            trigger OnValidate()
            begin
                Trans.Reset;
                Trans.SetRange(Trans.No, "Cheque to Discount");
                if Trans.Find('-') then begin
                    "Cheque Amount" := Trans.Amount;
                    "Cheque No" := Trans."Cheque No";
                    "Expected Maturity Date" := Trans."Expected Maturity Date";
                end;
                Gensetup.Get();
                if Account.Get("Account No") then begin
                    if Account."Allowable Cheque Discounting %" = 0 then begin
                        "VarAllowableChequeDisc%" := Gensetup."Allowable Cheque Discounting %" / 100
                    end else
                        "VarAllowableChequeDisc%" := Account."Allowable Cheque Discounting %" / 100;

                    "Percentage Discount" := "VarAllowableChequeDisc%";
                    "Discount Amount Allowable" := "Cheque Amount" * "Percentage Discount" + "Outstanding Discounted Cheque";
                end;
            end;
        }
        field(12; "Percentage Discount"; Decimal)
        {
        }
        field(13; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(14; "Account Type"; Code[20])
        {
        }
        field(15; "No. Series"; Code[20])
        {
        }
        field(16; "Cheque Amount"; Decimal)
        {
        }
        field(17; "Transaction Time"; Time)
        {
        }
        field(18; "Cheque No"; Code[20])
        {
        }
        field(19; "Expected Maturity Date"; Date)
        {
        }
        field(20; "Discount Amount Allowable"; Decimal)
        {
        }
        field(21; "Discounted Amount+Fee"; Decimal)
        {
        }
        field(22; "Amount Discounted"; Decimal)
        {

            trigger OnValidate()
            begin
                ChequeDiscountingComm := 0;
                Gensetup.Get();
                if "Amount Discounted" > "Discount Amount Allowable" then
                    Error('You Can not discount more than allowable')
                else
                    ChequeDiscountingComm := ("Amount Discounted" * Gensetup."Cheque Discounting Fee %");
                if ChequeDiscountingComm < Gensetup."Cheque Discounting Comission" then
                    ChequeDiscountingComm := Gensetup."Cheque Discounting Comission";
                "Cheque Discounting Commission" := ChequeDiscountingComm;

                ExciseDuty := ChequeDiscountingComm * (Gensetup."Excise Duty(%)" / 100);
                "Excise Duty" := ChequeDiscountingComm * (Gensetup."Excise Duty(%)" / 100);
                "Discounted Amount+Fee" := "Amount Discounted" - ((ChequeDiscountingComm) + ExciseDuty);
            end;
        }
        field(23; "Cheque Discounting Commission"; Decimal)
        {

            trigger OnValidate()
            begin
                Gensetup.Get;
                "Excise Duty" := Gensetup."Excise Duty(%)" / 100 * "Cheque Discounting Commission";
            end;
        }
        field(24; Posted; Boolean)
        {
        }
        field(25; "Posted By"; Code[20])
        {
        }
        field(26; "Date Posted"; Date)
        {
        }
        field(27; "Excise Duty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Outstanding Discounted Amount"; Decimal)
        {
            CalcFormula = sum("Discounting Ledger Entry".Amount where("Fosa Account" = field("Account No")));
            FieldClass = FlowField;
        }
        field(29; "Outstanding Discounted Cheque"; Decimal)
        {
            CalcFormula = sum("Discounting Ledger Entry".Amount where("Cheque No" = field("Cheque No"),
                                                                       "Fosa Account" = field("Account No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Transaction No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Transaction No" = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Transaction Nos.");
            NoSeriesMgt.InitSeries(NoSetup."Transaction Nos.", xRec."No. Series", 0D, "Transaction No", "No. Series");
        end;
        "Created By" := UserId;
        "Date Created" := Today;
        "Transaction Time" := Time;
    end;

    var
        Cust: Record Customer;
        CustM: Record Customer;
        Account: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
        ATMApp: Record "ATM Card Applications";
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Trans: Record Transactions;
        Gensetup: Record "Sacco General Set-Up";
        ChequeDiscountingComm: Decimal;
        ExciseDuty: Decimal;
        "VarAllowableChequeDisc%": Decimal;
}

