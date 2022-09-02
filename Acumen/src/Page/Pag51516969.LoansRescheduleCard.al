#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516969 "Loans Reschedule Card"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = true;
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
                Editable = false;
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
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Loan Interest Repayment"; "Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest Repayment';
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
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
                    Editable = false;
                    Visible = false;
                }
                field("Credit Officer"; "Credit Officer")
                {
                    ApplicationArea = Basic;
                    Caption = 'Credit Officer';
                }
                field("Loan Centre"; "Loan Centre")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                    Style = Favorable;
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
            group("Salary Details")
            {
                Caption = 'Salary Details';
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
                Visible = false;
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
                Visible = false;
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
            group("Loan Reschedule Details")
            {
                field("Outstanding Balance"; "Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        "OutBalance at time of Reschedule" := "Outstanding Balance" + "Oustanding Interest" + Loan_Insurance;
                    end;
                }
                field("Oustanding Interest"; "Oustanding Interest")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        "OutBalance at time of Reschedule" := "Outstanding Balance" + "Oustanding Interest" + Loan_Insurance;
                    end;
                }
                field("Loan Insurance"; Loan_Insurance)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        "OutBalance at time of Reschedule" := "Outstanding Balance" + "Oustanding Interest" + Loan_Insurance;
                    end;
                }
                field("Total Loan Reschedule Amount"; "OutBalance at time of Reschedule")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        "OutBalance at time of Reschedule" := "Outstanding Balance" + "Oustanding Interest" + Loan_Insurance;
                    end;
                }
                field("Reschedule Installment"; "Loan Reschedule Instalmentsnew")
                {
                    ApplicationArea = Basic;
                }
                field("Reschedule Date"; "Loan Rescheduled Date-New")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Reschedule Instalments"; "Loan Reschedule Instalments")
                {
                    ApplicationArea = Basic;
                    Caption = '<Losan Reschedule Instalments>';
                    Editable = reschedulesedit;
                    Visible = false;
                }
                field(Rescheduled; Rescheduled)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Rescheduled Date"; "Loan Rescheduled Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Loan Rescheduled By"; "Loan Rescheduled By")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Reason For Rescheduled"; "Reason For Loan RescheduleNew")
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Loan Reschedule"; "Reason For Loan Reschedule")
                {
                    ApplicationArea = Basic;
                    Visible = false;
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
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Enabled = true;
                    Image = GanttChart;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

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
                action("Member Ledger Entries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger Entries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    RunObject = Page "Member Ledger Entries";
                    RunPageLink = "Loan No" = field("Loan  No.");
                    RunPageView = sorting("Customer No.");
                }
                action("Loan Statement")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "Client Code");
                        Cust.SetFilter("Loan No. Filter", "Loan  No.");
                        Cust.SetFilter("Loan Product Filter", "Loan Product Type");
                        if Cust.Find('-') then
                            Report.Run(51516531, true, false, Cust);
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
                        Cust.SetRange(Cust."No.", "Client Code");
                        Cust.SetFilter("Loan No. Filter", "Loan  No.");
                        Cust.SetFilter("Loan Product Filter", "Loan Product Type");
                        if Cust.Find('-') then
                            Report.Run(51516504, true, false, Cust);
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
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then
                            Report.Run(51516477, true, false, LoanApp);
                    end;
                }
                action("View Rescheduled Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Rescheduled Schedule';
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then
                            Report.Run(51516924, true, false, LoanApp);
                    end;
                }
                action("Reschedule Loan")
                {
                    ApplicationArea = Basic;
                    Image = FORM;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        if Confirm('Are you sure you want to reschedule this loan', false) = true then begin

                            // IF "Loan Reschedule Instalments"=0 THEN
                            //  ERROR('Input the reschedule Instalment period');
                            // IF "Reason For Loan Reschedule"='' THEN
                            //  ERROR('Input the Reason for Loan reschedule');
                            if "OutBalance at time of Reschedule" = 0 then
                                Error('Input the Out-balance');

                            RSchedule.Reset;
                            RSchedule.SetRange(RSchedule."Loan No.", "Loan  No.");
                            RSchedule.SetRange(RSchedule."Close Schedule", true, false);
                            if RSchedule.FindSet then begin
                                repeat
                                    RSchedule."Close Schedule" := true;
                                    RSchedule.Modify;
                                until RSchedule.Next = 0;
                            end;




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

                            RunDate := 0D;
                            QCounter := 0;
                            QCounter := 3;
                            ScheduleBal := 0;
                            //EVALUATE(InPeriod,'1D');
                            GrPrinciple := "Grace Period - Principle (M)";
                            GrInterest := "Grace Period - Interest (M)";
                            InitialGraceInt := "Grace Period - Interest (M)";


                            LoansR.Reset;
                            LoansR.SetRange(LoansR."Loan  No.", "Loan  No.");
                            if LoansR.Find('-') then begin
                                LoansR.CalcFields(LoansR."Outstanding Balance");

                                TestField("Loan Disbursement Date");
                                TestField("Repayment Start Date");

                                RSchedule.Reset;
                                RSchedule.SetRange(RSchedule."Loan No.", "Loan  No.");
                                RSchedule.SetRange(RSchedule."Close Schedule", false);
                                RSchedule.DeleteAll;

                                if LoansR.Get("Loan  No.") then begin
                                    LoansR.CalcFields(LoansR."Outstanding Balance");
                                    LoanAmount := "OutBalance at time of Reschedule";
                                    InterestRate := LoansR.Interest;

                                    RepayPeriod := "Loan Reschedule Instalmentsnew";

                                    InitialInstal := LoansR.Installments + "Grace Period - Principle (M)";
                                    //InitialInstal:=
                                    // // LBalance:=LoansR."Outstanding Balance";
                                    // // LNBalance:=LoansR."Outstanding Balance";
                                    LBalance := "OutBalance at time of Reschedule";
                                    LNBalance := "OutBalance at time of Reschedule";

                                    RunDate := "Loan Rescheduled Date-New";

                                    //MESSAGE ('date is %1|%2|%3|%4',RunDate,LoanAmount,RepayPeriod,LBalance);
                                    //...............



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

                                    //RunDate:=0D;
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

                                            ObjProductCharge.Reset;
                                            ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loan Product Type");
                                            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                                            if ObjProductCharge.FindSet then begin
                                                LInsurance := "Approved Amount" * (ObjProductCharge.Percentage / 100);
                                            end;

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

                                            ObjProductCharge.Reset;
                                            ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loan Product Type");
                                            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                                            if ObjProductCharge.FindSet then begin
                                                LInsurance := "Approved Amount" * (ObjProductCharge.Percentage / 100);
                                            end;
                                        end;


                                        if "Repayment Method" = "repayment method"::"Reducing Balance" then begin
                                            TestField(Interest);
                                            TestField(Installments);
                                            LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                                            LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 1, '>');

                                            ObjProductCharge.Reset;
                                            ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loan Product Type");
                                            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                                            if ObjProductCharge.FindSet then begin
                                                LInsurance := "Approved Amount" * (ObjProductCharge.Percentage / 100);
                                            end;
                                        end;

                                        if "Repayment Method" = "repayment method"::Constants then begin
                                            TestField(Repayment);
                                            if LBalance < Repayment then
                                                LPrincipal := LBalance
                                            else
                                                LPrincipal := Repayment;
                                            LInterest := Interest;

                                            ObjProductCharge.Reset;
                                            ObjProductCharge.SetRange(ObjProductCharge."Product Code", "Loan Product Type");
                                            ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type", ObjProductCharge."loan charge type"::"Loan Insurance");
                                            if ObjProductCharge.FindSet then begin
                                                LInsurance := "Approved Amount" * (ObjProductCharge.Percentage / 100);
                                            end;
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

                                        //Grace Period
                                        RSchedule.Init;
                                        RSchedule."Repayment Code" := RepayCode;
                                        RSchedule."Loan No." := "Loan  No.";
                                        RSchedule."Loan Amount" := LoanAmount;
                                        RSchedule."Instalment No" := InstalNo;
                                        RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                                        RSchedule."Member No." := "Client Code";
                                        RSchedule."Loan Category" := "Loan Product Type";
                                        RSchedule."Monthly Repayment" := LInterest + LPrincipal + LInsurance;
                                        RSchedule."Monthly Interest" := LInterest;
                                        RSchedule."Principal Repayment" := LPrincipal;
                                        RSchedule."Monthly Insurance" := LInsurance;
                                        RSchedule."Loan Balance" := ScheduleBal;
                                        RSchedule."Reschedule No" := 1;
                                        RSchedule.Reschedule := true;
                                        RSchedule.Insert;
                                        WhichDay := Date2dwy(RSchedule."Repayment Date", 1);


                                    until LBalance < 1
                                end;
                            end;
                            "Loan reschedule Amount" := 0;
                            Rescheduled := true;
                            //Rescheduled:=TRUE;
                            //// "Loan Rescheduled Date":=
                            "Reschedule by" := UserId;
                            "Loan Rescheduled By" := UserId;
                            "Loan Rescheduled Date" := "Loan Rescheduled Date-New";
                            "Loan Reschedule" := true;
                            "Loan reschedule Amount" := "OutBalance at time of Reschedule";
                            "Loan reschedule installament" := "Loan Reschedule Instalmentsnew";
                            Modify;

                            Commit;

                            LoanApp.Reset;
                            LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                            if LoanApp.Find('-') then
                                if LoanApp."Loan Product Type" <> 'INST' then begin
                                    Report.Run(51516924, true, false, LoanApp);
                                end else begin
                                    Report.Run(51516924, true, false, LoanApp);
                                end;
                        end;

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
                    Visible = false;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //ApprovalMgt.SendLoanApprRequest(Rec);
                        if Confirm('Are you sure you want to cancel the approval request', false) = true then begin
                            "Loan Status" := "loan status"::Application;
                            "Approval Status" := "approval status"::Open;
                            Modify;
                        end;
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
        "OutBalance at time of Reschedule" := "Outstanding Balance" + "Oustanding Interest" + Loan_Insurance;
    end;

    trigger OnOpenPage()
    begin
        EditableField := true;
    end;

    var
        Loan_Insurance: Decimal;
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
        reschedulesedit: Boolean;
        DisbursementDateEditable: Boolean;
        AccountNoEditable: Boolean;
        LNBalance: Decimal;
        ApprovalEntries: Record "Approval Entry";
        RejectionRemarkEditable: Boolean;
        ApprovalEntry: Record "Approval Entry";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
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
        ObjProductCharge: Record "Loan Product Charges";
        LInsurance: Decimal;
        "OutBalance at time of Reschedule": Decimal;
        "Loan Reschedule Instalmentsnew": Integer;
        "Loan Rescheduled Date-New": Date;
        "Reason For Loan RescheduleNew": Text;
        RAmount: Decimal;
        outstanding_Interest: Decimal;


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
            reschedulesedit := true;
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
            reschedulesedit := true;
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
            reschedulesedit := true;

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
            reschedulesedit := true;

        end;
    end;


    procedure LoanAppPermisions()
    begin
    end;

    local procedure FnGenerateSchedule()
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
                LInterest := ROUND(LoansR."Approved Amount" * LoansR.Interest / 12 * (RepayPeriod + 1) / (200 * RepayPeriod), 0.05, '>'); //For Nafaka Only
                                                                                                                                          //Grace Period
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
                RSchedule."Principal Repayment" := LPrincipal;
                RSchedule."Loan Balance" := ScheduleBal;
                RSchedule.Insert;
                WhichDay := Date2dwy(RSchedule."Repayment Date", 1);


            until LBalance < 1

        end;

        Commit;

        LoanApp.Reset;
        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
        if LoanApp.Find('-') then
            if LoanApp."Loan Product Type" <> 'INST' then begin
                Report.Run(51516477, true, false, LoanApp);
            end else begin
                Report.Run(51516477, true, false, LoanApp);
            end;
    end;

    local procedure FnDisburseToCurrentAccount(LoanApps: Record "Loans Register")
    var
        ProcessingFees: Decimal;
        ProcessingFeesAcc: Code[50];
        PChargeAmount: Decimal;
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
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::Loan,
        GenJournalLine."account type"::Employee, LoanApps."Client Code", "Posting Date", LoanApps."Approved Amount", 'BOSA', LoanApps."Loan  No.",
        'Loan principle- ' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
        //--------------------------------(Debit Member Loan Account)---------------------------------------------

        //------------------------------------2. CREDIT MEMBER FOSA A/C---------------------------------------------------------------------------------------------
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::" ",
        GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanApps."Approved Amount" * -1, 'BOSA', LoanApps."Loan  No.",
        'Loan Issued- ' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
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
                    PChargeAmount := (LoanDisbAmount * PCharges.Percentage / 100);
                //-------------------EARN CHARGE-------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", "Posting Date", PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
                PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");
                //-------------------RECOVER-----------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", PChargeAmount, 'BOSA', LoanApps."Loan  No.",
                PCharges.Description + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanApps."Loan  No.");

                //------------------10% EXCISE DUTY----------------------------------------
                if SFactory.FnChargeExcise(PCharges.Code) then begin
                    //-------------------Earn---------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", "Posting Date", (PChargeAmount * -1) * 0.1, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No." + '- Excise(10%)', LoanApps."Loan  No.");
                    //-----------------Recover---------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", PChargeAmount * 0.1, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No." + '- Excise(10%)', LoanApps."Loan  No.");
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
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                    GenJournalLine."account type"::Employee, LoanApps."Client Code", "Posting Date", LoanTopUp."Principle Top Up" * -1, 'BOSA', LoanApps."Loan  No.",
                    'Off Set By - ' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                    //------------------------------------Outstanding Interest----------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::"Interest Paid",
                    GenJournalLine."account type"::Employee, LoanApps."Client Code", "Posting Date", LoanTopUp."Interest Top Up" * -1, 'BOSA', LoanApps."Loan  No.",
                    'Interest Due Paid on top up - ' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                    //-------------------------------------Levy--------------------------
                    LineNo := LineNo + 10000;
                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", LoanType."Top Up Commision Account", "Posting Date", TopUpComm * -1, 'BOSA', LoanApps."Loan  No.",
                        'Levy on Bridging -' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                    end;

                    //-------------------------------------RECOVER-------------------------------------------------------------------------------------------------------
                    //-------------------------------------Principal-----------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanTopUp."Principle Top Up", 'BOSA', LoanApps."Loan  No.",
                    'Loan Offset  - ' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                    //-------------------------------------Outstanding Interest-------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", LoanTopUp."Interest Top Up", 'BOSA', LoanApps."Loan  No.",
                    'Interest Due Paid on top up - ' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                    //--------------------------------------Levies--------------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", TopUpComm, 'BOSA', LoanApps."Loan  No.",
                        'Levy on Bridging - ' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
                    end;
                until LoanTopUp.Next = 0;
            end;
        end;

        //-----------------------------------------5. BOOST DEPOSITS / RECOVER FROM FOSA A/C--------------------------------------------------------------------------------------------
        if LoanApps."Boost this Loan" then begin
            //---------------------------------------BOOST-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
            GenJournalLine."account type"::Employee, GenSetUp."Boosting Fees Account", "Posting Date", ROUND(LoanApps."Boosted Amount", 0.05, '>') * -1, 'BOSA', LoanApps."Loan  No.",
            'Deposits Boosting - ' + LoanApps."Client Code" + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
            //--------------------------------------RECOVER-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", ROUND(LoanApps."Boosted Amount", 0.05, '>') * -1, 'BOSA', LoanApps."Loan  No.",
            'Deposits Boosting - ' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
        end;

        //-----------------------------------------6. EARN/RECOVER BOOSTING COMMISSION--------------------------------------------------------------------------------------------
        if LoanApps."Boosting Commision" > 0 then begin
            //---------------------------------------EARN-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::"Interest Paid",
            GenJournalLine."account type"::"G/L Account", GenSetUp."Boosting Fees Account", "Posting Date", ROUND(LoanApps."Boosting Commision", 0.05, '=') * -1, 'BOSA', LoanApps."Loan  No.",
            'Boosting Commision- ' + LoanApps."Client Code" + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
            //--------------------------------------RECOVER-----------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, LoanApps."Loan  No.", LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, SFactory.FnGetFosaAccount(LoanApps."Client Code"), "Posting Date", ROUND(LoanApps."Boosting Commision", 0.05, '='), 'BOSA', LoanApps."Loan  No.",
            'Boosting Commision- ' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up");
        end;

        LoanApps."Net Payment to FOSA" := LoanApps."Approved Amount";
        LoanApps."Processed Payment" := true;
        Modify;
    end;
}

