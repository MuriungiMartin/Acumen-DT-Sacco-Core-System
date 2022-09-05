#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516909 "Loan Disb Batch Card(MICRO)"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loan Disburesment-Batching";
    SourceTableView = where(Posted = const(false),
                            Source = filter(MICRO));

    layout
    {
        area(content)
        {
            field("Batch No."; "Batch No.")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field(Source; Source)
            {
                ApplicationArea = Basic;
                Editable = true;
            }
            field("Batch Type"; "Batch Type")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field(Status; Status)
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Description/Remarks"; "Description/Remarks")
            {
                ApplicationArea = Basic;
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
                Editable = ModeofDisburementEditable;

                trigger OnValidate()
                begin
                    /*IF "Mode Of Disbursement"="Mode Of Disbursement"::EFT THEN
                    "Cheque No.":="Batch No.";
                    MODIFY;  */
                    if "Mode Of Disbursement" <> "mode of disbursement"::Cheque then
                        "Cheque No." := "Batch No.";
                    Modify;

                end;
            }
            field("Document No."; "Document No.")
            {
                ApplicationArea = Basic;
                Editable = DocumentNoEditable;

                trigger OnValidate()
                begin
                    /*IF STRLEN("Document No.") > 6 THEN
                      ERROR('Document No. cannot contain More than 6 Characters.');
                      */

                end;
            }
            field("Posting Date"; "Posting Date")
            {
                ApplicationArea = Basic;
                Editable = PostingDateEditable;
            }
            field("BOSA Bank Account"; "BOSA Bank Account")
            {
                ApplicationArea = Basic;
                Caption = 'Paying Bank';
                Editable = PayingAccountEditable;
                Visible = false;
            }
            field("Cheque No."; LoansBatch."Cheque No.")
            {
                ApplicationArea = Basic;
                Editable = ChequeNoEditable;
                Visible = false;
            }
            part("`"; "Loans Sub-Page List")
            {
                Editable = false;
                SubPageLink = "Batch No." = field("Batch No."),
                              "System Created" = const(false);
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
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        if Posted = true then
                            Error('Batch already posted.');


                        LoansBatch.Reset;
                        LoansBatch.SetRange(LoansBatch."Batch No.", "Batch No.");
                        if LoansBatch.Find('-') then begin
                            if LoansBatch."Batch Type" = LoansBatch."batch type"::"Personal Loans" then
                                Report.Run(51516485, true, false, LoansBatch)
                            else
                                if LoansBatch."Batch Type" = LoansBatch."batch type"::"Branch Loans" then
                                    Report.Run(51516485, true, false, LoansBatch)
                                else
                                    if LoansBatch."Batch Type" = LoansBatch."batch type"::"Appeal Loans" then
                                        Report.Run(51516485, true, false, LoansBatch)
                                    else
                                        Report.Run(51516485, true, false, LoansBatch);
                        end;
                    end;
                }
                separator(Action1000000010)
                {
                }
                action("Member Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Card';
                    Image = Customer;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        /*LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Loan  No.",CurrPage.LoansSubForm);
                        IF LoanApp.FIND('-') THEN BEGIN*/

                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."No.",LoanApp."Client Code");
                        IF Cust.FIND('-') THEN
                        PAGE.RUNMODAL(,Cust);*/
                        //END;

                    end;
                }
                action("Loan Application")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Application Card';
                    Image = Loaners;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /*
                        LoanApp.RESET;
                        //LoanApp.SETRANGE(LoanApp."Loan  No.",CurrPage.LoansSubForm.PAGE.GetLoanNo);
                        IF LoanApp.FIND('-') THEN
                        PAGE.RUNMODAL(,LoanApp);
                        */

                    end;
                }
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Image = Statistics;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /*
                        LoanApp.RESET;
                        //LoanApp.SETRANGE(LoanApp."Loan  No.",CurrPage.LoansSubForm.PAGE.GetLoanNo);
                        IF LoanApp.FIND('-') THEN BEGIN
                        IF COPYSTR(LoanApp."Loan Product Type",1,2) = 'PL' THEN
                        REPORT.RUN(,TRUE,FALSE,LoanApp)
                        ELSE
                        REPORT.RUN(,TRUE,FALSE,LoanApp);
                        END;
                        */

                    end;
                }
                separator(Action1000000006)
                {
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::LoanDisbursement;
                        ApprovalEntries.Setfilters(Database::"Loan Disburesment-Batching", DocumentType, "Batch No.");
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

                    trigger OnAction()
                    var
                        Text001: label 'This Batch is already pending approval';
                        ApprovalsMgmt: Codeunit WorkflowIntegration;
                    begin
                        LoanApps.Reset;
                        LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
                        if LoanApps.Find('-') = false then
                            Error('You cannot send an empty batch for approval');
                        TestField("Description/Remarks");
                        if Status <> Status::Open then
                            Error(Text001);

                        if ApprovalsMgmt.CheckLoanDisbursementApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendLoanDisbursementForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit WorkflowIntegration;
                    begin
                        ApprovalMgt.OnCancelLoanDisbursementApprovalRequest(Rec);
                    end;
                }
                action("Cancel Cheque")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        Status := Status::Open;
                    end;
                }
                action("Post Loan Batch")
                {
                    ApplicationArea = Basic;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Status <> Status::Approved then
                            Error('Loan Batch is not Fully Approved');
                        LoanApps.Reset;
                        LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
                        LoanApps.SetRange(LoanApps."System Created", false);
                        if LoanApps.Find('-') then begin
                            repeat
                                if LoanApps."Loan Product Type" <> 'IMPORTED' then begin
                                    FnPostLoan()
                                end else
                                    FnPostImported();
                            until LoanApps.Next = 0;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControl();
    end;

    trigger OnOpenPage()
    begin
        Source := Source::MICRO;
        "Mode Of Disbursement" := "mode of disbursement"::"Transfer to FOSA";
        UpdateControl();
    end;

    var
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
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Temp: Record Customer;
        Jtemplate: Code[30];
        JBatch: Code[30];
        LBatches: Record "Loan Disburesment-Batching";
        ApprovalMgt: Codeunit WorkflowIntegration;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
        DescriptionEditable: Boolean;
        ModeofDisburementEditable: Boolean;
        DocumentNoEditable: Boolean;
        PostingDateEditable: Boolean;
        SourceEditable: Boolean;
        PayingAccountEditable: Boolean;
        ChequeNoEditable: Boolean;
        ChequeNameEditable: Boolean;
        upfronts: Decimal;
        EmergencyInt: Decimal;
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
        Deductions: Decimal;
        BatchBoostingCom: Decimal;
        HisaRepayment: Decimal;
        HisaLoan: Record "Loans Register";
        BatchHisaRepayment: Decimal;
        BatchFosaHisaComm: Decimal;
        BatchHisaShareBoostComm: Decimal;
        BatchShareCap: Decimal;
        BatchIntinArr: Decimal;
        Loaninsurance: Decimal;
        TLoaninsurance: Decimal;
        ProductCharges: Record "Loan Product Charges";
        InsuranceAcc: Code[20];
        PTEN: Code[20];
        LoanTypes: Record "Loan Products Setup";
        Customer: Record Customer;
        DataSheet: Record "Data Sheet Main";
        SMSAcc: Code[10];
        SMSFee: Decimal;
        UserSetup: Record "User Setup";
        LoanProcessingFee: Decimal;
        LoanProcessingFeeAcc: Code[20];
        InterestUpfrontSavers: Decimal;
        SaccoInterest: Decimal;
        SaccoInterestAccount: Code[20];
        SaccoIntRelief: Decimal;
        ArmotizationFactor: Decimal;
        compinfo: Record "Company Information";
        AccruedIntAcc: Code[20];
        AccruedInt: Decimal;
        TSCInterest: Decimal;
        TSCInterestAc: Code[20];
        IntCapitalized: Decimal;
        IntCapitalizedAcc: Code[20];
        LApplicationFee: Decimal;
        LApplicationFeeAcc: Code[20];
        IntCapitalizationFactor: Integer;
        Text001: label 'Status must be open';
        DisburesmentMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Mafanikio Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your Loan Application has been Approved and Posted to your FOSA Account</p><p style="font-family:Verdana,Arial;font-size:9pt">Loan Product Type <b>%2</b></p><br>Regards<p>%3</p><p><b>MAFANIKIO SACCO LTD</b></p>';


    procedure UpdateControl()
    begin
        if Status = Status::Open then begin
            DescriptionEditable := true;
            ModeofDisburementEditable := false;
            DocumentNoEditable := false;
            PostingDateEditable := false;
            SourceEditable := true;
            PayingAccountEditable := true;
            ChequeNoEditable := false;
            ChequeNameEditable := false;
        end;

        if Status = Status::"Pending Approval" then begin
            DescriptionEditable := false;
            ModeofDisburementEditable := false;
            DocumentNoEditable := false;
            PostingDateEditable := false;
            SourceEditable := false;
            PayingAccountEditable := false;
            ChequeNoEditable := false;
            ChequeNameEditable := false;

        end;

        if Status = Status::Rejected then begin
            DescriptionEditable := false;
            ModeofDisburementEditable := false;
            DocumentNoEditable := false;
            PostingDateEditable := false;
            SourceEditable := false;
            PayingAccountEditable := false;
            ChequeNoEditable := false;
            ChequeNameEditable := false;
        end;

        if Status = Status::Approved then begin
            DescriptionEditable := false;
            ModeofDisburementEditable := true;
            DocumentNoEditable := true;
            SourceEditable := false;
            PostingDateEditable := true;
            PayingAccountEditable := true;//FALSE;
            ChequeNoEditable := true;
            ChequeNameEditable := true;

        end;
    end;


    procedure FnSendDisburesmentSMS(LoanNo: Code[20]; AccountNo: Code[20])
    begin

        GenSetUp.Get;
        compinfo.Get;



        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := "Batch No.";
        SMSMessage."Document No" := LoanNo;
        SMSMessage."Account No" := AccountNo;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'BATCH';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member,Your Loan has been Approved and posted to your FOSA Account,'
        + compinfo.Name + ' ' + GenSetUp."Customer Care No";
        Cust.Reset;
        Cust.SetRange(Cust."No.", AccountNo);
        if Cust.Find('-') then begin
            SMSMessage."Telephone No" := Cust."Mobile Phone No";
        end;
        if Cust."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure FnSendDisburesmentEmail(LoanNo: Code[20])
    var
        LoanRec: Record "Loans Register";
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        Email: Text[30];
    begin
        SMTPSetup.Get();

        LoanRec.Reset;
        LoanRec.SetRange(LoanRec."Loan  No.", LoanNo);
        if LoanRec.Find('-') then begin
            if Cust.Get(LoanRec."Client Code") then begin
                Email := Cust."E-Mail (Personal)";
            end;
            if Email = '' then begin
                Error('Email Address Missing for Loan Application number' + '-' + LoanRec."Loan  No.");
            end;
            if Email <> '' then
                SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Email, 'Loan Disburesment', '', true);
            SMTPMail.AppendBody(StrSubstNo(DisburesmentMessage, LoanRec."Client Name", LoanRec."Loan Product Type Name", UserId));
            SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AddAttachment(FileName, Attachment);
            SMTPMail.Send;
        end;
    end;

    local procedure FnPostLoan()
    begin
        //ERROR('Under construction. wait a minute');

        if Posted = true then
            Error('Batch already posted.');
        //IF Status<>Status::Approved THEN
        //ERROR(FORMAT(Text001));
        CalcFields(Location);
        if Confirm('Are you sure you want to post this batch?', true) = false then
            exit;
        TestField("Description/Remarks");
        TestField("Posting Date");
        TestField("Document No.");
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PaymentS');
        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
        GenJournalLine.DeleteAll;

        GenSetUp.Get();

        //Disburesment To FOSA Account************************************************
        if "Mode Of Disbursement" = "mode of disbursement"::"Transfer to FOSA" then begin
            LoanApps.Reset;
            LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
            LoanApps.SetRange(LoanApps."System Created", false);
            if LoanApps.Find('-') then begin
                repeat


                    LoanApps.CalcFields(LoanApps."Top Up Amount", LoanApps."Topup iNTEREST");
                    TCharges := 0;
                    TopUpComm := 0;
                    TotalTopupComm := 0;
                    Vend.Reset;
                    Vend.SetRange(Vend."No.", LoanApps."Account No");
                    if Vend.Find('-') then begin
                    end;

                    //Post Loan(Debit Member Loan Account)---------------------------------------------
                    GenJournalLine.Init;
                    LineNo := LineNo + 10000;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Document No." := "Document No.";
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine.Description := 'Loan principle' + LoanApps."Product Code";
                    GenJournalLine.Amount := LoanApps."Approved Amount";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code"; //"Global Dimension 2 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //End Post Loan(Debit Member Loan Account)---------------------------------------------

                    //Post Loan(Credit Member Fosa Account)------------------------------------------------
                    GenJournalLine.Init;
                    LineNo := LineNo + 10000;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := LoanApps."Account No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := LoanApps."Loan Product Type Name" + '_LOAN'; //'loans'+LoanApps."Client Name"+'-'+LoanApps."Client Code";
                                                                                               //GenJournalLine.Amount:=(LoanApps."Approved Amount"-Loaninsurance-LoanApps."Loan SMS Fee"-ROUND(LoanApps."Hisa Boosting Commission",0.05,'<')-ROUND(LoanApps."Hisa Commission",0.05,'<')
                                                                                               //-ROUND((HisaRepayment),0.05,'=')-ROUND(LoanApps."Interest In Arrears",0.05,'>')-LoanApps."Boosting Commision")*-1;
                    GenJournalLine.Amount := (LoanApps."Approved Amount") * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //End Post Loan(Credit Member Fosa Account)------------------------------------------------
                    if LoanApps."Top Up Amount" > 0 then begin
                        LoanTopUp.Reset;
                        LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                        if LoanTopUp.Find('-') then begin
                            repeat
                                //Principle
                                GenJournalLine.Init;
                                LineNo := LineNo + 10000;
                                GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                GenJournalLine."Journal Batch Name" := 'LOANS';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := "Document No.";
                                GenJournalLine."Posting Date" := "Posting Date";
                                GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                GenJournalLine."Account No." := LoanApps."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                                GenJournalLine.Amount := LoanTopUp."Principle Top Up" * -1;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                // GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                                //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Pay Outstanding Interest on TopUp----------------------------------
                                GenJournalLine.Init;
                                LineNo := LineNo + 10000;
                                if LoanType.Get(LoanApps."Loan Product Type") then begin
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Employee;
                                    GenJournalLine."Account No." := LoanApps."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := "Document No.";
                                    GenJournalLine."Posting Date" := "Posting Date";
                                    GenJournalLine.Description := 'Interest Due Paid on top up ' + LoanApps."Loan Product Type Name";
                                    GenJournalLine.Amount := -LoanTopUp."Interest Top Up";
                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                    // GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                                    //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;
                                //End Pay Outstanding Interest on TopUp----------------------------------

                                //Levy On Bridging-------------------------------------------------------
                                if LoanType.Get(LoanApps."Loan Product Type") then begin
                                    GenJournalLine.Init;
                                    LineNo := LineNo + 10000;
                                    if LoanType."Top Up Commision" > 0 then begin
                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Account No." := LoanType."Top Up Commision Account";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Document No." := "Document No.";
                                        GenJournalLine."Posting Date" := "Posting Date";
                                        GenJournalLine.Description := 'Levy on Bridging';
                                        TopUpComm := LoanTopUp.Commision;
                                        TotalTopupComm := TotalTopupComm + TopUpComm;
                                        GenJournalLine.Amount := TopUpComm * -1;
                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        // GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                        //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                                        //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                    end;
                                end;
                            //End Levy On Bridging-------------------------------------------------------
                            until LoanTopUp.Next = 0;
                        end;
                    end;




                    //Boosting Shares Commision
                    GenSetUp.Get();
                    if LoanApps."Boosting Commision" > 0 then begin
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := GenSetUp."Boosting Fees Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := "Document No.";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine.Description := 'Boosting Commision';
                        GenJournalLine.Amount := ROUND(LoanApps."Boosting Commision", 0.05, '=') * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        Deductions += GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                        GenJournalLine."Bal. Account No." := LoanApps."Client Code";
                        GenJournalLine."Bal. Account No." := LoanApps."Account No";
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        BatchBoostingCom += GenJournalLine.Amount;
                        if Cust.Get(LoanApps."Client Code") then begin
                            Cust.BoostedAmount := 0;
                            Cust.Modify;
                        end;

                    end;


                    HisaRepayment := 0;



                    if LoanApps."Hisa Allocation" > 0 then begin

                        HisaLoan.Reset;
                        HisaLoan.SetRange(HisaLoan."BOSA No", LoanApps."Client Code");
                        HisaLoan.SetFilter(HisaLoan."Loan Product Type", 'HISAADV');
                        HisaLoan.SetFilter(HisaLoan."Outstanding Balance", '>0');
                        if HisaLoan.Find('-') then begin
                            //Principle
                            HisaLoan.CalcFields(HisaLoan."Outstanding Balance");
                            HisaRepayment := HisaLoan."Outstanding Balance";
                            // MESSAGE(HisaLoan."Client Code") ;
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := "Document No.";
                            ;
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                            GenJournalLine."Account No." := HisaLoan."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description := 'Off Set Hisa By - ' + HisaLoan."Loan  No.";
                            //GenJournalLine.Amount:=ROUND((HisaRepayment),1,'=') * -1;
                            GenJournalLine.Amount := ROUND((HisaRepayment), 0.05, '=') * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                            GenJournalLine."Bal. Account No." := LoanApps."Account No";
                            //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                            Deductions += GenJournalLine.Amount;
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                            GenJournalLine."Loan No" := HisaLoan."Loan  No.";
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                            BatchHisaRepayment += GenJournalLine.Amount * -1;

                        end;
                    end;


                    //Fosa Hisa Commision
                    GenSetUp.Get();
                    if LoanApps."Hisa Commission" > 0 then begin
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := GenSetUp."Boosting Fees Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := "Document No.";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine.Description := 'Fosa Hisa Commision';
                        GenJournalLine.Amount := ROUND(LoanApps."Hisa Commission", 0.05, '<') * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        Deductions += GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                        GenJournalLine."Bal. Account No." := LoanApps."Account No";
                        //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        BatchFosaHisaComm += GenJournalLine.Amount * -1;
                    end;



                    //Hisa Boosting Shares Commision
                    if LoanApps."Hisa Boosting Commission" > 0 then begin

                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := GenSetUp."Boosting Fees Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := "Document No.";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine.Description := 'Hisa Share Boosting Commision';
                        GenJournalLine.Amount := ROUND(LoanApps."Hisa Boosting Commission", 0.05, '<') * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        Deductions += GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                        GenJournalLine."Bal. Account No." := LoanApps."Account No";
                        //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        BatchHisaShareBoostComm += GenJournalLine.Amount * -1;


                    end;

                    //Loan TOP Up Interest Accrual for the Month
                    if (LoanApps."Loan Product Type" = 'TOPUPADV') or (LoanApps."Loan Product Type" = 'ORDINARYADV') then begin
                        if LoanType.Get(LoanApps."Loan Product Type") then begin
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                            GenJournalLine."Account No." := LoanApps."Account No";
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Loan No" := LoanApps."Loan  No.";
                            GenJournalLine."Document No." := "Document No.";
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine.Description := 'Interest Due';
                            GenJournalLine.Amount := (LoanType."Interest rate" / 1200) * LoanApps."Approved Amount";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            Deductions += GenJournalLine.Amount;
                            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := LoanType."Loan Interest Account";
                            //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;


                            //Processing Fee Okoa
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                            GenJournalLine."Account No." := LoanApps."Account No";
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Loan No" := LoanApps."Loan  No.";
                            GenJournalLine."Document No." := "Document No.";
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine.Description := 'Processing Fee Okoa';
                            GenJournalLine.Amount := 100;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            Deductions += GenJournalLine.Amount;
                            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := LoanType."Loan Interest Account";
                            //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                        end;
                    end;


                    /* IF LoanApps."Share Capital Due"> 0 THEN BEGIN
                       LineNo:=LineNo+10000;
                       GenJournalLine.INIT;
                       GenJournalLine."Journal Template Name":='PAYMENTS';
                       GenJournalLine."Journal Batch Name":='LOANS';
                       GenJournalLine."Line No.":=LineNo;
                       GenJournalLine."Document No.":="Document No.";;
                       GenJournalLine."Posting Date":="Posting Date";
                       GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                       GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                       GenJournalLine."Account No.":=LoanApps."Client Code";
                       GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Shares Capital";
                       GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                       GenJournalLine.Description:='Share Capital ' ;
                       GenJournalLine.Amount:=-LoanApps."Share Capital Due";
                       GenJournalLine.VALIDATE(GenJournalLine.Amount);
                       Deductions+=GenJournalLine.Amount;
                       GenJournalLine."Loan No":=LoanApps."Loan  No.";
                       GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                       GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                       GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                       GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                       GenJournalLine."Shortcut Dimension 2 Code":=LoanApps."Branch Code";
                       IF GenJournalLine.Amount<>0 THEN
                       GenJournalLine.INSERT;

                       BatchShareCap+=GenJournalLine.Amount*-1;
                     END;
                 */
                    //7.
                    if LoanApps."Interest In Arrears" <> 0 then begin
                        if LoanType.Get(LoanApps."Loan Product Type") then begin
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := LoanType."Interest In Arrears Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := "Document No.";
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine.Description := 'InterestInArreas';
                            GenJournalLine.Amount := ROUND(LoanApps."Interest In Arrears" * -1, 0.05, '>');
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            Deductions += GenJournalLine.Amount;
                            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                            GenJournalLine."Bal. Account No." := LoanApps."Account No";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                            BatchIntinArr += GenJournalLine.Amount;
                        end;
                    end;


                    Loaninsurance := 0;

                    if LoanApps."Approved Amount" > 0 then begin
                        //LOAN INSURANCE--------------------------------
                        ProductCharges.Reset;
                        ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                        ProductCharges.SetRange(ProductCharges.Code, 'LINSURANCE');
                        if ProductCharges.Find('-') then begin
                            if ProductCharges."Use Perc" = true then begin
                                Loaninsurance := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                                InsuranceAcc := ProductCharges."G/L Account";

                            end else
                                Loaninsurance := ProductCharges.Amount;
                            InsuranceAcc := ProductCharges."G/L Account";
                        end;

                        //END LOAN INSURANCE------------------------------------

                        //Loaninsurance:=Loaninsurance;
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := "Document No.";
                        ;
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := InsuranceAcc;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description := 'Loan Insurance - ' + LoanApps."Loan  No.";
                        GenJournalLine.Amount := ROUND(Loaninsurance * -1, 0.05, '=');
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        //Deductions+=GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                        GenJournalLine."Bal. Account No." := LoanApps."Account No";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;

                    TLoaninsurance := TLoaninsurance + GenJournalLine.Amount * -1;

                    //Loan processing fee (LPF).....
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'PROCESSSINGFEE');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            LoanProcessingFee := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                            if LoanProcessingFee < ProductCharges."Minimum Amount" then begin
                                LoanProcessingFee := ProductCharges."Minimum Amount"
                            end else
                                LoanProcessingFee := LoanProcessingFee;
                            LoanProcessingFeeAcc := ProductCharges."G/L Account";
                        end else
                            LoanProcessingFee := ProductCharges.Amount;
                        LoanProcessingFeeAcc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := LoanProcessingFeeAcc;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Loan Processing Fee - ' + LoanApps."Loan  No.";
                    GenJournalLine.Amount := LoanProcessingFee * -1;    //ROUND(LoanApps."Loan SMS Fee"*-1,0.05,'=');
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                    GenJournalLine."Bal. Account No." := LoanApps."Account No";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    // IF GenJournalLine.Amount<200 THEN
                    //SMSFee:=200;
                    // MODIFY;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Loan Appraisal fee (Loan Appraisal).....
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'LAPPRAISAL');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            LoanProcessingFee := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                            if LoanProcessingFee < ProductCharges."Minimum Amount" then begin
                                LoanProcessingFee := ProductCharges."Minimum Amount"
                            end else
                                LoanProcessingFee := LoanProcessingFee;
                            LoanProcessingFeeAcc := ProductCharges."G/L Account";
                        end else
                            LoanProcessingFee := ProductCharges.Amount;
                        LoanProcessingFeeAcc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Loan Appraisal Fee - ' + LoanApps."Loan  No.";
                    GenJournalLine.Amount := LoanProcessingFee;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := LoanProcessingFeeAcc;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    // IF GenJournalLine.Amount<200 THEN
                    //SMSFee:=200;
                    // MODIFY;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Sacco Interest (SaccoInt).....

                    if LoanApps."Sacco Interest" > 0 then begin
                        ProductCharges.Reset;
                        ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                        ProductCharges.SetRange(ProductCharges.Code, 'SACCOINT');
                        if ProductCharges.Find('-') then begin
                            if ProductCharges."Use Perc" = true then begin
                                LoanProcessingFee := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                                if SaccoInterest < ProductCharges."Minimum Amount" then begin
                                    SaccoInterest := ProductCharges."Minimum Amount"
                                end else
                                    SaccoInterest := SaccoInterest;
                                SaccoInterestAccount := ProductCharges."G/L Account";

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                GenJournalLine."Journal Batch Name" := 'LOANS';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := "Document No.";
                                ;
                                GenJournalLine."Posting Date" := "Posting Date";
                                GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                GenJournalLine."Account No." := LoanApps."Client Code";
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Sacco Interest - ' + LoanApps."Loan  No.";
                                GenJournalLine.Amount := LoanApps."Sacco Interest";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := SaccoInterestAccount;
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                            end;
                        end;
                    end;

                    //TSC Interest (TSCINT).....
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'TSCINT');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            TSCInterest := LoanApps."Approved Amount" * (ProductCharges.Percentage / 200) * (LoanApps.Installments + 1);
                            if TSCInterest < ProductCharges."Minimum Amount" then begin
                                TSCInterest := ProductCharges."Minimum Amount";
                                TSCInterestAc := ProductCharges."G/L Account"
                            end;
                        end else
                            TSCInterest := ProductCharges.Amount;
                        TSCInterestAc := ProductCharges."G/L Account";


                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := "Document No.";
                        ;
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                        GenJournalLine."Account No." := LoanApps."Client Code";
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description := 'TSC Interest - ' + LoanApps."Loan  No.";
                        GenJournalLine.Amount := TSCInterest;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        //Deductions+=GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := TSCInterestAc;
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;

                    //Loan Form Fee (FORMFEE).....
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'FORMFEE');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            LoanProcessingFee := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                            if LoanProcessingFee < ProductCharges."Minimum Amount" then begin
                                LoanProcessingFee := ProductCharges."Minimum Amount"
                            end else
                                LoanProcessingFee := LoanProcessingFee;
                            LoanProcessingFeeAcc := ProductCharges."G/L Account";
                        end else
                            LoanProcessingFee := ProductCharges.Amount;
                        LoanProcessingFeeAcc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := LoanProcessingFeeAcc;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Loan Form Fee - ' + LoanApps."Loan  No.";
                    GenJournalLine.Amount := LoanProcessingFee * -1;    //ROUND(LoanApps."Loan SMS Fee"*-1,0.05,'=');
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                    GenJournalLine."Bal. Account No." := LoanApps."Account No";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    // IF GenJournalLine.Amount<200 THEN
                    //SMSFee:=200;
                    // MODIFY;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //Loan Application Fee (LAPPLICATION).....
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'LAPPLICATION');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            LApplicationFee := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                            if LApplicationFee < ProductCharges."Minimum Amount" then begin
                                LApplicationFee := ProductCharges."Minimum Amount"
                            end else
                                LApplicationFee := LApplicationFee;
                            LApplicationFeeAcc := ProductCharges."G/L Account";
                        end else
                            LoanProcessingFee := ProductCharges.Amount;
                        LoanProcessingFeeAcc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := LApplicationFeeAcc;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Loan Application Fee - ' + LoanApps."Loan  No.";
                    GenJournalLine.Amount := LApplicationFee * -1;    //ROUND(LoanApps."Loan SMS Fee"*-1,0.05,'=');
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                    GenJournalLine."Bal. Account No." := LoanApps."Account No";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    // IF GenJournalLine.Amount<200 THEN
                    //SMSFee:=200;
                    // MODIFY;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Accrued Interest (ACCRUEDINT).....
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'ACCRUEDINT');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            AccruedInt := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);// *(LoanApps.Installments+1);
                            if AccruedInt < ProductCharges."Minimum Amount" then begin
                                AccruedInt := ProductCharges."Minimum Amount"
                            end else
                                AccruedInt := AccruedInt;
                            AccruedIntAcc := ProductCharges."G/L Account";
                        end else
                            AccruedInt := ProductCharges.Amount;
                        AccruedIntAcc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Accrued Interest - ' + LoanApps."Loan  No.";
                    GenJournalLine.Amount := AccruedInt;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                    GenJournalLine."Bal. Account No." := AccruedIntAcc;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    // IF GenJournalLine.Amount<200 THEN
                    //SMSFee:=200;
                    // MODIFY;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //Interest Capitalized  (INTUPFRONT).....
                    if (LoanApps.Installments <= 12) then begin
                        IntCapitalizationFactor := 1
                    end else
                        IntCapitalizationFactor := 2;


                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'INTUPFRONT');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            IntCapitalized := (LoanApps."Approved Amount" * (ProductCharges.Percentage / 100)) * IntCapitalizationFactor;// *(LoanApps.Installments+1);
                            if IntCapitalized < ProductCharges."Minimum Amount" then begin
                                IntCapitalized := ProductCharges."Minimum Amount"
                            end else
                                IntCapitalized := IntCapitalized;
                            IntCapitalizedAcc := ProductCharges."G/L Account";
                        end else
                            IntCapitalized := ProductCharges.Amount;
                        IntCapitalizedAcc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Interest Capitalized - ' + LoanApps."Loan  No.";
                    GenJournalLine.Amount := IntCapitalized;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                    GenJournalLine."Bal. Account No." := IntCapitalizedAcc;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    // IF GenJournalLine.Amount<200 THEN
                    //SMSFee:=200;
                    // MODIFY;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;



                    //Recover Interest Upfront Savers------------------------------------------------------
                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                        if LoanApps."Loan Product Type" = 'FL354' then begin
                            InterestUpfrontSavers := LoanApps."Approved Amount" * (LoanType."Interest rate" / 100);
                            GenJournalLine.Init;
                            LineNo := LineNo + 10000;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := LoanApps."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := "Document No.";
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine.Description := 'Interest On Savers Loan';
                            GenJournalLine.Amount := InterestUpfrontSavers;
                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := LoanType."Loan Interest Account";
                            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                            //End Recover Interest Upfront Savers------------------------------------------------------
                        end;
                    end;


                    //Recover Transfer to Fosa commission------------------------------------------------------
                    GenJournalLine.Init;
                    LineNo := LineNo + 10000;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := LoanApps."Account No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := "Document No.";
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine.Description := 'transfer to fosa comm';
                    GenJournalLine.Amount := GenSetUp."Loan Trasfer Fee-FOSA";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := GenSetUp."Loan Trasfer Fee A/C-FOSA";
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //End Recover Transfer to Fosa commission------------------------------------------------------

                    //Excise Transfer to Fosa commission------------------------------------------------------
                    GenJournalLine.Init;
                    LineNo := LineNo + 10000;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No." := LoanApps."Account No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := "Document No.";
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine.Description := 'Excise duty on transfer to fosa comm';
                    GenJournalLine.Amount := GenSetUp."Loan Trasfer Fee-FOSA" * (GenSetUp."Excise Duty(%)" / 100);
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := GenSetUp."Excise Duty Account";
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //End Recover Transfer to Fosa commission------------------------------------------------------

                    if "Mode Of Disbursement" = "mode of disbursement"::"Transfer to FOSA" then begin
                        LoanApps."Net Payment to FOSA" := LoanApps."Approved Amount";
                        LoanApps."Processed Payment" := false;
                        Modify
                    end;

                    //Loan Bridged and Comissions----------------------------------------------------
                    if LoanApps."Top Up Amount" > 0 then begin
                        LoanTopUp.Reset;
                        LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                        if LoanTopUp.Find('-') then begin
                            repeat
                                //Principle
                                GenJournalLine.Init;
                                LineNo := LineNo + 10000;
                                GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                GenJournalLine."Journal Batch Name" := 'LOANS';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := "Document No.";
                                GenJournalLine."Posting Date" := "Posting Date";
                                GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := LoanApps."Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                                GenJournalLine.Amount := LoanTopUp."Principle Top Up";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Interest Due On Comission----------------------------------------
                                if LoanType.Get(LoanApps."Loan Product Type") then begin
                                    GenJournalLine.Init;
                                    LineNo := LineNo + 10000;
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := LoanApps."Account No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := "Document No.";
                                    GenJournalLine."Posting Date" := "Posting Date";
                                    GenJournalLine.Description := 'Interest Due Paid on top up ' + LoanApps."Loan Product Type Name";
                                    GenJournalLine.Amount := LoanTopUp."Interest Top Up";
                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;
                                //End Interest Due On Comission----------------------------------------

                                //Levy On Briding------------------------------------------------------
                                if LoanType.Get(LoanApps."Loan Product Type") then begin
                                    if LoanType."Top Up Commision" > 0 then begin
                                        GenJournalLine.Init;
                                        LineNo := LineNo + 10000;
                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Account No." := LoanApps."Account No";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Document No." := "Document No.";
                                        GenJournalLine."Posting Date" := "Posting Date";
                                        GenJournalLine.Description := 'Levy on Bridging';
                                        TopUpComm := LoanTopUp.Commision;
                                        TotalTopupComm := TotalTopupComm + TopUpComm;
                                        GenJournalLine.Amount := TopUpComm;
                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                    end;
                                end;

                                //Generate Data Sheet Advice-Put Off top-ups
                                PTEN := '';

                                if StrLen(LoanTopUp."Staff No") = 10 then begin
                                    PTEN := CopyStr(LoanTopUp."Staff No", 10);
                                end else
                                    if StrLen(LoanTopUp."Staff No") = 9 then begin
                                        PTEN := CopyStr(LoanTopUp."Staff No", 9);
                                    end else
                                        if StrLen(LoanTopUp."Staff No") = 8 then begin
                                            PTEN := CopyStr(LoanTopUp."Staff No", 8);
                                        end else
                                            if StrLen(LoanTopUp."Staff No") = 7 then begin
                                                PTEN := CopyStr(LoanTopUp."Staff No", 7);
                                            end else
                                                if StrLen(LoanTopUp."Staff No") = 6 then begin
                                                    PTEN := CopyStr(LoanTopUp."Staff No", 6);
                                                end else
                                                    if StrLen(LoanTopUp."Staff No") = 5 then begin
                                                        PTEN := CopyStr(LoanTopUp."Staff No", 5);
                                                    end else
                                                        if StrLen(LoanTopUp."Staff No") = 4 then begin
                                                            PTEN := CopyStr(LoanTopUp."Staff No", 4);
                                                        end else
                                                            if StrLen(LoanTopUp."Staff No") = 3 then begin
                                                                PTEN := CopyStr(LoanTopUp."Staff No", 3);
                                                            end else
                                                                if StrLen(LoanTopUp."Staff No") = 2 then begin
                                                                    PTEN := CopyStr(LoanTopUp."Staff No", 2);
                                                                end else
                                                                    if StrLen(LoanTopUp."Staff No") = 1 then begin
                                                                        PTEN := CopyStr(LoanTopUp."Staff No", 1);
                                                                    end;

                                if LoanTypes.Get(LoanTopUp."Loan Type") then begin
                                    if Cust.Get(LoanTopUp."Client Code") then begin

                                        //Loans."Staff No":=customer."Payroll/Staff No";

                                        DataSheet.Init;
                                        DataSheet."PF/Staff No" := LoanTopUp."Staff No";
                                        DataSheet."Type of Deduction" := LoanTypes."Product Description";
                                        DataSheet."Remark/LoanNO" := LoanTopUp."Loan Top Up";
                                        DataSheet.Name := LoanApps."Client Name";
                                        DataSheet."ID NO." := LoanApps."ID NO";
                                        DataSheet."Amount ON" := 0;
                                        DataSheet."Amount OFF" := LoanTopUp."Total Top Up";
                                        DataSheet."REF." := '2026';
                                        DataSheet."New Balance" := 0;
                                        DataSheet.Date := Loans."Issued Date";
                                        DataSheet.Employer := Customer."Employer Code";
                                        DataSheet."Repayment Method" := Customer."Repayment Method";
                                        DataSheet."Transaction Type" := DataSheet."transaction type"::ADJUSTMENT;
                                        DataSheet."Sort Code" := PTEN;
                                        DataSheet.Insert;
                                    end;
                                end;
                            //End Levy On Briding------------------------------------------------------
                            until LoanTopUp.Next = 0;
                        end;
                    end;
                    //Loan Bridged and Comissions----------------------------------------------------
                    //Generate Data Sheet Advice
                    PTEN := '';

                    if StrLen(LoanApps."Staff No") = 10 then begin
                        PTEN := CopyStr(LoanApps."Staff No", 10);
                    end else
                        if StrLen(LoanApps."Staff No") = 9 then begin
                            PTEN := CopyStr(Loans."Staff No", 9);
                        end else
                            if StrLen(LoanApps."Staff No") = 8 then begin
                                PTEN := CopyStr(LoanApps."Staff No", 8);
                            end else
                                if StrLen(LoanApps."Staff No") = 7 then begin
                                    PTEN := CopyStr(LoanApps."Staff No", 7);
                                end else
                                    if StrLen(LoanApps."Staff No") = 6 then begin
                                        PTEN := CopyStr(LoanApps."Staff No", 6);
                                    end else
                                        if StrLen(LoanApps."Staff No") = 5 then begin
                                            PTEN := CopyStr(LoanApps."Staff No", 5);
                                        end else
                                            if StrLen(LoanApps."Staff No") = 4 then begin
                                                PTEN := CopyStr(LoanApps."Staff No", 4);
                                            end else
                                                if StrLen(LoanApps."Staff No") = 3 then begin
                                                    PTEN := CopyStr(LoanApps."Staff No", 3);
                                                end else
                                                    if StrLen(LoanApps."Staff No") = 2 then begin
                                                        PTEN := CopyStr(LoanApps."Staff No", 2);
                                                    end else
                                                        if StrLen(LoanApps."Staff No") = 1 then begin
                                                            PTEN := CopyStr(LoanApps."Staff No", 1);
                                                        end;



                    Loans."Staff No" := Customer."Personal No";
                    DataSheet.Init;
                    DataSheet."PF/Staff No" := LoanApps."Staff No";
                    DataSheet."Type of Deduction" := LoanApps."Loan Product Type";
                    DataSheet."Remark/LoanNO" := LoanApps."Loan  No.";
                    DataSheet.Name := LoanApps."Client Name";
                    DataSheet."ID NO." := LoanApps."ID NO";
                    DataSheet."Principal Amount" := LoanApps."Loan Principle Repayment";
                    DataSheet."Interest Amount" := LoanApps."Loan Interest Repayment";
                    DataSheet."Amount ON" := ROUND(LoanApps.Repayment, 5, '>');
                    //ROUND(LBalance / 100 / 12 * InterestRate,0.05,'>');
                    DataSheet."REF." := '2026';
                    DataSheet."Batch No." := "Batch No.";
                    DataSheet."New Balance" := LoanApps."Approved Amount";
                    DataSheet."Repayment Method" := Customer."Repayment Method";
                    DataSheet.Date := LoanApps."Issued Date";
                    if Customer.Get(LoanApps."Client Code") then begin
                        DataSheet.Employer := Customer."Employer Code";
                    end;
                    DataSheet."Sort Code" := PTEN;
                    DataSheet.Insert;
                    //END;
                    //END;
                    LoanApps."Issued Date" := Today;
                    LoanApps."Loan Status" := LoanApps."loan status"::Issued;
                    LoanApps.Posted := true;
                    LoanApps.Modify;
                //Generate Data Sheet Advice
                until LoanApps.Next = 0;
            end;
        end;


        //End of Disburesment to FOSA******************************************************





        //Disburesment To EFT Account************************************************
        if "Mode Of Disbursement" = "mode of disbursement"::EFT then begin
            LoanApps.Reset;
            LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
            LoanApps.SetRange(LoanApps."System Created", false);
            if LoanApps.Find('-') then begin
                repeat


                    LoanApps.CalcFields(LoanApps."Top Up Amount", LoanApps."Topup iNTEREST");
                    TCharges := 0;
                    TopUpComm := 0;
                    TotalTopupComm := 0;
                    Vend.Reset;
                    Vend.SetRange(Vend."No.", LoanApps."Account No");
                    if Vend.Find('-') then begin
                    end;
                    if LoanApps."Top Up Amount" > 0 then begin
                        LoanTopUp.Reset;
                        LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                        if LoanTopUp.Find('-') then begin
                            repeat
                                //Principle
                                GenJournalLine.Init;
                                LineNo := LineNo + 10000;
                                GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                GenJournalLine."Journal Batch Name" := 'LOANS';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := "Document No.";
                                GenJournalLine."Posting Date" := "Posting Date";
                                GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                GenJournalLine."Account No." := LoanApps."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                                GenJournalLine.Amount := LoanTopUp."Principle Top Up" * -1;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Pay Outstanding Interest on TopUp----------------------------------
                                GenJournalLine.Init;
                                LineNo := LineNo + 10000;
                                if LoanType.Get(LoanApps."Loan Product Type") then begin
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Employee;
                                    GenJournalLine."Account No." := LoanApps."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := "Document No.";
                                    GenJournalLine."Posting Date" := "Posting Date";
                                    GenJournalLine.Description := 'Interest Due Paid on top up ' + LoanApps."Loan Product Type Name";
                                    GenJournalLine.Amount := -LoanTopUp."Interest Top Up";
                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;
                                //End Pay Outstanding Interest on TopUp----------------------------------

                                //Levy On Bridging-------------------------------------------------------
                                if LoanType.Get(LoanApps."Loan Product Type") then begin
                                    GenJournalLine.Init;
                                    LineNo := LineNo + 10000;
                                    if LoanType."Top Up Commision" > 0 then begin
                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Account No." := LoanType."Top Up Commision Account";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Document No." := "Document No.";
                                        GenJournalLine."Posting Date" := "Posting Date";
                                        GenJournalLine.Description := 'Levy on Bridging';
                                        TopUpComm := LoanTopUp.Commision;
                                        TotalTopupComm := TotalTopupComm + TopUpComm;
                                        GenJournalLine.Amount := TopUpComm * -1;
                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                    end;
                                end;
                            //End Levy On Bridging-------------------------------------------------------
                            until LoanTopUp.Next = 0;
                        end;
                    end;

                    if "Mode Of Disbursement" = "mode of disbursement"::EFT then begin

                        PTEN := '';

                        if StrLen(LoanTopUp."Staff No") = 10 then begin
                            PTEN := CopyStr(LoanTopUp."Staff No", 10);
                        end else
                            if StrLen(LoanTopUp."Staff No") = 9 then begin
                                PTEN := CopyStr(LoanTopUp."Staff No", 9);
                            end else
                                if StrLen(LoanTopUp."Staff No") = 8 then begin
                                    PTEN := CopyStr(LoanTopUp."Staff No", 8);
                                end else
                                    if StrLen(LoanTopUp."Staff No") = 7 then begin
                                        PTEN := CopyStr(LoanTopUp."Staff No", 7);
                                    end else
                                        if StrLen(LoanTopUp."Staff No") = 6 then begin
                                            PTEN := CopyStr(LoanTopUp."Staff No", 6);
                                        end else
                                            if StrLen(LoanTopUp."Staff No") = 5 then begin
                                                PTEN := CopyStr(LoanTopUp."Staff No", 5);
                                            end else
                                                if StrLen(LoanTopUp."Staff No") = 4 then begin
                                                    PTEN := CopyStr(LoanTopUp."Staff No", 4);
                                                end else
                                                    if StrLen(LoanTopUp."Staff No") = 3 then begin
                                                        PTEN := CopyStr(LoanTopUp."Staff No", 3);
                                                    end else
                                                        if StrLen(LoanTopUp."Staff No") = 2 then begin
                                                            PTEN := CopyStr(LoanTopUp."Staff No", 2);
                                                        end else
                                                            if StrLen(LoanTopUp."Staff No") = 1 then begin
                                                                PTEN := CopyStr(LoanTopUp."Staff No", 1);
                                                            end;


                    end;



                    //Boosting Shares Commision
                    GenSetUp.Get();
                    if LoanApps."Boosting Commision" > 0 then begin
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := GenSetUp."Boosting Fees Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := "Document No.";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine.Description := 'Boosting Commision';
                        GenJournalLine.Amount := ROUND(LoanApps."Boosting Commision", 0.05, '=') * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        Deductions += GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        BatchBoostingCom += GenJournalLine.Amount;
                        if Cust.Get(LoanApps."Client Code") then begin
                            Cust.BoostedAmount := 0;
                            Cust.Modify;
                        end;

                    end;


                    HisaRepayment := 0;



                    if LoanApps."Hisa Allocation" > 0 then begin

                        HisaLoan.Reset;
                        HisaLoan.SetRange(HisaLoan."BOSA No", LoanApps."Client Code");
                        HisaLoan.SetFilter(HisaLoan."Loan Product Type", 'HISA ADV');
                        HisaLoan.SetFilter(HisaLoan."Outstanding Balance", '>0');
                        if HisaLoan.Find('-') then begin
                            //Principle
                            HisaLoan.CalcFields(HisaLoan."Outstanding Balance");
                            HisaRepayment := HisaLoan."Outstanding Balance";
                            // MESSAGE(HisaLoan."Client Code") ;
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := "Document No.";
                            ;
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                            GenJournalLine."Account No." := HisaLoan."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description := 'Off Set Hisa By - ' + HisaLoan."Loan  No.";
                            //GenJournalLine.Amount:=ROUND((HisaRepayment),1,'=') * -1;
                            GenJournalLine.Amount := ROUND((LoanApps."Hisa Allocation"), 0.05, '=') * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            Deductions += GenJournalLine.Amount;
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                            GenJournalLine."Loan No" := HisaLoan."Loan  No.";
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                            BatchHisaRepayment += GenJournalLine.Amount * -1;

                        end;
                    end;


                    //Fosa Hisa Commision
                    GenSetUp.Get();
                    if LoanApps."Hisa Commission" > 0 then begin
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := GenSetUp."Boosting Fees Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := "Document No.";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine.Description := 'Fosa Hisa Commision';
                        GenJournalLine.Amount := ROUND(LoanApps."Hisa Commission", 0.05, '<') * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        Deductions += GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        BatchFosaHisaComm += GenJournalLine.Amount * -1;
                    end;



                    //Hisa Boosting Shares Commision
                    if LoanApps."Hisa Boosting Commission" > 0 then begin

                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := GenSetUp."Boosting Fees Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := "Document No.";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine.Description := 'Hisa Share Boosting Commision';
                        GenJournalLine.Amount := ROUND(LoanApps."Hisa Boosting Commission", 0.05, '<') * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        Deductions += GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        BatchHisaShareBoostComm += GenJournalLine.Amount * -1;


                    end;





                    if LoanApps."Share Capital Due" > 0 then begin
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := "Document No.";
                        ;
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                        GenJournalLine."Account No." := LoanApps."Client Code";
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Recovery Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description := 'Share Capital ';
                        GenJournalLine.Amount := -LoanApps."Share Capital Due";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        Deductions += GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        BatchShareCap += GenJournalLine.Amount * -1;
                    end;

                    //7.
                    if LoanApps."Interest In Arrears" <> 0 then begin
                        if LoanType.Get(LoanApps."Loan Product Type") then begin
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := LoanType."Interest In Arrears Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := "Document No.";
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine.Description := 'InterestInArreas';
                            GenJournalLine.Amount := ROUND(LoanApps."Interest In Arrears" * -1, 0.05, '>');
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            Deductions += GenJournalLine.Amount;
                            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                            BatchIntinArr += GenJournalLine.Amount;
                        end;
                    end;


                    Loaninsurance := 0;

                    if LoanApps."Approved Amount" > 0 then begin
                        //LOAN INSURANCE--------------------------------
                        ProductCharges.Reset;
                        ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                        ProductCharges.SetRange(ProductCharges.Code, '0.5%INSUR');
                        if ProductCharges.Find('-') then begin
                            if ProductCharges."Use Perc" = true then begin
                                Loaninsurance := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                                InsuranceAcc := ProductCharges."G/L Account";

                            end else
                                Loaninsurance := ProductCharges.Amount;
                            InsuranceAcc := ProductCharges."G/L Account";
                        end;

                        //END LOAN INSURANCE------------------------------------

                        //Loaninsurance:=Loaninsurance;
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := "Document No.";
                        ;
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := InsuranceAcc;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description := 'Loan Insurance - ' + LoanApps."Loan  No.";
                        GenJournalLine.Amount := ROUND(LoanApps."Loan Insurance" * -1, 0.05, '=');
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        //Deductions+=GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                        //IF GenJournalLine.Amount<>0 THEN
                        GenJournalLine.Insert;
                    end;

                    TLoaninsurance := TLoaninsurance + GenJournalLine.Amount * -1;

                    //LPF
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'LPF');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            SMSFee := LoanApps."Approved Amount" * (ProductCharges.Percentage);
                            SMSAcc := ProductCharges."G/L Account";
                        end else
                            SMSFee := ProductCharges.Amount;
                        SMSAcc := ProductCharges."G/L Account";
                    end;
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := SMSAcc;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Loan Processing Fee - ' + LoanApps."Loan  No.";
                    GenJournalLine.Amount := SMSFee * -1;     //ROUND(LoanApps."Loan SMS Fee"*-1,0.05,'=');
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    //IF GenJournalLine.Amount<200 THEN
                    // SMSFee:=200;
                    // MODIFY;
                    GenJournalLine.Insert;


                    //Post Loan(Debit Member Loan Account)---------------------------------------------
                    GenJournalLine.Init;
                    LineNo := LineNo + 10000;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Document No." := "Document No.";
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine.Description := 'Loan principle' + LoanApps."Product Code";
                    GenJournalLine.Amount := LoanApps."Approved Amount";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //End Post Loan(Debit Member Loan Account)---------------------------------------------

                    //Post Loan(Credit EFT Account)------------------------------------------------
                    GenJournalLine.Init;
                    LineNo := LineNo + 10000;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := "BOSA Bank Account";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'loans' + LoanApps."Client Name" + '-' + LoanApps."Client Code";


                    //Commented by Cyrus to allow posting of Loans based on Disbursed Amount
                    /*
                    GenJournalLine.Amount:=(LoanApps."Approved Amount"-LoanApps."Loan Insurance"-LoanApps."Loan SMS Fee"-ROUND(LoanApps."Hisa Boosting Commission",0.05,'<')-ROUND(LoanApps."Hisa Commission",0.05,'<')
                    -ROUND((LoanApps."Hisa Allocation"),0.05,'=')-ROUND(LoanApps."Interest In Arrears",0.05,'>')-LoanApps."Total Topup Amount"-LoanApps."Share Capital Due"-LoanApps."Boosting Commision")*-1;
                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                    */
                    GenJournalLine.Amount := LoanApps."Loan Disbursed Amount";
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //End Post Loan(Credit Member Fosa Account)------------------------------------------------

                    //Recover Transfer Loan fee ------------------------------------------------------
                    GenJournalLine.Init;
                    LineNo := LineNo + 10000;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := GenSetUp."Loan Trasfer Fee A/C-EFT";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := "Document No.";
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine.Description := 'Loan Transfer Fee';
                    GenJournalLine.Amount := GenSetUp."Loan Trasfer Fee-EFT";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                    //GenJournalLine."Bal. Account No.":=GenSetUp."Loan Trasfer Fee A/C-EFT";
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //End Recover Transfer to Fosa commission------------------------------------------------------

                    if "Mode Of Disbursement" = "mode of disbursement"::"Transfer to FOSA" then begin
                        LoanApps."Net Payment to FOSA" := LoanApps."Approved Amount";
                        LoanApps."Processed Payment" := false;
                        Modify
                    end;

                    //Generate Data Sheet Advice
                    PTEN := '';

                    if StrLen(LoanApps."Staff No") = 10 then begin
                        PTEN := CopyStr(LoanApps."Staff No", 10);
                    end else
                        if StrLen(LoanApps."Staff No") = 9 then begin
                            PTEN := CopyStr(Loans."Staff No", 9);
                        end else
                            if StrLen(LoanApps."Staff No") = 8 then begin
                                PTEN := CopyStr(LoanApps."Staff No", 8);
                            end else
                                if StrLen(LoanApps."Staff No") = 7 then begin
                                    PTEN := CopyStr(LoanApps."Staff No", 7);
                                end else
                                    if StrLen(LoanApps."Staff No") = 6 then begin
                                        PTEN := CopyStr(LoanApps."Staff No", 6);
                                    end else
                                        if StrLen(LoanApps."Staff No") = 5 then begin
                                            PTEN := CopyStr(LoanApps."Staff No", 5);
                                        end else
                                            if StrLen(LoanApps."Staff No") = 4 then begin
                                                PTEN := CopyStr(LoanApps."Staff No", 4);
                                            end else
                                                if StrLen(LoanApps."Staff No") = 3 then begin
                                                    PTEN := CopyStr(LoanApps."Staff No", 3);
                                                end else
                                                    if StrLen(LoanApps."Staff No") = 2 then begin
                                                        PTEN := CopyStr(LoanApps."Staff No", 2);
                                                    end else
                                                        if StrLen(LoanApps."Staff No") = 1 then begin
                                                            PTEN := CopyStr(LoanApps."Staff No", 1);
                                                        end;



                    Loans."Staff No" := Customer."Personal No";
                    DataSheet.Init;
                    DataSheet."PF/Staff No" := LoanApps."Staff No";
                    DataSheet."Type of Deduction" := LoanApps."Loan Product Type";
                    DataSheet."Remark/LoanNO" := LoanApps."Loan  No.";
                    DataSheet.Name := LoanApps."Client Name";
                    DataSheet."ID NO." := LoanApps."ID NO";
                    DataSheet."Principal Amount" := LoanApps."Loan Principle Repayment";
                    DataSheet."Interest Amount" := LoanApps."Loan Interest Repayment";
                    DataSheet."Amount ON" := ROUND(LoanApps.Repayment, 5, '>');
                    //ROUND(LBalance / 100 / 12 * InterestRate,0.05,'>');
                    DataSheet."REF." := '2026';
                    DataSheet."Batch No." := "Batch No.";
                    DataSheet."New Balance" := LoanApps."Approved Amount";
                    DataSheet."Repayment Method" := Customer."Repayment Method";
                    DataSheet.Date := LoanApps."Issued Date";
                    if Customer.Get(LoanApps."Client Code") then begin
                        DataSheet.Employer := Customer."Employer Code";
                    end;
                    DataSheet."Sort Code" := PTEN;
                    DataSheet.Insert;
                    //END;

                    LoanApps."Issued Date" := Today;
                    LoanApps."Loan Status" := LoanApps."loan status"::Issued;
                    LoanApps.Posted := true;
                    LoanApps.Modify;
                //Loan Bridged and Comissions----------------------------------------------------
                until LoanApps.Next = 0;
            end;
        end;


        //END;
        //END;

        //Generate Data Sheet Advice




        //End of Disburesment to EFT******************************************************



        //If Mode of Disburesment is RTGS-New
        //Disburesment To EFT Account************************************************
        if "Mode Of Disbursement" = "mode of disbursement"::RTGS then begin
            LoanApps.Reset;
            LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
            LoanApps.SetRange(LoanApps."System Created", false);
            if LoanApps.Find('-') then begin
                repeat

                    LoanApps.CalcFields(LoanApps."Top Up Amount", LoanApps."Topup iNTEREST");
                    TCharges := 0;
                    TopUpComm := 0;
                    TotalTopupComm := 0;
                    Vend.Reset;
                    Vend.SetRange(Vend."No.", LoanApps."Account No");
                    if Vend.Find('-') then begin
                    end;
                    if LoanApps."Top Up Amount" > 0 then begin
                        LoanTopUp.Reset;
                        LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                        if LoanTopUp.Find('-') then begin
                            repeat
                                //Principle
                                GenJournalLine.Init;
                                LineNo := LineNo + 10000;
                                GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                GenJournalLine."Journal Batch Name" := 'LOANS';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := "Document No.";
                                GenJournalLine."Posting Date" := "Posting Date";
                                GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                GenJournalLine."Account No." := LoanApps."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                                GenJournalLine.Amount := LoanTopUp."Principle Top Up" * -1;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Pay Outstanding Interest on TopUp----------------------------------
                                GenJournalLine.Init;
                                LineNo := LineNo + 10000;
                                if LoanType.Get(LoanApps."Loan Product Type") then begin
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Employee;
                                    GenJournalLine."Account No." := LoanApps."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := "Document No.";
                                    GenJournalLine."Posting Date" := "Posting Date";
                                    GenJournalLine.Description := 'Interest Due Paid on top up ' + LoanApps."Loan Product Type Name";
                                    GenJournalLine.Amount := -LoanTopUp."Interest Top Up";
                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;
                                //End Pay Outstanding Interest on TopUp----------------------------------

                                //Levy On Bridging-------------------------------------------------------
                                if LoanType.Get(LoanApps."Loan Product Type") then begin
                                    GenJournalLine.Init;
                                    LineNo := LineNo + 10000;
                                    if LoanType."Top Up Commision" > 0 then begin
                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Account No." := LoanType."Top Up Commision Account";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Document No." := "Document No.";
                                        GenJournalLine."Posting Date" := "Posting Date";
                                        GenJournalLine.Description := 'Levy on Bridging';
                                        TopUpComm := LoanTopUp.Commision;
                                        TotalTopupComm := TotalTopupComm + TopUpComm;
                                        GenJournalLine.Amount := TopUpComm * -1;
                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                    end;
                                end;
                            //End Levy On Bridging-------------------------------------------------------
                            until LoanTopUp.Next = 0;
                        end;
                    end;




                    //Boosting Shares Commision
                    GenSetUp.Get();
                    if LoanApps."Boosting Commision" > 0 then begin
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := GenSetUp."Boosting Fees Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := "Document No.";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine.Description := 'Boosting Commision';
                        GenJournalLine.Amount := ROUND(LoanApps."Boosting Commision", 0.05, '=') * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        Deductions += GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        BatchBoostingCom += GenJournalLine.Amount;
                        if Cust.Get(LoanApps."Client Code") then begin
                            Cust.BoostedAmount := 0;
                            Cust.Modify;
                        end;

                    end;


                    HisaRepayment := 0;



                    if LoanApps."Hisa Allocation" > 0 then begin

                        HisaLoan.Reset;
                        HisaLoan.SetRange(HisaLoan."BOSA No", LoanApps."Client Code");
                        HisaLoan.SetFilter(HisaLoan."Loan Product Type", 'HISA ADV');
                        HisaLoan.SetFilter(HisaLoan."Outstanding Balance", '>0');
                        if HisaLoan.Find('-') then begin
                            //Principle
                            HisaLoan.CalcFields(HisaLoan."Outstanding Balance");
                            HisaRepayment := HisaLoan."Outstanding Balance";
                            // MESSAGE(HisaLoan."Client Code") ;
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := "Document No.";
                            ;
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                            GenJournalLine."Account No." := HisaLoan."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description := 'Off Set Hisa By - ' + HisaLoan."Loan  No.";
                            //GenJournalLine.Amount:=ROUND((HisaRepayment),1,'=') * -1;
                            GenJournalLine.Amount := ROUND((LoanApps."Hisa Allocation"), 0.05, '=') * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            Deductions += GenJournalLine.Amount;
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                            GenJournalLine."Loan No" := HisaLoan."Loan  No.";
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                            BatchHisaRepayment += GenJournalLine.Amount * -1;

                        end;
                    end;


                    //Fosa Hisa Commision
                    GenSetUp.Get();
                    if LoanApps."Hisa Commission" > 0 then begin
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := GenSetUp."Boosting Fees Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := "Document No.";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine.Description := 'Fosa Hisa Commision';
                        GenJournalLine.Amount := ROUND(LoanApps."Hisa Commission", 0.05, '<') * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        Deductions += GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        BatchFosaHisaComm += GenJournalLine.Amount * -1;
                    end;



                    //Hisa Boosting Shares Commision
                    if LoanApps."Hisa Boosting Commission" > 0 then begin

                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := GenSetUp."Boosting Fees Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := "Document No.";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine.Description := 'Hisa Share Boosting Commision';
                        GenJournalLine.Amount := ROUND(LoanApps."Hisa Boosting Commission", 0.05, '<') * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        Deductions += GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        BatchHisaShareBoostComm += GenJournalLine.Amount * -1;


                    end;





                    if LoanApps."Share Capital Due" > 0 then begin
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := "Document No.";
                        ;
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                        GenJournalLine."Account No." := LoanApps."Client Code";
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Recovery Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description := 'Share Capital ';
                        GenJournalLine.Amount := -LoanApps."Share Capital Due";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        Deductions += GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        BatchShareCap += GenJournalLine.Amount * -1;
                    end;

                    //7.
                    if LoanApps."Interest In Arrears" <> 0 then begin
                        if LoanType.Get(LoanApps."Loan Product Type") then begin
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := LoanType."Interest In Arrears Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := "Document No.";
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine.Description := 'InterestInArreas';
                            GenJournalLine.Amount := ROUND(LoanApps."Interest In Arrears" * -1, 0.05, '>');
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            Deductions += GenJournalLine.Amount;
                            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                            BatchIntinArr += GenJournalLine.Amount;
                        end;
                    end;


                    Loaninsurance := 0;

                    if LoanApps."Approved Amount" > 0 then begin
                        //LOAN INSURANCE--------------------------------
                        ProductCharges.Reset;
                        ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                        ProductCharges.SetRange(ProductCharges.Code, '0.5%INSUR');
                        if ProductCharges.Find('-') then begin
                            if ProductCharges."Use Perc" = true then begin
                                Loaninsurance := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                                InsuranceAcc := ProductCharges."G/L Account";

                            end else
                                Loaninsurance := ProductCharges.Amount;
                            InsuranceAcc := ProductCharges."G/L Account";
                        end;

                        //END LOAN INSURANCE------------------------------------

                        //Loaninsurance:=Loaninsurance;
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := "Document No.";
                        ;
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := InsuranceAcc;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description := 'Loan Insurance - ' + LoanApps."Loan  No.";
                        GenJournalLine.Amount := ROUND(LoanApps."Loan Insurance" * -1, 0.05, '=');
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        //Deductions+=GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                        //IF GenJournalLine.Amount<>0 THEN
                        GenJournalLine.Insert;
                    end;

                    TLoaninsurance := TLoaninsurance + GenJournalLine.Amount * -1;

                    //SMS
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'SMS');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            SMSFee := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                            SMSAcc := ProductCharges."G/L Account";
                        end else
                            SMSFee := ProductCharges.Amount;
                        SMSAcc := ProductCharges."G/L Account";
                    end;
                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := SMSAcc;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Loan SMS Fee - ' + LoanApps."Loan  No.";
                    GenJournalLine.Amount := ROUND(LoanApps."Loan SMS Fee" * -1, 0.05, '=');
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    //IF GenJournalLine.Amount<>0 THEN
                    GenJournalLine.Insert;


                    //Post Loan(Debit Member Loan Account)---------------------------------------------
                    GenJournalLine.Init;
                    LineNo := LineNo + 10000;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Document No." := "Document No.";
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine.Description := 'Loan principle';
                    GenJournalLine.Amount := LoanApps."Approved Amount";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //End Post Loan(Debit Member Loan Account)---------------------------------------------

                    //Post Loan(Credit rtgs Account)------------------------------------------------
                    GenJournalLine.Init;
                    LineNo := LineNo + 10000;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := "BOSA Bank Account";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'loans' + LoanApps."Client Name" + '-' + LoanApps."Client Code";
                    GenJournalLine.Amount := (LoanApps."Approved Amount" - LoanApps."Loan Insurance" - LoanApps."Loan SMS Fee" - ROUND(LoanApps."Hisa Boosting Commission", 0.05, '<') - ROUND(LoanApps."Hisa Commission", 0.05, '<')
                    - ROUND((LoanApps."Hisa Allocation"), 0.05, '=') - ROUND(LoanApps."Interest In Arrears", 0.05, '>') - LoanApps."Total Topup Amount" - LoanApps."Share Capital Due" - LoanApps."Boosting Commision" - GenSetUp."Loan Trasfer Fee-RTGS") * -1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //End Post Loan(Credit Member Fosa Account)------------------------------------------------

                    //Recover Transfer Loan fee ------------------------------------------------------
                    GenJournalLine.Init;
                    LineNo := LineNo + 10000;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := GenSetUp."Loan Trasfer Fee A/C-RTGS";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := "Document No.";
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine.Description := 'Loan Transfer Fee';
                    GenJournalLine.Amount := GenSetUp."Loan Trasfer Fee-RTGS" * -1;
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                    //GenJournalLine."Bal. Account No.":=GenSetUp."Loan Trasfer Fee A/C-EFT";
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //End Recover Transfer to Fosa commission------------------------------------------------------

                    if "Mode Of Disbursement" = "mode of disbursement"::"Transfer to FOSA" then begin
                        LoanApps."Net Payment to FOSA" := LoanApps."Approved Amount";
                        LoanApps."Processed Payment" := false;
                        Modify
                    end;


                    //Generate Data Sheet Advice-Put Off top-ups
                    PTEN := '';

                    if StrLen(LoanTopUp."Staff No") = 10 then begin
                        PTEN := CopyStr(LoanTopUp."Staff No", 10);
                    end else
                        if StrLen(LoanTopUp."Staff No") = 9 then begin
                            PTEN := CopyStr(LoanTopUp."Staff No", 9);
                        end else
                            if StrLen(LoanTopUp."Staff No") = 8 then begin
                                PTEN := CopyStr(LoanTopUp."Staff No", 8);
                            end else
                                if StrLen(LoanTopUp."Staff No") = 7 then begin
                                    PTEN := CopyStr(LoanTopUp."Staff No", 7);
                                end else
                                    if StrLen(LoanTopUp."Staff No") = 6 then begin
                                        PTEN := CopyStr(LoanTopUp."Staff No", 6);
                                    end else
                                        if StrLen(LoanTopUp."Staff No") = 5 then begin
                                            PTEN := CopyStr(LoanTopUp."Staff No", 5);
                                        end else
                                            if StrLen(LoanTopUp."Staff No") = 4 then begin
                                                PTEN := CopyStr(LoanTopUp."Staff No", 4);
                                            end else
                                                if StrLen(LoanTopUp."Staff No") = 3 then begin
                                                    PTEN := CopyStr(LoanTopUp."Staff No", 3);
                                                end else
                                                    if StrLen(LoanTopUp."Staff No") = 2 then begin
                                                        PTEN := CopyStr(LoanTopUp."Staff No", 2);
                                                    end else
                                                        if StrLen(LoanTopUp."Staff No") = 1 then begin
                                                            PTEN := CopyStr(LoanTopUp."Staff No", 1);
                                                        end;
                    //Delete Existing Duplicate  Datasheet
                    DataSheet.Reset;
                    DataSheet.SetRange(DataSheet."PF/Staff No", LoanApps."Staff No");
                    DataSheet.SetRange(DataSheet."ID NO.", LoanApps."ID NO");
                    DataSheet.SetRange(DataSheet.Date, LoanApps."Issued Date");
                    DataSheet.SetRange(DataSheet."Remark/LoanNO", LoanTopUp."Loan Top Up");
                    DataSheet.DeleteAll;
                    //End Delete Exisiting Duplicate Datasheet

                    if LoanTypes.Get(LoanTopUp."Loan Type") then begin
                        if Customer.Get(LoanTopUp."Client Code") then begin
                            //Loans."Staff No":=customer."Payroll/Staff No";
                            DataSheet.Init;
                            DataSheet."PF/Staff No" := LoanTopUp."Staff No";
                            DataSheet."Type of Deduction" := LoanTypes."Product Description";
                            DataSheet."Remark/LoanNO" := LoanTopUp."Loan Top Up";
                            DataSheet.Name := LoanApps."Client Name";
                            DataSheet."ID NO." := LoanApps."ID NO";
                            DataSheet."Amount ON" := 0;
                            DataSheet."Amount OFF" := LoanTopUp."Total Top Up";
                            DataSheet."REF." := '2026';
                            DataSheet."New Balance" := 0;
                            DataSheet.Date := Loans."Issued Date";
                            DataSheet.Employer := Customer."Employer Code";
                            DataSheet."Repayment Method" := Customer."Repayment Method";
                            DataSheet."Transaction Type" := DataSheet."transaction type"::ADJUSTMENT;
                            DataSheet."Sort Code" := PTEN;
                            DataSheet.Insert;
                        end;
                    end;
                    //End Levy On Briding------------------------------------------------------

                    //Generate Data Sheet Advice
                    PTEN := '';

                    if StrLen(LoanApps."Staff No") = 10 then begin
                        PTEN := CopyStr(LoanApps."Staff No", 10);
                    end else
                        if StrLen(LoanApps."Staff No") = 9 then begin
                            PTEN := CopyStr(Loans."Staff No", 9);
                        end else
                            if StrLen(LoanApps."Staff No") = 8 then begin
                                PTEN := CopyStr(LoanApps."Staff No", 8);
                            end else
                                if StrLen(LoanApps."Staff No") = 7 then begin
                                    PTEN := CopyStr(LoanApps."Staff No", 7);
                                end else
                                    if StrLen(LoanApps."Staff No") = 6 then begin
                                        PTEN := CopyStr(LoanApps."Staff No", 6);
                                    end else
                                        if StrLen(LoanApps."Staff No") = 5 then begin
                                            PTEN := CopyStr(LoanApps."Staff No", 5);
                                        end else
                                            if StrLen(LoanApps."Staff No") = 4 then begin
                                                PTEN := CopyStr(LoanApps."Staff No", 4);
                                            end else
                                                if StrLen(LoanApps."Staff No") = 3 then begin
                                                    PTEN := CopyStr(LoanApps."Staff No", 3);
                                                end else
                                                    if StrLen(LoanApps."Staff No") = 2 then begin
                                                        PTEN := CopyStr(LoanApps."Staff No", 2);
                                                    end else
                                                        if StrLen(LoanApps."Staff No") = 1 then begin
                                                            PTEN := CopyStr(LoanApps."Staff No", 1);
                                                        end;

                    //Delete Existing Duplicate  Datasheet
                    DataSheet.Reset;
                    DataSheet.SetRange(DataSheet."PF/Staff No", LoanApps."Staff No");
                    DataSheet.SetRange(DataSheet."ID NO.", LoanApps."ID NO");
                    DataSheet.SetRange(DataSheet.Date, LoanApps."Issued Date");
                    DataSheet.SetRange(DataSheet."Remark/LoanNO", LoanApps."Loan  No.");
                    DataSheet.DeleteAll;
                    //End Delete Exisiting Duplicate Datasheet
                    //IF LoanTypes.GET(Loans."Loan Product Type") THEN BEGIN
                    //IF Customer.GET(LoanApps."Client Code") THEN BEGIN
                    //Loans."Staff No":=customer."Payroll/Staff No";
                    DataSheet.Init;
                    DataSheet."PF/Staff No" := LoanApps."Staff No";
                    DataSheet."Type of Deduction" := LoanApps."Loan Product Type";
                    DataSheet."Remark/LoanNO" := LoanApps."Loan  No.";
                    DataSheet.Name := LoanApps."Client Name";
                    DataSheet."ID NO." := LoanApps."ID NO";
                    DataSheet."Principal Amount" := LoanApps."Loan Principle Repayment";
                    DataSheet."Interest Amount" := LoanApps."Loan Interest Repayment";
                    DataSheet."Amount ON" := ROUND(LoanApps.Repayment, 5, '>');
                    //ROUND(LBalance / 100 / 12 * InterestRate,0.05,'>');
                    DataSheet."REF." := '2026';
                    DataSheet."Batch No." := "Batch No.";
                    DataSheet."New Balance" := LoanApps."Approved Amount";
                    DataSheet."Repayment Method" := Customer."Repayment Method";
                    DataSheet.Date := LoanApps."Issued Date";
                    if Customer.Get(LoanApps."Client Code") then begin
                        DataSheet.Employer := Customer."Employer Code";
                    end;
                    DataSheet."Sort Code" := PTEN;
                    DataSheet.Insert;

                    LoanApps."Issued Date" := Today;
                    LoanApps."Loan Status" := LoanApps."loan status"::Issued;
                    LoanApps.Posted := true;
                    LoanApps.Modify;
                //Loan Bridged and Comissions----------------------------------------------------
                until LoanApps.Next = 0;
            end;
        end;

        //End RTGS New

        //Disburesment Via Cheque**************************************************************
        if "Mode Of Disbursement" = "mode of disbursement"::Cheque then begin
            LoanApps.Reset;
            LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
            LoanApps.SetRange(LoanApps."System Created", false);
            LoanApps.SetFilter(LoanApps."Loan Status", '<>Rejected');
            if LoanApps.Find('-') then begin
                repeat

                    LoanApps.CalcFields(LoanApps."Top Up Amount", LoanApps."Topup iNTEREST");
                    TCharges := 0;
                    TopUpComm := 0;
                    TotalTopupComm := 0;
                    if LoanApps."Top Up Amount" > 0 then begin
                        LoanTopUp.Reset;
                        LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                        if LoanTopUp.Find('-') then begin
                            repeat
                                GenJournalLine.Init;
                                LineNo := LineNo + 10000;
                                //Principle
                                GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                GenJournalLine."Journal Batch Name" := 'LOANS';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := "Document No.";
                                GenJournalLine."Posting Date" := "Posting Date";
                                GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                GenJournalLine."Account No." := LoanApps."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                                GenJournalLine.Amount := LoanTopUp."Principle Top Up" * -1;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Interest Due Paid-----------------------------------------------
                                GenJournalLine.Init;
                                LineNo := LineNo + 10000;
                                if LoanType.Get(LoanApps."Loan Product Type") then begin
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Employee;
                                    GenJournalLine."Account No." := LoanApps."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := "Document No.";
                                    GenJournalLine."Posting Date" := "Posting Date";
                                    GenJournalLine.Description := 'Interest Due Paid on top up ' + LoanApps."Loan Product Type Name";
                                    GenJournalLine.Amount := -LoanTopUp."Interest Top Up";
                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;
                                //End Interest Due Paid-----------------------------------------------

                                //Levy On Briding-----------------------------------------------------
                                if LoanType.Get(LoanApps."Loan Product Type") then begin
                                    GenJournalLine.Init;
                                    LineNo := LineNo + 10000;
                                    if LoanType."Top Up Commision" > 0 then begin
                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Account No." := LoanType."Top Up Commision Account";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Document No." := "Document No.";
                                        GenJournalLine."Posting Date" := "Posting Date";
                                        GenJournalLine.Description := 'Levy on Bridging';
                                        TopUpComm := LoanTopUp.Commision;
                                        TotalTopupComm := TotalTopupComm + TopUpComm;
                                        GenJournalLine.Amount := TopUpComm * -1;
                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                    end;
                                end;
                                //End Levy On Briding-----------------------------------------------------


                                //Penalty Paid On Defaulted Loan-----------------------------------------------------
                                GenJournalLine.Init;
                                LineNo := LineNo + 10000;
                                if LoanType.Get(LoanApps."Loan Product Type") then begin
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Employee;
                                    GenJournalLine."Account No." := LoanApps."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := "Document No.";
                                    GenJournalLine."Posting Date" := "Posting Date";
                                    GenJournalLine.Description := 'Penalty Paid on Loan Defaulted ' + LoanApps."Loan Product Type Name";
                                    GenJournalLine.Amount := -LoanTopUp."Penalty Charged";
                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"23";
                                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;
                                //End Penalty Paid On Defaulted Loan-----------------------------------------------------
                                //Generate Data Sheet Advice-Put Off top-ups
                                PTEN := '';

                                if StrLen(LoanTopUp."Staff No") = 10 then begin
                                    PTEN := CopyStr(LoanTopUp."Staff No", 10);
                                end else
                                    if StrLen(LoanTopUp."Staff No") = 9 then begin
                                        PTEN := CopyStr(LoanTopUp."Staff No", 9);
                                    end else
                                        if StrLen(LoanTopUp."Staff No") = 8 then begin
                                            PTEN := CopyStr(LoanTopUp."Staff No", 8);
                                        end else
                                            if StrLen(LoanTopUp."Staff No") = 7 then begin
                                                PTEN := CopyStr(LoanTopUp."Staff No", 7);
                                            end else
                                                if StrLen(LoanTopUp."Staff No") = 6 then begin
                                                    PTEN := CopyStr(LoanTopUp."Staff No", 6);
                                                end else
                                                    if StrLen(LoanTopUp."Staff No") = 5 then begin
                                                        PTEN := CopyStr(LoanTopUp."Staff No", 5);
                                                    end else
                                                        if StrLen(LoanTopUp."Staff No") = 4 then begin
                                                            PTEN := CopyStr(LoanTopUp."Staff No", 4);
                                                        end else
                                                            if StrLen(LoanTopUp."Staff No") = 3 then begin
                                                                PTEN := CopyStr(LoanTopUp."Staff No", 3);
                                                            end else
                                                                if StrLen(LoanTopUp."Staff No") = 2 then begin
                                                                    PTEN := CopyStr(LoanTopUp."Staff No", 2);
                                                                end else
                                                                    if StrLen(LoanTopUp."Staff No") = 1 then begin
                                                                        PTEN := CopyStr(LoanTopUp."Staff No", 1);
                                                                    end;

                                if LoanTypes.Get(LoanTopUp."Loan Type") then begin
                                    if Customer.Get(LoanTopUp."Client Code") then begin
                                        //Loans."Staff No":=customer."Payroll/Staff No";
                                        DataSheet.Reset;
                                        DataSheet.SetRange(DataSheet."PF/Staff No", LoanApps."Staff No");
                                        DataSheet.SetRange(DataSheet."ID NO.", LoanApps."ID NO");
                                        DataSheet.SetRange(DataSheet.Date, LoanApps."Issued Date");
                                        DataSheet.SetRange(DataSheet."Remark/LoanNO", LoanTopUp."Loan Top Up");
                                        if DataSheet.Find('-') then begin
                                            DataSheet.Delete
                                        end;
                                        DataSheet.Reset;
                                        DataSheet.SetRange(DataSheet."PF/Staff No", LoanApps."Staff No");
                                        DataSheet.SetRange(DataSheet."ID NO.", LoanApps."ID NO");
                                        DataSheet.SetRange(DataSheet.Date, LoanApps."Issued Date");
                                        DataSheet.SetRange(DataSheet."Remark/LoanNO", LoanTopUp."Loan Top Up");
                                        if DataSheet.Find('-') then begin
                                            DataSheet.Init;
                                            DataSheet."PF/Staff No" := LoanTopUp."Staff No";
                                            DataSheet."Type of Deduction" := LoanTypes."Product Description";
                                            DataSheet."Remark/LoanNO" := LoanTopUp."Loan Top Up";
                                            DataSheet.Name := LoanApps."Client Name";
                                            DataSheet."ID NO." := LoanApps."ID NO";
                                            DataSheet."Amount ON" := 0;
                                            DataSheet."Amount OFF" := LoanTopUp."Total Top Up";
                                            DataSheet."REF." := '2026';
                                            DataSheet."New Balance" := 0;
                                            DataSheet.Date := Loans."Issued Date";
                                            DataSheet.Employer := Customer."Employer Code";
                                            DataSheet."Repayment Method" := Customer."Repayment Method";
                                            DataSheet."Transaction Type" := DataSheet."transaction type"::ADJUSTMENT;
                                            DataSheet."Sort Code" := PTEN;
                                            DataSheet.Insert;
                                        end;
                                    end;
                                end;

                                BatchTopUpAmount := 0;
                                BatchTopUpComm := 0;
                                BatchTopUpAmount := BatchTopUpAmount + LoanApps."Top Up Amount" + LoanTopUp."Interest Top Up";
                                BatchTopUpComm := BatchTopUpComm + TotalTopupComm;
                            until LoanTopUp.Next = 0;
                        end;
                    end;

                    //Comission on Disburesment Via Cheque----------------------------------------------
                    GenJournalLine.Init;
                    LineNo := LineNo + 10000;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                    GenJournalLine."Account No." := GenSetUp."Loan Trasfer Fee A/C-Cheque";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No." := "Document No.";
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine.Description := 'CHQ COMM';
                    GenJournalLine.Amount := GenSetUp."Loan Trasfer Fee-Cheque" * -1;
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //End Comission on Disburesment Via Cheque----------------------------------------------

                    //Disburesment Via Cheque(Debit Members Account)-------------------------
                    GenJournalLine.Init;
                    LineNo := LineNo + 10000;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'loans' + LoanApps."Client Name" + '-' + LoanApps."Client Code";
                    GenJournalLine.Amount := LoanApps."Approved Amount";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //End Disburesment Via Cheque(Debit Members Account)-------------------------

                    //Disburesment Via Cheque(Credit Bank)-----------------------------------------------------
                    GenJournalLine.Init;
                    LineNo := LineNo + 10000;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := "BOSA Bank Account";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'loans' + LoanApps."Client Name" + '-' + LoanApps."Client Code";
                    if LoanApps."Top Up Amount" > 0 then begin
                        GenJournalLine.Amount := LoanApps."Approved Amount" * -1 + (GenSetUp."Loan Trasfer Fee-Cheque" + LoanApps."Top Up Amount" + BatchTopUpComm + upfronts + LoanApps."Deposit Reinstatement" + LoanApps."Jaza Deposits" + (LoanApps."Jaza Deposits" * 0.15));
                    end else begin
                        GenJournalLine.Amount := LoanApps."Approved Amount" * -1 + (GenSetUp."Loan Trasfer Fee-Cheque" + upfronts + LoanApps."Deposit Reinstatement" + LoanApps."Jaza Deposits" + (LoanApps."Jaza Deposits" * 0.15));
                    end;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    LoanApps."Issued Date" := Today;
                    LoanApps."Loan Status" := LoanApps."loan status"::Issued;
                    LoanApps.Posted := true;
                    LoanApps.Modify;
                //End Disburesment Via Cheque(Credit Bank)-----------------------------------------------------
                until LoanApps.Next = 0;
            end;
        end;
        //End of Disburesment Via Cheque**************************************************************

        //Post New

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;
        LoanApps."Issued Date" := Today;
        LoanApps."Loan Status" := LoanApps."loan status"::Issued;
        LoanApps.Posted := true;
        LoanApps.Modify;

        GenSetUp.Get();
        //Send Loan Disburesment SMS*********************************************
        if GenSetUp."Send Loan Disbursement SMS" = true then begin
            FnSendDisburesmentSMS(LoanApps."Loan  No.", LoanApps."Client Code");
        end;
        //Send Loan Disburesment Email*******************************************
        if GenSetUp."Send Loan Disbursement Email" = true then begin
            FnSendDisburesmentEmail(LoanApps."Loan  No.");
        end;
        Posted := true;
        Modify;

        Message('Batch posted successfully.');

    end;

    local procedure FnPostImported()
    begin
        if Posted = true then
            Error('Batch already posted.');
        //IF Status<>Status::Approved THEN
        //ERROR(FORMAT(Text001));
        CalcFields(Location);
        if Confirm('Are you sure you want to post this batch?', true) = false then
            exit;
        TestField("Description/Remarks");
        TestField("Posting Date");
        TestField("Document No.");
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PaymentS');
        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
        GenJournalLine.DeleteAll;

        GenSetUp.Get();

        //Disburesment To FOSA Account************************************************
        if "Mode Of Disbursement" = "mode of disbursement"::"Transfer to FOSA" then begin
            LoanApps.Reset;
            LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
            LoanApps.SetRange(LoanApps."System Created", false);
            if LoanApps.Find('-') then begin
                repeat


                    LoanApps.CalcFields(LoanApps."Top Up Amount", LoanApps."Topup iNTEREST");
                    TCharges := 0;
                    TopUpComm := 0;
                    TotalTopupComm := 0;
                    Vend.Reset;
                    Vend.SetRange(Vend."No.", LoanApps."Account No");
                    if Vend.Find('-') then begin
                    end;

                    //Post Loan(Debit Member Loan Account)---------------------------------------------
                    GenJournalLine.Init;
                    LineNo := LineNo + 10000;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Document No." := "Document No.";
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine.Description := 'Loan principle' + LoanApps."Product Code";
                    GenJournalLine.Amount := LoanApps."Approved Amount";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code"; //"Global Dimension 2 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //End Post Loan(Debit Member Loan Account)---------------------------------------------


                    if LoanApps."Top Up Amount" > 0 then begin
                        LoanTopUp.Reset;
                        LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                        if LoanTopUp.Find('-') then begin
                            repeat
                                //Principle
                                GenJournalLine.Init;
                                LineNo := LineNo + 10000;
                                GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                GenJournalLine."Journal Batch Name" := 'LOANS';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := "Document No.";
                                GenJournalLine."Posting Date" := "Posting Date";
                                GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                GenJournalLine."Account No." := LoanApps."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                                GenJournalLine.Amount := LoanTopUp."Principle Top Up" * -1;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                // GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                                //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //Pay Outstanding Interest on TopUp----------------------------------
                                GenJournalLine.Init;
                                LineNo := LineNo + 10000;
                                if LoanType.Get(LoanApps."Loan Product Type") then begin
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                    GenJournalLine."Account No." := LoanApps."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := "Document No.";
                                    GenJournalLine."Posting Date" := "Posting Date";
                                    GenJournalLine.Description := 'Interest Due Paid on top up ' + LoanApps."Loan Product Type Name";
                                    GenJournalLine.Amount := -LoanTopUp."Interest Top Up";
                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                    // GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                                    //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;
                                //End Pay Outstanding Interest on TopUp----------------------------------

                                //Levy On Bridging-------------------------------------------------------
                                if LoanType.Get(LoanApps."Loan Product Type") then begin
                                    GenJournalLine.Init;
                                    LineNo := LineNo + 10000;
                                    if LoanType."Top Up Commision" > 0 then begin
                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Account No." := LoanType."Top Up Commision Account";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Document No." := "Document No.";
                                        GenJournalLine."Posting Date" := "Posting Date";
                                        GenJournalLine.Description := 'Levy on Bridging';
                                        TopUpComm := LoanTopUp.Commision;
                                        TotalTopupComm := TotalTopupComm + TopUpComm;
                                        GenJournalLine.Amount := TopUpComm * -1;
                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        // GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                        //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                                        //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                    end;
                                end;
                            //End Levy On Bridging-------------------------------------------------------
                            until LoanTopUp.Next = 0;
                        end;
                    end;




                    //Boosting Shares Commision
                    GenSetUp.Get();
                    if LoanApps."Boosting Commision" > 0 then begin
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := GenSetUp."Boosting Fees Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := "Document No.";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine.Description := 'Boosting Commision';
                        GenJournalLine.Amount := ROUND(LoanApps."Boosting Commision", 0.05, '=') * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        Deductions += GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                        GenJournalLine."Bal. Account No." := LoanApps."Client Code";
                        GenJournalLine."Bal. Account No." := LoanApps."Account No";
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        BatchBoostingCom += GenJournalLine.Amount;
                        if Cust.Get(LoanApps."Client Code") then begin
                            Cust.BoostedAmount := 0;
                            Cust.Modify;
                        end;

                    end;








                    //Loan TOP Up Interest Accrual for the Month
                    if (LoanApps."Loan Product Type" = 'TOPUPADV') or (LoanApps."Loan Product Type" = 'ORDINARYADV') then begin
                        if LoanType.Get(LoanApps."Loan Product Type") then begin
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                            GenJournalLine."Account No." := LoanApps."Account No";
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Loan No" := LoanApps."Loan  No.";
                            GenJournalLine."Document No." := "Document No.";
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine.Description := 'Interest Due';
                            GenJournalLine.Amount := (LoanType."Interest rate" / 1200) * LoanApps."Approved Amount";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            Deductions += GenJournalLine.Amount;
                            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := LoanType."Loan Interest Account";
                            //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;


                            //Processing Fee Okoa
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                            GenJournalLine."Account No." := LoanApps."Account No";
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Loan No" := LoanApps."Loan  No.";
                            GenJournalLine."Document No." := "Document No.";
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine.Description := 'Processing Fee Okoa';
                            GenJournalLine.Amount := 100;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            Deductions += GenJournalLine.Amount;
                            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := LoanType."Loan Interest Account";
                            //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                        end;
                    end;



                    //7.
                    if LoanApps."Interest In Arrears" <> 0 then begin
                        if LoanType.Get(LoanApps."Loan Product Type") then begin
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := LoanType."Interest In Arrears Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := "Document No.";
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine.Description := 'InterestInArreas';
                            GenJournalLine.Amount := ROUND(LoanApps."Interest In Arrears" * -1, 0.05, '>');
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            Deductions += GenJournalLine.Amount;
                            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                            GenJournalLine."Bal. Account No." := LoanApps."Account No";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                            BatchIntinArr += GenJournalLine.Amount;
                        end;
                    end;


                    Loaninsurance := 0;

                    if LoanApps."Approved Amount" > 0 then begin
                        //LOAN INSURANCE--------------------------------
                        ProductCharges.Reset;
                        ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                        ProductCharges.SetRange(ProductCharges.Code, 'LINSURANCE');
                        if ProductCharges.Find('-') then begin
                            if ProductCharges."Use Perc" = true then begin
                                Loaninsurance := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                                InsuranceAcc := ProductCharges."G/L Account";

                            end else
                                Loaninsurance := ProductCharges.Amount;
                            InsuranceAcc := ProductCharges."G/L Account";
                        end;

                        //END LOAN INSURANCE------------------------------------

                        //Loaninsurance:=Loaninsurance;
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := "Document No.";
                        ;
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                        GenJournalLine."Account No." := LoanApps."Client Code";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description := 'Loan Insurance - ' + LoanApps."Loan  No.";
                        GenJournalLine.Amount := ROUND(Loaninsurance, 0.05, '=');
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        //Deductions+=GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := InsuranceAcc;
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;

                    TLoaninsurance := TLoaninsurance + GenJournalLine.Amount * -1;

                    //Loan processing fee (LPF).....
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'PROCESSSINGFEE');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            LoanProcessingFee := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                            if LoanProcessingFee < ProductCharges."Minimum Amount" then begin
                                LoanProcessingFee := ProductCharges."Minimum Amount"
                            end else
                                LoanProcessingFee := LoanProcessingFee;
                            LoanProcessingFeeAcc := ProductCharges."G/L Account";
                        end else
                            LoanProcessingFee := ProductCharges.Amount;
                        LoanProcessingFeeAcc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Loan Processing Fee - ' + LoanApps."Loan  No.";
                    GenJournalLine.Amount := LoanProcessingFee;    //ROUND(LoanApps."Loan SMS Fee"*-1,0.05,'=');
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := LoanProcessingFeeAcc;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    // IF GenJournalLine.Amount<200 THEN
                    //SMSFee:=200;
                    // MODIFY;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Loan Appraisal fee (Loan Appraisal).....
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'LAPPRAISAL');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            LoanProcessingFee := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                            if LoanProcessingFee < ProductCharges."Minimum Amount" then begin
                                LoanProcessingFee := ProductCharges."Minimum Amount"
                            end else
                                LoanProcessingFee := LoanProcessingFee;
                            LoanProcessingFeeAcc := ProductCharges."G/L Account";
                        end else
                            LoanProcessingFee := ProductCharges.Amount;
                        LoanProcessingFeeAcc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Loan Appraisal Fee - ' + LoanApps."Loan  No.";
                    GenJournalLine.Amount := LoanProcessingFee;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := LoanProcessingFeeAcc;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    // IF GenJournalLine.Amount<200 THEN
                    //SMSFee:=200;
                    // MODIFY;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Sacco Interest (SaccoInt).....

                    if LoanApps."Sacco Interest" > 0 then begin
                        ProductCharges.Reset;
                        ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                        ProductCharges.SetRange(ProductCharges.Code, 'SACCOINT');
                        if ProductCharges.Find('-') then begin
                            if ProductCharges."Use Perc" = true then begin
                                LoanProcessingFee := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                                if SaccoInterest < ProductCharges."Minimum Amount" then begin
                                    SaccoInterest := ProductCharges."Minimum Amount"
                                end else
                                    SaccoInterest := SaccoInterest;
                                SaccoInterestAccount := ProductCharges."G/L Account";

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                GenJournalLine."Journal Batch Name" := 'LOANS';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := "Document No.";
                                ;
                                GenJournalLine."Posting Date" := "Posting Date";
                                GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                GenJournalLine."Account No." := LoanApps."Client Code";
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Sacco Interest - ' + LoanApps."Loan  No.";
                                GenJournalLine.Amount := LoanApps."Sacco Interest";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := SaccoInterestAccount;
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                            end;
                        end;
                    end;

                    //TSC Interest (TSCINT).....
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'TSCINT');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            TSCInterest := LoanApps."Approved Amount" * (ProductCharges.Percentage / 200) * (LoanApps.Installments + 1);
                            if TSCInterest < ProductCharges."Minimum Amount" then begin
                                TSCInterest := ProductCharges."Minimum Amount"
                            end else
                                TSCInterest := LoanProcessingFee;
                            TSCInterestAc := ProductCharges."G/L Account";
                        end else
                            TSCInterest := ProductCharges.Amount;
                        TSCInterestAc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'TSC Interest - ' + LoanApps."Loan  No.";
                    GenJournalLine.Amount := TSCInterest;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := TSCInterestAc;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //Loan Form Fee (FORMFEE).....
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'FORMFEE');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            LoanProcessingFee := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                            if LoanProcessingFee < ProductCharges."Minimum Amount" then begin
                                LoanProcessingFee := ProductCharges."Minimum Amount"
                            end else
                                LoanProcessingFee := LoanProcessingFee;
                            LoanProcessingFeeAcc := ProductCharges."G/L Account";
                        end else
                            LoanProcessingFee := ProductCharges.Amount;
                        LoanProcessingFeeAcc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Loan Form Fee - ' + LoanApps."Loan  No.";
                    GenJournalLine.Amount := LoanProcessingFee;    //ROUND(LoanApps."Loan SMS Fee"*-1,0.05,'=');
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := LoanProcessingFeeAcc;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    // IF GenJournalLine.Amount<200 THEN
                    //SMSFee:=200;
                    // MODIFY;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //Loan Application Fee (LAPPLICATION).....
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'LAPPLICATION');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            LApplicationFee := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                            if LApplicationFee < ProductCharges."Minimum Amount" then begin
                                LApplicationFee := ProductCharges."Minimum Amount"
                            end else
                                LApplicationFee := LApplicationFee;
                            LApplicationFeeAcc := ProductCharges."G/L Account";
                        end else
                            LoanProcessingFee := ProductCharges.Amount;
                        LoanProcessingFeeAcc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Loan Application Fee - ' + LoanApps."Loan  No.";
                    GenJournalLine.Amount := LApplicationFee;    //ROUND(LoanApps."Loan SMS Fee"*-1,0.05,'=');
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := LApplicationFeeAcc;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    // IF GenJournalLine.Amount<200 THEN
                    //SMSFee:=200;
                    // MODIFY;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Accrued Interest (ACCRUEDINT).....
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'ACCRUEDINT');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            AccruedInt := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);// *(LoanApps.Installments+1);
                            if AccruedInt < ProductCharges."Minimum Amount" then begin
                                AccruedInt := ProductCharges."Minimum Amount"
                            end else
                                AccruedInt := AccruedInt;
                            AccruedIntAcc := ProductCharges."G/L Account";
                        end else
                            AccruedInt := ProductCharges.Amount;
                        AccruedIntAcc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Accrued Interest - ' + LoanApps."Loan  No.";
                    GenJournalLine.Amount := AccruedInt;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                    GenJournalLine."Bal. Account No." := AccruedIntAcc;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    // IF GenJournalLine.Amount<200 THEN
                    //SMSFee:=200;
                    // MODIFY;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //Interest Capitalized  (INTUPFRONT).....
                    if (LoanApps.Installments <= 12) then begin
                        IntCapitalizationFactor := 1
                    end else
                        IntCapitalizationFactor := 2;


                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'INTUPFRONT');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            IntCapitalized := (LoanApps."Approved Amount" * (ProductCharges.Percentage / 100)) * IntCapitalizationFactor;// *(LoanApps.Installments+1);
                            if IntCapitalized < ProductCharges."Minimum Amount" then begin
                                IntCapitalized := ProductCharges."Minimum Amount"
                            end else
                                IntCapitalized := IntCapitalized;
                            IntCapitalizedAcc := ProductCharges."G/L Account";
                        end else
                            IntCapitalized := ProductCharges.Amount;
                        IntCapitalizedAcc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Interest Capitalized - ' + LoanApps."Loan  No.";
                    GenJournalLine.Amount := IntCapitalized;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                    GenJournalLine."Bal. Account No." := IntCapitalizedAcc;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Branch Code";
                    // IF GenJournalLine.Amount<200 THEN
                    //SMSFee:=200;
                    // MODIFY;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;



                    //Generate Data Sheet Advice-Put Off top-ups
                    PTEN := '';

                    if StrLen(LoanTopUp."Staff No") = 10 then begin
                        PTEN := CopyStr(LoanTopUp."Staff No", 10);
                    end else
                        if StrLen(LoanTopUp."Staff No") = 9 then begin
                            PTEN := CopyStr(LoanTopUp."Staff No", 9);
                        end else
                            if StrLen(LoanTopUp."Staff No") = 8 then begin
                                PTEN := CopyStr(LoanTopUp."Staff No", 8);
                            end else
                                if StrLen(LoanTopUp."Staff No") = 7 then begin
                                    PTEN := CopyStr(LoanTopUp."Staff No", 7);
                                end else
                                    if StrLen(LoanTopUp."Staff No") = 6 then begin
                                        PTEN := CopyStr(LoanTopUp."Staff No", 6);
                                    end else
                                        if StrLen(LoanTopUp."Staff No") = 5 then begin
                                            PTEN := CopyStr(LoanTopUp."Staff No", 5);
                                        end else
                                            if StrLen(LoanTopUp."Staff No") = 4 then begin
                                                PTEN := CopyStr(LoanTopUp."Staff No", 4);
                                            end else
                                                if StrLen(LoanTopUp."Staff No") = 3 then begin
                                                    PTEN := CopyStr(LoanTopUp."Staff No", 3);
                                                end else
                                                    if StrLen(LoanTopUp."Staff No") = 2 then begin
                                                        PTEN := CopyStr(LoanTopUp."Staff No", 2);
                                                    end else
                                                        if StrLen(LoanTopUp."Staff No") = 1 then begin
                                                            PTEN := CopyStr(LoanTopUp."Staff No", 1);
                                                        end;

                    if LoanTypes.Get(LoanTopUp."Loan Type") then begin
                        if Cust.Get(LoanTopUp."Client Code") then begin

                            //Loans."Staff No":=customer."Payroll/Staff No";

                            DataSheet.Init;
                            DataSheet."PF/Staff No" := LoanTopUp."Staff No";
                            DataSheet."Type of Deduction" := LoanTypes."Product Description";
                            DataSheet."Remark/LoanNO" := LoanTopUp."Loan Top Up";
                            DataSheet.Name := LoanApps."Client Name";
                            DataSheet."ID NO." := LoanApps."ID NO";
                            DataSheet."Amount ON" := 0;
                            DataSheet."Amount OFF" := LoanTopUp."Total Top Up";
                            DataSheet."REF." := '2026';
                            DataSheet."New Balance" := 0;
                            DataSheet.Date := Loans."Issued Date";
                            DataSheet.Employer := Customer."Employer Code";
                            DataSheet."Repayment Method" := Customer."Repayment Method";
                            DataSheet."Transaction Type" := DataSheet."transaction type"::ADJUSTMENT;
                            DataSheet."Sort Code" := PTEN;
                            DataSheet.Insert;
                        end;
                    end;

                    //Loan Bridged and Comissions----------------------------------------------------
                    //Generate Data Sheet Advice
                    PTEN := '';

                    if StrLen(LoanApps."Staff No") = 10 then begin
                        PTEN := CopyStr(LoanApps."Staff No", 10);
                    end else
                        if StrLen(LoanApps."Staff No") = 9 then begin
                            PTEN := CopyStr(Loans."Staff No", 9);
                        end else
                            if StrLen(LoanApps."Staff No") = 8 then begin
                                PTEN := CopyStr(LoanApps."Staff No", 8);
                            end else
                                if StrLen(LoanApps."Staff No") = 7 then begin
                                    PTEN := CopyStr(LoanApps."Staff No", 7);
                                end else
                                    if StrLen(LoanApps."Staff No") = 6 then begin
                                        PTEN := CopyStr(LoanApps."Staff No", 6);
                                    end else
                                        if StrLen(LoanApps."Staff No") = 5 then begin
                                            PTEN := CopyStr(LoanApps."Staff No", 5);
                                        end else
                                            if StrLen(LoanApps."Staff No") = 4 then begin
                                                PTEN := CopyStr(LoanApps."Staff No", 4);
                                            end else
                                                if StrLen(LoanApps."Staff No") = 3 then begin
                                                    PTEN := CopyStr(LoanApps."Staff No", 3);
                                                end else
                                                    if StrLen(LoanApps."Staff No") = 2 then begin
                                                        PTEN := CopyStr(LoanApps."Staff No", 2);
                                                    end else
                                                        if StrLen(LoanApps."Staff No") = 1 then begin
                                                            PTEN := CopyStr(LoanApps."Staff No", 1);
                                                        end;



                    Loans."Staff No" := Customer."Personal No";
                    DataSheet.Init;
                    DataSheet."PF/Staff No" := LoanApps."Staff No";
                    DataSheet."Type of Deduction" := LoanApps."Loan Product Type";
                    DataSheet."Remark/LoanNO" := LoanApps."Loan  No.";
                    DataSheet.Name := LoanApps."Client Name";
                    DataSheet."ID NO." := LoanApps."ID NO";
                    DataSheet."Principal Amount" := LoanApps."Loan Principle Repayment";
                    DataSheet."Interest Amount" := LoanApps."Loan Interest Repayment";
                    DataSheet."Amount ON" := ROUND(LoanApps.Repayment, 5, '>');
                    //ROUND(LBalance / 100 / 12 * InterestRate,0.05,'>');
                    DataSheet."REF." := '2026';
                    DataSheet."Batch No." := "Batch No.";
                    DataSheet."New Balance" := LoanApps."Approved Amount";
                    DataSheet."Repayment Method" := Customer."Repayment Method";
                    DataSheet.Date := LoanApps."Issued Date";
                    if Customer.Get(LoanApps."Client Code") then begin
                        DataSheet.Employer := Customer."Employer Code";
                    end;
                    DataSheet."Sort Code" := PTEN;
                    DataSheet.Insert;
                    //END;
                    //END;
                    LoanApps."Issued Date" := Today;
                    LoanApps."Loan Status" := LoanApps."loan status"::Issued;
                    LoanApps.Posted := true;
                    LoanApps.Modify;
                //Generate Data Sheet Advice
                until LoanApps.Next = 0;
            end;
        end;


        //End of Disburesment to FOSA******************************************************



        //Post New

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;
        LoanApps."Issued Date" := Today;
        LoanApps."Loan Status" := LoanApps."loan status"::Issued;
        LoanApps.Posted := true;
        LoanApps.Modify;

        GenSetUp.Get();
        //Send Loan Disburesment SMS*********************************************
        if GenSetUp."Send Loan Disbursement SMS" = true then begin
            FnSendDisburesmentSMS(LoanApps."Loan  No.", LoanApps."Client Code");
        end;
        //Send Loan Disburesment Email*******************************************
        if GenSetUp."Send Loan Disbursement Email" = true then begin
            FnSendDisburesmentEmail(LoanApps."Loan  No.");
        end;
        Posted := true;
        Modify;

        Message('Batch posted successfully.');
    end;
}

