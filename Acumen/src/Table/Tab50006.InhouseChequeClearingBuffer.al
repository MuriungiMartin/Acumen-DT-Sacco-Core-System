#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50006 "Inhouse Cheque Clearing Buffer"
{

    fields
    {
        field(1;"No.";Code[10])
        {
        }
        field(2;"Transaction No";Code[20])
        {

            trigger OnValidate()
            begin
                if "Cheque No"="cheque no"::"0" then begin
                Cust.Reset;
                if Cust.Get("Transaction No") then begin
                "Account No":=Cust.Name;
                "Account Name":="account name"::"0";
                //"Destination Account No.":=Cust."FOSA Account";
                Validate("Transaction Type");
                end;
                end;

                if "Cheque No"="cheque no":: "2" then begin
                Bank.Reset;
                if Bank.Get("Transaction No") then begin
                "Account No":=Bank.Name;
                end;
                end;

                if "Cheque No"="cheque no"::"1" then begin
                Vend.Reset;
                if Vend.Get("Transaction No") then begin
                "Account No":=Vend.Name;
                "Drawers Member No":=Vend."BOSA Account No";

                end;
                end;

                if "Cheque No"="cheque no"::"4" then begin
                memb.Reset;
                if memb.Get("Transaction No") then begin
                "Account No":=memb.Name;
                  "Drawers Member No":=memb.Name;
                end;
                end;


                if "Cheque No"="cheque no"::"3" then begin
                "G/L".Reset;
                if "G/L".Get("Transaction No") then begin
                "Account No":="G/L".Name;
                end;
                end;

                if Accounttype.Get('CURRENT') then begin
                  Charge:=50;
                  end;
            end;
        }
        field(3;"Account No";Code[50])
        {
        }
        field(4;"Account Name";Code[100])
        {

            trigger OnValidate()
            begin
                /*IF "Destination Account Type"="Destination Account Type"::BANK THEN BEGIN
                "Destination Account No.":='5-02-09276-01';
                VALIDATE("Destination Account No.");
                END;
                   */

            end;
        }
        field(5;"Transaction Type";Code[20])
        {

            trigger OnValidate()
            begin
                if "Account Name" = "account name"::"0" then begin
                Vend.Reset;
                if Vend.Get("Transaction Type") then
                "Expected Maturity Date":=Vend.Name;
                end else
                if "Account Name" = "account name"::"2" then begin
                Cust.Reset;
                if Cust.Get("Transaction Type") then
                "Expected Maturity Date":=Cust.Name;
                end;

                if "Account Name"="account name"::"3" then begin
                "G/L".Reset;
                if "G/L".Get("Transaction Type") then begin
                "Expected Maturity Date":="G/L".Name;
                end;
                end;

                if "Account Name"="account name"::"4" then begin
                memb.Reset;
                if memb.Get("Transaction Type") then begin
                "Expected Maturity Date":=memb.Name;
                end;
                end;
                if "Account Name"="account name"::"1" then begin
                Bank.Reset;
                if Bank.Get("Transaction Type") then begin
                "Expected Maturity Date":=Bank.Name;
                end;
                end;
            end;
        }
        field(6;Amount;Decimal)
        {
        }
        field(7;"Cheque No";Code[50])
        {
        }
        field(8;"Expected Maturity Date";Date)
        {
        }
        field(9;"Cheque Clearing Status";Option)
        {
            OptionCaption = ' ,Cleared,Bounced';
            OptionMembers = " ",Cleared,Bounced;
        }
    }

    keys
    {
        key(Key1;"No.","Transaction No")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if "Transaction No" <> '' then begin
        Bosa.Reset;
        if Bosa.Get("No.") then begin
        if (Bosa.Posted) or (Bosa.Approved) then
        Error('Cannot delete approved or posted batch');
        end;
        end;
    end;

    trigger OnModify()
    begin
        if "Transaction No" <> '' then begin
        Bosa.Reset;
        if Bosa.Get("No.") then begin
        if (Bosa.Posted) or (Bosa.Approved) then
        Error('Cannot modify approved or posted batch');
        end;
        end;
    end;

    trigger OnRename()
    begin
        Bosa.Reset;
        if Bosa.Get("No.") then begin
        if (Bosa.Posted) or (Bosa.Approved) then
        Error('Cannot rename approved or posted batch');
        end;
    end;

    var
        Cust: Record "Member Register";
        Vend: Record Vendor;
        Bank: Record "Bank Account";
        Bosa: Record "BOSA Transfers";
        "G/L": Record "G/L Account";
        memb: Record "Member Register";
        Accounttype: Record "Account Types-Saving Products";
}

