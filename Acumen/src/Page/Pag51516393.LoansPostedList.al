#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516393 "Loans Posted List"
{
    ApplicationArea = Basic;
    CardPageID = "Loans Application Card(Posted)";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where(Posted=const(true),
                            Source=const(BOSA));
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Control1000000008)
            {
                field("Loan  No.";"Loan  No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type";"Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Client Code";"Client Code")
                {
                    ApplicationArea = Basic;
                }
                field("Loans Category";"Loans Category")
                {
                    ApplicationArea = Basic;
                }
                field("Client Name";"Client Name")
                {
                    ApplicationArea = Basic;
                }
                field("ID NO";"ID NO")
                {
                    ApplicationArea = Basic;
                }
                field("Staff No";"Staff No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No';
                }
                field("Loan Status";"Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Requested Amount";"Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount";"Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Disbursed";"Amount Disbursed")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Disburesment Type";"Disburesment Type")
                {
                    ApplicationArea = Basic;
                }
                field(Installments;Installments)
                {
                    ApplicationArea = Basic;
                }
                field("Loans Category-SASRA";"Loans Category-SASRA")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Principle Repayment";"Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Principle Repayment';
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Outstanding Balance";"Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Oustanding Interest";"Oustanding Interest")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Loan Disbursement Date";"Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
                field(Reversed;Reversed)
                {
                    ApplicationArea = Basic;
                }
                field("Captured By";"Captured By")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code";"Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Date filter";"Date filter")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Last Pay Date";"Last Pay Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Membership Duration(Years)";"Membership Duration(Years)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Expected Date of Completion";"Expected Date of Completion")
                {
                    ApplicationArea = Basic;
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
                action("Loan Appraisal ")
                {
                    ApplicationArea = Basic;
                    Enabled = true;
                    Image = GanttChart;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.","Loan  No.");
                        if LoanApp.Find('-') then begin
                        //REPORT.RUN(51516399,TRUE,FALSE,LoanApp);
                          Report.Run(51516270,true,false,LoanApp);

                        end;
                    end;
                }
                action("Loan Statement")
                {
                    ApplicationArea = Basic;
                    Image = SelectReport;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.","Client Code");
                        Cust.SetFilter("Loan No. Filter","Loan  No.");
                        Cust.SetFilter("Loan Product Filter","Loan Product Type");
                        if Cust.Find('-') then
                        Report.Run(51516531,true,false,Cust);
                    end;
                }
                action("Guarantors' Report")
                {
                    ApplicationArea = Basic;
                    Image = SelectReport;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.","Client Code");
                        Cust.SetFilter("Loan No. Filter","Loan  No.");
                        Cust.SetFilter("Loan Product Filter","Loan Product Type");
                        if Cust.Find('-') then
                        Report.Run(51516504,true,false,Cust);
                    end;
                }
                action("Member Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.","Client Code");
                        Report.Run(51516886,true,false,Cust);
                    end;
                }
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';
                    Visible = false;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.","Loan  No.");
                        if LoanApp.Find('-') then
                        Report.Run(51516477,true,false,LoanApp);
                    end;
                }
                action("Loans to Offset")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans to Offset';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Loan Offset Detail List-P";
                    RunPageLink = "Loan No."=field("Loan  No."),
                                  "Client Code"=field("Client Code");
                }
                action("View Schedule new")
                {
                    ApplicationArea = Basic;
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.","Loan  No.");
                        if LoanApp.Find('-') then
                        Report.Run(51516301,true,false,LoanApp);
                    end;
                }
                action("View ReSchedule ")
                {
                    ApplicationArea = Basic;
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.","Loan  No.");
                        if LoanApp.Find('-') then
                        Report.Run(51516302,true,false,LoanApp);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Overdue := Overdue::" ";
        if FormatField(Rec) then
          Overdue := Overdue::Yes;
    end;

    var
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
        CustomerRecord: Record "Member Register";
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record "Member Register";
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record "Member Register";
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sales & Receivables Setup";
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
        SMSMessage: Record "Member Register";
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
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
        Overdue: Option Yes," ";


    procedure GetVariables(var LoanNo: Code[20];var LoanProductType: Code[20])
    begin
        LoanNo:="Loan  No.";
        LoanProductType:="Loan Product Type";
    end;


    procedure FormatField(Rec: Record "Loans Register") OK: Boolean
    begin
        if "Outstanding Balance">0 then begin
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

