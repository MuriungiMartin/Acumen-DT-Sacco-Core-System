#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516902 "Bulk Withdrawal Application"
{

    fields
    {
        field(1;"Transaction No";Code[20])
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
        field(2;"Created By";Code[30])
        {
        }
        field(3;"Date Created";Date)
        {
        }
        field(4;"Member No";Code[20])
        {
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            begin
                  Cust.Reset;
                  Cust.SetRange(Cust."No.","Member No");
                  if Cust.Find('-') then begin
                    "Member Name":=Cust.Name;
                    end;
            end;
        }
        field(5;"Member Name";Text[50])
        {
        }
        field(6;"Account No";Code[20])
        {
            NotBlank = true;
            TableRelation = Vendor."No." where ("BOSA Account No"=field("Member No"));

            trigger OnValidate()
            begin
                
                //INSERT IMAGE & SIGNATURE
                CustM.Reset;
                CustM.SetRange(CustM."No.","Account No");
                if CustM.Find('-') then begin
                //CustM.CALCFIELDS(CustM.Picture,CustM.Signature);
                //Picture:=CustM.Picture;
                //Signature:=CustM.Signature;
                end;
                
                //CHECK ACCOUNT ACTIVITY
                Account.Reset;
                if Account.Get("Account No") then begin
                if Account.Status=Account.Status::Dormant then begin
                Account.Status:=Account.Status::Active;
                Account.Modify;
                end;
                if Account.Status=Account.Status::New then begin
                end
                else begin
                /*IF Account.Status<>Account.Status::Active THEN
                ERROR('The account is not active and therefore cannot be transacted upon.');*/
                end;
                
                Account.CalcFields(Account.Balance);//,Account.Picture,Account.Signature
                "Account Name":=Account.Name;
                //Payee:=Account.Name;
                "Account Type":=Account."Account Type";
                //"Currency Code":=Account."Currency Code";
                //"Staff/Payroll No":=Account."Personal No.";
                //"ID No":=Account."ID No.";
                //Picture:=Account.Picture;
                //Signature:=Account.Signature;
                if (Account.Balance <> 0) and (Account.Status = Account.Status::New) then begin
                Account.Status:=Account.Status::Active;
                Account.Modify;
                end;
                
                
                if AccountTypes.Get("Account Type") then begin
                Account.CalcFields(Account.Balance);//,Account.Picture,Account.Signature
                
                //Picture:=Account.Picture;
                //Signature:=Account.Signature;
                
                end;
                ATMApp.Reset;
                ATMApp.SetRange(ATMApp."No.","Account No");
                if ATMApp.Find('-') then begin
                if ATMApp.Collected=true then
                Message('The ATM card for this Memer is ready for collection');
                end;
                end;

            end;
        }
        field(7;"Account Name";Text[200])
        {
        }
        field(8;"Savings Product";Code[20])
        {
            TableRelation = "Account Types-Saving Products".Code;

            trigger OnValidate()
            begin
                Account.Reset;
                Account.SetRange(Account."BOSA Account No","Member No");
                Account.SetRange(Account."Account Type","Savings Product");
                if Account.Find('-') then begin
                "Account No":=Account."No.";
                "Account Name":=Account.Name;
                Validate("Account No");
                end;
            end;
        }
        field(9;Picture;MediaSet)
        {
        }
        field(10;Signature;MediaSet)
        {
        }
        field(11;"Amount to Withdraw";Decimal)
        {

            trigger OnValidate()
            begin
                ObjWithCharges.Reset;
                ObjWithCharges.SetRange(ObjWithCharges."Notice Status",ObjWithCharges."notice status"::Notified);
                if ObjWithCharges.FindSet then begin
                  repeat
                   if ("Amount to Withdraw">=ObjWithCharges."Minimum Amount") and ("Amount to Withdraw"<=ObjWithCharges."Maximum Amount")  then begin
                    if ObjWithCharges."Use Percentage"=true then begin
                      "Fee on Withdrawal":="Amount to Withdraw"*(ObjWithCharges."Percentage of Amount"/100)
                      end else
                      "Fee on Withdrawal":=ObjWithCharges.Amount;
                    end;
                  until ObjWithCharges.Next=0;
                  end;

                Gensetup.Get();
                ExciseDuty:=ROUND("Fee on Withdrawal"*(Gensetup."Excise Duty(%)"/100),0.05,'>');
                "Fee on Withdrawal":="Fee on Withdrawal"+ExciseDuty;
            end;
        }
        field(12;"Date for Withdrawal";Date)
        {
        }
        field(13;Status;Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(14;"Account Type";Code[20])
        {
        }
        field(15;"No. Series";Code[20])
        {
        }
        field(16;"Reason for Bulk Withdrawal";Text[50])
        {
        }
        field(17;"Transaction Time";Time)
        {
        }
        field(18;"Available Account Balance";Decimal)
        {
        }
        field(19;"Fee on Withdrawal";Decimal)
        {
        }
        field(20;"Noticed Updated";Boolean)
        {
        }
        field(21;"Notice Updated By";Code[30])
        {
        }
        field(22;"Date Notified";Date)
        {
        }
    }

    keys
    {
        key(Key1;"Transaction No")
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
        NoSeriesMgt.InitSeries(NoSetup."Transaction Nos.",xRec."No. Series",0D,"Transaction No","No. Series");
        end;
        "Created By":=UserId;
        "Date Created":=Today;
        "Transaction Time":=Time;
    end;

    var
        Cust: Record "Member Register";
        CustM: Record "Member Register";
        Account: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
        ATMApp: Record "ATM Card Applications";
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Trans: Record Transactions;
        Gensetup: Record "Sacco General Set-Up";
        ChequeDiscountingComm: Decimal;
        ObjWithCharges: Record "CWithdrawal Graduated Charges";
        ExciseDuty: Decimal;
}

