#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516398 "Posted Loans Batch Card"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loan Disburesment-Batching";
    SourceTableView = where(Posted = const(true));

    layout
    {
        area(content)
        {
            field("Batch No."; "Batch No.")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Batch Type"; "Batch Type")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Description/Remarks"; "Description/Remarks")
            {
                ApplicationArea = Basic;
            }
            field(Status; Status)
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Total Loan Amount"; "Total Loan Amount")
            {
                ApplicationArea = Basic;
            }
            field("No of Loans"; "No of Loans")
            {
                ApplicationArea = Basic;
            }
            field("Mode Of Disbursement"; "Mode Of Disbursement")
            {
                ApplicationArea = Basic;
            }
            field("Document No."; "Document No.")
            {
                ApplicationArea = Basic;

                trigger OnValidate()
                begin
                    if StrLen("Document No.") > 6 then
                        Error('Document No. cannot contain More than 6 Characters.');
                end;
            }
            field("Posting Date"; "Posting Date")
            {
                ApplicationArea = Basic;
            }
            field("BOSA Bank Account"; "BOSA Bank Account")
            {
                ApplicationArea = Basic;
            }
            field("Cheque Name"; "Cheque Name")
            {
                ApplicationArea = Basic;
            }
            part(LoansSubForm; "Loans Sub-Page List")
            {
                SubPageLink = "Batch No." = field("Batch No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(LoansB)
            {
                Caption = 'Batch';
                action("Loans Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Schedule';
                    Image = SuggestPayment;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                 //   RunObject = Report UnknownReport51516231;

                    trigger OnAction()
                    begin
                        LoansBatch.Reset;
                        LoansBatch.SetRange(LoansBatch."Batch No.", "Batch No.");
                        if LoansBatch.Find('-') then begin
                            Report.Run(51516372, true, false, LoansBatch);
                        end;
                    end;
                }
                separator(Action1102760034)
                {
                }
                action("Member Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Card';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    //RunObject = Report UnknownReport51516279;

                    trigger OnAction()
                    begin
                        /*Cust1.RESET;
                       Cust1.SETRANGE(Cust1."No.",Cust1."No.");
                        IF Cust1.FINDFIRST THEN BEGIN
                         REPORT.RUN(REPORT::"members card",TRUE,FALSE,Cust1);
                        END;     */

                    end;
                }
                action("Loan Application")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Application Card';
                    Image = Loaners;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HR Appraisal Ratings";
                    Visible = true;

                    trigger OnAction()
                    begin
                        /*
                      LoanApp.RESET;
                      LoanApp.SETRANGE(LoanApp."Batch No.","Batch No.");
                      LoanApp.SETRANGE(LoanApp."Client Code",LoanApp."Client Code");
                      IF LoanApp.FIND('-') THEN
                      PAGE.RUN(51516245,TRUE,FALSE,LoanApp);    */

                    end;
                }
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;

                    trigger OnAction()
                    begin

                        LoanApp.Reset;
                        //LoanApp.SETRANGE(LoanApp."Loan  No.",CurrPage.LoansSubForm.PAGE.GetLoanNo);
                        if LoanApp.Find('-') then begin
                            if CopyStr(LoanApp."Loan Product Type", 1, 2) = 'PL' then
                                Report.Run(51516244, true, false, LoanApp)
                            else
                                Report.Run(51516244, true, false, LoanApp);
                        end;
                    end;
                }
                separator(Action1102760045)
                {
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::Batches;
                        ApprovalEntries.Setfilters(Database::"Salary Step/Notch Transactions", DocumentType, "Batch No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit WorkflowIntegration;
                        Text001: label 'This Batch is already pending approval';
                    begin
                        LBatches.Reset;
                        LBatches.SetRange(LBatches."Batch No.", "Batch No.");
                        if LBatches.Find('-') then begin
                            if LBatches.Status <> LBatches.Status::Open then
                                Error(Text001);
                        end;

                        //End allocate batch number
                        //ApprovalMgt.SendBatchApprRequest(LBatches);
                    end;
                }
                action("Canel Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //IF ApprovalMgt.CancelBatchAppr(Rec,TRUE,TRUE) THEN;
                    end;
                }
                action("Post ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        Text001: label 'The Batch need to be approved.';
                    begin
                        if Posted = true then
                            Error('Batch already posted.');

                        if Status <> Status::Approved then
                            Error(Format(Text001));

                        CalcFields(Location);

                        if ("Mode Of Disbursement" = "mode of disbursement"::Cheque) or
                           ("Mode Of Disbursement" = "mode of disbursement"::"Individual Cheques") then
                            TestField("BOSA Bank Account");


                        TestField("Description/Remarks");
                        TestField("Posting Date");
                        TestField("Document No.");

                        //For branch loans - only individual cheques
                        if "Batch Type" = "batch type"::"Branch Loans" then begin
                            if "Mode Of Disbursement" <> "mode of disbursement"::"Individual Cheques" then
                                Error('Mode of disbursement must be Individual Cheques for branch loans.');
                        end;

                        /*IF "Mode Of Disbursement" <> "Mode Of Disbursement"::"Individual Cheques" THEN
                        TESTFIELD("Cheque No.");*/

                        if Confirm('Are you sure you want to post this batch?', true) = false then
                            exit;

                        //PRORATED DAYS
                        EndMonth := CalcDate('-1D', CalcDate('1M', Dmy2date(1, Date2dmy("Posting Date", 2), Date2dmy("Posting Date", 3))));
                        RemainingDays := (EndMonth - "Posting Date") + 1;
                        TMonthDays := Date2dmy(EndMonth, 1);
                        //PRORATED DAYS


                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                        GenJournalLine.DeleteAll;


                        GenSetUp.Get();

                        DActivity := 'BOSA';
                        DBranch := 'NAIROBI';

                        LoanApps.Reset;
                        LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
                        LoanApps.SetRange(LoanApps."System Created", false);
                        //LoanApps.SETRANGE(LoanApps.Source,LoanApps.Source::BOSA);
                        LoanApps.SetFilter(LoanApps."Loan Status", '<>Rejected');
                        if LoanApps.Find('-') then begin
                            repeat
                                LoanApps.CalcFields(LoanApps."Special Loan Amount");

                                if (LoanApps.Source = LoanApps.Source::BOSA) and
                                   ("Mode Of Disbursement" <> "mode of disbursement"::"FOSA Loans") then
                                    Error('Mode of disbursement must be FOSA Loans for FOSA Loans.');

                                if (LoanApps.Source = LoanApps.Source::" ") and
                                   ("Mode Of Disbursement" = "mode of disbursement"::"FOSA Loans") then
                                    Error('Mode of disbursement connot be FOSA loans for BOSA Loans.');


                                if "Mode Of Disbursement" = "mode of disbursement"::"FOSA Loans" then begin
                                    DActivity := '';
                                    DBranch := '';
                                    if Vend.Get(LoanApps."Client Code") then begin
                                        DActivity := Vend."Global Dimension 1 Code";
                                        DBranch := Vend."Global Dimension 2 Code";
                                    end;

                                end;

                                if "Batch Type" = "batch type"::"Appeal Loans" then
                                    LoanDisbAmount := LoanApps."Appeal Amount"
                                else
                                    LoanDisbAmount := LoanApps."Approved Amount";

                                if (LoanApps."Special Loan Amount" > 0) and (LoanApps."Bridging Loan Posted" = false) then
                                    Error('Bridging Loans must be posted before the loans are disbursed. ' + LoanApps."Loan  No.");

                                TCharges := 0;
                                TopUpComm := 0;
                                TotalTopupComm := 0;


                                if LoanApps."Loan Status" <> LoanApps."loan status"::Approved then
                                    Error('Loan status must be Approved for you to post Loan. - ' + LoanApps."Loan  No.");

                                if "Batch Type" <> "batch type"::"Appeal Loans" then begin
                                    if LoanApps.Posted = true then
                                        Error('Loan has already been posted. - ' + LoanApps."Loan  No.");
                                end;

                                LoanApps.CalcFields(LoanApps."Top Up Amount");



                                RunningDate := "Posting Date";


                                //Generate and post Approved Loan Amount
                                if not GenBatch.Get('GENERAL', 'LOANS') then begin
                                    GenBatch.Init;
                                    GenBatch."Journal Template Name" := 'GENERAL';
                                    GenBatch.Name := 'LOANS';
                                    GenBatch.Insert;
                                end;

                                PCharges.Reset;
                                PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                                if PCharges.Find('-') then begin
                                    repeat
                                        PCharges.TestField(PCharges."G/L Account");

                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'GENERAL';
                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                        GenJournalLine."Account No." := PCharges."G/L Account";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Document No." := "Document No.";
                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                        GenJournalLine."Posting Date" := "Posting Date";
                                        GenJournalLine.Description := PCharges.Description;
                                        if PCharges."Use Perc" = true then
                                            GenJournalLine.Amount := (LoanDisbAmount * PCharges.Percentage / 100) * -1
                                        else
                                            GenJournalLine.Amount := PCharges.Amount * -1;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        //Don't top up charges on principle
                                        if ("Mode Of Disbursement" = "mode of disbursement"::"FOSA Loans") or
                                           ("Mode Of Disbursement" = "mode of disbursement"::"Transfer to FOSA") then begin
                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                                            GenJournalLine."Bal. Account No." := LoanApps."Account No";
                                        end else begin

                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Employee;
                                            GenJournalLine."Bal. Account No." := LoanApps."Client Code";

                                        end;
                                        //Don't top up charges on principle
                                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                        // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                        // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        TCharges := TCharges + (GenJournalLine.Amount * -1);


                                    until PCharges.Next = 0;
                                end;

                                //Boosting Shares Commision
                                if LoanApps."Boosting Commision" > 0 then begin
                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                    GenJournalLine."Account No." := GenSetUp."Boosting Fees Account";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := "Document No.";
                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                    GenJournalLine."Posting Date" := "Posting Date";
                                    GenJournalLine.Description := 'Boosting Commision';
                                    GenJournalLine.Amount := LoanApps."Boosting Commision" * -1;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    //Don't top up charges on principle
                                    if ("Mode Of Disbursement" = "mode of disbursement"::"FOSA Loans") or
                                       ("Mode Of Disbursement" = "mode of disbursement"::"Transfer to FOSA") then begin
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                                        GenJournalLine."Bal. Account No." := LoanApps."Account No";
                                    end;
                                    //Don't top up charges on principle
                                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                    //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    TCharges := TCharges + (GenJournalLine.Amount * -1);

                                end;

                                //Don't top up charges on principle
                                TCharges := 0;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'LOANS';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                GenJournalLine."Account No." := LoanApps."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := "Document No.";
                                GenJournalLine."Posting Date" := "Posting Date";
                                GenJournalLine.Description := 'Principal Amount';
                                GenJournalLine.Amount := LoanDisbAmount + TCharges;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                                GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //POST INTEREST DIFFERENCE
                                if (LoanApps."Loan Product Type" = 'BELA') or (LoanApps."Loan Product Type" = 'EMERGENCY') or
                                 (LoanApps."Loan Product Type" = 'ADDITIONAL')
                                or (LoanApps."Loan Product Type" = 'JITEGEMEE') then begin
                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                    GenJournalLine."Account No." := LoanApps."Client Code";
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                                    //GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := "Document No.";
                                    GenJournalLine."Posting Date" := "Posting Date";
                                    GenJournalLine.Description := 'Interest Due';
                                    GenJournalLine.Amount := ((LoanApps.Repayment * LoanApps.Installments)) - LoanApps."Approved Amount";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    // GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                                    // GenJournalLine."Bal. Account No.":=LoanType."Loan Interest Account";
                                    // GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                    //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                    GenJournalLine."Account No." := LoanApps."Client Code";
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                                    //GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := "Document No.";
                                    GenJournalLine."Posting Date" := "Posting Date";
                                    GenJournalLine.Description := 'Interest Due';
                                    GenJournalLine.Amount := (((LoanApps.Repayment * LoanApps.Installments)) - LoanApps."Approved Amount") * -1;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    // GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                                    //GenJournalLine."Bal. Account No.":=LoanType."Loan Interest Account";
                                    // GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                    //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;







                                end;

                                //Post Interest Due




                                if LoanApps."Top Up Amount" > 0 then begin
                                    LoanTopUp.Reset;
                                    LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                                    if LoanTopUp.Find('-') then begin
                                        repeat
                                            //Principle
                                            LineNo := LineNo + 10000;
                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := 'GENERAL';
                                            GenJournalLine."Journal Batch Name" := 'LOANS';
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Document No." := "Document No.";
                                            GenJournalLine."Posting Date" := "Posting Date";
                                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                            GenJournalLine."Account No." := LoanApps."Client Code";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                                            GenJournalLine.Amount := LoanTopUp."Total Top Up" * -1;
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                            GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;


                                            //Interest (Reversed if top up)
                                            if LoanType.Get(LoanApps."Loan Product Type") then begin
                                                LineNo := LineNo + 10000;
                                                GenJournalLine.Init;
                                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                                GenJournalLine."Journal Batch Name" := 'LOANS';
                                                GenJournalLine."Line No." := LineNo;
                                                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Employee;
                                                GenJournalLine."Account No." := LoanApps."Client Code";
                                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                                GenJournalLine."Document No." := "Document No.";
                                                GenJournalLine."Posting Date" := "Posting Date";
                                                GenJournalLine.Description := 'Interest Due rev on top up ' + LoanApps."Loan Product Type Name";
                                                GenJournalLine.Amount := LoanTopUp."Interest Top Up" * -1;
                                                GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                GenJournalLine.Validate(GenJournalLine.Amount);
                                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                GenJournalLine."Bal. Account No." := LoanType."Receivable Interest Account";
                                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                                                GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                                //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                                if GenJournalLine.Amount <> 0 then
                                                    GenJournalLine.Insert;


                                            end;
                                            //Commision
                                            if LoanType.Get(LoanApps."Loan Product Type") then begin
                                                if LoanType."Top Up Commision" > 0 then begin
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                    GenJournalLine."Account No." := LoanType."Top Up Commision Account";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                                    GenJournalLine."Document No." := "Document No.";
                                                    GenJournalLine."Posting Date" := "Posting Date";
                                                    GenJournalLine.Description := 'Commision on Loan Top Up';
                                                    TopUpComm := (LoanTopUp."Principle Top Up") * (LoanType."Top Up Commision" / 100);
                                                    TotalTopupComm := TotalTopupComm + TopUpComm;
                                                    GenJournalLine.Amount := TopUpComm * -1;
                                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                    // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                                    // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;


                                                end;
                                            end;



                                        until LoanTopUp.Next = 0;

                                    end;



                                    //IF Top Up
                                    if LoanApps."Top Up Amount" > 0 then begin
                                        if "Mode Of Disbursement" = "mode of disbursement"::"Individual Cheques" then begin
                                            LineNo := LineNo + 10000;

                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := 'GENERAL';
                                            GenJournalLine."Journal Batch Name" := 'LOANS';
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Document No." := "Document No.";
                                            GenJournalLine."Posting Date" := "Posting Date";
                                            LoanApps.TestField(LoanApps."Cheque No.");
                                            GenJournalLine."External Document No." := LoanApps."Cheque No.";
                                            if "Post to Loan Control" = true then begin
                                                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                GenJournalLine."Account No." := '024005';
                                            end else begin
                                                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                                                GenJournalLine."Account No." := "BOSA Bank Account";
                                            end;
                                            //GenJournalLine."Account Type":=GenJournalLine."Bal. Account Type"::"Bank Account";
                                            //GenJournalLine."Account No.":="BOSA Bank Account";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine.Description := LoanApps."Client Name";
                                            GenJournalLine.Amount := (LoanDisbAmount - (LoanApps."Top Up Amount" + TotalTopupComm)) * -1;
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                            // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;
                                        end;
                                    end;



                                end else begin
                                    if "Mode Of Disbursement" = "mode of disbursement"::"Individual Cheques" then begin
                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'GENERAL';
                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Document No." := "Document No.";
                                        GenJournalLine."Posting Date" := "Posting Date";
                                        LoanApps.TestField(LoanApps."Cheque No.");
                                        GenJournalLine."External Document No." := LoanApps."Cheque No.";
                                        if "Post to Loan Control" = true then begin
                                            GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                            GenJournalLine."Account No." := '024005';
                                        end else begin
                                            GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                                            GenJournalLine."Account No." := "BOSA Bank Account";
                                        end;
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine.Description := LoanApps."Client Name";
                                        GenJournalLine.Amount := LoanDisbAmount * -1;
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                        //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                        // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                    end;
                                end;

                                //END;
                                //END;
                                BatchTopUpAmount := BatchTopUpAmount + LoanApps."Top Up Amount";
                                BatchTopUpComm := BatchTopUpComm + TotalTopupComm;


                                LoanApps."Issued Date" := "Posting Date";
                                LoanApps.Advice := true;
                                LoanApps."Advice Type" := LoanApps."advice type"::"Fresh Loan";
                                LoanApps.Posted := true;
                                LoanApps.Modify;


                                //Contractual Shares Variation
                                if GenSetUp."Contactual Shares (%)" <> 0 then begin
                                    if Cust.Get(LoanApps."Client Code") then begin
                                        ContractualShares := ROUND(((LoanDisbAmount * GenSetUp."Contactual Shares (%)") * 0.01), 1);
                                        if ContractualShares > GenSetUp."Max. Contactual Shares" then
                                            ContractualShares := GenSetUp."Max. Contactual Shares";

                                        if Cust."Monthly Contribution" < ContractualShares then begin
                                            Cust."Monthly Contribution" := ContractualShares;
                                            Cust.Advice := true;
                                            Cust."Advice Type" := Cust."advice type"::"Shares Adjustment";
                                            Cust.Modify;
                                        end;
                                    end;
                                end;
                            //Contractual Shares Variation


                            until LoanApps.Next = 0;
                        end;

                        //BOSA Bank Entry
                        if "Mode Of Disbursement" = "mode of disbursement"::Cheque then begin
                            //No Cheque for STIMA
                            //("Mode Of Disbursement"="Mode Of Disbursement"::"Transfer to FOSA") THEN BEGIN
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := "Document No.";
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine."External Document No." := "Cheque No.";
                            GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                            GenJournalLine."Account No." := "BOSA Bank Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description := "Description/Remarks";
                            if "Batch Type" = "batch type"::"Appeal Loans" then
                                GenJournalLine.Amount := ("Total Appeal Amount" - (BatchTopUpAmount + BatchTopUpComm)) * -1
                            else
                                GenJournalLine.Amount := ("Total Loan Amount" - (BatchTopUpAmount + BatchTopUpComm)) * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                        end;


                        //Transfer to FOSA
                        if ("Mode Of Disbursement" = "mode of disbursement"::"Transfer to FOSA") or
                           ("Mode Of Disbursement" = "mode of disbursement"::"FOSA Loans") then begin
                            DActivity := 'FOSA';
                            DBranch := 'NAIROBI';

                            LoanApps.Reset;
                            LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
                            LoanApps.SetRange(LoanApps."System Created", false);
                            //LoanApps.SETRANGE(LoanApps.Source,LoanApps.Source::BOSA);
                            LoanApps.SetFilter(LoanApps."Loan Status", '<>Rejected');
                            if LoanApps.Find('-') then begin
                                repeat
                                    LoanApps.CalcFields(LoanApps."Special Loan Amount", LoanApps."Other Commitments Clearance");

                                    if "Mode Of Disbursement" = "mode of disbursement"::"FOSA Loans" then begin
                                        DActivity := '';
                                        DBranch := '';
                                        if Vend.Get(LoanApps."Client Code") then begin
                                            DActivity := Vend."Global Dimension 1 Code";
                                            DBranch := Vend."Global Dimension 2 Code";
                                        end;

                                    end;


                                    if "Batch Type" = "batch type"::"Appeal Loans" then
                                        LoanDisbAmount := LoanApps."Appeal Amount"
                                    else
                                        if "Batch Type" = "batch type"::"Personal Loans" then
                                            LoanDisbAmount := LoanApps."Approved Amount" - (LoanApps."Approved Amount" * 0.025)
                                        else
                                            LoanDisbAmount := LoanApps."Approved Amount";


                                    //Top Up Commision
                                    TopUpComm := 0;
                                    TotalTopupComm := 0;

                                    if LoanApps."Top Up Amount" > 0 then begin
                                        LoanTopUp.Reset;
                                        LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                                        if LoanTopUp.Find('-') then begin
                                            repeat
                                                TopUpComm := (LoanTopUp."Principle Top Up") * (LoanType."Top Up Commision" / 100);
                                                TotalTopupComm := TotalTopupComm + TopUpComm;

                                            until LoanTopUp.Next = 0;

                                        end;
                                    end;



                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Document No." := "Document No.";
                                    GenJournalLine."Posting Date" := "Posting Date";
                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                    //LoanApps.TESTFIELD(LoanApps."Account No");
                                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Vendor;
                                    GenJournalLine."Account No." := LoanApps."Account No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    if (LoanApps."Account No" = '350011') or (LoanApps."Account No" = '350012') then begin
                                        GenJournalLine.Description := LoanApps."Client Name";
                                        if Cust.Get(LoanApps."Client Code") then begin
                                            GenJournalLine."External Document No." := Cust."ID No.";
                                            GenJournalLine.Description := Cust."Personal No" + ' - ' + GenJournalLine.Description;
                                        end;
                                    end else
                                        GenJournalLine.Description := LoanApps."Loan Product Type Name";
                                    //IPF Loan to CIC Account
                                    if (LoanApps."Loan Product Type" = 'IPF') then begin
                                        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Account No." := '4-10-000540';
                                        GenJournalLine."External Document No." := Cust."ID No.";
                                        GenJournalLine.Description := CopyStr(LoanApps."Client Name" + '-' + Cust."Personal No", 1, 30);
                                    end;
                                    GenJournalLine.Amount := (LoanDisbAmount - (LoanApps."Top Up Amount" + TotalTopupComm)) * -1;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                    //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    //Recover Special Loan
                                    //IF LoanApps."Bridging Loan Posted" = TRUE THEN BEGIN

                                    Loans.Reset;
                                    Loans.SetCurrentkey(Loans."BOSA Loan No.", Loans."Account No", Loans."Batch No.");
                                    //Loans.SETRANGE(Loans."BOSA Loan No.",LoanApps."Loan  No.");
                                    Loans.SetRange(Loans."Loan Product Type", 'BRIDGING');
                                    Loans.SetRange(Loans."Account No", LoanApps."Account No");
                                    Loans.SetFilter(Loans."Outstanding Balance", '>0');
                                    if Loans.Find('-') then begin
                                        repeat

                                            Loans.CalcFields(Loans."Outstanding Balance");

                                            LineNo := LineNo + 10000;

                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := 'GENERAL';
                                            GenJournalLine."Journal Batch Name" := 'LOANS';
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Document No." := "Document No.";
                                            GenJournalLine."Posting Date" := "Posting Date";
                                            GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Employee;
                                            GenJournalLine."Account No." := LoanApps."Account No";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine.Description := 'Bridging Loan Recovery';
                                            GenJournalLine.Amount := -Loans."Outstanding Balance";
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                            GenJournalLine."Loan No" := Loans."Loan  No.";
                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                            // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                            // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;

                                            //SpecialComm:=ROUND((LoanApps."Special Loan Amount"+LoanApps."Other Commitments Clearance")*0.05,0.01);
                                            //Special Commision
                                            SpecialComm := 0;
                                            BridgedLoans.Reset;
                                            BridgedLoans.SetCurrentkey(BridgedLoans."Loan No.");
                                            BridgedLoans.SetRange(BridgedLoans."Loan No.", LoanApps."Loan  No.");
                                            if BridgedLoans.Find('-') then begin
                                                repeat
                                                    if BridgedLoans.Source = BridgedLoans.Source::FOSA then begin
                                                        if BridgedLoans."Loan Type" = 'SUPER' then
                                                            SpecialComm := SpecialComm + (BridgedLoans."Total Off Set" * 0.1)
                                                        else
                                                            SpecialComm := SpecialComm + (BridgedLoans."Total Off Set" * 0.1);
                                                    end else begin
                                                        SpecialComm := SpecialComm + (BridgedLoans."Total Off Set" * 0.1);
                                                    end;
                                                until BridgedLoans.Next = 0;
                                            end;

                                            //POLICESpecialComm:=ROUND(SpecialComm+(LoanApps."Other Commitments Clearance"*0.05),0.01);
                                            //SPecial Commision


                                            LineNo := LineNo + 10000;

                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := 'GENERAL';
                                            GenJournalLine."Journal Batch Name" := 'LOANS';
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Document No." := "Document No.";
                                            GenJournalLine."Posting Date" := "Posting Date";
                                            LoanApps.TestField(LoanApps."Account No");
                                            GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Vendor;
                                            GenJournalLine."Account No." := LoanApps."Account No";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine.Description := 'Bridging Loan Commision';
                                            GenJournalLine.Amount := SpecialComm;
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;


                                            LineNo := LineNo + 10000;

                                            GenJournalLine.Init;
                                            GenJournalLine."Journal Template Name" := 'GENERAL';
                                            GenJournalLine."Journal Batch Name" := 'LOANS';
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Document No." := "Document No.";
                                            GenJournalLine."Posting Date" := "Posting Date";
                                            LoanApps.TestField(LoanApps."Account No");
                                            GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Vendor;
                                            GenJournalLine."Account No." := LoanApps."Account No";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            if (LoanApps."Account No" = '350011') or (LoanApps."Account No" = '350012') then begin
                                                GenJournalLine.Description := LoanApps."Client Name";
                                                if Cust.Get(LoanApps."Client Code") then
                                                    GenJournalLine."External Document No." := Cust."ID No.";
                                            end else
                                                GenJournalLine.Description := 'Bridging Loan Recovery';
                                            GenJournalLine.Amount := (Loans."Outstanding Balance" - SpecialComm);
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                            // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;

                                        until Loans.Next = 0;


                                    end else begin
                                        if (LoanApps."Special Loan Amount" + LoanApps."Other Commitments Clearance") > 0 then
                                            Error('Bridging loan for %1 not found.', LoanApps."Loan  No.");
                                    end;


                                    //Transfer Project Loan Amount
                                    if LoanApps."Project Amount" > 0 then begin
                                        LoanApps.TestField(LoanApps."Project Account No");
                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'GENERAL';
                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Document No." := "Document No.";
                                        GenJournalLine."Posting Date" := "Posting Date";
                                        GenJournalLine."External Document No." := LoanApps."Project Account No";
                                        LoanApps.TestField(LoanApps."Account No");
                                        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Vendor;
                                        GenJournalLine."Account No." := LoanApps."Account No";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine.Description := 'Transfer to Project';
                                        GenJournalLine.Amount := LoanApps."Project Amount";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                        //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                        //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;


                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'GENERAL';
                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Document No." := "Document No.";
                                        GenJournalLine."Posting Date" := "Posting Date";
                                        GenJournalLine."External Document No." := LoanApps."Account No";
                                        LoanApps.TestField(LoanApps."Account No");
                                        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Vendor;
                                        GenJournalLine."Account No." := LoanApps."Project Account No";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine.Description := LoanApps."Client Name";
                                        GenJournalLine.Amount := -LoanApps."Project Amount";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                        // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                        //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;



                                    end;
                                //Transfer Project Loan Amount
                                until LoanApps.Next = 0;
                            end;

                        end;
















                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                        if GenJournalLine.Find('-') then begin
                            //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                        end;

                        //Post New

                        Posted := true;
                        Modify;


                        Message('Batch posted successfully.');

                        //Post

                    end;
                }
                action("Print Cheque")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        if ("Mode Of Disbursement" = "mode of disbursement"::EFT) or ("Mode Of Disbursement" = "mode of disbursement"::RTGS) then
                            Error('This Payment was made by other modes other than Cheque.');
                        //Print Cheque
                        Reset;
                        SetFilter("Batch No.", "Batch No.");
                        if Confirm(Text002, true) then begin

                            //REPORT.RUN(,TRUE,TRUE,Rec);
                            Reset;
                        end;
                    end;
                }
            }
        }
    }

    var
        Text001: label 'Status must be open';
        Text002: label 'Dou you want to print a Cheque for this payment';
        MovementTracker: Record "File Movement Tracker";
        FileMovementTracker: Record "File Movement Tracker";
        NextStage: Integer;
        EntryNo: Integer;
        NextLocation: Text[100];
        LoansBatch: Record "Loan Disburesment-Batching";
        i: Integer;
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record "Loan Repayment Schedule";
        RSchedule: Record "Loan Repayment Schedule";
        GP: Text[30];
        ScheduleCode: Code[20];
        PreviewShedule: Record "Loan Repayment Schedule";
        PeriodInterval: Code[10];
        CustomerRecord: Record Customer;
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record Customer;
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record Customer;
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sacco General Set-Up";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        Loans: Record "Loans Register";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        TotalTopupComm: Decimal;
        CustE: Record Customer;
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Guarantee Details";
        SpecialComm: Decimal;
        LoanApps: Record "Loans Register";
        Banks: Record "Bank Account";
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        TotalSpecialLoan: Decimal;
        SpecialLoanCl: Record "Loan Special Clearance";
        Loans2: Record "Loans Register";
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        Refunds: Record "Loan Products Setup";
        TotalRefunds: Decimal;
        WithdrawalFee: Decimal;
        NetPayable: Decimal;
        NetRefund: Decimal;
        FWithdrawal: Decimal;
        OutstandingInt: Decimal;
        TSC: Decimal;
        LoanDisbAmount: Decimal;
        NegFee: Decimal;
        DValue: Record "Dimension Value";
        ChBank: Code[20];
        Trans: Record Transactions;
        TransactionCharges: Record "Transaction Charges";
        BChequeRegister: Record "Banker Cheque Register";
        OtherCommitments: Record "Other Commitements Clearance";
        BoostingComm: Decimal;
        BoostingCommTotal: Decimal;
        BridgedLoans: Record "Loan Special Clearance";
        InterestDue: Decimal;
        ContractualShares: Decimal;
        BridgingChanged: Boolean;
        BankersChqNo: Code[20];
        LastPayee: Text[100];
        RunningAmount: Decimal;
        BankersChqNo2: Code[20];
        BankersChqNo3: Code[20];
        EndMonth: Date;
        RemainingDays: Integer;
        PrincipalRepay: Decimal;
        InterestRepay: Decimal;
        TMonthDays: Integer;
        SMSMessage: Record "Loan Appraisal Salary Details";
        iEntryNo: Integer;
        Temp: Record Customer;
        Jtemplate: Code[30];
        JBatch: Code[30];
        LBatches: Record "Loan Disburesment-Batching";
        ApprovalMgt: Codeunit WorkflowIntegration;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
        DescriptionEditable: Boolean;
        ModeofDisburementEditable: Boolean;
        DocumentNoEditable: Boolean;
        PostingDateEditable: Boolean;
        SourceEditable: Boolean;
        PayingAccountEditable: Boolean;
        ChequeNoEditable: Boolean;
        ChequeNameEditable: Boolean;
        upfronts: Decimal;
}

