#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516616 "Loan Recovery Header"
{
    PageType = Card;
    SourceTable = "Loan Recovery Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                    Editable = MemberNoEditable;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Current Shares"; "Current Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Deposits';
                    Editable = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Total Outstanding Loans"; "Total Outstanding Loans")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Loan Disbursement Date"; "Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction Date';
                    Editable = true;
                }
                field("Loan to Attach"; "Loan to Attach")
                {
                    ApplicationArea = Basic;
                    Editable = LoantoAttachEditable;
                }
                field("Loan Liabilities"; "Loan Liabilities")
                {
                    ApplicationArea = Basic;
                    Caption = 'Outstanding Balance';
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Interest Repayment"; "Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest Repayment';
                    Editable = false;
                    Enabled = false;
                    HideValue = true;
                    Visible = false;
                }
                field("Principal Repayment"; "Principal Repayment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Principal Repayment';
                    Editable = false;
                    Enabled = false;
                    HideValue = true;
                    Visible = false;
                }
                field("Total Interest Due Recovered"; "Total Interest Due Recovered")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Total Thirdparty Loans"; "Total Thirdparty Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Trustee Loans';
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Mobile Loan"; "Mobile Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Deposits Aportioned"; "Deposits Aportioned")
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    StyleExpr = true;
                    ToolTip = '(Outstanding Balance/Total Loans Outstanding Balance)*(Deposits-(Total Accrued Interest+Thirdparty Loans+Mobile Loan))';
                }
                field("Loan Distributed to Guarantors"; "Loan Distributed to Guarantors")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Recovery Difference"; "Recovery Difference")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recovery Difference';
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field("Recovery Type"; "Recovery Type")
                {
                    ApplicationArea = Basic;
                    Editable = RecoveryTypeEditable;
                }
                field("Guarantor Allocation Type"; "Guarantor Allocation Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Liability Allocation Type';
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                    Visible = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Activity Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = Global1Editable;
                    OptionCaption = 'Activity';
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Created';
                    Editable = false;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loans Generated"; "Loans Generated")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Repayment Start Date"; "Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1000000009; "Loan Recovery Details")
            {
                Editable = GuarantorLoansDetailsEdit;
                Enabled = true;
                SubPageLink = "Document No" = field("Document No"),
                              "Member No" = field("Member No");
                Visible = true;
            }
        }
        area(factboxes)
        {
            part(Control3; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("Member No");
                Visible = true;
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // IF (Status=Status::Approved) OR (Status=Status::Pending) THEN
                        // ERROR(text001);
                        // TESTFIELD("Global Dimension 1 Code");
                        // IF ApprovalsMgmt.CheckGuarantorRecoveryApprovalsWorkflowEnabled(Rec) THEN
                        //  ApprovalsMgmt.OnSendGuarantorRecoveryForApproval(Rec);
                        Status := Status::Approved;
                        Modify;
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel A&pproval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        if (Status = Status::Open) or (Status = Status::Approved) then
                            Error(text001);

                        if ApprovalsMgmt.CheckGuarantorRecoveryApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnCancelGuarantorRecoveryApprovalRequest(Rec);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::GuarantorRecovery;

                        ApprovalEntries.Setfilters(Database::"Loan Recovery Header", DocumentType, "Document No");
                        ApprovalEntries.Run;
                    end;
                }
                action("Load Guarantors")
                {
                    ApplicationArea = Basic;
                    Image = CalculateLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        LoanDetails: Record "Loan Member Loans";
                        GCount: Integer;
                    begin

                        if ((Status = Status::Pending) or (Posted = true)) then
                            Error('You cannot Load guarantors for a document which is not approved');

                        if "Recovery Type" = "recovery type"::"Attach Defaulted Loans to Guarantors" then begin
                            LoanDetails.Reset;
                            LoanDetails.SetRange(LoanDetails."Loan No.", "Loan to Attach");
                            LoanDetails.SetRange(LoanDetails."Member No", "Member No");
                            if LoanDetails.Find('-') then
                                LoanDetails.DeleteAll;

                            LoanGuarantors.Reset;
                            LoanGuarantors.SetRange(LoanGuarantors."Loan No", "Loan to Attach");
                            LoanGuarantors.SetRange(LoanGuarantors.Substituted, false);
                            if LoanGuarantors.FindSet then begin
                                GCount := LoanGuarantors.Count;
                                repeat
                                    LoanDetails.Init;
                                    LoanGuarantors.CalcFields(LoanGuarantors."Outstanding Balance", LoanGuarantors."Oustanding Interest", LoanGuarantors."Total Loans Guaranteed");
                                    LoanDetails."Document No" := "Document No";
                                    LoanDetails."Member No" := "Member No";
                                    LoanDetails."Member Name" := LoanGuarantors.Name;
                                    LoanDetails."Loan Type" := 'TRUSTEE';
                                    if LoanType.Get(LoanDetails."Loan Type") then begin
                                        LoanDetails."Loan Instalments" := LoanType."No of Installment";
                                        LoanDetails."Interest Rate" := LoanType."Interest rate";
                                    end;
                                    if CustomerRecord.Get(LoanGuarantors."Member No") then begin
                                        CustomerRecord.CalcFields(CustomerRecord."Current Shares");
                                        LoanDetails."Guarantor Deposits" := CustomerRecord."Current Shares";
                                    end;
                                    LoanDetails."Approved Loan Amount" := ROUND(FnGetDefaultorLoanAmount("Loan Distributed to Guarantors", LoanGuarantors."Amont Guaranteed", LoanGuarantors."Total Loans Guaranteed", GCount), 0.1, '=');
                                    ;
                                    LoanDetails."Guarantor Number" := LoanGuarantors."Member No";
                                    LoanDetails."Loan No." := LoanGuarantors."Loan No";
                                    LoanDetails."Amont Guaranteed" := LoanGuarantors."Amont Guaranteed";
                                    LoanDetails."Outstanding Balance" := LoanGuarantors."Outstanding Balance";
                                    LoanDetails."Outstanding Interest" := FnGetInterestForLoanToAttach();
                                    LoanDetails."Defaulter Loan" := LoanGuarantors."Amont Guaranteed";
                                    ROUND(FnGetDefaultorLoanAmount("Loan Distributed to Guarantors", LoanGuarantors."Amont Guaranteed", LoanGuarantors."Total Loans Guaranteed", GCount), 0.1, '=');
                                    LoanDetails.Insert;
                                until LoanGuarantors.Next = 0;
                            end;
                        end else
                            Error('Please ensure you select the correct recovery mode');
                    end;
                }
                action("Post Transaction")
                {
                    ApplicationArea = Basic;
                    Enabled = EnableCreateMember;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        LineNo: Integer;
                        TotalLoanRecovered: Decimal;
                    begin
                        if ((Status = Status::Open) or (Status = Status::Pending) or (Posted = true)) then
                            Error('You cannot post a document which is not approved');
                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'RECOVERIES';
                        DOCUMENT_NO := "Document No";
                        EXTERNAL_DOC_NO := "Loan to Attach";
                        Datefilter := '..' + Format("Loan Disbursement Date");

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;

                        if "Recovery Type" = "recovery type"::"Attach Defaulted Loans to Guarantors" then begin
                            LineNo := 0;
                            FnRunInterest("Total Interest Due Recovered");
                            FnRunPrincipleThirdparty("Total Thirdparty Loans");
                            FnRecoverMobileLoanPrincipal("Mobile Loan");
                            FnRunPrinciple("Deposits Aportioned");
                            FnGenerateDefaulterLoans();
                            FnRunFromGuarantorDeposits();
                        end;

                        if "Recovery Type" = "recovery type"::"Recover From Loanee Deposits" then begin
                            LineNo := 0;
                            //MESSAGE ('loan is %1',"Loan to Attach");
                            RunBal := FnRunInterest("Current Shares");
                            FnRunRecoverFromLoaneesDeposits(RunBal);
                        end;

                        // // Post New
                        // //   GenJournalLine.RESET;
                        // //   GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                        // //   GenJournalLine.SETRANGE("Journal Batch Name",'RECOVERIES');
                        // //   IF GenJournalLine.FIND('-') THEN BEGIN
                        // //   CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch",GenJournalLine);
                        // //   END;
                        // //
                        // //   ObjGuarantorRec.RESET;
                        // //   ObjGuarantorRec.SETRANGE("Loan No","Loan No");
                        // //   IF ObjGuarantorRec.FIND('-') THEN BEGIN
                        // //    "Loans Generated":=Posted;
                        // //     Posted:=TRUE;
                        // //     "Loans Generated":=Posted;
                        // //     "Posting Date":=TODAY;
                        // //     MODIFY;
                        // //   END;
                        Message('Recovery posted sucessfully!');
                        CurrPage.Close;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls();
        UpdateControls();
        EnableCreateMember := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (Rec.Status = Status::Approved) then
            EnableCreateMember := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Created By" := UserId;
        "Application Date" := Today;
    end;

    trigger OnOpenPage()
    begin
        //UpdateControls();
    end;

    var
        PayOffDetails: Record "Loans PayOff Details";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        LoanType: Record "Loan Products Setup";
        LoansRec: Record "Loans Register";
        TotalRecovered: Decimal;
        TotalInsuarance: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        GLoanDetails: Record "Loan Member Loans";
        TotalOustanding: Decimal;
        ClosingDepositBalance: Decimal;
        RemainingAmount: Decimal;
        AMOUNTTOBERECOVERED: Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        PDate: Date;
        Interest: Decimal;
        TextDateFormula2: Text[30];
        TextDateFormula1: Text[30];
        DateFormula2: DateFormula;
        DateFormula1: DateFormula;
        Lbal: Decimal;
        GenLedgerSetup: Record "General Ledger Setup";
        Hesabu: Integer;
        "Loan&int": Decimal;
        TotDed: Decimal;
        Available: Decimal;
        Distributed: Decimal;
        WINDOW: Dialog;
        PostingCode: Codeunit "Gen. Jnl.-Post Line";
        SHARES: Decimal;
        TOTALLOANS: Decimal;
        LineN: Integer;
        instlnclr: Decimal;
        appotbal: Decimal;
        PRODATA: Decimal;
        LOANAMOUNT2: Decimal;
        TOTALLOANSB: Decimal;
        NETSHARES: Decimal;
        Tinst: Decimal;
        Finst: Decimal;
        Floans: Decimal;
        GrAmount: Decimal;
        TGrAmount: Decimal;
        FGrAmount: Decimal;
        LOANBAL: Decimal;
        Serie: Integer;
        DLN: Code[10];
        "LN Doc": Code[20];
        INTBAL: Decimal;
        COMM: Decimal;
        loanTypes: Record "Loan Products Setup";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication;
        MemberNoEditable: Boolean;
        RecoveryTypeEditable: Boolean;
        Global1Editable: Boolean;
        Global2Editable: Boolean;
        LoantoAttachEditable: Boolean;
        GuarantorLoansDetailsEdit: Boolean;
        TotalRecoverable: Decimal;
        LoanGuarantors: Record "Loans Guarantee Details";
        AmounttoRecover: Decimal;
        BaltoRecover: Decimal;
        InstRecoveredAmount: Decimal;
        X: Decimal;
        ObjGuarantorML: Record "Loan Member Loans";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        RunBal: Decimal;
        TotalSharesUsed: Decimal;
        i: Integer;
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        LoanGuar: Record "Loans Guarantee Details";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
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
        CustomerRecord: Record "Member Register";
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record "Member Register";
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record "Member Register";
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sacco General Set-Up";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        LoansR: Record "Loans Register";
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
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        TotalTopupComm: Decimal;
        CustE: Record "Member Register";
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Guarantee Details";
        SpecialComm: Decimal;
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BridgedLoans: Record "Loan Special Clearance";
        SMSMessage: Record "SMS Messages";
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        Disbursement: Record "Loan Disburesment-Batching";
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loans Register";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loans Guarantee Details";
        CurrpageEditable: Boolean;
        LoanStatusEditable: Boolean;
        MNoEditable: Boolean;
        ApplcDateEditable: Boolean;
        LProdTypeEditable: Boolean;
        InstallmentEditable: Boolean;
        AppliedAmountEditable: Boolean;
        ApprovedAmountEditable: Boolean;
        RepayMethodEditable: Boolean;
        RepaymentEditable: Boolean;
        BatchNoEditable: Boolean;
        RepayFrequencyEditable: Boolean;
        ModeofDisburesmentEdit: Boolean;
        DisbursementDateEditable: Boolean;
        AccountNoEditable: Boolean;
        LNBalance: Decimal;
        ApprovalEntries: Record "Approval Entry";
        RejectionRemarkEditable: Boolean;
        ApprovalEntry: Record "Approval Entry";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening","Member Closure",Loan;
        GrossPay: Decimal;
        Nettakehome: Decimal;
        TotalDeductions: Decimal;
        UtilizableAmount: Decimal;
        NetUtilizable: Decimal;
        Deductions: Decimal;
        Benov: Decimal;
        TAXABLEPAY: Record "PAYE Brackets Credit";
        PAYE: Decimal;
        PAYESUM: Decimal;
        BAND1: Decimal;
        BAND2: Decimal;
        BAND3: Decimal;
        BAND4: Decimal;
        BAND5: Decimal;
        Taxrelief: Decimal;
        OTrelief: Decimal;
        Chargeable: Decimal;
        PartPay: Record "Loan Partial Disburesments";
        PartPayTotal: Decimal;
        AmountPayable: Decimal;
        RepaySched: Record "Loan Repayment Schedule";
        LoanReferee1NameEditable: Boolean;
        LoanReferee2NameEditable: Boolean;
        LoanReferee1MobileEditable: Boolean;
        LoanReferee2MobileEditable: Boolean;
        LoanReferee1AddressEditable: Boolean;
        LoanReferee2AddressEditable: Boolean;
        LoanReferee1PhyAddressEditable: Boolean;
        LoanReferee2PhyAddressEditable: Boolean;
        LoanReferee1RelationEditable: Boolean;
        LoanReferee2RelationEditable: Boolean;
        LoanPurposeEditable: Boolean;
        WitnessEditable: Boolean;
        compinfo: Record "Company Information";
        LoanRepa: Record "Loan Repayment Schedule";
        ObjGuarantorRec: Record "Loan Recovery Header";
        Text0001: label 'Please consider recovering from the Loanee Shares Before Attaching to Guarantors';
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        EXTERNAL_DOC_NO: Code[40];
        SFactory: Codeunit "SURESTEP Factory.";
        DLoan: Code[20];
        Datefilter: Text;
        LoanDetails: Record "Loan Member Loans";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        RecoveryTransType: Option Normal,"Guarantor Recoverd","Guarantor Paid";
        ObjLoansRec: Record "Loans Register";
        ObjNoSeries: Record "No. Series Line";
        ObjSaccoNoSeries: Record "Sacco No. Series";
        LastNoUsed: Code[20];
        ObjLoanType: Record "Loan Products Setup";
        VarAmounttoDeduct: Decimal;
        ObjCust: Record "Member Register";
        ObjLoanGuarantors: Record "Loan Member Loans";
        VarTotalGuarantorAmount: Decimal;
        VarGuarantorCount: Integer;
        VarTotalApprotionLess: Decimal;
        VarTotalApprotionGreater: Decimal;
        VarTotalApprotionLessCount: Decimal;


    procedure UpdateControls()
    begin

        if Status = Status::Open then begin
            MemberNoEditable := true;
            RecoveryTypeEditable := true;
            LoantoAttachEditable := true;
            Global1Editable := true;
            Global2Editable := true;
            GuarantorLoansDetailsEdit := true;
        end;
        if Status = Status::Pending then begin
            MemberNoEditable := false;
            RecoveryTypeEditable := false;
            LoantoAttachEditable := false;
            Global1Editable := false;
            Global2Editable := false;
            GuarantorLoansDetailsEdit := true;
        end;
        if Status = Status::Approved then begin
            MemberNoEditable := false;
            RecoveryTypeEditable := false;
            LoantoAttachEditable := false;
            Global1Editable := false;
            Global2Editable := false;
            GuarantorLoansDetailsEdit := true;
        end
    end;

    local procedure FnGetDefaultorLoanAmount(OutstandingBalance: Decimal; GuaranteedAmount: Decimal; TotalGuaranteedAmount: Decimal; GuarantorCount: Integer): Decimal
    begin
        exit(ROUND(GuaranteedAmount / TotalGuaranteedAmount * ("Loan Distributed to Guarantors"), 0.01, '='));
    end;


    procedure FnPostRepaymentJournal(TDefaulterLoan: Decimal)
    var
        ObjLoanDetails: Record "Loan Member Loans";
    begin
        if LoansRec.Get("Loan to Attach") then begin
            LineNo := LineNo + 10000;

            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
            GenJournalLine."account type"::Investor, LoansRec."Client Code", "Loan Disbursement Date", TDefaulterLoan * -1, Format(LoanApps.Source), EXTERNAL_DOC_NO,
            'Defaulted Loan Recovered-' + "Loan to Attach", "Loan to Attach");//Maximum No of Parameters(13) Exceeded

        end;
    end;

    local procedure FnGetInterestForLoanToAttach(): Decimal
    var
        ObjLoansRegisterLocal: Record "Loans Register";
    begin
        ObjLoansRegisterLocal.Reset;
        ObjLoansRegisterLocal.SetRange(ObjLoansRegisterLocal."Loan  No.", "Loan to Attach");
        if ObjLoansRegisterLocal.Find('-') then begin
            ObjLoansRegisterLocal.CalcFields(ObjLoansRegisterLocal."Oustanding Interest");
            exit(ObjLoansRegisterLocal."Oustanding Interest");
        end;
    end;

    local procedure FnRunInterest(RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        VarInterestDeducted: Decimal;
    begin
        //RunningBalance:="Total Interest Due Recovered";
        if RunningBalance > 0 then begin
            VarInterestDeducted := 0;
            LoanApp.Reset;
            //LoanApp.SETCURRENTKEY(Source,"Issued Date","Loan Product Type","Client Code","Staff No","Employer Code");
            //LoanApp.SETRANGE("BOSA No","Member No");
            LoanApp.SetRange(LoanApp."Loan  No.", "Loan to Attach");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                // MESSAGE ('loan is int %1',RunningBalance);

                repeat
                    //            LoanApp.CALCFIELDS(LoanApp."Oustanding Interest");
                    //            AmountToDeduct:=0;
                    //            IF LoanApp."Oustanding Interest">0 THEN BEGIN
                    //            IF (LoanApp."Oustanding Interest")<RunningBalance THEN BEGIN
                    //            AmountToDeduct:=LoanApp."Oustanding Interest";
                    //            END ELSE
                    //            AmountToDeduct:=RunningBalance;
                    AmountToDeduct := "Total Interest Due Recovered";
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                    GenJournalLine."account type"::Member, LoanApp."Client Code", "Loan Disbursement Date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                    Format(GenJournalLine."transaction type"::"Interest Paid") + '-Recovered from Deposits', LoanApp."Loan  No.");
                    RunningBalance := RunningBalance - AmountToDeduct;
                    VarInterestDeducted := VarInterestDeducted + AmountToDeduct;
                //END;
                until LoanApp.Next = 0;
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::Member, "Member No", "Loan Disbursement Date", VarInterestDeducted, 'BOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoanApp."Employer Name", '');
            end;
        end;
        exit(RunningBalance);
    end;

    local procedure FnRunPrinciple(RunningBalance: Decimal)
    var
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
    begin
        begin
            if LoansRec.Get("Loan to Attach") then begin
                //---------------------PAY-------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                GenJournalLine."account type"::Investor, LoansRec."Client Code", "Loan Disbursement Date", "Deposits Aportioned" * -1, Format(LoansRec.Source), EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Loan Repayment"), "Loan to Attach");
                //--------------------RECOVER-----------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::Investor, "Member No", "Loan Disbursement Date", "Deposits Aportioned", Format(LoansRec.Source), EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoansRec."Loan Product Type", '');
            end;
        end;
    end;

    local procedure FnLoansGenerated()
    begin
    end;

    local procedure FnDefaulterLoansDisbursement(ObjLoanDetails: Record "Loan Member Loans"; LineNo: Integer): Code[40]
    var
        GenJournalLine: Record "Gen. Journal Line";
        CUNoSeriesManagement: Codeunit NoSeriesManagement;
        DocNumber: Code[100];
        loanTypes: Record "Loan Products Setup";
        ObjLoanX: Record "Loans Register";
        ObjSaccoNoSeries: Record "Sacco No. Series";
    begin
        loanTypes.Reset;
        loanTypes.SetRange(loanTypes.Code, 'TRUSTEE');
        if loanTypes.Find('-') then begin
            ObjSaccoNoSeries.Get();

            DocNumber := CUNoSeriesManagement.GetNextNo(ObjSaccoNoSeries."BOSA Loans Nos", 0D, true);
            LoansRec.Init;
            LoansRec."Loan  No." := DocNumber;
            LoansRec.Insert;

            if LoansRec.Get(LoansRec."Loan  No.") then begin
                if LoansRec."Client Code" <> ObjLoanDetails."Guarantor Number" then begin
                    LoansRec."Client Code" := ObjLoanDetails."Guarantor Number";
                    LoansRec.Validate(LoansRec."Client Code");
                    LoansRec."Loan Product Type" := 'TRUSTEE';
                    LoansRec.Validate(LoansRec."Loan Product Type");
                    LoansRec.Interest := ObjLoanDetails."Interest Rate";
                    LoansRec."Loan Status" := LoansRec."loan status"::Issued;
                    LoansRec."Application Date" := "Loan Disbursement Date";
                    LoansRec."Issued Date" := "Loan Disbursement Date";
                    LoansRec."Loan Disbursement Date" := "Loan Disbursement Date";
                    //      LoansRec."Original Loan":=ObjLoanDetails."Loan No.";
                    LoansRec."Expected Date of Completion" := "Expected Date of Completion";
                    LoansRec.Validate(LoansRec."Loan Disbursement Date");
                    LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"Bank Transfer";
                    LoansRec."Repayment Start Date" := "Repayment Start Date";
                    LoansRec."Global Dimension 1 Code" := Format(LoanApps.Source);
                    LoansRec."Global Dimension 2 Code" := SFactory.FnGetUserBranch();
                    LoansRec.Source := LoansRec.Source::BOSA;
                    LoansRec."Approval Status" := LoansRec."approval status"::Approved;
                    //LoansRec.Repayment:=ObjLoanDetails."Approved Loan Amount";
                    LoansRec."Requested Amount" := ObjLoanDetails."Defaulter Loan";
                    LoansRec."Approved Amount" := ObjLoanDetails."Defaulter Loan";
                    LoansRec.Posted := true;
                    LoansRec."Advice Date" := Today;
                    LoansRec.Modify;
                    //*******Cater For Finding Repayment *******//
                    LoansRec.Validate(LoansRec."Approved Amount");
                    LoansRec.Modify;
                    //*******end Cater For Finding Repayment *******//
                end;
            end;
        end;
        exit(DocNumber);
    end;

    local procedure FnGenerateRepaymentSchedule(LoanNumber: Code[50])
    begin
        LoansR.Reset;
        LoansR.SetRange(LoansR."Loan  No.", LoansRec."Loan  No.");
        LoansR.SetFilter(LoansR."Approved Amount", '>%1', 0);
        LoansR.SetFilter(LoansR.Posted, '=%1', true);
        if LoansR.Find('-') then begin
            if ((LoansR."Loan Product Type" = 'TRUSTEE') and (LoansR."Issued Date" <> 0D) and (LoansR."Repayment Start Date" <> 0D)) then begin
                LoansRec.TestField(LoansRec."Loan Disbursement Date");
                LoansRec.TestField(LoansRec."Repayment Start Date");

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", LoansR."Loan  No.");
                RSchedule.DeleteAll;

                LoanAmount := LoansR."Approved Amount";
                InterestRate := LoansR.Interest;
                RepayPeriod := LoansR.Installments;
                InitialInstal := LoansR.Installments + LoansRec."Grace Period - Principle (M)";
                LBalance := LoansR."Approved Amount";
                RunDate := "Repayment Start Date";
                InstalNo := 0;

                //Repayment Frequency
                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                    RunDate := CalcDate('-1D', RunDate)
                else
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                        RunDate := CalcDate('-1W', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                            RunDate := CalcDate('-1M', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                RunDate := CalcDate('-1Q', RunDate);
                //Repayment Frequency


                repeat
                    InstalNo := InstalNo + 1;
                    //Repayment Frequency
                    if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else
                        if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else
                            if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Monthly then
                                RunDate := CalcDate('1M', RunDate)
                            else
                                if LoansRec."Repayment Frequency" = LoansRec."repayment frequency"::Quaterly then
                                    RunDate := CalcDate('1Q', RunDate);

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Amortised then begin
                        //LoansRec.TESTFIELD(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Straight Line" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LoanAmount / RepayPeriod;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::"Reducing Balance" then begin
                        LoansRec.TestField(LoansRec.Interest);
                        LoansRec.TestField(LoansRec.Installments);
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 12 / 100) * LBalance;
                    end;

                    if LoansRec."Repayment Method" = LoansRec."repayment method"::Constants then begin
                        LoansRec.TestField(LoansRec.Repayment);
                        if LBalance < LoansRec.Repayment then
                            LPrincipal := LBalance
                        else
                            LPrincipal := LoansRec.Repayment;
                        LInterest := LoansRec.Interest;
                    end;

                    //Grace Period
                    if GrPrinciple > 0 then begin
                        LPrincipal := 0
                    end else begin
                        LBalance := LBalance - LPrincipal;

                    end;

                    if GrInterest > 0 then
                        LInterest := 0;

                    GrPrinciple := GrPrinciple - 1;
                    GrInterest := GrInterest - 1;
                    Evaluate(RepayCode, Format(InstalNo));


                    RSchedule.Init;
                    RSchedule."Repayment Code" := RepayCode;
                    RSchedule."Interest Rate" := InterestRate;
                    RSchedule."Loan No." := LoansRec."Loan  No.";
                    RSchedule."Loan Amount" := LoanAmount;
                    RSchedule."Instalment No" := InstalNo;
                    RSchedule."Repayment Date" := RunDate;
                    RSchedule."Member No." := LoansRec."Client Code";
                    RSchedule."Loan Category" := LoansRec."Loan Product Type";
                    RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                    RSchedule."Monthly Interest" := LInterest;
                    RSchedule."Principal Repayment" := LPrincipal;
                    RSchedule.Insert;
                    WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                until LBalance < 1

            end;
        end;

        Commit;
    end;

    local procedure FnRecoverMobileLoanPrincipal(RunningBalance: Decimal)
    var
        AmountToDeduct: Decimal;
        varLRepayment: Decimal;
    begin
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."BOSA No", "Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter("Loan Product Type", 'SUKUMA');
            LoanApp.SetFilter(Posted, 'Yes');
            if LoanApp.Find('-') then begin
                //---------------------PAY-------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                GenJournalLine."account type"::Investor, LoanApp."Client Code", "Loan Disbursement Date", "Mobile Loan" * -1, 'BOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");
                //--------------------RECOVER-----------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::Investor, "Member No", "Loan Disbursement Date", "Mobile Loan", 'BOSA', EXTERNAL_DOC_NO,
                 'Loan Recovery from-' + Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoansRec."Loan  No.", LoanApp."Loan  No.");
            end;
        end;
    end;

    local procedure FnRunPrincipleThirdparty(RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ReceiptLine: Record "Checkoff Lines-Distributed";
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", "Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'TRUSTEE');
            if LoanApp.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then begin
                            varLRepayment := 0;
                            PRpayment := 0;
                            varLRepayment := LoanApp."Outstanding Balance";
                            if varLRepayment > 0 then begin
                                if RunningBalance > 0 then begin
                                    if RunningBalance > varLRepayment then begin
                                        AmountToDeduct := varLRepayment;
                                    end
                                    else
                                        AmountToDeduct := RunningBalance;
                                end;
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                GenJournalLine."account type"::Investor, LoanApp."Client Code", "Loan Disbursement Date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                                Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");
                                RunningBalance := RunningBalance - AmountToDeduct;
                            end;
                        end;
                    end;

                until LoanApp.Next = 0;
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::Investor, "Member No", "Loan Disbursement Date", "Total Thirdparty Loans", 'BOSA', EXTERNAL_DOC_NO,
                Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoanApp."Loan Product Type", '');
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnGenerateDefaulterLoans()
    var
        DLoanAmount: Decimal;
        phone: Code[20];
    begin
        if CustomerRecord.Get("Member No") then begin
            phone := CustomerRecord."Phone No.";
        end;

        LoanDetails.Reset;
        LoanDetails.SetRange(LoanDetails."Document No", "Document No");
        LoanDetails.SetRange(LoanDetails."Loan No.", "Loan to Attach");
        LoanDetails.SetRange(LoanDetails."Member No", "Member No");
        if LoanDetails.FindSet then begin
            repeat
                LineNo := LineNo + 10000;
                DLoan := FnDefaulterLoansDisbursement(LoanDetails, LineNo);
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
                GenJournalLine."account type"::Investor, LoanDetails."Guarantor Number", "Loan Disbursement Date", LoanDetails."Defaulter Loan", Format(LoansRec.Source::BOSA), "Loan to Attach",
                'Defaulter Recovery-' + "Loan to Attach", DLoan);//DLoan
                DLoanAmount := DLoanAmount + LoanDetails."Defaulter Loan";

                if LoansRec.Get("Loan to Attach") then begin
                    LineNo := LineNo + 10000;
                    /*SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Repayment",
                    GenJournalLine."Account Type"::Member,LoansRec."Client Code","Loan Disbursement Date",DLoanAmount*-1,FORMAT(LoanApps.Source),EXTERNAL_DOC_NO,
                    'Defaulted Loan Recovered-'+LoansRec."Loan Product Type","Loan to Attach");*///Maximum no of Parameters Exceeded

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := BATCH_TEMPLATE;
                    GenJournalLine."Journal Batch Name" := BATCH_NAME;
                    GenJournalLine."Document No." := DOCUMENT_NO;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Investor;
                    GenJournalLine."Account No." := LoansRec."Client Code";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
                    GenJournalLine."Loan No" := "Loan to Attach";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date" := "Loan Disbursement Date";
                    GenJournalLine.Description := 'Trustee Loan-' + LoanDetails."Guarantor Number";
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount := LoanDetails."Defaulter Loan" * -1;
                    GenJournalLine."External Document No." := "Loan to Attach";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Recovery Transaction Type" := GenJournalLine."recovery transaction type"::"Guarantor Recoverd";
                    GenJournalLine."Recoverd Loan" := "Loan to Attach";
                    GenJournalLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                    GenJournalLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                end;
                SFactory.FnSendSMS('GUARANTOR', 'Dear ' + LoanDetails."Member Name" + ' Ksh ' + Format(LoanDetails."Amount from Deposits") +
                 'has been offset from your deposits to pay ' + "Member Name" + ' loan', "Member No", phone);
            until LoanDetails.Next = 0;
        end;

    end;

    local procedure FnCalculateTotalInterestDue(Loans: Record "Loans Register") InterestDue: Decimal
    var
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        "Loan Age": Integer;
    begin
        ObjRepaymentSchedule.Reset;
        ObjRepaymentSchedule.SetRange("Loan No.", Loans."Loan  No.");
        ObjRepaymentSchedule.SetFilter("Repayment Date", '<=%1', "Loan Disbursement Date");
        if ObjRepaymentSchedule.Find('-') then
            "Loan Age" := ObjRepaymentSchedule.Count;
        Loans.CalcFields("Outstanding Balance", "Interest Paid");

        InterestDue := ((0.01 * Loans."Approved Amount" + 0.01 * Loans."Outstanding Balance") * Loans.Interest / 12 * ("Loan Age")) / 2 - Abs(Loans."Interest Paid");
        if (Date2dmy("Loan Disbursement Date", 1) > 15) then begin
            InterestDue := ((0.01 * Loans."Approved Amount" + 0.01 * Loans."Outstanding Balance") * Loans.Interest / 12 * ("Loan Age" + 1)) / 2 - Abs(Loans."Interest Paid");
        end;
        if InterestDue <= 0 then
            exit(0);
        //MESSAGE('Approved=%1 Loan Age=%2 OBalance=%3 InterestPaid=%4 InterestDue=%5',Loans."Approved Amount","Loan Age",Loans."Outstanding Balance",Loans."Interest Paid",InterestDue);
        exit(InterestDue);
    end;

    local procedure FnRunRecoverFromLoaneesDeposits(RunningBalance: Decimal)
    var
        AmountToDeduct: Decimal;
        SharesBalance: Decimal;
    begin
        SharesBalance := RunningBalance;
        if RunningBalance > 0 then begin
            LoanApp.Reset;
            //LoanApp.SETCURRENTKEY(Source,"Issued Date","Loan Product Type","Client Code","Staff No","Employer Code");
            LoanApp.SetRange(LoanApp."Loan  No.", "Loan to Attach");
            LoanApp.SetRange("BOSA No", "Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    // MESSAGE ('loan is rep %1',RunningBalance);

                    LoanApp.CalcFields(LoanApp."Outstanding Balance");
                    if RunningBalance > 0 then begin
                        AmountToDeduct := 0;
                        if LoanApp."Outstanding Balance" > 0 then begin
                            if RunningBalance > LoanApp."Outstanding Balance" then begin
                                ///  IF (LoanApp."Outstanding Balance"*SharesBalance/"Total Outstanding Loans")<RunningBalance THEN BEGIN
                                AmountToDeduct := LoanApp."Outstanding Balance"//*SharesBalance/"Total Outstanding Loans"
                            end else
                                AmountToDeduct := RunningBalance;
                            LineNo := LineNo + 10000;

                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                            GenJournalLine."account type"::Member, LoanApp."Client Code", "Loan Disbursement Date", AmountToDeduct * -1, Format(LoanApp.Source), EXTERNAL_DOC_NO,
                            'Repayment Recovered From Deposits', LoanApp."Loan  No.");
                            RunningBalance := RunningBalance - AmountToDeduct;
                            VarAmounttoDeduct := VarAmounttoDeduct + AmountToDeduct;
                        end;
                    end;
                until LoanApp.Next = 0;
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::Member, "Member No", "Loan Disbursement Date", VarAmounttoDeduct, 'BOSA', EXTERNAL_DOC_NO,
                'Repayment Recovered From Deposits' + '-' + LoanApp."Employer Name", '');
            end;
        end;
    end;

    local procedure FnRunRecoverFromGuarantorsDeposits(VarDocumentNo: Code[20]; VarLoanNo: Code[20]; VarMemberNo: Code[20]; VarPostingDate: Date)
    begin
        ObjLoanGuarantors.Reset;
        ObjLoanGuarantors.SetRange("Document No", VarDocumentNo);
        if ObjLoanGuarantors.FindSet then begin
            repeat
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                GenJournalLine."account type"::Investor, ObjLoanGuarantors."Guarantor Number", VarPostingDate, ObjLoanGuarantors."Guarantor Amount Apportioned", 'BOSA', EXTERNAL_DOC_NO,
                'Defaulted Loan Recovered' + '-' + VarMemberNo + '-' + VarLoanNo, '');

                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLineGuarantorRecovery(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                GenJournalLine."account type"::Investor, VarMemberNo, VarPostingDate, ObjLoanGuarantors."Guarantor Amount Apportioned" * -1, 'BOSA', EXTERNAL_DOC_NO,
                'Repayment Recovered From Guarantor Deposits_' + ObjLoanGuarantors."Guarantor Number", VarLoanNo, GenJournalLine."recovery transaction type"::"Guarantor Recoverd", VarLoanNo);
            until ObjLoanGuarantors.Next = 0;
        end;
    end;

    local procedure FnTransferShareCapitalToDeposits()
    begin
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
        GenJournalLine."account type"::Investor, "Member No", "Loan Disbursement Date", "Net Share Capital" * -1, 'BOSA', EXTERNAL_DOC_NO,
        'Defaulted Loan Recovered-From SC', '');

        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Share Capital",
        GenJournalLine."account type"::Investor, "Member No", "Loan Disbursement Date", "Net Share Capital", 'BOSA', EXTERNAL_DOC_NO,
        'Defaulted Loan Recovered-TO Deposits', '');
    end;

    local procedure FnRunFromGuarantorDeposits()
    var
        MemberRegister: Record "Member Register";
    begin
        if LoansRec.Get("Loan to Attach") then begin
            //---------------------PAY-------------------------------

            LoanDetails.Reset;
            LoanDetails.SetRange(LoanDetails."Document No", "Document No");
            LoanDetails.SetRange(LoanDetails."Loan No.", "Loan to Attach");
            LoanDetails.SetRange(LoanDetails."Member No", "Member No");
            if LoanDetails.FindSet then begin
                repeat
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                    GenJournalLine."account type"::Investor, LoanDetails."Member No", "Loan Disbursement Date", LoanDetails."Amount from Deposits" * -1, Format(LoansRec.Source), EXTERNAL_DOC_NO,
                    'Guarantor ' + LoanDetails."Guarantor Number", "Loan to Attach");
                    //--------------------RECOVER-----------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                    GenJournalLine."account type"::Investor, LoanDetails."Guarantor Number", "Loan Disbursement Date", LoanDetails."Amount from Deposits", Format(LoansRec.Source), EXTERNAL_DOC_NO,
                    'Loan Recovery from-' + Format(GenJournalLine."transaction type"::"Deposit Contribution") + '-' + LoansRec."Loan  No.", '');
                until LoanDetails.Next = 0;
            end;
        end;
    end;
}

