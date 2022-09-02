#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 50007 "Sacco Transfers"
{

    fields
    {
        field(1;No;Code[20])
        {

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                  NoSetup.Get(0);
                  NoSeriesMgt.TestManual(No);
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Transaction Date";Date)
        {
        }
        field(3;"Schedule Total";Decimal)
        {
            CalcFormula = sum("Sacco Transfers Schedule".Amount where ("No."=field(No)));
            FieldClass = FlowField;
        }
        field(4;Approved;Boolean)
        {
        }
        field(5;"Approved By";Code[10])
        {
        }
        field(6;Posted;Boolean)
        {
        }
        field(7;"No. Series";Code[20])
        {
        }
        field(8;"Responsibility Center";Code[10])
        {
        }
        field(9;"Transaction Description";Code[30])
        {
        }
        field(10;"Source Account Type";Option)
        {
            OptionCaption = 'Customer,FOSA,Bank,G/L ACCOUNT,MEMBER';
            OptionMembers = Customer,FOSA,Bank,"G/L ACCOUNT",MEMBER;

            trigger OnValidate()
            begin
                if "Source Account Type"="source account type"::MEMBER then
                  begin
                    "Source Account No":="Member No";
                    end;
            end;
        }
        field(11;"Source Account No";Code[20])
        {
            TableRelation = if ("Source Account Type"=filter(FOSA)) Vendor."No." where ("BOSA Account No"=field("Member No"))
                            else if ("Source Account Type"=filter(Bank)) "Bank Account"."No."
                            else if ("Source Account Type"=filter("G/L ACCOUNT")) "G/L Account"."No."
                            else if ("Source Account Type"=filter(MEMBER)) "Member Register"."No.";

            trigger OnValidate()
            begin
                if "Source Account Type"="source account type"::Customer then begin
                Cust.Reset;
                if Cust.Get("Source Account No") then begin
                "Source Account Name":=Cust.Name;
                "Source Transaction Type":="source transaction type"::"38";
                //"Source Account No":=Cust."FOSA Account";
                Validate("Source Account No");
                end;
                end;

                if "Source Account Type"="source account type":: Bank then begin
                Bank.Reset;
                if Bank.Get("Source Account No") then begin
                "Source Account Name":=Bank.Name;
                "Global Dimension 2 Code":=Bank."Global Dimension 2 Code";
                end;
                end;

                if "Source Account Type"="source account type"::FOSA then begin
                Vend.Reset;
                if Vend.Get("Source Account No") then begin
                "Source Account Name":=Vend.Name;
                "Global Dimension 2 Code":=Vend."Global Dimension 2 Code";
                end;
                end;

                if "Source Account Type"="source account type"::MEMBER then begin
                memb.Reset;
                if memb.Get("Source Account No") then begin
                "Source Account Name":=memb.Name;
                  "Bosa Number":=memb."No.";
                "Global Dimension 2 Code":=memb."Global Dimension 2 Code";
                end;
                end;


                if "Source Account Type"="source account type"::"G/L ACCOUNT" then begin
                "G/L".Reset;
                if "G/L".Get("Source Account No") then begin
                "Source Account Name":="G/L".Name;
                end;
                end;
            end;
        }
        field(12;"Source Transaction Type";Option)
        {
            OptionCaption = ' ,Registration Fee,Share Capital,Interest Paid,Loan Repayment,Deposit Contribution,Insurance Contribution,Benevolent Fund,Loan,Unallocated Funds,Dividend,FOSA Account';
            OptionMembers = " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account";

            trigger OnValidate()
            begin
                "Header Amount":=0;
                if ("Source Transaction Type"="source transaction type"::"Deposit Contribution") then
                  begin
                    ObjCust.Reset;
                    ObjCust.SetRange("No.","Source Account No");
                    if ObjCust.Find('-') then
                      begin
                        ObjCust.CalcFields("Current Shares","Shares Retained");
                        "Header Amount":=ObjCust."Current Shares";
                      end
                  end;
                if ("Source Transaction Type"="source transaction type"::Dividend) then
                begin
                  ObjCust.Reset;
                  ObjCust.SetRange("No.","Source Account No");
                  if ObjCust.Find('-') then
                    begin
                      ObjCust.CalcFields("Dividend Amount");
                      "Header Amount":=ObjCust."Dividend Amount";
                    end
                end;
                  Modify;
            end;
        }
        field(13;"Source Account Name";Text[50])
        {
        }
        field(14;"Source Loan No";Code[20])
        {
            TableRelation = if ("Source Account Type"=filter(FOSA)) "Loans Register"."Loan  No." where ("Loan  No."=filter('LOAN  NO.'))
                            else if ("Source Account Type"=filter(MEMBER)) "Loans Register"."Loan  No." where ("Loan  No."=filter('LOAN  NO.'));

            trigger OnValidate()
            begin
                "Header Amount":=0;
                ObjLoans.Reset;
                ObjLoans.SetRange("Loan  No.","Source Loan No");
                if ObjLoans.Find('-') then
                  begin
                    if (("Source Transaction Type"="source transaction type"::"Loan Repayment") or
                      ("Source Transaction Type"="source transaction type"::"Interest Paid")) then
                      begin
                        ObjLoans.CalcFields("Outstanding Balance","Oustanding Interest");
                        if (("Source Transaction Type"="source transaction type"::"Loan Repayment") and (ObjLoans."Outstanding Balance"<0)) then
                        "Header Amount":=Abs(ObjLoans."Outstanding Balance");
                        if (("Source Transaction Type"="source transaction type"::"Interest Paid") and (ObjLoans."Oustanding Interest"<0)) then
                        "Header Amount":=Abs(ObjLoans."Oustanding Interest");
                      end;
                end;
                Modify;
            end;
        }
        field(15;"Created By";Code[30])
        {
        }
        field(16;Debit;Text[30])
        {
            Editable = false;
        }
        field(17;Refund;Boolean)
        {
        }
        field(18;"Guarantor Recovery";Boolean)
        {
        }
        field(19;"Payrol No.";Code[30])
        {
        }
        field(20;"Global Dimension 1 Code";Code[10])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1),
                                                          "Dimension Value Type"=const(Standard));
        }
        field(21;"Global Dimension 2 Code";Code[10])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2),
                                                          "Dimension Value Type"=const(Standard));
        }
        field(22;"Bosa Number";Code[30])
        {
            Editable = false;
        }
        field(51516061;Status;Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(51516062;"Savings Account Type";Code[30])
        {
            TableRelation = "Account Types-Saving Products".Code;
        }
        field(51516063;"Deposit Debit Options";Option)
        {
            OptionCaption = ' ,Partial Refund,Loan Recovery,Posting Adjustment';
            OptionMembers = " ","Partial Refund","Loan Recovery","Posting Adjustment";
        }
        field(51516064;"Member No";Code[20])
        {
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Member No") then
                  begin
                    "Member Name":=ObjCust.Name;
                    end;
            end;
        }
        field(51516065;"Member Name";Code[100])
        {
        }
        field(51516066;"Header Amount";Decimal)
        {
            DataClassification = ToBeClassified;
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
        if Approved or Posted then
        Error('Cannot delete posted or approved batch');
    end;

    trigger OnInsert()
    begin
         if No = '' then begin
          NoSetup.Get;
          NoSetup.TestField(NoSetup."BOSA Transfer Nos");
          NoSeriesMgt.InitSeries(NoSetup."BOSA Transfer Nos",xRec."No. Series",0D,No,"No. Series");
          end;
         "Transaction Date":=Today;
         "Created By":=UserId;
         Debit:='Credit';
    end;

    trigger OnModify()
    begin
        if Posted then
        Error('Cannot modify a posted batch');
    end;

    trigger OnRename()
    begin
        if Posted then
        Error('Cannot rename a posted batch');
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Cust: Record Customer;
        Bank: Record "Bank Account";
        Vend: Record Vendor;
        memb: Record "Member Register";
        "G/L": Record "G/L Account";
        ObjCust: Record "Member Register";
        ObjLoans: Record "Loans Register";
}

