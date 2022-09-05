#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516574 "Loans Application Card(Approv)"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "Loans Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Loan  No."; "Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Staff No"; "Staff No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff No';
                    Editable = false;
                }
                field("Client Code"; "Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member';
                    Editable = MNoEditable;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Editable = AccountNoEditable;
                }
                field("Client Name"; "Client Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID NO"; "ID NO")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Deposits"; "Member Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = ApplcDateEditable;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field("Loan Product Type"; "Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = LProdTypeEditable;
                }
                field(Installments; Installments)
                {
                    ApplicationArea = Basic;
                    Editable = InstallmentEditable;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field(Interest; Interest)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Product Currency Code"; "Product Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = true;
                    Visible = false;
                }
                field("Requested Amount"; "Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Applied';
                    Editable = AppliedAmountEditable;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field("Boost this Loan"; "Boost this Loan")
                {
                    ApplicationArea = Basic;
                    Editable = AppliedAmountEditable;
                }
                field("Boosted Amount"; "Boosted Amount")
                {
                    ApplicationArea = Basic;
                    Editable = AppliedAmountEditable;
                }
                field("Recommended Amount"; "Recommended Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approved Amount"; "Approved Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Amount';
                    Editable = ApprovedAmountEditable;

                    trigger OnValidate()
                    begin
                        TestField(Posted, false);
                    end;
                }
                field("Loan Purpose"; "Loan Purpose")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = RemarksEditable;
                    Visible = true;
                }
                field("Repayment Method"; "Repayment Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Repayment; Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = RepaymentEditable;
                }
                field("Loan Principle Repayment"; "Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Principle Repayment';
                }
                field("Loan Interest Repayment"; "Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest Repayment';
                }
                field("Approved Repayment"; "Approved Repayment")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Loan Status"; "Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = LoanStatusEditable;

                    trigger OnValidate()
                    begin
                        //UpdateControl();
                    end;
                }
                field("Batch No."; "Batch No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Top Up Amount"; "Top Up Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bridged Amount';
                }
                field("Repayment Frequency"; "Repayment Frequency")
                {
                    ApplicationArea = Basic;
                    Editable = RepayFrequencyEditable;
                }
                field("Mode of Disbursement"; "Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Disbursement Date"; "Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    AssistEdit = true;
                    Editable = EditableField;
                    Enabled = EditableField;
                    Importance = Promoted;
                    NotBlank = true;
                    ShowMandatory = true;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if StrLen("Cheque No.") > 6 then
                            Error('Document No. cannot contain More than 6 Characters.');
                    end;
                }
                field("Repayment Start Date"; "Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Date of Completion"; "Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("External EFT"; "External EFT")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Approval Status"; "Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("partially Bridged"; "partially Bridged")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Total TopUp Commission"; "Total TopUp Commission")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Rejection  Remark"; "Rejection  Remark")
                {
                    ApplicationArea = Basic;
                    Editable = RejectionRemarkEditable;
                }
            }
            group("Disbursement Information")
            {
                Caption = 'Disbursement Information';
                field("Disburesment Type"; "Disburesment Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Amount Disbursed"; "Amount Disbursed")
                {
                    ApplicationArea = Basic;
                }
                field("Initial Trunch"; "Initial Trunch")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                }
            }
            group(Earnings)
            {
                Caption = 'Earnings';
                Editable = false;
                field("Basic Pay H"; "Basic Pay H")
                {
                    ApplicationArea = Basic;
                    Caption = 'Basic Pay';
                }
                field("House AllowanceH"; "House AllowanceH")
                {
                    ApplicationArea = Basic;
                    Caption = 'House Allowance';
                }
                field("Medical AllowanceH"; "Medical AllowanceH")
                {
                    ApplicationArea = Basic;
                    Caption = 'Medical Allowance';
                }
                field("Transport/Bus Fare"; "Transport/Bus Fare")
                {
                    ApplicationArea = Basic;
                }
                field("Other Income"; "Other Income")
                {
                    ApplicationArea = Basic;
                }
                field(GrossPay; GrossPay)
                {
                    ApplicationArea = Basic;
                }
                field(Nettakehome; Nettakehome)
                {
                    ApplicationArea = Basic;
                }
            }
            group("Non-Taxable Deductions")
            {
                Caption = 'Non-Taxable Deductions';
                Editable = false;
                field("Pension Scheme"; "Pension Scheme")
                {
                    ApplicationArea = Basic;
                }
                field("Other Non-Taxable"; "Other Non-Taxable")
                {
                    ApplicationArea = Basic;
                }
                field("Other Tax Relief"; "Other Tax Relief")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Deductions)
            {
                Caption = 'Deductions';
                Editable = false;
                field("Monthly Contribution"; "Monthly Contribution")
                {
                    ApplicationArea = Basic;
                }
                field(NHIF; NHIF)
                {
                    ApplicationArea = Basic;
                }
                field(NSSF; NSSF)
                {
                    ApplicationArea = Basic;
                }
                field(PAYE; PAYE)
                {
                    ApplicationArea = Basic;
                }
                field("Risk MGT"; "Risk MGT")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Insurance"; "Medical Insurance")
                {
                    ApplicationArea = Basic;
                }
                field("Life Insurance"; "Life Insurance")
                {
                    ApplicationArea = Basic;
                }
                field("Other Liabilities"; "Other Liabilities")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Deductions"; "Sacco Deductions")
                {
                    ApplicationArea = Basic;
                }
                field("Other Loans Repayments"; "Other Loans Repayments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Loan Repayments';
                }
                field(TotalDeductions; TotalDeductions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Deductions';
                }
                field(UtilizableAmount; "Utilizable Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Bridge Amount Release"; "Bridge Amount Release")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cleared Loan Repayment';
                }
                field(NetUtilizable; NetUtilizable)
                {
                    ApplicationArea = Basic;
                    Caption = 'Net Utilizable Amount';
                }
            }
            part(Control1000000001; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                Editable = false;
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            part(Control1000000000; "Loan Collateral Security")
            {
                Caption = 'Other Securities';
                Editable = false;
                SubPageLink = "Loan No" = field("Loan  No.");
                Visible = false;
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
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Enabled = true;
                    Image = GanttChart;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        TestField("Mode of Disbursement");
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            if LoanApp.Source = LoanApp.Source::BOSA then
                                Report.Run(51516384, true, false, LoanApp)
                            else
                                Report.Run(51516384, true, false, LoanApp)
                        end;
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
                        Cust.SetRange(Cust."No.", "Client Code");
                        Report.Run(51516886, true, false, Cust);
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

                    trigger OnAction()
                    begin
                        SFactory.FnGenerateRepaymentSchedule(Rec."Loan  No.");
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then
                            Report.Run(51516477, true, false, LoanApp);
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
                    RunPageLink = "Loan No." = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                }
                action("Post Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Loan';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Usersetup.Get(UserId) then begin
                            if Usersetup."Post Loans" = false then
                                Error('You dont have permissions to Post a Loan! ')
                        end;
                        /*IF NOT "Released By Auditor" THEN
                         ERROR ('This document must be released by the Auditor to enable posting!');
                         */
                        if Posted = true then
                            Error('Loan already posted.');

                        if "Loan Disbursement Date" <> Today then
                            Error('Disbursement date is must be equal to ' + Format(Today));

                        //IF ("Board Approval Status" <>"Board Approval Status"::Approved) AND ("Type Of Loan Duration"="Type Of Loan Duration"::"Long Term")  THEN
                        //    ERROR('You cannot post loan which has not been approved by Board');

                        if "Approved Amount" <= 0 then
                            Error('You cannot post this Amount Less or Equal to Zero');

                        if Confirm('Are you sure you want to post this loan?', true) = false then
                            exit;
                        RepaySched.Reset;
                        RepaySched.SetRange(RepaySched."Loan No.", "Loan  No.");
                        if not RepaySched.Find('-') then begin
                            SFactory.FnGenerateRepaymentSchedule(Rec."Loan  No.");
                        end;
                        SFactory.FnSendSMS('LOAN ISSUE', 'Your loan application of KSHs.' + Format("Approved Amount") + ' has been posted to your Fosa Account No.', "Account No", SFactory.FnGetPhoneNumber(Rec));

                        "Loan Disbursement Date" := Today;
                        TestField("Loan Disbursement Date");
                        "Posting Date" := "Loan Disbursement Date";
                        BATCH_TEMPLATE := 'PAYMENTS';
                        BATCH_NAME := 'LOANS';
                        LineNo := 1000;
                        SFactory.FnClearGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME);

                        if "Mode of Disbursement" = "mode of disbursement"::"Bank Transfer" then
                            SFactory.FnDisburseToCurrentAccount(Rec, LineNo);
                        if (("Mode of Disbursement" = "mode of disbursement"::Cheque) or ("Mode of Disbursement" = "mode of disbursement"::EFT) or ("Mode of Disbursement" = "mode of disbursement"::RTGS)) then
                            SFactory.FnDisburseToExternalAccount(Rec, LineNo);

                        SFactory.FnPostGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME);
                        Message('Loan Posted successfully. The Member and the attached guarantors will be notified via an SMS.');

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        EditableField := true;
    end;

    trigger OnAfterGetRecord()
    begin
        EditableField := true;
    end;

    trigger OnOpenPage()
    begin
        EditableField := true;
    end;

    var
        i: Integer;
        LoanType: Record "Loan Products Setup";
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
        CustE: Record Customer;
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
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
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
        ApprovalsMgmt: Codeunit WorkflowIntegration;
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
        CummulativeGuarantee: Decimal;
        LoansRec: Record "Loans Register";
        RecoveryModeEditable: Boolean;
        RemarksEditable: Boolean;
        CopyofIDEditable: Boolean;
        CopyofPayslipEditable: Boolean;
        ScheduleBal: Decimal;
        SFactory: Codeunit "SURESTEP Factory.";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        ReschedulingFees: Decimal;
        ReschedulingFeeAccount: Code[50];
        LoanProcessingFee: Decimal;
        ExciseDuty: Decimal;
        EditableField: Boolean;
        DOCUMENT_NO: Code[40];
        Usersetup: Record "User Setup";


    procedure UpdateControl()
    begin
        if "Approval Status" = "approval status"::Open then begin
            MNoEditable := true;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := true;
            InstallmentEditable := true;
            AppliedAmountEditable := true;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := true;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
            BatchNoEditable := false;
            RemarksEditable := false;
        end;

        if "Approval Status" = "approval status"::Pending then begin
            MNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
            BatchNoEditable := false;
            RemarksEditable := false;
        end;

        if "Approval Status" = "approval status"::Rejected then begin
            MNoEditable := false;
            AccountNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := false;
            DisbursementDateEditable := false;
            RejectionRemarkEditable := false;
            BatchNoEditable := false;
            RemarksEditable := false;
        end;

        if "Approval Status" = "approval status"::Approved then begin
            MNoEditable := false;
            AccountNoEditable := false;
            LoanStatusEditable := false;
            ApplcDateEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := true;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := true;
            RejectionRemarkEditable := false;
            BatchNoEditable := true;
            RemarksEditable := false;
        end;
    end;


    procedure LoanAppPermisions()
    begin
    end;

    local procedure FnGenerateSchedule()
    var
        NLInterest: Decimal;
        InterestVarianceOnlyNafaka: Decimal;
    begin
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
        ScheduleBal := 0;
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

            LoanAmount := LoansR."Approved Amount" + LoansR."Capitalized Charges";
            InterestRate := LoansR.Interest;
            RepayPeriod := LoansR.Installments;
            InitialInstal := LoansR.Installments + "Grace Period - Principle (M)";
            LBalance := LoansR."Approved Amount" + LoansR."Capitalized Charges";
            LNBalance := LoansR."Outstanding Balance";
            RunDate := "Repayment Start Date";

            InstalNo := 0;
            Evaluate(RepayInterval, '1W');

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
                ScheduleBal := LBalance;

                //*************Repayment Frequency***********************//
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






                //*******************If Amortised****************************//
                if "Repayment Method" = "repayment method"::Amortised then begin
                    TestField(Installments);
                    TestField(Interest);
                    TestField(Installments);
                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                    TotalMRepay := (InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount;
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate);

                    LPrincipal := TotalMRepay - LInterest;
                end;



                if "Repayment Method" = "repayment method"::"Straight Line" then begin
                    TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                    if ("Loan Product Type" = 'INST') or ("Loan Product Type" = 'MAZAO') then begin
                        LInterest := 0;
                    end else begin
                        LInterest := ROUND((InterestRate / 1200) * LoanAmount, 1, '>');
                    end;

                    Repayment := LPrincipal + LInterest;
                    "Loan Principle Repayment" := LPrincipal;
                    "Loan Interest Repayment" := LInterest;
                end;


                if "Repayment Method" = "repayment method"::"Reducing Balance" then begin
                    TestField(Interest);
                    TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 1, '>');
                end;

                if "Repayment Method" = "repayment method"::Constants then begin
                    TestField(Repayment);
                    if LBalance < Repayment then
                        LPrincipal := LBalance
                    else
                        LPrincipal := Repayment;
                    LInterest := Interest;
                end;


                //Grace Period
                if GrPrinciple > 0 then begin
                    LPrincipal := 0
                end else begin
                    if "Instalment Period" <> InPeriod then
                        LBalance := LBalance - LPrincipal;
                    ScheduleBal := ScheduleBal - LPrincipal;
                end;

                if GrInterest > 0 then
                    LInterest := 0;

                GrPrinciple := GrPrinciple - 1;
                GrInterest := GrInterest - 1;

                //NLInterest:=ROUND(LoansRec."Approved Amount"*LoansRec.Interest/12*(RepayPeriod+1)/(200*RepayPeriod),1,'>'); //For Nafaka Only
                //InterestVarianceOnlyNafaka:=LInterest-NLInterest;

                RSchedule.Init;
                RSchedule."Repayment Code" := RepayCode;
                RSchedule."Loan No." := "Loan  No.";
                RSchedule."Loan Amount" := LoanAmount;
                RSchedule."Instalment No" := InstalNo;
                RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                RSchedule."Member No." := "Client Code";
                RSchedule."Loan Category" := "Loan Product Type";
                RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                RSchedule."Monthly Interest" := LInterest;
                RSchedule."Monthly Insurance" := ROUND(LInterest, 1, '>');
                //RSchedule."Close Schedule":=InterestVarianceOnlyNafaka;
                RSchedule."Principal Repayment" := LPrincipal;
                RSchedule."Loan Balance" := ScheduleBal;
                RSchedule.Insert;
                WhichDay := Date2dwy(RSchedule."Repayment Date", 1);


            until LBalance < 1

        end;
        LoanApp.Reset;
        LoanApp.SetRange("Loan  No.", "Loan  No.");
        if LoanApp.Find('-') then begin
            LoanApp.Repayment := LInterest + LPrincipal;
            LoanApp.Modify;
        end;
        Commit;
    end;

    local procedure FnDisburseToCurrentAccount(LoanApps: Record "Loans Register")
    var
        ProcessingFees: Decimal;
        ProcessingFeesAcc: Code[50];
        PChargeAmount: Decimal;
        BLoan: Code[30];
    begin
        if (SFactory.FnGetFosaAccount(LoanApps."Client Code") = '') then
            Error('Member must be assigned the ordinary Account.');

        GenSetUp.Get();
        LoanApps.CalcFields(LoanApps."Top Up Amount", LoanApps."Topup iNTEREST");
        TCharges := 0;
        TopUpComm := 0;
        TotalTopupComm := LoanApps."Top Up Amount";

        //------------------------------------1. DEBIT MEMBER LOAN A/C---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
        GenJournalLine."account type"::Member, LoanApps."Client Code", "Posting Date", LoanApps."Approved Amount", Format(LoanApps.Source), LoanApps."Loan  No.",
        'Loan principle- ' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
        //--------------------------------(Debit Member Loan Account)---------------------------------------------

        //------------------------------------2. CREDIT MEMBER FOSA A/C---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanApps."Approved Amount" * -1, 'BOSA', LoanApps."Loan  No.",
        'Loan Issued- ' + LoanApps."Loan Product Type", LoanApps."Loan  No.");
        //----------------------------------(Credit Member Fosa Account)------------------------------------------------

        //------------------------------------3. EARN/RECOVER PRODUCT CHARGES FROM FOSA A/C--------------------------------------
        PCharges.Reset;
        PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
        if PCharges.Find('-') then begin
            repeat
                PCharges.TestField(PCharges."G/L Account");
                GenSetUp.TestField(GenSetUp."Excise Duty Account");
                PChargeAmount := PCharges.Amount;
                if PCharges."Use Perc" = true then
                    PChargeAmount := (LoanApps."Approved Amount" * PCharges.Percentage / 100);
                //-------------------EARN CHARGE-------------------------------------------
                if (LoanApp."Loan Product Type" <> 'EMERGENCY 20') or (LoanApp."Loan Product Type" <> 'EMERGENCY 6') then begin

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", "Posting Date", PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
                    //-------------------RECOVER-----------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", PChargeAmount, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Loan Product Type", LoanApps."Loan  No.");
                end;
                //New Emergency Loans
                //-------------------EARN CHARGE-------------------------------------------
                if (LoanApp."Loan Product Type" = 'EMERGENCY 20') or (LoanApp."Loan Product Type" = 'EMERGENCY 6') and (PCharges.Code <> 'LPF') then begin

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", "Posting Date", PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
                    //-------------------RECOVER-----------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", PChargeAmount, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Loan Product Type", LoanApps."Loan  No.");
                end;

                if (LoanApp."Loan Product Type" = 'EMERGENCY 20') or (LoanApp."Loan Product Type" = 'EMERGENCY 6') and (PCharges.Code = 'LPF') then begin

                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", "Posting Date", PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
                    //-------------------RECOVER-----------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", PChargeAmount, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Loan Product Type", LoanApps."Loan  No.");
                end;

                //End New Emergency Addition
                //------------------10% EXCISE DUTY----------------------------------------
                if SFactory.FnChargeExcise(PCharges.Code) then begin
                    //-------------------Earn---------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", "Posting Date", (PChargeAmount * -1) * 0.1, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No." + '- Excise(10%)', LoanApps."Loan  No.");
                    //-----------------Recover---------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", PChargeAmount * 0.1, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Loan Product Type" + ' - Excise(10%)', LoanApps."Loan  No.");
                end
            //----------------END 10% EXCISE--------------------------------------------
            until PCharges.Next = 0;
        end;


        //----------------------------------------4. PAY/RECOVER TOP UPS------------------------------------------------------------------------------------------
        if LoanApps."Top Up Amount" > 0 then begin
            LoanTopUp.Reset;
            LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
            if LoanTopUp.Find('-') then begin
                repeat
                    //------------------------------------PAY-----------------------------------------------------------------------------------------------------------
                    //------------------------------------Principal---------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                    GenJournalLine."account type"::Member, LoanApps."Client Code", "Posting Date", LoanTopUp."Principle Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                    'Off Set By - ' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                    //------------------------------------Outstanding Interest----------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                    GenJournalLine."account type"::Member, LoanApps."Client Code", "Posting Date", LoanTopUp."Interest Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                    'Interest Paid-' + '-' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                    //-------------------------------------Levy--------------------------
                    LineNo := LineNo + 10000;
                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", LoanType."Top Up Commision Account", "Posting Date", LoanTopUp.Commision * -1, 'BOSA', LoanTopUp."Loan Top Up",
                        'Levy on Bridging -' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                    end;

                    //-------------------------------------RECOVER-------------------------------------------------------------------------------------------------------
                    //-------------------------------------Principal-----------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanTopUp."Principle Top Up", 'BOSA', LoanTopUp."Loan Top Up",
                    'Loan Offset  - ' + LoanApps."Loan Product Type", LoanTopUp."Loan Top Up");
                    //-------------------------------------Outstanding Interest-------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanTopUp."Interest Top Up", 'BOSA', LoanTopUp."Loan Top Up",
                    'Interest Due Paid on top up - ' + LoanApps."Loan Product Type", LoanTopUp."Loan Top Up");
                    //--------------------------------------Levies--------------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanTopUp.Commision, 'BOSA', LoanTopUp."Loan Top Up",
                        'Levy on Bridging - ' + LoanApps."Loan Product Type", LoanTopUp."Loan Top Up");
                    end;
                //-------------------------------------Update Datasheet for Top up-------------------------------------------------------------------------------
                //SFactory.FnUpdateDatasheetTopup(LoanTopUp,LoanApps);
                until LoanTopUp.Next = 0;
            end;
        end;







        //-----------------------------------------5. BOOST DEPOSITS / RECOVER FROM FOSA A/C--------------------------------------------------------------------------------------------
        if LoanApps."Boost this Loan" then begin
            //---------------------------------------BOOST-----------------------------------------------
            LineNo := LineNo + 10000;
            BLoan := "Booster Loan No";
            if BLoan = '' then begin
                BLoan := FnBoosterLoansDisbursement(Rec, LineNo); //Issue Loan
                "Booster Loan No" := BLoan;
            end;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
            GenJournalLine."account type"::Member, LoanApps."Client Code", "Posting Date", LoanApps."Boosted Amount", 'BOSA', BLoan,
            'Deposits Booster for ' + LoanApps."Loan  No.", BLoan);

            //----------------------Credit FOSA a/c-----------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanApps."Boosted Amount" * -1, 'BOSA', BLoan,
            'Deposits Booster Loan-Booster Loan', BLoan);


            //------------------------------Boost Deposits-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
            GenJournalLine."account type"::Member, "Client Code", "Posting Date", LoanApps."Boosted Amount" * -1, 'BOSA', BLoan,
            'Deposits Booster Loan', BLoan);

            //--------------------------------------RECOVER-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanApps."Boosted Amount", 'BOSA', BLoan,
            'Deposits Booster Loan Recov.', BLoan);
        end;







        //-----------------------------------------6. EARN/RECOVER BOOSTING COMMISSION--------------------------------------------------------------------------------------------
        if LoanApps."Boosting Commision" > 0 then begin
            //---------------------------------------EARN-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"G/L Account", GenSetUp."Boosting Fees Account", "Posting Date", LoanApps."Boosting Commision" * -1, 'BOSA', BLoan,
            'Boosting Commision- ' + LoanApps."Client Code" + LoanApps."Loan Product Type" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
            //--------------------------------------RECOVER-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanApps."Boosting Commision", 'BOSA', BLoan,
            'Deposits Booster Comm. Recov.', LoanApps."Loan  No.");
        end;

        //-----------------------------------------7. EARN/RECOVER BOOSTER LOAN PRINCIPAL--------------------------------------------------------------------------------------------
        if LoanApps."Boosting Commision" > 0 then begin
            //---------------------------------------PAY-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
            GenJournalLine."account type"::Member, "Client Code", "Posting Date", LoanApps."Boosted Amount" * -1, 'BOSA', BLoan,
            'Deposits Booster Repayment-' + LoanApps."Client Code" + LoanApps."Loan Product Type", BLoan);
            //--------------------------------------RECOVER-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanApps."Boosted Amount", 'BOSA', BLoan,
            'Deposits Booster Loan Recov.', BLoan);
        end;

        //-----------------------------------------8. EARN/RECOVER BOOSTER LOAN INTEREST--------------------------------------------------------------------------------------------
        if LoanApps."Boosting Commision" > 0 then begin
            //---------------------------------------PAY-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
            GenJournalLine."account type"::Member, "Client Code", "Posting Date", LoanApps."Boosted Amount Interest" * -1, 'BOSA', BLoan,
            'Deposits Booster Int - ' + LoanApps."Client Code" + LoanApps."Loan Product Type", BLoan);
            //--------------------------------------RECOVER-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanApps."Boosted Amount Interest", 'BOSA', BLoan,
            'Deposits Booster Int Recov.', BLoan);
        end;

        LoanApps."Net Payment to FOSA" := LoanApps."Approved Amount";
        LoanApps."Processed Payment" := true;
        Modify;
        //SFactory.FnCheckLoanArrears(LoanApps."Account No");
    end;

    local procedure FnBoosterLoansDisbursement(ObjLoanDetails: Record "Loans Register"; LineNo: Integer): Code[40]
    var
        GenJournalLine: Record "Gen. Journal Line";
        CUNoSeriesManagement: Codeunit NoSeriesManagement;
        DocNumber: Code[100];
        loanTypes: Record "Loan Products Setup";
        ObjLoanX: Record "Loans Register";
    begin
        loanTypes.Reset;
        loanTypes.SetRange(loanTypes.Code, 'BLOAN');
        if loanTypes.Find('-') then begin
            DocNumber := CUNoSeriesManagement.GetNextNo('LOANSB', 0D, true);
            LoansRec.Init;
            LoansRec."Loan  No." := DocNumber;
            LoansRec.Insert;

            if LoansRec.Get(LoansRec."Loan  No.") then begin
                LoansRec."Client Code" := ObjLoanDetails."Client Code";
                LoansRec.Validate(LoansRec."Client Code");
                LoansRec."Loan Product Type" := 'BLOAN';
                LoansRec.Validate(LoansRec."Loan Product Type");
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Loan Status" := LoansRec."loan status"::Issued;
                LoansRec."Application Date" := ObjLoanDetails."Application Date";
                LoansRec."Issued Date" := ObjLoanDetails."Posting Date";
                LoansRec."Loan Disbursement Date" := ObjLoanDetails."Loan Disbursement Date";
                LoansRec.Validate(LoansRec."Loan Disbursement Date");
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"Bank Transfer";
                LoansRec."Repayment Start Date" := ObjLoanDetails."Repayment Start Date";
                LoansRec."Global Dimension 1 Code" := 'BOSA';
                LoansRec."Global Dimension 2 Code" := SFactory.FnGetUserBranch();
                LoansRec.Source := ObjLoanDetails.Source;
                LoansRec."Approval Status" := ObjLoanDetails."Approval Status";
                LoansRec.Repayment := ObjLoanDetails."Boosted Amount";
                LoansRec."Requested Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec."Approved Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"Bank Transfer";
                LoansRec.Posted := true;
                LoansRec."Advice Date" := Today;
                LoansRec.Modify;
            end;
        end;
        exit(DocNumber);
    end;
}

