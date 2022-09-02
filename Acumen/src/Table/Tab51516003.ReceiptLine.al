#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516003 "Receipt Line"
{

    fields
    {
        field(10;"Line No";Integer)
        {
            AutoIncrement = true;
        }
        field(11;"Document No";Code[20])
        {
        }
        field(12;"Document Type";Option)
        {
            OptionCaption = 'Receipt';
            OptionMembers = Receipt;
        }
        field(13;"Transaction Type";Code[50])
        {
            TableRelation = "Receipts and Payment Types" where (Type=filter(Receipt));

            trigger OnValidate()
            begin
                 FundsTypes.Reset;
                 FundsTypes.SetRange(FundsTypes.Code,"Transaction Type");
                 if FundsTypes.FindFirst then begin
                  "Default Grouping":=FundsTypes."Default Grouping";
                  "Account Type":=FundsTypes."Account Type";
                  "Account Code":=FundsTypes."G/L Account";
                  "Account Name":=FundsTypes."G/L Account Name";
                  Description:=FundsTypes.Description;
                 end;

                 RHeader.Reset;
                 RHeader.SetRange(RHeader."No.","Document No");
                  if RHeader.FindFirst then begin
                      "Posting Date":=RHeader."Posting Date";
                      "Document Date":=RHeader.Date;
                      "Global Dimension 1 Code":=RHeader."Global Dimension 1 Code";
                      "Global Dimension 2 Code":=RHeader."Global Dimension 2 Code";
                      "Shortcut Dimension 3 Code":=RHeader."Shortcut Dimension 3 Code";
                      "Shortcut Dimension 4 Code":=RHeader."Shortcut Dimension 4 Code";
                      "Shortcut Dimension 5 Code":=RHeader."Shortcut Dimension 5 Code";
                      "Shortcut Dimension 6 Code":=RHeader."Shortcut Dimension 6 Code";
                      "Shortcut Dimension 7 Code":=RHeader."Shortcut Dimension 7 Code";
                      "Shortcut Dimension 8 Code":=RHeader."Shortcut Dimension 8 Code";
                      "Pay Mode":=RHeader."Pay Mode";
                      "Cheque No":=RHeader."Cheque No";
                      "Responsibility Center":=RHeader."Responsibility Center";
                      "Document Type":="document type"::Receipt;
                      "Bank Code":=RHeader."Bank Code";
                      Validate("Bank Code");
                      "Currency Code":=RHeader."Currency Code";
                      Validate("Currency Code");
                      "Currency Factor":=RHeader."Currency Factor";
                      Validate("Currency Factor");
                  end;
                  Validate("Account Type");
            end;
        }
        field(14;"Default Grouping";Code[20])
        {
            Editable = false;
        }
        field(15;"Account Type";Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,Investor';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor;
        }
        field(16;"Account Code";Code[20])
        {
            TableRelation = if ("Account Type"=const("G/L Account")) "G/L Account"."No."
                            else if ("Account Type"=const(Customer)) Customer."No."
                            else if ("Account Type"=const(Vendor)) Vendor."No."
                            else if ("Account Type"=const("Fixed Asset")) "Fixed Asset"."No."
                            else if ("Account Type"=const(Member)) "Member Register"."No.";

            trigger OnValidate()
            begin
                   if "Account Type"="account type"::"G/L Account" then begin
                      "G/L Account".Reset;
                      "G/L Account".SetRange("G/L Account"."No.","Account Code");
                      if "G/L Account".FindFirst then begin
                        "Account Name":="G/L Account".Name;
                      end;
                   end;
                   if "Account Type"="account type"::Customer then begin
                      Customer.Reset;
                      Customer.SetRange(Customer."No.","Account Code");
                      if Customer.FindFirst then begin
                        "Account Name":=Customer.Name;
                      end;
                   end;
                   if "Account Type"="account type"::Vendor then begin
                      Vendor.Reset;
                      Vendor.SetRange(Vendor."No.","Account Code");
                      if Vendor.FindFirst then begin
                        "Account Name":=Vendor.Name;
                      end;
                   end;
                   if "Account Type"="account type"::Member then begin
                      MEMB.Reset;
                      MEMB.SetRange(MEMB."No.","Account Code");
                      if MEMB.FindFirst then begin
                        "Account Name":=MEMB.Name;
                      end;
                   end;
                   if "Account Code"='' then
                    "Account Name":='';
            end;
        }
        field(17;"Account Name";Text[100])
        {
            Editable = false;
        }
        field(18;Description;Text[100])
        {
        }
        field(19;"Global Dimension 1 Code";Code[50])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));
        }
        field(20;"Global Dimension 2 Code";Code[50])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(21;"Shortcut Dimension 3 Code";Code[50])
        {
        }
        field(22;"Shortcut Dimension 4 Code";Code[50])
        {
        }
        field(23;"Shortcut Dimension 5 Code";Code[50])
        {
        }
        field(24;"Shortcut Dimension 6 Code";Code[50])
        {
        }
        field(25;"Shortcut Dimension 7 Code";Code[50])
        {
        }
        field(26;"Shortcut Dimension 8 Code";Code[50])
        {
        }
        field(27;"Responsibility Center";Code[50])
        {
        }
        field(28;"Pay Mode";Option)
        {
            OptionCaption = ' ,Cash/Mpesa,Cheque,Deposit Slip,EFT,Bankers Cheque,RTGS,STO';
            OptionMembers = " ",Cash,Cheque,"Deposit Slip",EFT,"Bankers Cheque",RTGS,STO;
        }
        field(29;"Currency Code";Code[20])
        {

            trigger OnValidate()
            begin
                if "Currency Code"<>'' then begin
                    TestField("Bank Code");
                    if BankAcc.Get("Bank Code") then begin
                        BankAcc.TestField(BankAcc."Currency Code","Currency Code");
                        "Currency Factor" :=CurrExchRate.ExchangeRate("Posting Date","Currency Code");
                    end;
                end;
            end;
        }
        field(30;"Currency Factor";Decimal)
        {
        }
        field(31;Amount;Decimal)
        {

            trigger OnValidate()
            begin
                  TestField("Transaction Type");
                  if "Currency Code"='' then begin
                    "Amount(LCY)":=Amount;
                    "Net Amount":=Amount;
                    Validate("Net Amount");
                  end else begin
                    "Amount(LCY)":=ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date","Currency Code",Amount,"Currency Factor"));
                    "Net Amount":=Amount;
                    Validate("Net Amount");
                  end;
            end;
        }
        field(32;"Amount(LCY)";Decimal)
        {
            Editable = false;
        }
        field(33;"Cheque No";Code[20])
        {

            trigger OnValidate()
            begin
                 if "Cheque No"<>'' then begin
                    //Check for double presentation
                    /*ReceiptLine.RESET;
                    ReceiptLine.SETFILTER(ReceiptLine."Document No",'<>%1',"Document No");
                    IF ReceiptLine.FINDSET THEN BEGIN
                      REPEAT
                       IF ReceiptLine."Cheque No"="Cheque No" THEN
                         ERROR('Cheque/Deposit Slip No:'+FORMAT("Cheque No")+' is already tied to Receipt No:'+FORMAT(ReceiptLine."Document No"));
                      UNTIL ReceiptLine.NEXT=0;
                    END;*/
                
                    GLEntry.Reset;
                    GLEntry.SetRange(GLEntry."External Document No.","Cheque No");
                    GLEntry.SetRange(GLEntry.Reversed,false);
                    if GLEntry.FindSet then begin
                    Error('Cheque/Deposit Slip No:'+Format("Cheque No")+' is already tied to Receipt No:'+Format(GLEntry."Document No."));
                    end;
                 end;

            end;
        }
        field(34;"Applies-To Doc No.";Code[20])
        {
        }
        field(35;"Applies-To ID";Code[20])
        {
        }
        field(36;"Bank Code";Code[20])
        {
            TableRelation = "Bank Account";

            trigger OnValidate()
            begin
                 BankAcc.Reset;
                 BankAcc.SetRange(BankAcc."No.","Bank Code");
                 if BankAcc.FindFirst then begin
                  "Bank Name":=BankAcc.Name;
                 end;
            end;
        }
        field(37;"Bank Name";Text[50])
        {
            Editable = false;
        }
        field(54;Status;Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted;
        }
        field(55;Posted;Boolean)
        {
            Editable = false;
        }
        field(56;"Posted By";Code[50])
        {
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(57;"Date Posted";Date)
        {
            Editable = false;
        }
        field(58;"Time Posted";Time)
        {
            Editable = false;
        }
        field(59;"VAT Code";Code[20])
        {
            TableRelation = "Funds Tax Codes"."Tax Code" where (Type=const(VAT));
        }
        field(60;"VAT Percentage";Decimal)
        {
        }
        field(61;"VAT Amount";Decimal)
        {
        }
        field(62;"VAT Amount(LCY)";Decimal)
        {
        }
        field(63;"W/TAX Code";Code[20])
        {
            TableRelation = "Funds Tax Codes"."Tax Code" where (Type=const("W/Tax"));
        }
        field(64;"W/TAX Percentage";Decimal)
        {
        }
        field(65;"W/TAX Amount";Decimal)
        {
        }
        field(66;"W/TAX Amount(LCY)";Decimal)
        {
        }
        field(67;"Net Amount";Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                 if "Currency Code"='' then begin
                    "Net Amount(LCY)":="Net Amount";
                 end else begin
                    "Net Amount(LCY)":=ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Posting Date","Currency Code","Net Amount","Currency Factor"));
                 end;
            end;
        }
        field(68;"Net Amount(LCY)";Decimal)
        {
            Editable = false;
        }
        field(69;"Gen. Bus. Posting Group";Code[20])
        {
        }
        field(70;"Gen. Prod. Posting Group";Code[20])
        {
        }
        field(71;"VAT Bus. Posting Group";Code[20])
        {
        }
        field(72;"VAT Prod. Posting Group";Code[20])
        {
        }
        field(73;Reversed;Boolean)
        {
            Editable = false;
        }
        field(74;"Reversed By";Code[30])
        {
            Editable = false;
        }
        field(75;"Reversal Date";Date)
        {
            Editable = false;
        }
        field(76;"Reversal Time";Time)
        {
            Editable = false;
        }
        field(77;"Posting Date";Date)
        {
        }
        field(78;"Document Date";Date)
        {
        }
        field(79;"Applicant No";Code[20])
        {
        }
        field(80;"Fee Type";Code[20])
        {
        }
        field(81;"Fee SubType";Code[20])
        {
        }
        field(82;"Fee Description";Text[50])
        {
        }
        field(83;"From Year";Integer)
        {
        }
        field(84;ToYear;Integer)
        {
        }
    }

    keys
    {
        key(Key1;"Line No","Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        BankAcc: Record "Bank Account";
        BankStmt: Record "Imported Bank Statement";
        ReceiptLine: Record "Receipt Line";
        ImportedStatement: Record "Imported Bank Statement";
        FundsTypes: Record "Receipts and Payment Types";
        "G/L Account": Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        RHeader: Record "Receipt Header";
        FundsTaxCodes: Record "Funds Tax Codes";
        CurrExchRate: Record "Currency Exchange Rate";
        Setup: Record "Funds General Setup";
        ok: Boolean;
        FundsTransTypes: Record "Receipts and Payment Types";
        "G/LAcc": Record "G/L Account";
        GLEntry: Record "Bank Account Ledger Entry";
        MEMB: Record "Member Register";
}

