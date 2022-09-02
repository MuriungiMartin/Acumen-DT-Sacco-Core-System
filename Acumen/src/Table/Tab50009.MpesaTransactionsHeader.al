#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50009 "Mpesa Transactions Header"
{

    fields
    {
        field(1;"Transaction No.";Code[20])
        {
        }
        field(2;"Account No.";Code[20])
        {
            NotBlank = true;
            TableRelation = if ("Account Type"=const(Member)) "Member Register"."No." where ("Customer Type"=filter(Member))
                            else if ("Account Type"=const(Debtor)) Customer."No."
                            else if ("Account Type"=const("G/L Account")) "G/L Account"."No."
                            else if ("Account Type"=const("FOSA Loan")) "Member Register"."No." where ("Customer Type"=const(Member))
                            else if ("Account Type"=const(Vendor)) Vendor."No." where ("Creditor Type"=filter("FOSA Account"));

            trigger OnValidate()
            begin
                TestField(Source);

                if ("Account Type" = "account type"::"FOSA Loan") or
                   ("Account Type" = "account type"::Debtor) then begin
                if Cust.Get("Account No.") then begin
                Name:=Cust.Name;

                end;
                end;
                if ("Account Type" = "account type"::Member) then begin
                if Mem.Get("Account No.") then
                Name:=Mem.Name;
                end;

                if ("Account Type" = "account type"::Vendor) then begin
                if Vend.Get("Account No.") then
                Name:=Vend.Name;
                end;

                if ("Account Type" = "account type"::"G/L Account") then begin
                if GLAcct.Get("Account No.") then begin
                Name:=GLAcct.Name;
                end;
                end;
            end;
        }
        field(3;Name;Text[50])
        {
        }
        field(4;Amount;Decimal)
        {
            NotBlank = true;

            trigger OnValidate()
            begin

                MpesaCharge.Reset;
                if MpesaCharge.Find('-') then begin
                repeat
                if (Amount>=MpesaCharge."Min Amount") and (Amount<=MpesaCharge."Max Amount") then
                if "Transaction Type"="transaction type"::Withdrawal then
                MchargeOtherMpesa:=MpesaCharge."Transfer to Other M-PESA User"
                else
                if "Transaction Type"="transaction type"::Deposit then
                MchargeOtherMpesa:=MpesaCharge."Withdrawal From M-PESA Agent";

                until MpesaCharge.Next=0;
                end;
                Gensetup.Get();

                Message('MchargeOtherMpesa is %1',MchargeOtherMpesa);
                ReceiptAllo.Init;
                ReceiptAllo."Document No":="Transaction No.";
                ReceiptAllo."Mpesa Account Type":=ReceiptAllo."mpesa account type"::"G/L Account";
                ReceiptAllo."Mpesa Account No":=Gensetup."Comission Received Mpesa";
                ReceiptAllo.Amount:=MchargeOtherMpesa;
                ReceiptAllo.Insert;

                Gensetup.Get();
                if "Transaction Type"="transaction type"::Withdrawal then begin
                ReceiptAllo.Init;
                ReceiptAllo."Document No":="Transaction No.";
                ReceiptAllo."Mpesa Account Type":=ReceiptAllo."mpesa account type"::"G/L Account";
                ReceiptAllo."Mpesa Account No":=Gensetup."Mpesa Cash Withdrawal fee ac";
                ReceiptAllo.Amount:=Gensetup."Mpesa Withdrawal Fee";
                ReceiptAllo.Insert;

                ReceiptAllo.Init;
                ReceiptAllo."Document No":="Transaction No.";
                ReceiptAllo."Mpesa Account Type":=ReceiptAllo."mpesa account type"::"G/L Account";
                ReceiptAllo."Mpesa Account No":=Gensetup."Excise Duty Account";
                ReceiptAllo.Amount:=(MchargeOtherMpesa+Gensetup."Mpesa Withdrawal Fee")*(Gensetup."Excise Duty(%)"/100);
                ReceiptAllo.Insert;

                end;
            end;
        }
        field(5;"Transaction Ref No.";Code[20])
        {

            trigger OnValidate()
            begin
                BOSARcpt.Reset;
                BOSARcpt.SetRange(BOSARcpt."Transaction Ref No.","Transaction Ref No.");
                BOSARcpt.SetRange(BOSARcpt.Posted,true);
                if BOSARcpt.Find('-') then
                Error('Cheque no already exist in a posted receipt.');
            end;
        }
        field(6;"Document Date";Date)
        {
        }
        field(7;Posted;Boolean)
        {
            Editable = true;
        }
        field(8;"Receipt Bank";Code[20])
        {
            Editable = true;
            TableRelation = if (Source=const(Bosa)) "Bank Account"."No."
                            else if (Source=const(Fosa)) "Bank Account"."No.";
        }
        field(9;"User ID";Code[50])
        {
            Editable = false;
        }
        field(10;"Allocated Amount";Decimal)
        {
            CalcFormula = sum("Receipt Allocation".Amount where ("Document No"=field("Transaction No.")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                /*CALCFIELDS("Un allocated Amount");
                VALIDATE("Un allocated Amount");
                */

            end;
        }
        field(11;"Transaction Date";Date)
        {
            Editable = true;
        }
        field(12;"Transaction Time";Time)
        {
            Editable = false;
        }
        field(13;"No. Series";Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(14;"Account Type";Option)
        {
            OptionCaption = 'Member,Debtor,G/L Account,FOSA Loan,Customer,Vendor';
            OptionMembers = Member,Debtor,"G/L Account","FOSA Loan",Customer,Vendor;
        }
        field(15;"Transaction Slip Type";Option)
        {
            OptionCaption = ' ,Standing Order,Direct Debit,Direct Deposit,Cash,Cheque,M-Pesa';
            OptionMembers = " ","Standing Order","Direct Debit","Direct Deposit",Cash,Cheque,"M-Pesa";
        }
        field(16;"Bank Name";Code[50])
        {
        }
        field(50000;Insuarance;Decimal)
        {
            FieldClass = Normal;
        }
        field(50001;"Un allocated Amount";Decimal)
        {
        }
        field(50002;Source;Option)
        {
            OptionMembers = " ",Bosa,Fosa;
        }
        field(50003;"Mode of Payment";Option)
        {
            OptionCaption = 'Mpesa';
            OptionMembers = Mpesa;
        }
        field(50004;Remarks;Text[50])
        {
        }
        field(50005;"Code";Code[20])
        {
        }
        field(50006;Type;Option)
        {
            NotBlank = true;
            OptionMembers = " ",Receipt,Payment,Imprest,Advance;
        }
        field(50007;Description;Text[50])
        {
        }
        field(50008;"Default Grouping";Code[20])
        {
            Editable = false;
        }
        field(50009;"Transation Remarks";Text[50])
        {
        }
        field(50010;"Customer Payment On Account";Boolean)
        {
        }
        field(50011;"G/L Account";Code[20])
        {
            TableRelation = if ("Account Type"=const("G/L Account")) "G/L Account"."No.";

            trigger OnValidate()
            begin
                GLAcc.Reset;
                
                if GLAcc.Get("G/L Account") then
                begin
                //IF Type=Type::Payment THEN
                 //  GLAcc.TESTFIELD(GLAcc."Budget Controlled",TRUE);
                if GLAcc."Direct Posting"=false then
                  begin
                    Error('Direct Posting must be True');
                  end;
                end;
                
                 /*PayLine.RESET;
                 PayLine.SETRANGE(PayLine.Type,Code);
                 IF PayLine.FIND('-') THEN
                    ERROR('This Transaction Code Is Already in Use You Cannot Delete');uncomment*/

            end;
        }
        field(50012;Blocked;Boolean)
        {
        }
        field(50013;"Transaction Type";Option)
        {
            OptionCaption = 'Deposit,Withdrawal';
            OptionMembers = Deposit,Withdrawal;
        }
    }

    keys
    {
        key(Key1;"Transaction No.")
        {
            Clustered = true;
        }
        key(Key2;"Account Type",Posted)
        {
            SumIndexFields = Amount;
        }
        key(Key3;"Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*
        IF Posted THEN
        ERROR('Cannot delete a posted transaction');
        */

    end;

    trigger OnInsert()
    begin
        if "Transaction No." = '' then begin
        NoSetup.Get();
        NoSetup.TestField(NoSetup."BOSA Receipts Nos");
        NoSeriesMgt.InitSeries(NoSetup."BOSA Receipts Nos",xRec."No. Series",0D,"Transaction No.","No. Series");
        end;

        "User ID":=UserId;
        "Transaction Date":=Today;
        "Transaction Time":=Time;
    end;

    trigger OnModify()
    begin
        /*IF Posted THEN
        ERROR('Cannot modify a posted transaction');
        */

    end;

    trigger OnRename()
    begin
        /*IF Posted THEN
        ERROR('Cannot rename a posted transaction');
        */

    end;

    var
        Cust: Record Customer;
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        BOSARcpt: Record "Mpesa Transactions Header";
        GLAcct: Record "G/L Account";
        Mem: Record "Member Register";
        Vend: Record Vendor;
        GLAcc: Record "G/L Account";
        PayLine: Record "Payment Line.";
        MpesaCharge: Record "M-PESA Charges";
        MchargeOtherMpesa: Decimal;
        MchargeUnregistered: Decimal;
        MchargeWith: Decimal;
        ReceiptAllo: Record "Receipt Allocation";
        Gensetup: Record "Sacco General Set-Up";
}

