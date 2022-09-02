#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516855 "Loans List-MICRO(New)"
{
    ApplicationArea = Basic;
    CardPageID = "Loan Application MICRO(New)";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where(Source=const(MICRO),
                            Posted=const(false),
                            "Loan Status"=const(Application));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Overdue;Overdue)
                {
                    ApplicationArea = Basic;
                    Caption = 'OverDue';
                    Editable = false;
                    OptionCaption = 'Yes';
                    ToolTip = 'OverDue Entry';
                }
                field("Loan  No.";"Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Old Account No.";"Old Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Group Code";"Group Code")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type";"Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Advice Type";"Advice Type")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Date of Completion";"Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";"Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Client Code";"Client Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("BOSA No";"BOSA No")
                {
                    ApplicationArea = Basic;
                }
                field("Issued Date";"Issued Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Client Name";"Client Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks;Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Approval Status";"Approval Status")
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
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action(Approval)
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
                        /*
                        LBatches.RESET;
                        LBatches.SETRANGE(LBatches."Loan  No.","Loan  No.");
                        IF LBatches.FIND('-') THEN BEGIN
                            ApprovalEntries.Setfilters(DATABASE::Loans,17,LBatches."Loan  No.");
                              ApprovalEntries.RUN;
                        END;
                        */
                        /*
                        DocumentType:=DocumentType::Loan;
                        ApprovalEntries.Setfilters(DATABASE::Loans,DocumentType,"Loan  No.");
                        ApprovalEntries.RUN;
                        */

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
        LoanType: Record "HR Interview Evaluation";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LoanApp: Record test;
        DiscountingAmount: Decimal;
        StatusPermissions: Record "HR Employee Timesheet.";
        SpecialComm: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        LoansR: Record test;
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
        BridgedLoans: Record "HR Committee Benefit(Non Cash)";
        LoanAdj: Decimal;
        LoanAdjInt: Decimal;
        AdjustRemarks: Text[30];
        Princip: Decimal;
        Overdue: Option Yes," ";
        i: Integer;
        PeriodDueDate: Date;
        ScheduleRep: Record "HR Leave Family Employees";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record "HR Leave Family Employees";
        RSchedule: Record "HR Leave Family Employees";
        GP: Text[30];
        ScheduleCode: Code[20];
        PreviewShedule: Record "HR Leave Family Employees";
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
        TestAmt: Decimal;
        CustRec: Record "Member Register";
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sales & Receivables Setup";
        PCharges: Record "HR Interview Evalution Rating";
        TCharges: Decimal;
        LAppCharges: Record "HR Interview Evaluatn Message";
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
        LoanTopUp: Record "HR Employee Grievance";
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
        LoanG: Record "HR Leave Attachments";
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "HR Notice Board Feedback Form";
        SMSMessage: Record "SMS Messages";
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record test;
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        Disbursement: Record "HR Employee Course of Study";
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record test;
        SalDetails: Record "HR Education Assistance";
        LGuarantors: Record "HR Leave Attachments";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;


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

