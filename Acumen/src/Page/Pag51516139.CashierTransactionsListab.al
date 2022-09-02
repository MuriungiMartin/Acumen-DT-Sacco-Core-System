#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516139 "Cashier TransactionsListab"
{
    CardPageID = "Cashier Transactions Cards";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Transactions;
    SourceTableView = where("Transaction Type"=filter('ABC'),
                            Discard=filter(false));

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field(No;No)
                {
                    ApplicationArea = Basic;
                }
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Expected Maturity Date";"Expected Maturity Date")
                {
                    ApplicationArea = Basic;
                }
                field(Cashier;Cashier)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Discounted";"Amount Discounted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Discard;Discard)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000000;"FOSA Statistics FactBox")
            {
                SubPageLink = "No."=field("Account No");
            }
            part(Control1000000004;"Member Statistics FactBox")
            {
                SubPageLink = "No."=field("Member No");
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        SetRange(Cashier,UserId);
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Account: Record Vendor;
        AccountType: Record "Account Types-Saving Products";
        LineNo: Integer;
        ChequeType: Record "Cheque Types";
        DimensionV: Record "Dimension Value";
        ChargeAmount: Decimal;
        DiscountingAmount: Decimal;
        Loans: Record "Loans Register";
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        Vend: Record Vendor;
        LoanType: Record "Loan Products Setup";
        BOSABank: Code[20];
        ReceiptAllocations: Record "Receipt Allocation";
        StatusPermissions: Record "Status Change Permision";


    procedure PostBOSAEntries()
    var
        ReceiptAllocation: Record "Receipt Allocation";
    begin
        //BOSA Cash Book Entry
        if "Account No" = '502-00-000300-00' then
        BOSABank:='13865'
        else if "Account No" = '502-00-000303-00' then
        BOSABank:='070006';


        LineNo:=LineNo+10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."External Document No.":="Cheque No";
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No.":=BOSABank;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:=Payee;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=-Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;

        ReceiptAllocations.Reset;
        ReceiptAllocations.SetRange(ReceiptAllocations."Document No",No);
        if ReceiptAllocations.Find('-') then begin
        repeat

        LineNo:=LineNo+10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Document No.":=No;
        GenJournalLine."External Document No.":="Cheque No";
        GenJournalLine."Posting Date":="Transaction Date";
        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Interest Paid" then begin
        GenJournalLine."Account Type":=GenJournalLine."bal. account type"::"G/L Account";
        if "Account No" = '502-00-000303-00' then
        GenJournalLine."Account No.":='080023'
        else
        GenJournalLine."Account No.":='045003';
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description:=Payee;
        end else begin
        GenJournalLine."Account Type":=GenJournalLine."bal. account type"::Customer;
        GenJournalLine."Account No.":=ReceiptAllocations."Member No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description:=Format(ReceiptAllocations."Transaction Type");
        end;
        GenJournalLine.Amount:=ReceiptAllocations.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Deposit Contribution" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Benevolent Fund"
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Share Capital" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::Loan
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Benevolent Fund" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Loan Insurance Paid"
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Interest Paid"
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Loan Repayment" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Registration Fee";
        GenJournalLine."Loan No":=ReceiptAllocations."Loan No.";
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;

        if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee") and
           (ReceiptAllocations."Interest Amount" > 0) then begin
        LineNo:=LineNo+10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Document No.":=No;
        GenJournalLine."External Document No.":="Cheque No";
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine."Account Type":=GenJournalLine."bal. account type"::Customer;
        GenJournalLine."Account No.":=ReceiptAllocations."Member No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description:='Interest Paid';
        GenJournalLine.Amount:=ReceiptAllocations."Interest Amount";
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Insurance Contribution";
        GenJournalLine."Loan No":=ReceiptAllocations."Loan No.";
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;

        end;

        until ReceiptAllocations.Next = 0;
        end;
    end;
}

