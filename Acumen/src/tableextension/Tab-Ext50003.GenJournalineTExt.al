tableextension 50003 "GenJournalineTExt" extends "Gen. Journal Line"
{
    fields
    {
        field(51516220; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Registration Fee,Share Capital,Interest Paid,Loan Repayment,Deposit Contribution,Insurance Contribution,Benevolent Fund,Loan,Unallocated Funds,Dividend,FOSA Account,Loan Insurance Charged,Loan Insurance Paid,Recovery Account,FOSA Shares,Additional Shares,Interest Due,Capital Reserve,Commission,Children,Holiday,School Fees';
            OptionMembers = " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Capital Reserve",Commission,Children,Holiday,"School Fees";

            trigger OnValidate()
            begin
                //Description:=FORMAT("Transaction Type");
            end;
        }
        field(51516221; "Loan No"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Account No."));
        }
        field(51516222; "Loan Product Type"; Code[20])
        {
        }
        field(51516223; Interest; Decimal)
        {
        }
        field(51516224; Principal; Decimal)
        {
        }
        field(51516225; Status; Option)
        {
            OptionCaption = 'Pending,Verified,Approved,Canceled';
            OptionMembers = Pending,Verified,Approved,Canceled;
        }
        field(51516226; "User ID"; Code[25])
        {
        }
        field(51516227; Posted; Boolean)
        {
        }
        field(51516228; Charge; Code[20])
        {
            TableRelation = Resource."No.";

            trigger OnValidate()
            begin
                //IF Res.GET(Charge) THEN
                //Description:=Res.Name;
            end;
        }
        field(51516229; "Calculate VAT"; Boolean)
        {
        }
        field(51516230; "VAT Value Amount"; Decimal)
        {
        }
        field(51516231; Bank; Text[30])
        {
        }
        field(51516232; Branch; Text[30])
        {
        }
        field(51516233; "Invoice to Post"; Code[20])
        {
        }
        field(51516234; Found; Boolean)
        {
        }
        field(51516235; "Staff No."; Code[20])
        {
        }
        field(51516236; "Prepayment date"; Date)
        {
        }
        field(51516237; LN; Code[20])
        {
            CalcFormula = lookup(test.No where(No = field("Loan No")));
            FieldClass = FlowField;
        }
        field(51516238; "Group Code"; Code[20])
        {
        }
        field(51516239; "Int Count"; Integer)
        {
            CalcFormula = count("Gen. Journal Line" where("Journal Template Name" = const('GENERAL'),
                                                           "Journal Batch Name" = const('INT DUE')));
            FieldClass = FlowField;
        }
        field(51516240; "Member Name"; Text[70])
        {
        }
        field(51516241; "Interest Due Amount"; Decimal)
        {
        }
        field(51516430; "Interest Code"; Code[50])
        {
            Description = 'Investment Management Field';
            Editable = false;
        }
        field(51516431; "Investor Interest"; Boolean)
        {
        }
        field(51516432; "Int on Dep SMS"; Boolean)
        {
        }
        field(51516433; "Dividend SMS"; Boolean)
        {
        }
        field(51516434; Text; Text[30])
        {
        }
        field(51516435; Blocked; Option)
        {
            CalcFormula = lookup(Vendor.Blocked where("No." = field("Account No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,All,Payment';
            OptionMembers = " ",All,Payment;
        }
        field(51516436; "ATM SMS"; Boolean)
        {
        }
        field(51516437; "Trace ID"; Code[10])
        {
        }
        field(51516438; Description2; Text[70])
        {
        }
        field(51516439; "test field"; Boolean)
        {
        }
        field(51516440; "Group Account No"; Code[20])
        {
        }
        field(51516441; "Account No (BOSA)"; Code[20])
        {

            trigger OnValidate()
            begin
                ObjAccountNoBuffer.Reset;
                ObjAccountNoBuffer.SetRange(ObjAccountNoBuffer."Account No", "Account No (BOSA)");
                if ObjAccountNoBuffer.FindSet then begin
                    "Account No." := ObjAccountNoBuffer."Member No";
                    "Transaction Type" := ObjAccountNoBuffer."Transaction Type";
                    "Member Name" := ObjAccountNoBuffer."Account Name";
                    Description := Format(ObjAccountNoBuffer."Transaction Type");
                end;
            end;
        }
        field(51516442; "Recovery Transaction Type"; Option)
        {
            OptionCaption = 'Normal,Guarantor Recoverd,Guarantor Paid';
            OptionMembers = Normal,"Guarantor Recoverd","Guarantor Paid";
        }
        field(51516443; "Recoverd Loan"; Code[20])
        {
        }
    }
    var
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        PaymentTerms: Record "Payment Terms";
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        EmplLedgEntry: Record "Employee Ledger Entry";
        GenJnlAlloc: Record "Gen. Jnl. Allocation";
        VATPostingSetup: Record "VAT Posting Setup";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        GenProdPostingGrp: Record "Gen. Product Posting Group";
        GLSetup: Record "General Ledger Setup";
        Job: Record Job;
        SourceCodeSetup: Record "Source Code Setup";
        TempJobJnlLine: Record "Job Journal Line" temporary;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        GenJnlShowCTEntries: Codeunit "Gen. Jnl.-Show CT Entries";
        CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";
        VendEntrySetApplID: Codeunit "Vend. Entry-SetAppl.ID";
        EmplEntrySetApplID: Codeunit "Empl. Entry-SetAppl.ID";
        DimMgt: Codeunit DimensionManagement;
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        DeferralUtilities: Codeunit "Deferral Utilities";
        // ApprovalsMgmt: Codeunit WorkflowIntegration;
        Window: Dialog;
        DeferralDocType: Option Purchase,Sales,"G/L";
        CurrencyCode: Code[10];
        Text014: label 'The %1 %2 has a %3 %4.\\Do you still want to use %1 %2 in this journal line?', Comment = '%1=Caption of Table Customer, %2=Customer No, %3=Caption of field Bill-to Customer No, %4=Value of Bill-to customer no.';
        TemplateFound: Boolean;
        Text015: label 'You are not allowed to apply and post an entry to an entry with an earlier posting date.\\Instead, post %1 %2 and then apply it to %3 %4.';
        CurrencyDate: Date;
        Text016: label '%1 must be G/L Account or Bank Account.';
        HideValidationDialog: Boolean;
        Text018: label '%1 can only be set when %2 is set.';
        Text019: label '%1 cannot be changed when %2 is set.';
        GLSetupRead: Boolean;
        ExportAgainQst: label 'One or more of the selected lines have already been exported. Do you want to export them again?';
        NothingToExportErr: label 'There is nothing to export.';
        NotExistErr: label 'Document number %1 does not exist or is already closed.', Comment = '%1=Document number';
        DocNoFilterErr: label 'The document numbers cannot be renumbered while there is an active filter on the Document No. field.';
        DueDateMsg: label 'This posting date will cause an overdue payment.';
        CalcPostDateMsg: label 'Processing payment journal lines #1##########';
        NoEntriesToVoidErr: label 'There are no entries to void.';
        OnlyLocalCurrencyForEmployeeErr: label 'The value of the Currency Code field must be empty. General journal lines in foreign currency are not supported for employee account type.';
        ObjAccountNoBuffer: Record "BOSA Accounts No Buffer";
        AccTypeNotSupportedErr: label 'You cannot specify a deferral code for this type of account.';
        SalespersonPurchPrivacyBlockErr: label 'Privacy Blocked must not be true for Salesperson / Purchaser %1.', Comment = '%1 = salesperson / purchaser code.';
        BlockedErr: label 'The Blocked field must not be %1 for %2 %3.', Comment = '%1=Blocked field value,%2=Account Type,%3=Account No.';
        BlockedEmplErr: label 'You cannot export file because employee %1 is blocked due to privacy.', Comment = '%1 = Employee no. ';
        Membr: Record Customer;
}