#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516458 "Loan Application FOSA(New)"
{
    ApplicationArea = Basic;
    CardPageID = "Loan Application Card(FOSA)";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where(Posted = filter(false),
                            Source = const(FOSA),
                            "Approval Status" = filter(Open),
                            Discard = filter(true));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Loan  No."; "Loan  No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Client Code"; "Client Code")
                {
                    ApplicationArea = Basic;
                }
                field("Client Name"; "Client Name")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount"; "Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount"; "Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field("ID NO"; "ID NO")
                {
                    ApplicationArea = Basic;
                }
                field("Staff No"; "Staff No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No';
                }
                field(Source; Source)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status"; "Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Loan)
            {
                Caption = 'Loan';
                Image = AnalysisView;
                action("Mark As Posted")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mark As Posted';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Posted := true;
                        Modify;
                    end;
                }
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Image = GanttChart;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        TestField("Mode of Disbursement");

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(51516493, true, false, LoanApp)
                        end;
                    end;
                }
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    Image = "table";
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        //IF Posted=TRUE THEN
                        //ERROR('Loan has been posted, Can only preview schedule');

                        if "Repayment Frequency" = "repayment frequency"::Daily then
                            Evaluate(InPeriod, '1D')
                        else
                            if "Repayment Frequency" = "repayment frequency"::Weekly then
                                Evaluate(InPeriod, '1W')
                            else
                                if "Repayment Frequency" = "repayment frequency"::Monthly then
                                    Evaluate(InPeriod, '1M')
                                else
                                    if "Repayment Frequency" = "repayment frequency"::Quaterly then
                                        Evaluate(InPeriod, '1Q');


                        QCounter := 0;
                        QCounter := 3;
                        //EVALUATE(InPeriod,'1D');
                        GrPrinciple := "Grace Period - Principle (M)";
                        GrInterest := "Grace Period - Interest (M)";
                        InitialGraceInt := "Grace Period - Interest (M)";

                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Loan  No.", "Loan  No.");
                        if LoansR.Find('-') then begin

                            TestField("Loan Disbursement Date");
                            TestField("Repayment Start Date");

                            RSchedule.Reset;
                            RSchedule.SetRange(RSchedule."Loan No.", "Loan  No.");
                            RSchedule.DeleteAll;

                            LoanAmount := LoansR."Approved Amount";
                            InterestRate := LoansR.Interest;
                            RepayPeriod := LoansR.Installments;
                            InitialInstal := LoansR.Installments + "Grace Period - Principle (M)";
                            LBalance := LoansR."Approved Amount";
                            RunDate := "Repayment Start Date";//"Loan Disbursement Date";
                                                              //RunDate:=CALCDATE('-1W',RunDate);
                            InstalNo := 0;
                            //EVALUATE(RepayInterval,'1W');
                            //EVALUATE(RepayInterval,InPeriod);

                            //Repayment Frequency
                            if "Repayment Frequency" = "repayment frequency"::Daily then
                                RunDate := CalcDate('-1D', RunDate)
                            else
                                if "Repayment Frequency" = "repayment frequency"::Weekly then
                                    RunDate := CalcDate('-1W', RunDate)
                                else
                                    if "Repayment Frequency" = "repayment frequency"::Monthly then
                                        RunDate := CalcDate('-1M', RunDate)
                                    else
                                        if "Repayment Frequency" = "repayment frequency"::Quaterly then
                                            RunDate := CalcDate('-1Q', RunDate);
                            //Repayment Frequency


                            repeat
                                InstalNo := InstalNo + 1;
                                //RunDate:=CALCDATE("Instalment Period",RunDate);
                                //RunDate:=CALCDATE('1W',RunDate);


                                //Repayment Frequency
                                if "Repayment Frequency" = "repayment frequency"::Daily then
                                    RunDate := CalcDate('1D', RunDate)
                                else
                                    if "Repayment Frequency" = "repayment frequency"::Weekly then
                                        RunDate := CalcDate('1W', RunDate)
                                    else
                                        if "Repayment Frequency" = "repayment frequency"::Monthly then
                                            RunDate := CalcDate('1M', RunDate)
                                        else
                                            if "Repayment Frequency" = "repayment frequency"::Quaterly then
                                                RunDate := CalcDate('1Q', RunDate);
                                //Repayment Frequency

                                //kma
                                if "Repayment Method" = "repayment method"::Amortised then begin
                                    TestField(Interest);
                                    TestField(Installments);
                                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.05, '>');
                                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.05, '>');
                                    LPrincipal := TotalMRepay - LInterest;
                                end;

                                if "Repayment Method" = "repayment method"::"Straight Line" then begin
                                    TestField(Interest);
                                    TestField(Installments);
                                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                                    LInterest := ROUND((InterestRate / 12 / 100) * LoanAmount, 0.05, '>');
                                    //Grace Period Interest
                                    LInterest := ROUND((LInterest * InitialInstal) / (InitialInstal - InitialGraceInt), 0.05, '>');
                                end;

                                if "Repayment Method" = "repayment method"::"Reducing Balance" then begin
                                    TestField(Interest);
                                    TestField(Installments);
                                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 0.05, '>');
                                end;

                                if "Repayment Method" = "repayment method"::Constants then begin
                                    TestField(Repayment);
                                    if LBalance < Repayment then
                                        LPrincipal := LBalance
                                    else
                                        LPrincipal := Repayment;
                                    LInterest := Interest;
                                end;
                                //kma



                                //Grace Period
                                if GrPrinciple > 0 then begin
                                    LPrincipal := 0
                                end else begin
                                    //IF "Instalment Period" <> InPeriod THEN
                                    LBalance := LBalance - LPrincipal;

                                end;

                                if GrInterest > 0 then
                                    LInterest := 0;

                                GrPrinciple := GrPrinciple - 1;
                                GrInterest := GrInterest - 1;
                                //Grace Period
                                /*
                               //Q Principle
                               IF "Instalment Period" = InPeriod THEN BEGIN
                               //ADDED
                               IF GrPrinciple <> 0 THEN
                               GrPrinciple:=GrPrinciple-1;
                               IF QCounter = 1 THEN BEGIN
                               QCounter:=3;
                               LPrincipal:=QPrinciple+LPrincipal;
                               IF LPrincipal > LBalance THEN
                               LPrincipal:=LBalance;
                               LBalance:=LBalance-LPrincipal;
                               QPrinciple:=0;
                               END ELSE BEGIN
                               QCounter:=QCounter - 1;
                               QPrinciple:=QPrinciple+LPrincipal;
                               //IF QPrinciple > LBalance THEN
                               //QPrinciple:=LBalance;
                               LPrincipal:=0;
                               END

                               END;
                               //Q Principle
                                */

                                Evaluate(RepayCode, Format(InstalNo));
                                /*
                               WhichDay:=DATE2DWY(RunDate,1);
                               IF WhichDay=6 THEN
                                RunDate:=RunDate+2
                               ELSE IF WhichDay=7 THEN
                                RunDate:=RunDate+1;
                                    */
                                //MESSAGE('which day is %1',WhichDay);



                                RSchedule.Init;
                                RSchedule."Repayment Code" := RepayCode;
                                RSchedule."Loan No." := "Loan  No.";
                                RSchedule."Loan Amount" := LoanAmount;
                                RSchedule."Instalment No" := InstalNo;
                                RSchedule."Repayment Date" := RunDate;
                                RSchedule."Member No." := "Client Code";
                                RSchedule."Loan Category" := "Loan Product Type";
                                RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                                RSchedule."Monthly Interest" := LInterest;
                                RSchedule."Principal Repayment" := LPrincipal;
                                RSchedule.Insert;
                                //WhichDay:=(DATE2DMY,RSchedule."Repayment Date",1);
                                WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                            //MESSAGE('which day is %1',WhichDay);
                            //BEEP(2,10000);
                            until LBalance < 1

                        end;

                        Commit;
                        /*
                        LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Loan  No.","Loan  No.");
                        IF LoanApp.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,LoanApp);
                        */

                    end;
                }
                action("Loan Securities")
                {
                    ApplicationArea = Basic;
                    Caption = 'Securities';
                    Image = AllLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HR Employee Kin SF";
                    RunPageLink = "Employee Code" = field("Loan  No.");
                    Visible = true;
                }
                action("Loans to Offset")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans to Offset';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Loan Offset Detail List";
                    RunPageLink = "Loan No." = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalMgt: Codeunit WorkflowIntegration;
                    begin
                        if "Approved Amount" = 0 then Error('Kindly upraise your loan application before sending approval request');

                        TestField("Loan Product Type");
                        TestField("Recovery Mode");
                        TestField("Requested Amount");
                        if "Approval Status" <> "approval status"::Open then
                            Error(Text001);

                        if ApprovalsMgmt.CheckLoanApplicationApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendLoanApplicationForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit WorkflowIntegration;
                    begin
                        //ApprovalMgt.SendLoanApprRequest(Rec);
                    end;
                }
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::LoanApplication;
                        ApprovalEntries.Setfilters(Database::"Loans Register", DocumentType, "Loan  No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        EnableCreateMember := false;
        EditableAction := true;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec."Approval Status" = "approval status"::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (Rec."Approval Status" = "approval status"::Approved) then
            EnableCreateMember := true;

        if Rec."Approval Status" <> "approval status"::Open then
            EditableAction := false;
        if "Approval Status" = "approval status"::Pending then
            CanCancelApprovalForRecord := true; //to correct
    end;

    trigger OnAfterGetRecord()
    begin
        Overdue := Overdue::" ";
        if FormatField(Rec) then
            Overdue := Overdue::Yes;
    end;

    var
        LoanType: Record "Loan Products Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LoanApp: Record "Loans Register";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        SpecialComm: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        LoansR: Record "Loans Register";
        DActivity: Code[20];
        DBranch: Code[20];
        Vend: Record Vendor;
        LineNo: Integer;
        DoubleComm: Boolean;
        AvailableBal: Decimal;
        Account: Record Vendor;
        RunBal: Decimal;
        TotalRecovered: Decimal;
        OInterest: Decimal;
        OBal: Decimal;
        ReffNo: Code[20];
        DiscountCommission: Decimal;
        BridgedLoans: Record "Loan Offset Details";
        LoanAdj: Decimal;
        LoanAdjInt: Decimal;
        AdjustRemarks: Text[30];
        Princip: Decimal;
        Overdue: Option Yes," ";
        i: Integer;
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
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record Customer;
        TestAmt: Decimal;
        CustRec: Record Customer;
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sales & Receivables Setup";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Appraisal Salary Details";
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
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        TotalTopupComm: Decimal;
        CustE: Record Customer;
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Guarantee Details";
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "File Movement Tracker";
        SMSMessage: Record Customer;
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loans Register";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loans Guarantee Details";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        EditableAction: Boolean;
        SFactory: Codeunit "SURESTEP Factory.";
        ApprovalsMgmt: Codeunit WorkflowIntegration;


    procedure GetVariables(var LoanNo: Code[20]; var LoanProductType: Code[20])
    begin
        LoanNo := "Loan  No.";
        LoanProductType := "Loan Product Type";
    end;


    procedure FormatField(Rec: Record "Loans Register") OK: Boolean
    begin
        if "Outstanding Balance" > 0 then begin
            if (Rec."Expected Date of Completion" < Today) then
                exit(true)
            else
                exit(false);
        end;
    end;


    procedure CalledFrom()
    begin
        Overdue := Overdue::" ";
    end;
}

