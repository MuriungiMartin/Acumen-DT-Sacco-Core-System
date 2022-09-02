#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516657 "Posted Checkoff Proc. Headerx"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    SourceTable = "Checkoff Header-Distributed";
    SourceTableView = where(Posted = const(true));

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
                field("Total Count"; "Total Count")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
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
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
            }
            part("Checkoff Lines-Distributed"; "Checkoff Processing Lines-D")
            {
                Caption = 'Checkoff Lines-Distributed';
                SubPageLink = "Staff Not Found" = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Checkoff Distributed")
            {
                ApplicationArea = Basic;
                Caption = 'Import Checkoff';
                Enabled = ActionEnabled;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = XMLport UnknownXMLport51516003;
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
                    TestField("Document No");
                    TestField(Amount);

                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'CHECKOFF';
                    DOCUMENT_NO := Remarks;
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;

                    MembLedg.Reset;
                    MembLedg.SetRange(MembLedg."Document No.", "Document No");
                    if MembLedg.Find('-') = true then
                        Error('Sorry,You have already posted this Document. Validation not Allowed.');
                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Staff Not Found", No);
                    if ReceiptLine.FindSet(true, true) then begin
                        repeat
                            ReceiptLine."No Repayment" := '';
                            ReceiptLine."Total Amount" := '';
                            ReceiptLine.TOTAL_DISTRIBUTED := 0;
                            ReceiptLine.Modify;
                        until ReceiptLine.Next = 0;
                    end;

                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Staff Not Found", No);
                    if ReceiptLine.Find('-') then begin
                        repeat
                            Memb.Reset;
                            Memb.SetRange("Personal No", ReceiptLine."Checkoff No");
                            if Memb.Find('-') then begin
                                ReceiptLine."No Repayment" := Memb."No.";
                                ReceiptLine."Total Amount" := Memb.Name;
                                ReceiptLine.TOTAL_DISTRIBUTED := ReceiptLine."Date Filter" + ReceiptLine."Car Loan" + ReceiptLine.Development + ReceiptLine.Sambamba + ReceiptLine.Emergency + ReceiptLine."School Fees" + ReceiptLine.Benevolent + ReceiptLine."Deposit Contribution" +
                          ReceiptLine
                        WDefaulter+
                          ReceiptLine."Account Not Found"+ReceiptLine."Okoa Jahazi"+ReceiptLine."School Fees"+ReceiptLine.Benevolent+ReceiptLine."Account Name"+ReceiptLine."40 Years"+ReceiptLine."Account No."+ReceiptLine."Staff/Payroll No"+ReceiptLine.
                    "Employee Name"+
                    Wrong Expre.TOTAL_DISTRIBUTED+ReceiptLine.PHONE_I+
                          ReceiptLine.ADVANCENSE_P+ReceiptLine.ADVANCENSE_I+ReceiptLine.SHARES;
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
                    if Confirm('Are you sure you want to Transfer this Checkoff to Journals ?') = true then begin
                        TestField("Document No");
                        TestField(Amount);
                        if Amount <> "Total Scheduled" then
                            Error('Scheduled Amount must be equal to the Cheque Amount');

                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'CHECKOFF';
                        DOCUMENT_NO := Remarks;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;
                        LineNo := 0;
                        ReceiptLine.Reset;
                        ReceiptLine.SetRange("Staff Not Found", No);
                        if ReceiptLine.Find('-') then begin
                            repeat
                                if ReceiptLine."No Repayment" <> '' then begin
                                    //----------------------------1. DEPOSITS----------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                    GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", ReceiptLine."Date Filter" * -1, 'BOSA', "Document No",
                                    Format(GenJournalLine."transaction type"::"Deposit Contribution"), '');


                                    //----------------------------2. NORM_P------------------------------------------------------------------
                                    if FnCheckLoanErrors('NORM', ReceiptLine."Car Loan", ReceiptLine."No Repayment") then begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", (ReceiptLine."Car Loan" + ReceiptLine.Development) * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Deposit Contribution"), '');
                                    end else begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", ReceiptLine."Car Loan" * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Loan Repayment"), FnGetLoanNumber(ReceiptLine."No Repayment", 'NORM'));
                                        //----------------------------3. NORM_I------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", ReceiptLine.Development * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Interest Paid"), FnGetLoanNumber(ReceiptLine."No Repayment", 'NORM'));
                                    end;


                                    //----------------------------4. REFIN_P------------------------------------------------------------------
                                    if FnCheckLoanErrors('REFIN', ReceiptLine.Sambamba, ReceiptLine."No Repayment") then begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", (ReceiptLine.Sambamba + ReceiptLine.Emergency) * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Deposit Contribution"), '');
                                    end else begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", ReceiptLine.Sambamba * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Loan Repayment"), FnGetLoanNumber(ReceiptLine."No Repayment", 'REFIN'));
                                        //----------------------------5. REFIN_I------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", ReceiptLine.Emergency * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Interest Paid"), FnGetLoanNumber(ReceiptLine."No Repayment", 'REFIN'));
                                    end;


                                    //----------------------------6. EMER_P------------------------------------------------------------------
                                    if FnCheckLoanErrors('EMER', ReceiptLine."School Fees", ReceiptLine."No Repayment") then begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", (ReceiptLine."School Fees" + ReceiptLine.Benevolent) * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Deposit Contribution"), '');
                                    end else begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", ReceiptLine."School Fees" * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Loan Repayment"), FnGetLoanNumber(ReceiptLine."No Repayment", 'EMER'));
                                        //----------------------------7. EMER_I------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", ReceiptLine.Benevolent * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Interest Paid"), FnGetLoanNumber(ReceiptLine."No Repayment", 'EMER'));
                                    end;


                                    //----------------------------8. SCHOOL_P------------------------------------------------------------------
                                    if FnCheckLoanErrors('SCH LOAN', ReceiptLine."Deposit Contribution", ReceiptLine."No Repayment") then begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", (ReceiptLine."Deposit Contribution" + ReceiptLine.Defaulter) * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Deposit Contribution"), '');
                                    end else begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", ReceiptLine."Deposit Contribution" * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Loan Repayment"), FnGetLoanNumber(ReceiptLine."No Repayment", 'SCH LOAN'));
                                        //----------------------------9. SCHOOL_I------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", ReceiptLine.Defaulter * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Interest Paid"), FnGetLoanNumber(ReceiptLine."No Repayment", 'SCH LOAN'));
                                    end;


                                    //----------------------------10. SPECIAL_P------------------------------------------------------------------
                                    if FnCheckLoanErrors('SP', ReceiptLine."Account Not Found", ReceiptLine."No Repayment") then begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", (ReceiptLine."Account Not Found" + ReceiptLine."Okoa Jahazi") * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Deposit Contribution"), '');
                                    end else begin
                                        FnCheckLoanErrors('SP', ReceiptLine."Account Not Found", ReceiptLine."No Repayment");
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", ReceiptLine."Account Not Found" * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Loan Repayment"), FnGetLoanNumber(ReceiptLine."No Repayment", 'SP'));
                                        //----------------------------11. SPECIAL_I------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", ReceiptLine."Okoa Jahazi" * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Interest Paid"), FnGetLoanNumber(ReceiptLine."No Repayment", 'SP'));
                                    end;


                                    //----------------------------12.INSURANCE-------------------------------------------------------------------

                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Insurance Contribution",
                                    GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", ReceiptLine."Account Name" * -1, 'BOSA', "Document No",
                                    Format(GenJournalLine."transaction type"::"Insurance Contribution"), '');

                                    //----------------------------13.GOLDSAVE-------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                    GenJournalLine."account type"::Vendor, FnGetFosaAccountNo(ReceiptLine."No Repayment", 'GOLDSAVE'), "Posting date", ReceiptLine."Account No." * -1, 'BOSA', "Document No",
                                    'Gold Save', '');

                                    //----------------------------15.THIRDPARTY------------------------------------------------------------------
                                    if FnCheckLoanErrors('GUR', ReceiptLine."Vuka Special", ReceiptLine."No Repayment") then begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", (ReceiptLine."Vuka Special") * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Deposit Contribution"), '');
                                    end else begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", ReceiptLine."Vuka Special" * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Loan Repayment"), FnGetLoanNumber(ReceiptLine."No Repayment", 'GUR'));
                                    end;
                                    //---------------------------16.BENEVOLENT------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Benevolent Fund",
                                    GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", ReceiptLine."40 Years" * -1, 'BOSA', "Document No",
                                    Format(GenJournalLine."transaction type"::"Benevolent Fund"), '');


                                    //----------------------------17.ADVANCE_P------------------------------------------------------------------
                                    if FnCheckLoanErrors('SAL ADV', ReceiptLine."Staff/Payroll No", ReceiptLine."No Repayment") then begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", (ReceiptLine."Staff/Payroll No" + ReceiptLine."Employee Name") * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Deposit Contribution"), '');
                                    end else begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", ReceiptLine."Staff/Payroll No" * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Loan Repayment"), FnGetLoanNumber(ReceiptLine."No Repayment", 'SAL ADV'));
                                        //----------------------------18.ADVANCE_I------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", ReceiptLine."Employee Name" * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Interest Paid"), FnGetLoanNumber(ReceiptLine."No Repayment", 'SAL ADV'));
                                    end;
                                    //17.PHONE_P
                                    //18.PHONE_I

                                    //----------------------------19.ADVANCENSE_P------------------------------------------------------------------
                                    if FnCheckLoanErrors('NSE', ReceiptLine.ADVANCENSE_P, ReceiptLine."No Repayment") then begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", (ReceiptLine.ADVANCENSE_P + ReceiptLine.ADVANCENSE_I) * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Deposit Contribution"), '');
                                    end else begin
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", ReceiptLine.ADVANCENSE_P * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Loan Repayment"), FnGetLoanNumber(ReceiptLine."No Repayment", 'NSE'));

                                        //----------------------------20.ADVANCENSE_I------------------------------------------------------------------
                                        LineNo := LineNo + 10000;
                                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                        GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", ReceiptLine.ADVANCENSE_I * -1, 'BOSA', "Document No",
                                        Format(GenJournalLine."transaction type"::"Interest Paid"), FnGetLoanNumber(ReceiptLine."No Repayment", 'NSE'));
                                    end;
                                    //-----------------------------21.SHARES--------------------------------------------------------------------
                                    LineNo := LineNo + 10000;
                                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Share Capital",
                                    GenJournalLine."account type"::Employee, ReceiptLine."No Repayment", "Posting date", ReceiptLine.SHARES * -1, 'BOSA', "Document No",
                                    Format(GenJournalLine."transaction type"::"Share Capital"), '');
                                end;
                            until ReceiptLine.Next = 0;
                        end;
                        //Balancing Journal Entry
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        "Account Type", "Account No", "Posting date", Amount, 'BOSA', "Document No",
                        Remarks, '');



                        Message('Checkoff successfully Generated Jouranls ready for posting');
                    end;
                end;
            }
            action("Process Checkoff Unallocated")
            {
                ApplicationArea = Basic;
                Visible = false;

                trigger OnAction()
                begin
                    MembLedg.Reset;
                    MembLedg.SetRange(MembLedg."Document No.", Remarks);
                    if MembLedg.Find('-') = false then begin
                        Error('You Can Only do this process on Already Posted Checkoffs')
                    end;
                    ReceiptLine.Reset;
                    //ReceiptLine.SETRANGE(ReceiptLine."Receipt Header No",No);
                    //IF ReceiptLine.FIND('-') THEN
                    //REPORT.RUN(51516543,TRUE,FALSE,ReceiptLine);
                end;
            }
            action("Process Annual Charge")
            {
                ApplicationArea = Basic;
                Image = AuthorizeCreditCard;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    TestField("Document No");
                    TestField(Amount);
                    ReceiptLine.Reset;
                    //ReceiptLine.SETRANGE(ReceiptLine."Receipt Header No",No);
                    //IF ReceiptLine.FIND('-') THEN
                    //REPORT.RUN(50100,TRUE,FALSE,ReceiptLine);
                end;
            }
            action("Mark as Posted")
            {
                ApplicationArea = Basic;
                Enabled = false;
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
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        MembLedg.Reset;
        MembLedg.SetRange(MembLedg."Document No.", Remarks);
        if MembLedg.Find('-') = true then
            ActionEnabled := false;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Posting date" := Today;
        "Date Entered" := Today;
    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "Checkoff Lines-Distributed";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Checkoff Header-Distributed";
        Cust: Record "Member Register";
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        RcptBufLines: Record "Checkoff Lines-Distributed";
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
        Memb: Record "Member Register";
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        ReceiptLine: Record "Checkoff Lines-Distributed";
        MembLedg: Record "Cust. Ledger Entry";
        SFactory: Codeunit "SURESTEP Factory.";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        GenJournalLine: Record "Gen. Journal Line";
        ActionEnabled: Boolean;

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

    local procedure FnCheckLoanErrors(LoanProduct: Code[100]; Amount: Decimal; MemberNo: Code[40]): Boolean
    var
        ObjLoans: Record "Loans Register";
    begin
        if Amount > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetRange("Client Code", MemberNo);
            ObjLoans.SetRange("Loan Product Type", LoanProduct);
            if ObjLoans.FindFirst = false then
                exit(true);
        end;
    end;
}

