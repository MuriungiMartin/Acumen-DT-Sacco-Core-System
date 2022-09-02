#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516503 "Loan Calculator"
{
    ApplicationArea = Basic;
    PageType = Card;
    SourceTable = "Loan Calculator";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Loan Calculator Type";"Loan Calculator Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        FnShowFields();
                    end;
                }
                group(MemberDetails)
                {
                    Visible = MemberNoVisible;
                    field("Member No";"Member No")
                    {
                        ApplicationArea = Basic;
                        Enabled = MemberNoVisible;
                    }
                    field("Member Name";"Member Name")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Current Deposits";"Current Deposits")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Basic Pay";"Basic Pay")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Total Deduction";"Total Deduction")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Total Loans Outstanding";"Total Loans Outstanding")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Loan Product Type";"Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Product Description";"Product Description")
                {
                    ApplicationArea = Basic;
                }
                field(Installments;Installments)
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Method";"Repayment Method")
                {
                    ApplicationArea = Basic;
                }
                field("Interest rate";"Interest rate")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount";"Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Loans To Offset";"Total Loans To Offset")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Principle Repayment";"Principle Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Repayment";"Interest Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Total Monthly Repayment";"Total Monthly Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Start Date";"Repayment Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Instalment Period";"Instalment Period")
                {
                    ApplicationArea = Basic;
                }
                field("Grace Period - Principle (M)";"Grace Period - Principle (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Grace Period - Interest (M)";"Grace Period - Interest (M)")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Qualification Analysis")
            {
                Caption = 'Qualification Analysis';
                Visible = QualificationAnalysisVisible;
                field("Qualification As Per Deposit";"Qualification As Per Deposit")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("2/3rds";"2/3rds")
                {
                    ApplicationArea = Basic;
                }
                field("1/3rd";"1/3rd")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Qualification As Per Salary";"Qualification As Per Salary")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Eligible Amount";"Eligible Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Deficit on Deposit";"Deficit on Deposit")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control1000000035;"Loan Repayment Schedule")
            {
                SubPageLink = "Loan No."=field("Member No");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Loans to Offset")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Loan Calc. Loans to Offset";
                RunPageLink = "Client Code"=field("Member No");
            }
            action("Reset Calculator")
            {
                ApplicationArea = Basic;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you Sure You Want to Reset the Calculator?',false)=true then begin
                    Rec.DeleteAll;
                    ScheduleRep.DeleteAll;
                    LoanCalctoTopup.DeleteAll;
                    end;
                end;
            }
            action("View Schedule")
            {
                ApplicationArea = Basic;
                Caption = 'View Schedule';
                Image = Form;
                Promoted = true;
                PromotedCategory = "Report";
                ShortCutKey = 'Ctrl+F7';

                trigger OnAction()
                begin
                    //IF Posted=TRUE THEN
                    //ERROR('Loan has been posted, Can only preview schedule');

                    if "Repayment Frequency"="repayment frequency"::Daily then
                    Evaluate(InPeriod,'1D')
                    else if "Repayment Frequency"="repayment frequency"::Weekly then
                    Evaluate(InPeriod,'1W')
                    else if "Repayment Frequency"="repayment frequency"::Monthly then
                    Evaluate(InPeriod,'1M')
                    else if "Repayment Frequency"="repayment frequency"::Quaterly then
                    Evaluate(InPeriod,'1Q');


                    QCounter:=0;
                    QCounter:=3;
                    ScheduleBal:=0;
                    //EVALUATE(InPeriod,'1D');
                    GrPrinciple:="Grace Period - Principle (M)";
                    GrInterest:="Grace Period - Interest (M)";
                    InitialGraceInt:="Grace Period - Interest (M)";

                    LoansR.Reset;
                    LoansR.SetRange(LoansR."Member No","Member No");
                    if LoansR.Find('-') then begin

                    "Loan Disbursement Date":=Today;
                    "Repayment Start Date":=Today;

                    RSchedule.Reset;
                    RSchedule.SetRange(RSchedule."Loan No.","Member No");
                    RSchedule.DeleteAll;

                    LoanAmount:="Requested Amount";
                    InterestRate:="Interest rate";
                    RepayPeriod:=Installments;
                    InitialInstal:=LoansR.Installments+"Grace Period - Principle (M)";
                    LBalance:="Requested Amount";
                    LNBalance:="Requested Amount";
                    RunDate:="Repayment Start Date";

                    InstalNo:=0;
                    Evaluate(RepayInterval,'1W');

                    //Repayment Frequency
                    if "Repayment Frequency"="repayment frequency"::Daily then
                    RunDate:=CalcDate('-1D',RunDate)
                    else if "Repayment Frequency"="repayment frequency"::Weekly then
                    RunDate:=CalcDate('-1W',RunDate)
                    else if "Repayment Frequency"="repayment frequency"::Monthly then
                    RunDate:=CalcDate('-1M',RunDate)
                    else if "Repayment Frequency"="repayment frequency"::Quaterly then
                    RunDate:=CalcDate('-1Q',RunDate);
                    //Repayment Frequency


                    repeat
                    InstalNo:=InstalNo+1;
                    ScheduleBal:=LBalance;

                    //*************Repayment Frequency***********************//
                    if "Repayment Frequency"="repayment frequency"::Daily then
                    RunDate:=CalcDate('1D',RunDate)
                    else if "Repayment Frequency"="repayment frequency"::Weekly then
                    RunDate:=CalcDate('1W',RunDate)
                    else if "Repayment Frequency"="repayment frequency"::Monthly then
                    RunDate:=CalcDate('1M',RunDate)
                    else if "Repayment Frequency"="repayment frequency"::Quaterly then
                    RunDate:=CalcDate('1Q',RunDate);






                    //*******************If Amortised****************************//
                    if "Repayment Method"="repayment method"::Amortised then begin
                    TestField(Installments);
                    TestField("Interest rate");
                    TestField(Installments);
                    TotalMRepay:=ROUND((InterestRate/12/100) / (1 - Power((1 + (InterestRate/12/100)),- RepayPeriod)) * LoanAmount,1,'>');
                    TotalMRepay:=(InterestRate/12/100) / (1 - Power((1 + (InterestRate/12/100)),- RepayPeriod)) * LoanAmount;
                    LInterest:=ROUND(LBalance / 100 / 12 * InterestRate);

                    LPrincipal:=TotalMRepay-LInterest;

                    ObjProductCharge.Reset;
                    ObjProductCharge.SetRange(ObjProductCharge."Product Code","Loan Product Type");
                    ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type",ObjProductCharge."loan charge type"::"Loan Insurance");
                    if ObjProductCharge.FindSet then begin
                      LInsurance:="Requested Amount"*(ObjProductCharge.Percentage/100);
                      end;
                    end;



                    if "Repayment Method"="repayment method"::"Straight Line" then begin
                    TestField(Installments);
                    LPrincipal:=ROUND(LoanAmount/RepayPeriod,1,'>');
                    if ("Loan Product Type" = 'INST') or ("Loan Product Type" = 'MAZAO') then begin
                    LInterest:=0;
                    end else begin
                    LInterest:=ROUND((InterestRate/1200)*LoanAmount,1,'>');

                    ObjProductCharge.Reset;
                    ObjProductCharge.SetRange(ObjProductCharge."Product Code","Loan Product Type");
                    ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type",ObjProductCharge."loan charge type"::"Loan Insurance");
                    if ObjProductCharge.FindSet then begin
                      LInsurance:="Requested Amount"*(ObjProductCharge.Percentage/100);
                      end;
                    end;

                    Repayment:=LPrincipal+LInterest;
                    "Loan Principle Repayment":=LPrincipal;
                    "Loan Interest Repayment":=LInterest;
                    end;


                    if "Repayment Method"="repayment method"::"Reducing Balance" then begin
                    TestField("Interest rate");
                    TestField(Installments);
                    LPrincipal:=ROUND(LoanAmount/RepayPeriod,1,'>');
                    LInterest:=ROUND((InterestRate/12/100)*LBalance,1,'>');

                    ObjProductCharge.Reset;
                    ObjProductCharge.SetRange(ObjProductCharge."Product Code","Loan Product Type");
                    ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type",ObjProductCharge."loan charge type"::"Loan Insurance");
                    if ObjProductCharge.FindSet then begin
                      LInsurance:="Requested Amount"*(ObjProductCharge.Percentage/100);
                      end;
                    end;

                    if "Repayment Method"="repayment method"::Constants then begin
                    TestField(Repayment);
                    if LBalance < Repayment then
                    LPrincipal:=LBalance
                    else
                    LPrincipal:=Repayment;
                    LInterest:="Interest rate";

                    ObjProductCharge.Reset;
                    ObjProductCharge.SetRange(ObjProductCharge."Product Code","Loan Product Type");
                    ObjProductCharge.SetRange(ObjProductCharge."Loan Charge Type",ObjProductCharge."loan charge type"::"Loan Insurance");
                    if ObjProductCharge.FindSet then begin
                      LInsurance:="Requested Amount"*(ObjProductCharge.Percentage/100);
                      end;
                    end;


                    //Grace Period
                    if GrPrinciple > 0 then begin
                    LPrincipal:=0
                    end else begin
                    if "Instalment Period" <> InPeriod then
                    LBalance:=LBalance-LPrincipal;
                    ScheduleBal:=ScheduleBal-LPrincipal;
                    end;

                    if GrInterest > 0 then
                    LInterest:=0;

                    GrPrinciple:=GrPrinciple-1;
                    GrInterest:=GrInterest-1;

                    //Grace Period
                    RSchedule.Init;
                    RSchedule."Repayment Code":=RepayCode;
                    RSchedule."Loan No.":="Member No";
                    RSchedule."Loan Amount":=LoanAmount;
                    RSchedule."Instalment No":=InstalNo;
                    RSchedule."Repayment Date":=RunDate;
                    RSchedule."Member No.":="Member No";
                    RSchedule."Loan Category":="Loan Product Type";
                    RSchedule."Monthly Repayment":=LInterest + LPrincipal+LInsurance;
                    RSchedule."Monthly Interest":=LInterest;
                    RSchedule."Principal Repayment":=LPrincipal;
                    RSchedule."Loan Balance":=ScheduleBal;
                    RSchedule."Monthly Insurance":=LInsurance;
                    RSchedule.Insert;
                    WhichDay:=Date2dwy(RSchedule."Repayment Date",1);


                    until LBalance < 1

                    end;

                    Commit;

                    ObjLoanCalc.Reset;
                    ObjLoanCalc.SetRange(ObjLoanCalc."Loan Product Type","Loan Product Type");
                    if ObjLoanCalc.Find('-') then
                      begin
                        //REPORT.RUN(51516922,TRUE,FALSE,ObjLoanCalc);
                    end;
                end;
            }
            action("Generate Schedule")
            {
                ApplicationArea = Basic;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FnShowFields();
    end;

    var
        LoanCalctoTopup: Record "Loan Calc. Loans to Offset";
        i: Integer;
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repay Schedule-Calc";
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
        NewSchedule: Record "Loan Repay Schedule-Calc";
        RSchedule: Record "Loan Repay Schedule-Calc";
        GP: Text[30];
        ScheduleCode: Code[20];
        PreviewShedule: Record "Loan Repay Schedule-Calc";
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
        LoansR: Record "Loan Calculator";
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
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening","Member Closure",Loan;
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
        RepaySched: Record "Loan Repay Schedule-Calc";
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
        MemberNoVisible: Boolean;
        MemberNameVisible: Boolean;
        MemberDepositVisible: Boolean;
        MemberBasicPayVisible: Boolean;
        MemberTotalDeductionsVisible: Boolean;
        MemberTotalLoansOustandingVisible: Boolean;
        QualificationAnalysisVisible: Boolean;
        ScheduleBal: Decimal;
        ObjLoanCalc: Record "Loan Calculator";
        ObjProductCharge: Record "Loan Product Charges";
        LInsurance: Decimal;

    local procedure FnShowFields()
    begin
         if ("Loan Calculator Type"="loan calculator type"::" ") or ("Loan Calculator Type"="loan calculator type"::"Product Specific") then
           begin
              MemberNoVisible:=false;
              MemberNameVisible:=false;
              MemberDepositVisible:=false;
              MemberBasicPayVisible:=false;
              MemberTotalDeductionsVisible:=false;
              MemberTotalLoansOustandingVisible:=false;
              QualificationAnalysisVisible:=false;
              end;

                if "Loan Calculator Type"="loan calculator type"::"Member Specific" then
                  begin
                  MemberNoVisible:=true;
                  MemberNameVisible:=true;
                  MemberDepositVisible:=true;
                  MemberBasicPayVisible:=true;
                  MemberTotalDeductionsVisible:=true;
                  MemberTotalLoansOustandingVisible:=true;
                  QualificationAnalysisVisible:=true;
                  end;





    end;
}

