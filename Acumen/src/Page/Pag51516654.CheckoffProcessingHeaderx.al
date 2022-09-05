#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516654 "Checkoff Processing Headerx"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Checkoff Header-Distributedx";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By"; "Entered By")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Date Entered"; "Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date"; "Posting date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    ShowMandatory = true;
                }
                field("Loan CutOff Date"; "Loan CutOff Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Name"; "Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Document No./ Cheque No.';
                    ShowMandatory = true;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Total Scheduled"; "Total Scheduled")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Total Count"; "Total Count")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
            }
            part("Checkoff Lines-Distributed"; "Checkoff Processing Lines-D")
            {
                Caption = 'Checkoff Lines-Distributed';
              //  SubPageLink = "Staff Not Found" = field(false);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Clear Lines")
            {
                ApplicationArea = Basic;
                Enabled = ActionEnabled;
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('This Action will clear all the Lines for the current Check off. Do you want to Continue') = false then
                        exit;
                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Staff/Payroll No", No);
                    ReceiptLine.DeleteAll;

                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'CHECKOFF';
                    DOCUMENT_NO := Remarks;
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;
                end;
            }
            action("Import Checkoff Distributed")
            {
                ApplicationArea = Basic;
                Caption = 'Import Checkoff';
                Enabled = ActionEnabled;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = XMLport "Import Checkoff Distributed";
            }
            group(ActionGroup1102755021)
            {
            }
            action("Validate Checkoff")
            {
                ApplicationArea = Basic;
                Caption = 'Validate Checkoff';
                Enabled = ActionEnabled;
                Image = ViewCheck;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'CHECKOFF';
                    DOCUMENT_NO := Remarks;
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;

                    /*
                    MembLedg.RESET;
                    MembLedg.SETRANGE(MembLedg."Document No.","Document No");
                    IF MembLedg.FIND('-')= TRUE THEN
                    ERROR('Sorry,You have already posted this Document. Validation not Allowed.');
                    */
                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Checkoff No", No);
                    if ReceiptLine.FindSet(true, true) then begin
                        repeat
                            ReceiptLine."Account No." := '';
                            ReceiptLine."Employee Name" := '';
                            ReceiptLine.TOTAL_DISTRIBUTED := 0;
                            ReceiptLine.Modify;
                        until ReceiptLine.Next = 0;
                    end;

                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Checkoff No", No);
                    if ReceiptLine.Find('-') then begin
                        repeat
                            Memb.Reset;
                            Memb.SetCurrentkey(Memb."Personal No");
                            Memb.SetRange(Memb."Customer Type", Cust."customer type"::Member);
                            Memb.SetRange(Memb."Customer Posting Group", 'BOSA');
                            Memb.SetRange("Personal No", ReceiptLine."Staff/Payroll No");
                            if Memb.Find('-') then begin
                                ReceiptLine."Account No." := Memb."No.";
                                ReceiptLine."Account Name" := Memb.Name;
                                ReceiptLine."Employee Name" := Memb."Employer Name";
                                ReceiptLine.TOTAL_DISTRIBUTED :=
                                ReceiptLine.Benevolent +
                                ReceiptLine."Car Loan" +
                                ReceiptLine."Deposit Contribution" +
                                ReceiptLine.Development +
                                ReceiptLine.Emergency +
                                ReceiptLine."Okoa Jahazi" +
                                ReceiptLine.Sambamba +
                                ReceiptLine."School Fees" +
                                ReceiptLine."Vuka Special" +
                                ReceiptLine.Defaulter +
                                ReceiptLine."40 Years";
                                ReceiptLine.Modify;
                            end;

                        until ReceiptLine.Next = 0;
                    end;
                    Message('Validation was successfully completed');

                end;
            }
            action("Unallocated Funds")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;

                trigger OnAction()
                begin
                    ReptProcHeader.Reset;
                    ReptProcHeader.SetRange(ReptProcHeader.No, No);
                    if ReptProcHeader.Find('-') then
                        Report.Run(51516542, true, false, ReptProcHeader);
                end;
            }
            group(ActionGroup1102755019)
            {
            }
            action("Process Checkoff Distributed")
            {
                ApplicationArea = Basic;
                Caption = 'Process Checkoff';
                Enabled = ActionEnabled;
                Image = Apply;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    //Morris Process Check off
                    if Confirm('Are you sure you want to Transfer this Checkoff to Journals ?') = true then begin
                        TestField("Document No");
                        TestField(Amount);
                        PDate := "Posting date";
                        if PDate = 0D then
                            Error('Please input posting date!');


                        if Amount <> "Total Scheduled" then
                            Error('Scheduled Amount must be equal to the Cheque Amount');
                        LineN := 0;
                        RunBal := 0;


                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'CHECKOFF';
                        DOCUMENT_NO := "Document No";
                        Counter := 0;
                        Percentage := 0;
                        TotalCount := 0;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;
                        LineNo := 0;
                        ReceiptLine.Reset;
                        ReceiptLine.SetRange("Checkoff No", No);
                        if ReceiptLine.Find('-') then begin
                            // Window.OPEN('@1@');
                            // ProgressBar.OPEN('Process Checkoff: @1@@@@@@@@@@@@@@@@'+'Record:#2###############');
                            TotalCount := ReceiptLine.Count;
                            repeat
                                //FnUpdateProgressBar();

                                // MaxDate:=ReceiptLine.GETRANGEMAX(ReceiptLine."Date Filter");

                                LastIssuedDate := (CalcDate('-1M+20D', "Posting date"));
                                //LastIssuedDate:=TODAY;
                                if ReceiptLine."Account No." <> '' then begin

                                    FnRecoverCarLoan(ReceiptLine."Car Loan", ReceiptLine."Account No.");
                                    FnRecoverDevLoans(ReceiptLine.Development, ReceiptLine."Account No.");
                                    FnRecoverSambambaLoans(ReceiptLine.Sambamba, ReceiptLine."Account No.");
                                    FnRecoverDefaulterLoans(ReceiptLine.Defaulter, ReceiptLine."Account No.");
                                    FnRecoverSchoolFeesLoans(ReceiptLine."School Fees", ReceiptLine."Account No.");
                                    FnRecoverEmergencyLoans(ReceiptLine.Emergency, ReceiptLine."Account No.");
                                    FnRecoverOkoaLoans(ReceiptLine."Okoa Jahazi", ReceiptLine."Account No.");
                                    FnPostDepositContribution(ReceiptLine."Deposit Contribution", ReceiptLine."Account No.");
                                    FnPostBenevolent(ReceiptLine.Benevolent, ReceiptLine."Account No.");
                                    FnRecoverVukaSpecial(ReceiptLine."Vuka Special", ReceiptLine."Account No.");
                                    FnRecover40years(ReceiptLine."40 Years", ReceiptLine."Account No.");

                                end;
                            until ReceiptLine.Next = 0;
                        end;
                        //Balancing Journal Entry
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        "Account Type", "Account No", "Posting date", Amount, 'BOSA', "Document No",
                        Remarks, '');

                        //ProgressBar.CLOSE();

                        Message('Checkoff successfully Generated Jouranls ready for posting');
                    end;



                    //End Morris Process Check off
                end;
            }
            action("Mark as Posted")
            {
                ApplicationArea = Basic;
                Enabled = not ActionEnabled;
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to mark this Checkoff as Posted ?', false) = true then begin
                        MembLedg.Reset;
                        MembLedg.SetRange(MembLedg."Document No.", Remarks);
                        if MembLedg.Find('-') = false then
                            Error('Sorry,You can only do this process on already posted Checkoffs');
                        Posted := true;
                        "Posted By" := UserId;
                        "Posting date" := Today;
                        Modify;
                    end;
                end;
            }
            action(Journals)
            {
                ApplicationArea = Basic;
                Caption = 'General Journal';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedOnly = true;
                RunObject = Page "General Journal";
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ActionEnabled := true;
        MembLedg.Reset;
        MembLedg.SetRange(MembLedg."Document No.", Remarks);
        MembLedg.SetRange(MembLedg."External Document No.", "Cheque No.");
        if MembLedg.Find('-') then begin
            ActionEnabled := false;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //"Posting date":=TODAY;
        "Date Entered" := Today;
    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "Checkoff Lines-Distributedx";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Checkoff Header-Distributedx";
        Cust: Record Customer;
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        RcptBufLines: Record "Checkoff Lines-Distributedx";
        LoanType: Record "Loan Products Setup";
        LoanApp: Record "Loans Register";
        Interest: Decimal;
        LineN: Integer;
        TotalRepay: Decimal;
        MultipleLoan: Integer;
        LType: Text;
        MonthlyAmount: Decimal;
        ShRec: Decimal;
        SHARESCAP: Decimal;
        DIFF: Decimal;
        DIFFPAID: Decimal;
        genstup: Record "Sacco General Set-Up";
        Memb: Record Customer;
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        ReceiptLine: Record "Checkoff Lines-Distributedx";
        MembLedg: Record "Cust. Ledger Entry";
        SFactory: Codeunit "SURESTEP Factory.";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        GenJournalLine: Record "Gen. Journal Line";
        ActionEnabled: Boolean;
        XMLCheckOff: XmlPort "Import Checkoff Distributed";
        Window: Dialog;
        TotalCount: Integer;
        Counter: Integer;
        Percentage: Integer;
        MaxDate: Date;
        PeriodYear: Integer;
        LoanRBal: Decimal;
        LastIssuedDate: Date;
        Repayment: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        ProgressBar: Dialog;
        Percentange: Integer;

    local procedure FnGetLoanNumber(MemberNo: Code[40]; "Loan Product Code": Code[100]): Code[100]
    var
        ObjLoans: Record "Loans Register";
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange("Client Code", MemberNo);
        ObjLoans.SetRange("Loan Product Type", "Loan Product Code");
        if ObjLoans.FindFirst then
            exit(ObjLoans."Loan  No.");
    end;

    local procedure FnGetFosaAccountNo(BosaAccountNo: Code[40]; "Product Code": Code[100]): Code[100]
    var
        ObjVendor: Record Vendor;
    begin
        ObjVendor.Reset;
        ObjVendor.SetRange("BOSA Account No", BosaAccountNo);
        ObjVendor.SetRange("Account Type", "Product Code");
        if ObjVendor.Find('-') then
            exit(ObjVendor."No.");
    end;

    local procedure FnCheckLoanErrors(LoanProduct: Code[100]; Amount: Decimal; MemberNo: Code[40]) IsInvalidLoan: Boolean
    var
        ObjLoans: Record "Loans Register";
    begin
        if Amount > 0 then begin
            IsInvalidLoan := true;
            ObjLoans.Reset;
            ObjLoans.SetRange("Client Code", MemberNo);
            ObjLoans.SetRange("Loan Product Type", LoanProduct);
            ObjLoans.SetFilter("Date filter", '..%1', "Posting date");
            if ObjLoans.FindFirst then begin
                IsInvalidLoan := false;
            end
        end;
        exit(IsInvalidLoan);
    end;

    local procedure FnInitiateProgressBar()
    begin
    end;

    local procedure FnUpdateProgressBar()
    begin
        /*Percentage:=(ROUND(Counter/TotalCount*10000,1));
        Counter:=Counter+1;
        Window.UPDATE(1,Percentage);*/

        Percentange := (ROUND(Counter / TotalCount * 10000, 1));
        Counter := Counter + 1;
        ProgressBar.Update(1, Percentange);
        ProgressBar.Update(2, Counter);

    end;

    local procedure FnGetLoanGetInterest(Source: Code[50]; ProductType: Code[100]; MemberNo: Code[100]; LastIssueDate: Date) InterestBal: Decimal
    begin
    end;

    local procedure FnGetLoanGetPrinciple(Source: Code[50]; ProductType: Code[100]; MemberNo: Code[100]; LastIssueDate: Date)
    var
        InterestBal: Decimal;
    begin
    end;


    procedure FnRecoverCarLoan(AmountReceived: Decimal; AccountNo: Code[50])
    begin

        if AmountReceived > 0 then begin
            RunBal := AmountReceived;
            LoanRBal := 0;
            LoanApp.Reset;
            LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
            LoanApp.SetRange(LoanApp."Loan Product Type", 'CARLOAN');
            LoanApp.SetRange(LoanApp."Client Code", AccountNo);
            LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', LastIssuedDate);
            if LoanApp.Find('-') then begin
                repeat
                    LoanApp.CalcFields(LoanApp."Outstanding Balance");

                    if LoanApp."Outstanding Balance" > 0 then begin
                        Repayment := LoanApp."Loan Principle Repayment";

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                 GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", AmountReceived * -1, 'BOSA', "Document No",
                                 Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");
                        RunBal := RunBal + (AmountReceived * -1);
                    end;

                until LoanApp.Next = 0;

            end;
        end;

        if RunBal > 0 then begin //No CAR Loan Found
            FnLoanExcess(RunBal, 'Car Loan - ' + AccountNo, ReceiptLine."Account No.");
        end;
    end;


    procedure FnRecoverDevLoans(AmountReceived: Decimal; AccountNo: Code[50])
    var
        InterestToPost: Decimal;
        PrincipleToPost: Decimal;
        LCount: Integer;
    begin
        InterestToPost := 0;
        PrincipleToPost := 0;
        RunBal := AmountReceived;
        //Recover Interest
        LoanApp.Reset;
        LoanApp.SetCurrentkey(Source, "Loan Product Type", "Client Code", "Issued Date");
        LoanApp.SetRange(LoanApp."Client Code", AccountNo);
        LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
        LoanApp.SetFilter(LoanApp."Loan Product Type", 'DEV LOAN');
        LoanApp.SetRange(LoanApp.Posted, true);
        LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', LastIssuedDate);
        if LoanApp.Find('-') then begin
            repeat
                if RunBal > 0 then begin

                    Interest := 0;
                    InterestToPost := 0;
                    LoanApp.CalcFields(LoanApp."Oustanding Interest");
                    if LoanApp."Oustanding Interest" > 0 then begin
                        Interest := LoanApp."Oustanding Interest";
                        if RunBal > Interest then begin
                            InterestToPost := Interest;
                        end
                        else begin
                            InterestToPost := RunBal;
                        end;
                        //MESSAGE('Loan number %1 interest %2 and runbal %3',LoanApp."Loan  No.",InterestToPost,RunBal);
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                 GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", InterestToPost * -1, 'BOSA', "Document No",
                                 Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.");
                        RunBal -= InterestToPost;
                    end;
                end;
            until LoanApp.Next = 0;
        end;


        //Recover Repayment

        LoanApp.Reset;
        LoanApp.SetCurrentkey(Source, "Loan Product Type", "Client Code", LoanApp."Issued Date");
        LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
        LoanApp.SetRange(LoanApp."Client Code", AccountNo);
        LoanApp.SetRange(LoanApp.Posted, true);
        LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', LastIssuedDate);
        LoanApp.SetFilter(LoanApp."Loan Product Type", 'DEV LOAN');
        if LoanApp.Find('-') then begin
            LCount := LoanApp.Count;
            repeat
                if RunBal > 0 then begin
                    Repayment := 0;
                    PrincipleToPost := 0;
                    LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Oustanding Interest");
                    Repayment := LoanApp.Repayment - LoanApp."Oustanding Interest";
                    if (LoanApp."Outstanding Balance" > 0) then begin
                        if (RunBal > Repayment) then begin
                            PrincipleToPost := Repayment;
                        end
                        else begin
                            PrincipleToPost := RunBal;
                        end;


                        //MESSAGE('Loan number %1 principle %2 and runbal %3',LoanApp."Loan  No.",PrincipleToPost,RunBal);
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                         GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", PrincipleToPost * -1, 'BOSA', "Document No",
                         Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");
                        RunBal -= PrincipleToPost;
                        LCount -= 1;
                    end;
                end;
            until LoanApp.Next = 0;
        end;


        if RunBal > 0 then begin


            FnPostExcess(RunBal, 'Unallocated Funds - ' + AccountNo, AccountNo, 'DEV LOAN');
        end;
        //IF (InterestToPost+PrincipleToPost) <> (AmountReceived )THEN
        //MESSAGE('Here we go %1 and %2 halafu %3',InterestToPost + PrincipleToPost,AmountReceived,RunBal);
    end;


    procedure FnPostDepositContribution(AmountReceived: Decimal; AccountNo: Code[50])
    begin
        if AmountReceived > 0 then begin
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
             GenJournalLine."account type"::Member, AccountNo, "Posting date", AmountReceived * -1, 'BOSA', "Document No",
             Format(GenJournalLine."transaction type"::"Deposit Contribution"), '');
        end;
    end;


    procedure FnPostBenevolent(AmountReceived: Decimal; AccountNo: Code[50])
    begin
        if AmountReceived > 0 then begin
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Benevolent Fund",
             GenJournalLine."account type"::Member, AccountNo, "Posting date", AmountReceived * -1, 'BOSA', "Document No",
             Format(GenJournalLine."transaction type"::"Benevolent Fund"), '');
        end;
    end;


    procedure FnPostExcess(ExcessAmount: Decimal; Description: Text[30]; AccountNo: Code[50]; LoanNo: Code[15])
    var
        InterestToPost: Decimal;
        LCount: Integer;
        PrincipleToPost: Decimal;
    begin

        if ExcessAmount > 0 then begin
            GenSetUp.Get(0);
            // GenSetUp.TESTFIELD(GenSetUp."Accounts Not Found Account");
            LineN := LineN + 10000;

            ////
            RunBal := ExcessAmount;
            //Recover Interest

            if RunBal > 0 then begin
                LoanApp.Reset;
                LoanApp.SetCurrentkey(Source, "Loan Product Type", "Client Code", "Issued Date");
                LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
                LoanApp.SetFilter(LoanApp."Loan Product Type", 'VUKA LOAN|VUKA SPEC|OKOA JAAZI|DEV - NEW');
                LoanApp.SetRange(LoanApp.Posted, true);
                LoanApp.SetRange(LoanApp."Client Code", AccountNo);
                LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', LastIssuedDate);
                if LoanApp.Find('-') then begin
                    LCount := 0;
                    repeat

                        LCount += 1;
                        LoanApp.CalcFields(LoanApp."Oustanding Interest");
                        if LoanApp."Oustanding Interest" > 0 then begin
                            Interest := LoanApp."Oustanding Interest";
                            if RunBal > Interest then begin
                                RunBal := RunBal - Interest;
                                InterestToPost := Interest;
                            end
                            else begin
                                InterestToPost := RunBal;
                                RunBal := 0;
                            end;

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                     GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", InterestToPost * -1, 'BOSA', "Document No",
                                     Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.");
                            //RunBal:=RunBal-InterestToPost;

                        end;
                    until LoanApp.Next = 0;
                end;
            end;



            //Recover Repayment
            if RunBal > 0 then begin
                LoanApp.Reset;
                LoanApp.SetCurrentkey(Source, "Loan Product Type", "Client Code", "Issued Date");
                LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
                LoanApp.SetFilter(LoanApp."Loan Product Type", 'VUKA LOAN|VUKA SPEC|OKOA JAAZI|DEV - NEW');
                LoanApp.SetRange(LoanApp.Posted, true);
                LoanApp.SetRange(LoanApp."Client Code", AccountNo);
                LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', LastIssuedDate);
                if LoanApp.Find('-') then begin
                    repeat
                        if RunBal > 0 then begin
                            Repayment := 0;
                            PrincipleToPost := 0;
                            LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Oustanding Interest");
                            Repayment := LoanApp.Repayment - LoanApp."Oustanding Interest";
                            if (LoanApp."Outstanding Balance" > 0) then begin
                                if (RunBal > Repayment) then begin
                                    PrincipleToPost := Repayment;
                                end
                                else begin
                                    PrincipleToPost := RunBal;
                                end;


                                //MESSAGE('Loan number %1 principle %2 and runbal %3',LoanApp."Loan  No.",PrincipleToPost,RunBal);
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                 GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", PrincipleToPost * -1, 'BOSA', "Document No",
                                 Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");
                                RunBal -= PrincipleToPost;
                                LCount -= 1;
                            end;
                        end;

                    until LoanApp.Next = 0;
                end;
            end;
        end;




        //RECOVER EXCESS FOR PREDEFINED LOANS (SAMBAMBA, SCHOOL FEES, DEVELOPMENT)


        // POST EXCESS AFTER ALL DEDUCTIONS
        if RunBal > 0 then begin
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Unallocated Funds",
              GenJournalLine."account type"::Member, AccountNo, "Posting date", RunBal * -1, 'BOSA', "Document No",
              Format(GenJournalLine."transaction type"::"Unallocated Funds") + ' - ' + LoanNo, '');
        end;
    end;


    procedure FnLoanExcess(ExcessAmount: Decimal; Description: Text[30]; AccountNo: Code[50])
    begin
        //IF RunBal >0 THEN BEGIN


        if ExcessAmount > 0 then begin
            GenSetUp.Get(0);
            //GenSetUp.TESTFIELD(GenSetUp."Accounts Not Found Account");
            LineN := LineN + 10000;

            ////
            RunBal := ExcessAmount;
            //Recover Interest


            // POST EXCESS AFTER ALL DEDUCTIONS
            if RunBal > 0 then begin

                LineN := LineN + 10000;

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Unallocated Funds",
                            GenJournalLine."account type"::Member, AccountNo, "Posting date", RunBal * -1, 'BOSA', "Document No",
                            Format(GenJournalLine."transaction type"::"Unallocated Funds"), LoanApp."Loan  No.");

            end;

        end;
    end;


    procedure FnRecoverSambambaLoans(AmountReceived: Decimal; AccountNo: Code[50])
    var
        InterestToPost: Decimal;
        LCount: Integer;
        PrincipleToPost: Decimal;
    begin
        RunBal := AmountReceived;
        //Recover Interest
        if RunBal > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Loan Product Type", "Client Code", "Issued Date");
            LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'SAMBAMBA|SAMBAMBA-P');
            LoanApp.SetRange(LoanApp.Posted, true);
            LoanApp.SetRange(LoanApp."Client Code", AccountNo);
            LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', LastIssuedDate);
            if LoanApp.Find('-') then begin
                repeat
                    if RunBal > 0 then begin
                        LoanApp.CalcFields(LoanApp."Oustanding Interest");
                        if LoanApp."Oustanding Interest" > 0 then begin

                            Interest := LoanApp."Oustanding Interest";
                            if RunBal > Interest then begin
                                InterestToPost := Interest;
                            end
                            else begin
                                InterestToPost := RunBal;
                            end;
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                     GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", InterestToPost * -1, 'BOSA', "Document No",
                                     Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.");
                            RunBal := RunBal - InterestToPost;
                        end;
                    end;

                until LoanApp.Next = 0;
            end;
        end;




        //Recover Repayment
        LoanApp.Reset;
        LoanApp.SetCurrentkey(Source, "Loan Product Type", "Client Code", LoanApp."Issued Date");
        LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
        LoanApp.SetRange(LoanApp."Loan Product Type", LoanType.Code);
        LoanApp.SetRange(LoanApp."Client Code", AccountNo);
        LoanApp.SetRange(LoanApp.Posted, true);
        LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', LastIssuedDate);
        LoanApp.SetFilter(LoanApp."Loan Product Type", 'SAMBAMBA|SAMBAMBA-P');
        if LoanApp.Find('-') then begin
            repeat
                if RunBal > 0 then begin
                    Repayment := 0;
                    LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Oustanding Interest");
                    if (LoanApp."Outstanding Balance" > 0) then begin
                        Repayment := LoanApp.Repayment - LoanApp."Oustanding Interest";
                        if (LCount = 1) then begin
                            PrincipleToPost := RunBal;
                        end
                        else
                            if (LoanApp."Outstanding Balance" > 0) then begin
                                if (RunBal > Repayment) then begin
                                    PrincipleToPost := Repayment;
                                end
                                else begin
                                    PrincipleToPost := RunBal;
                                end;

                            end;

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                         GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", PrincipleToPost * -1, 'BOSA', "Document No",
                         Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");
                        RunBal := RunBal - PrincipleToPost;
                        LCount := LCount - 1;
                    end;
                end;
            until LoanApp.Next = 0;
        end;

        if RunBal > 0 then begin
            FnPostExcess(RunBal, 'Unallocated Funds - ' + AccountNo, AccountNo, 'SAMBAMBA');
        end;
    end;


    procedure FnRecoverDefaulterLoans(AmountReceived: Decimal; AccountNo: Code[50])
    var
        InterestToPost: Decimal;
        LCount: Integer;
        PrincipleToPost: Decimal;
    begin
        RunBal := AmountReceived;
        //Recover Interest
        if RunBal > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Loan Product Type", "Client Code", "Issued Date");
            LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'Defaulter');
            LoanApp.SetRange(LoanApp.Posted, true);
            LoanApp.SetRange(LoanApp."Client Code", AccountNo);
            LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', LastIssuedDate);
            if LoanApp.Find('-') then begin
                repeat
                    if RunBal > 0 then begin
                        LoanApp.CalcFields(LoanApp."Oustanding Interest");
                        if LoanApp."Oustanding Interest" > 0 then begin
                            Interest := LoanApp."Oustanding Interest";
                            if RunBal > Interest then begin
                                InterestToPost := Interest;
                            end
                            else begin
                                InterestToPost := RunBal;
                            end;
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                            GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", InterestToPost * -1, 'BOSA', "Document No",
                            Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.");
                            RunBal := RunBal - InterestToPost;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
        end;


        //Recover Repayment

        LoanApp.Reset;
        LoanApp.SetCurrentkey(Source, "Loan Product Type", "Client Code", LoanApp."Issued Date");
        LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
        LoanApp.SetRange(LoanApp."Loan Product Type", LoanType.Code);
        LoanApp.SetRange(LoanApp."Client Code", AccountNo);
        LoanApp.SetRange(LoanApp.Posted, true);
        LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', LastIssuedDate);
        LoanApp.SetFilter(LoanApp."Loan Product Type", 'Defaulter');
        if LoanApp.Find('-') then begin
            LCount := LoanApp.Count;
            repeat
                if RunBal > 0 then begin
                    Repayment := 0;
                    LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Oustanding Interest");
                    if (LoanApp."Outstanding Balance" > 0) then begin
                        Repayment := LoanApp.Repayment - LoanApp."Oustanding Interest";
                        if (LCount = 1) then begin
                            PrincipleToPost := RunBal;
                        end
                        else
                            if (LoanApp."Outstanding Balance" > 0) then begin
                                if (RunBal > Repayment) then begin
                                    PrincipleToPost := Repayment;
                                end
                                else begin
                                    PrincipleToPost := RunBal;
                                end;

                            end;

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                        GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", PrincipleToPost * -1, 'BOSA', "Document No",
                        Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");
                        RunBal := RunBal - PrincipleToPost;
                        LCount := LCount - 1;
                    end;
                end;
            until LoanApp.Next = 0;
        end;

        if RunBal > 0 then begin

            FnPostExcess(RunBal, 'Unallocated Funds - ' + AccountNo, AccountNo, 'Defaulter');
        end;
    end;


    procedure FnRecoverSchoolFeesLoans(AmountReceived: Decimal; AccountNo: Code[50])
    var
        InterestToPost: Decimal;
        LCount: Integer;
        PrincipleToPost: Decimal;
    begin
        RunBal := AmountReceived;
        //Recover Interest
        if RunBal > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Loan Product Type", "Client Code", "Issued Date");
            LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'SCH LOAN');
            LoanApp.SetRange(LoanApp.Posted, true);
            LoanApp.SetRange(LoanApp."Client Code", AccountNo);
            LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', LastIssuedDate);
            if LoanApp.Find('-') then begin
                repeat
                    if RunBal > 0 then begin
                        LoanApp.CalcFields(LoanApp."Oustanding Interest");
                        if LoanApp."Oustanding Interest" > 0 then begin

                            Interest := LoanApp."Oustanding Interest";
                            if RunBal > Interest then begin
                                InterestToPost := Interest;
                            end
                            else begin
                                InterestToPost := RunBal;
                            end;
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                     GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", InterestToPost * -1, 'BOSA', "Document No",
                                     Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.");
                            RunBal := RunBal - InterestToPost;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
        end;




        //Recover Repayment
        LoanApp.Reset;
        LoanApp.SetCurrentkey(Source, "Loan Product Type", "Client Code", LoanApp."Issued Date");
        LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
        LoanApp.SetRange(LoanApp."Loan Product Type", LoanType.Code);
        LoanApp.SetRange(LoanApp."Client Code", AccountNo);
        LoanApp.SetRange(LoanApp.Posted, true);
        LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', LastIssuedDate);
        LoanApp.SetFilter(LoanApp."Loan Product Type", 'SCH LOAN');
        if LoanApp.Find('-') then begin
            LCount := LoanApp.Count;
            repeat
                if RunBal > 0 then begin
                    Repayment := 0;
                    LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Oustanding Interest");
                    if (LoanApp."Outstanding Balance" > 0) then begin
                        Repayment := LoanApp.Repayment - LoanApp."Oustanding Interest";
                        if (LCount = 1) then begin
                            PrincipleToPost := RunBal;
                        end
                        else
                            if (LoanApp."Outstanding Balance" > 0) then begin
                                if (RunBal > Repayment) then begin
                                    PrincipleToPost := Repayment;
                                end
                                else begin
                                    PrincipleToPost := RunBal;
                                end;

                            end;

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                         GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", PrincipleToPost * -1, 'BOSA', "Document No",
                         Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");
                        RunBal := RunBal - PrincipleToPost;
                        LCount := LCount - 1;
                    end;
                end;
            until LoanApp.Next = 0;
        end;

        if RunBal > 0 then begin

            FnPostExcess(RunBal, 'Unallocated Funds - ' + AccountNo, AccountNo, 'SCH LOAN');
        end;
    end;


    procedure FnRecoverEmergencyLoans(AmountReceived: Decimal; AccountNo: Code[50])
    var
        InterestToPost: Decimal;
        LCount: Integer;
        PrincipleToPost: Decimal;
    begin
        RunBal := AmountReceived;
        //Recover Interest
        if RunBal > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Loan Product Type", "Client Code", "Issued Date");
            LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'EMERGENCY');
            LoanApp.SetRange(LoanApp.Posted, true);
            LoanApp.SetRange(LoanApp."Client Code", AccountNo);
            LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', LastIssuedDate);
            if LoanApp.Find('-') then begin
                repeat
                    if RunBal > 0 then begin
                        LoanApp.CalcFields(LoanApp."Oustanding Interest");
                        if LoanApp."Oustanding Interest" > 0 then begin

                            Interest := LoanApp."Oustanding Interest";
                            if RunBal > Interest then begin
                                InterestToPost := Interest;
                            end
                            else begin
                                InterestToPost := RunBal;
                            end;
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                     GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", InterestToPost * -1, 'BOSA', "Document No",
                                     Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.");
                            RunBal := RunBal - InterestToPost;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
        end;




        //Recover Repayment
        LoanApp.Reset;
        LoanApp.SetCurrentkey(Source, "Loan Product Type", "Client Code", LoanApp."Issued Date");
        LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
        LoanApp.SetRange(LoanApp."Loan Product Type", LoanType.Code);
        LoanApp.SetRange(LoanApp."Client Code", AccountNo);
        LoanApp.SetRange(LoanApp.Posted, true);
        LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', LastIssuedDate);
        LoanApp.SetFilter(LoanApp."Loan Product Type", 'EMERGENCY');
        if LoanApp.Find('-') then begin
            LCount := LoanApp.Count;
            repeat
                if RunBal > 0 then begin
                    Repayment := 0;
                    LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Oustanding Interest");
                    if (LoanApp."Outstanding Balance" > 0) then begin
                        Repayment := LoanApp.Repayment - LoanApp."Oustanding Interest";
                        if (LCount = 1) then begin
                            PrincipleToPost := RunBal;
                        end
                        else
                            if (LoanApp."Outstanding Balance" > 0) then begin
                                if (RunBal > Repayment) then begin
                                    PrincipleToPost := Repayment;
                                end
                                else begin
                                    PrincipleToPost := RunBal;
                                end;

                            end;

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                         GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", PrincipleToPost * -1, 'BOSA', "Document No",
                         Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");
                        RunBal := RunBal - PrincipleToPost;
                        LCount := LCount - 1;
                    end;
                end;

            until LoanApp.Next = 0;
        end;



        if RunBal > 0 then begin
            FnPostExcess(RunBal, 'Unallocated Funds - ' + AccountNo, AccountNo, 'EMERGENCY');
        end;
    end;


    procedure FnRecoverOkoaLoans(AmountReceived: Decimal; AccountNo: Code[50])
    var
        InterestToPost: Decimal;
        LCount: Integer;
        PrincipleToPost: Decimal;
    begin
        RunBal := AmountReceived;
        //Recover Interest
        if RunBal > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Loan Product Type", "Client Code", "Issued Date");
            LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'OKOA JAAZI');
            LoanApp.SetRange(LoanApp.Posted, true);
            LoanApp.SetRange(LoanApp."Client Code", AccountNo);
            LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', LastIssuedDate);
            if LoanApp.Find('-') then begin
                repeat
                    if RunBal > 0 then begin
                        LoanApp.CalcFields(LoanApp."Oustanding Interest");
                        if LoanApp."Oustanding Interest" > 0 then begin

                            Interest := LoanApp."Oustanding Interest";
                            if RunBal > Interest then begin
                                InterestToPost := Interest;
                            end
                            else begin
                                InterestToPost := RunBal;
                            end;
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                     GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", InterestToPost * -1, 'BOSA', "Document No",
                                     Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.");
                            RunBal := RunBal - InterestToPost;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
        end;




        //Recover Repayment
        LoanApp.Reset;
        LoanApp.SetCurrentkey(Source, "Loan Product Type", "Client Code", LoanApp."Issued Date");
        LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
        LoanApp.SetRange(LoanApp."Loan Product Type", LoanType.Code);
        LoanApp.SetRange(LoanApp."Client Code", AccountNo);
        LoanApp.SetRange(LoanApp.Posted, true);
        LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', LastIssuedDate);
        LoanApp.SetFilter(LoanApp."Loan Product Type", 'OKOA JAAZI');
        if LoanApp.Find('-') then begin
            LCount := LoanApp.Count;
            repeat
                if RunBal > 0 then begin
                    Repayment := 0;
                    LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Oustanding Interest");
                    if (LoanApp."Outstanding Balance" > 0) then begin
                        Repayment := LoanApp.Repayment - LoanApp."Oustanding Interest";
                        if (LCount = 1) then begin
                            PrincipleToPost := RunBal;
                        end
                        else
                            if (LoanApp."Outstanding Balance" > 0) then begin
                                if (RunBal > Repayment) then begin
                                    PrincipleToPost := Repayment;
                                end
                                else begin
                                    PrincipleToPost := RunBal;
                                end;

                            end;

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                         GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", PrincipleToPost * -1, 'BOSA', "Document No",
                         Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");
                        RunBal := RunBal - PrincipleToPost;
                        LCount := LCount - 1;
                    end;
                end;
            until LoanApp.Next = 0;
        end;




        if RunBal > 0 then begin
            FnPostExcess(RunBal, 'Unallocated Funds - ' + AccountNo, AccountNo, 'OKOA JAAZI');
        end;
    end;


    procedure FnRegisterCheckoff()
    begin
    end;


    procedure FnRecoverVukaSpecial(AmountReceived: Decimal; AccountNo: Code[50])
    var
        InterestToPost: Decimal;
        LCount: Integer;
        PrincipleToPost: Decimal;
    begin

        RunBal := AmountReceived;
        //Recover Interest

        LoanApp.Reset;
        LoanApp.SetCurrentkey(Source, "Loan Product Type", "Client Code", "Issued Date");
        LoanApp.SetRange(LoanApp."Client Code", AccountNo);
        LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
        LoanApp.SetFilter(LoanApp."Loan Product Type", 'VUKA SPEC');
        LoanApp.SetRange(LoanApp.Posted, true);
        LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', LastIssuedDate);
        if LoanApp.Find('-') then begin
            repeat
                if RunBal > 0 then begin
                    LoanApp.CalcFields(LoanApp."Oustanding Interest");
                    if LoanApp."Oustanding Interest" > 0 then begin
                        Interest := LoanApp."Oustanding Interest";
                        if RunBal > Interest then begin
                            InterestToPost := Interest;
                        end
                        else begin
                            InterestToPost := RunBal;
                            RunBal := 0;
                        end;

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                 GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", InterestToPost * -1, 'BOSA', "Document No",
                                 Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.");
                        RunBal := RunBal - Interest;

                    end;
                end;
            until LoanApp.Next = 0;
        end;






        //Recover Repayment

        LoanApp.Reset;
        LoanApp.SetCurrentkey(Source, "Loan Product Type", "Client Code", LoanApp."Issued Date");
        LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
        LoanApp.SetRange(LoanApp."Client Code", AccountNo);
        LoanApp.SetRange(LoanApp.Posted, true);
        LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', LastIssuedDate);
        LoanApp.SetFilter(LoanApp."Loan Product Type", 'VUKA SPEC');
        if LoanApp.Find('-') then begin
            LCount := LoanApp.Count;
            repeat
                Repayment := 0;
                if RunBal > 0 then begin
                    LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Oustanding Interest");
                    if (LoanApp."Outstanding Balance" > 0) then begin
                        Repayment := LoanApp.Repayment - LoanApp."Oustanding Interest";
                        if (LCount = 1) then begin
                            if (RunBal > Repayment) then begin
                                PrincipleToPost := Repayment;
                            end
                            else begin
                                Gnljnline.Amount := RunBal;
                            end;
                        end
                        else
                            if (LoanApp."Outstanding Balance" > 0) then begin
                                if (RunBal > Repayment) then begin
                                    PrincipleToPost := Repayment;
                                end
                                else begin
                                    Gnljnline.Amount := RunBal;
                                end;
                            end;

                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                         GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", PrincipleToPost * -1, 'BOSA', "Document No",
                         Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");


                        LCount := LCount - 1;
                    end;
                    RunBal := RunBal - PrincipleToPost;
                end;
            until LoanApp.Next = 0;
        end;
        //END;



        if RunBal > 0 then begin


            FnPostExcess(RunBal, 'Unallocated Funds - ' + AccountNo, AccountNo, 'VUKA SPEC');
        end;
    end;


    procedure FnRecover40years(AmountReceived: Decimal; AccountNo: Code[50])
    var
        InterestToPost: Decimal;
        LCount: Integer;
        PrincipleToPost: Decimal;
    begin

        RunBal := AmountReceived;
        //MESSAGE('balance is %1',RunBal);
        //Recover Interest
        if RunBal > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Loan Product Type", "Client Code", "Issued Date");
            LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'DEV40');
            LoanApp.SetRange(LoanApp.Posted, true);
            LoanApp.SetRange(LoanApp."Client Code", AccountNo);
            LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', LastIssuedDate);
            if LoanApp.Find('-') then begin
                repeat
                    if RunBal > 0 then begin
                        LoanApp.CalcFields(LoanApp."Oustanding Interest");
                        if LoanApp."Oustanding Interest" > 0 then begin

                            Interest := LoanApp."Oustanding Interest";
                            if RunBal > Interest then begin
                                InterestToPost := Interest;
                            end
                            else begin
                                InterestToPost := RunBal;
                            end;
                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                     GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", InterestToPost * -1, 'BOSA', "Document No",
                                     Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.");
                            RunBal := RunBal - InterestToPost;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
        end;




        //Recover Repayment
        if RunBal > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Loan Product Type", "Client Code", LoanApp."Issued Date");
            LoanApp.SetRange(LoanApp.Source, LoanApp.Source::BOSA);
            LoanApp.SetRange(LoanApp."Loan Product Type", LoanType.Code);
            LoanApp.SetRange(LoanApp."Client Code", AccountNo);
            LoanApp.SetRange(LoanApp.Posted, true);
            LoanApp.SetFilter(LoanApp."Issued Date", '<=%1', LastIssuedDate);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'DEV40');

            LCount := LoanApp.Count;
            if LoanApp.Find('-') then begin
                repeat
                    if RunBal > 0 then begin
                        Repayment := 0;
                        LoanApp.CalcFields(LoanApp."Outstanding Balance", LoanApp."Oustanding Interest");
                        if (LoanApp."Outstanding Balance" > 0) then begin
                            Repayment := LoanApp.Repayment - LoanApp."Oustanding Interest";
                            if (LCount = 1) then begin
                                PrincipleToPost := RunBal;
                            end
                            else
                                if (LoanApp."Outstanding Balance" > 0) then begin
                                    if (RunBal > Repayment) then begin
                                        PrincipleToPost := Repayment;
                                    end
                                    else begin
                                        PrincipleToPost := RunBal;
                                    end;

                                end;

                            LineNo := LineNo + 10000;
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                             GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", PrincipleToPost * -1, 'BOSA', "Document No",
                             Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");
                            RunBal := RunBal - PrincipleToPost;
                            LCount := LCount - 1;
                        end;
                    end;
                until LoanApp.Next = 0;
            end;
        end;

        if RunBal > 0 then begin

            FnPostExcess(RunBal, 'Unallocated Funds - ' + AccountNo, AccountNo, 'DEV40');
        end;
    end;
}

