#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516561 "Loans Approved Card"
{
    // 
    // //IF Posted=TRUE THEN
    // //ERROR('Loan has been posted, Can only preview schedule');
    // {
    // IF "Repayment Frequency"="Repayment Frequency"::Daily THEN
    // EVALUATE(InPeriod,'1D')
    // ELSE IF "Repayment Frequency"="Repayment Frequency"::Weekly THEN
    // EVALUATE(InPeriod,'1W')
    // ELSE IF "Repayment Frequency"="Repayment Frequency"::Monthly THEN
    // EVALUATE(InPeriod,'1M')
    // ELSE IF "Repayment Frequency"="Repayment Frequency"::Quaterly THEN
    // EVALUATE(InPeriod,'1Q');
    // 
    // 
    // QCounter:=0;
    // QCounter:=3;
    // //EVALUATE(InPeriod,'1D');
    // GrPrinciple:="Grace Period - Principle (M)";
    // GrInterest:="Grace Period - Interest (M)";
    // InitialGraceInt:="Grace Period - Interest (M)";
    // 
    // LoansR.RESET;
    // LoansR.SETRANGE(LoansR."Loan  No.","Loan  No.");
    // IF LoansR.FIND('-') THEN BEGIN
    // 
    // TESTFIELD("Loan Disbursement Date");
    // TESTFIELD("Repayment Start Date");
    // 
    // RSchedule.RESET;
    // RSchedule.SETRANGE(RSchedule."Loan No.","Loan  No.");
    // RSchedule.DELETEALL;
    // 
    // LoanAmount:=LoansR."Approved Amount";
    // InterestRate:=LoansR.Interest;
    // RepayPeriod:=LoansR.Installments;
    // InitialInstal:=LoansR.Installments+"Grace Period - Principle (M)";
    // LBalance:=LoansR."Approved Amount";
    // RunDate:="Repayment Start Date";//"Loan Disbursement Date";
    // 
    // InstalNo:=0;
    // 
    // //Repayment Frequency
    // IF "Repayment Frequency"="Repayment Frequency"::Daily THEN
    // RunDate:=CALCDATE('-1D',RunDate)
    // ELSE IF "Repayment Frequency"="Repayment Frequency"::Weekly THEN
    // RunDate:=CALCDATE('-1W',RunDate)
    // ELSE IF "Repayment Frequency"="Repayment Frequency"::Monthly THEN
    // RunDate:=CALCDATE('-1M',RunDate)
    // ELSE IF "Repayment Frequency"="Repayment Frequency"::Quaterly THEN
    // RunDate:=CALCDATE('-1Q',RunDate);
    // //Repayment Frequency
    // 
    // 
    // REPEAT
    // InstalNo:=InstalNo+1;
    // 
    // 
    // //Repayment Frequency
    // IF "Repayment Frequency"="Repayment Frequency"::Daily THEN
    // RunDate:=CALCDATE('1D',RunDate)
    // ELSE IF "Repayment Frequency"="Repayment Frequency"::Weekly THEN
    // RunDate:=CALCDATE('1W',RunDate)
    // ELSE IF "Repayment Frequency"="Repayment Frequency"::Monthly THEN
    // RunDate:=CALCDATE('1M',RunDate)
    // ELSE IF "Repayment Frequency"="Repayment Frequency"::Quaterly THEN
    // RunDate:=CALCDATE('1Q',RunDate);
    // //Repayment Frequency
    // 
    // 
    // IF "Repayment Method"="Repayment Method"::Amortised THEN BEGIN
    // TESTFIELD(Interest);
    // TESTFIELD(Installments);
    // TotalMRepay:=ROUND((InterestRate/12/100) / (1 - POWER((1 +(InterestRate/12/100)),- (RepayPeriod))) * (LoanAmount));
    // LInterest:=ROUND(LBalance / 100 / 12 * InterestRate);
    // LPrincipal:=TotalMRepay-LInterest;
    // END;
    // 
    // IF "Repayment Method"="Repayment Method"::"Straight Line" THEN BEGIN
    // TESTFIELD(Interest);
    // TESTFIELD(Installments);
    // LPrincipal:=ROUND(LoanAmount/RepayPeriod,0.05,'>');
    // LInterest:=ROUND((InterestRate/12/100)*LoanAmount,0.05,'>');
    // //Grace Period Interest
    // LInterest:=ROUND((LInterest*InitialInstal)/(InitialInstal-InitialGraceInt),0.05,'>');
    // END;
    // 
    // IF "Repayment Method"="Repayment Method"::"Reducing Balance" THEN BEGIN
    // TESTFIELD(Interest);
    // TESTFIELD(Installments);
    // LPrincipal:=ROUND(LoanAmount/RepayPeriod,0.05,'>');
    // LInterest:=ROUND((InterestRate/12/100)*LBalance,0.05,'>');
    // END;
    // 
    // IF "Repayment Method"="Repayment Method"::Constants THEN BEGIN
    // TESTFIELD(Repayment);
    // IF LBalance < Repayment THEN
    // LPrincipal:=LBalance
    // ELSE
    // LPrincipal:=Repayment;
    // LInterest:=Interest;
    // END;
    // //kma
    // 
    // //Grace Period
    // IF GrPrinciple > 0 THEN BEGIN
    // LPrincipal:=0
    // END ELSE BEGIN
    // //IF "Instalment Period" <> InPeriod THEN
    // LBalance:=LBalance-LPrincipal;
    // 
    // END;
    // 
    // IF GrInterest > 0 THEN
    // LInterest:=0;
    // 
    // GrPrinciple:=GrPrinciple-1;
    // GrInterest:=GrInterest-1;
    // //Grace Period
    // EVALUATE(RepayCode,FORMAT(InstalNo));
    // 
    // 
    // 
    // RSchedule.INIT;
    // RSchedule."Repayment Code":=RepayCode;
    // RSchedule."Loan No.":="Loan  No.";
    // RSchedule."Loan Amount":=LoanAmount;
    // RSchedule."Instalment No":=InstalNo;
    // RSchedule."Repayment Date":=RunDate;
    // RSchedule."Member No.":="Client Code";
    // RSchedule."Loan Category":="Loan Product Type";
    // RSchedule."Monthly Repayment":=LInterest + LPrincipal;
    // RSchedule."Monthly Interest":=LInterest;
    // RSchedule."Principal Repayment":=LPrincipal;
    // RSchedule.INSERT;
    // //WhichDay:=(DATE2DMY,RSchedule."Repayment Date",1);
    //  WhichDay:=DATE2DWY(RSchedule."Repayment Date",1);
    // //MESSAGE('which day is %1',WhichDay);
    // //BEEP(2,10000);
    // UNTIL LBalance < 1
    // 
    // END;
    // 
    // COMMIT;
    // }

    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    SourceTable = "Loans Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Loan  No.";"Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Staff No";"Staff No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff No';
                    Editable = false;
                }
                field("Client Code";"Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member';
                    Editable = MNoEditable;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                    Editable = AccountNoEditable;
                }
                field("Client Name";"Client Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID NO";"ID NO")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Deposits";"Member Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";"Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = ApplcDateEditable;

                    trigger OnValidate()
                    begin
                         TestField(Posted,false);
                    end;
                }
                field("Loan Product Type";"Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = LProdTypeEditable;
                }
                field(Installments;Installments)
                {
                    ApplicationArea = Basic;
                    Editable = InstallmentEditable;

                    trigger OnValidate()
                    begin
                        TestField(Posted,false);
                    end;
                }
                field(Interest;Interest)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Product Currency Code";"Product Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Enabled = true;
                }
                field("Requested Amount";"Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Applied';
                    Editable = AppliedAmountEditable;

                    trigger OnValidate()
                    begin
                         TestField(Posted,false);
                    end;
                }
                field("Recommended Amount";"Recommended Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approved Amount";"Approved Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Amount';
                    Editable = ApprovedAmountEditable;

                    trigger OnValidate()
                    begin
                        TestField(Posted,false);
                    end;
                }
                field("Loan Purpose";"Loan Purpose")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field(Remarks;Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
                field("Repayment Method";"Repayment Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Repayment;Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = RepaymentEditable;
                }
                field("Approved Repayment";"Approved Repayment")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Loan Status";"Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = LoanStatusEditable;

                    trigger OnValidate()
                    begin
                        UpdateControl();
                        
                        /*IF LoanType.GET('DISCOUNT') THEN BEGIN
                        IF (("Approved Amount")-("Special Loan Amount"+"Other Commitments Clearance"+SpecialComm))
                             < 0 THEN
                        ERROR('Bridging amount more than the loans applied/approved.');
                        
                        END;
                        
                        
                        IF "Loan Status" = "Loan Status"::Appraisal THEN BEGIN
                        StatusPermissions.RESET;
                        StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
                        StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::"Bosa Loan Appraisal");
                        IF StatusPermissions.FIND('-') = FALSE THEN
                        ERROR('You do not have permissions to Appraise this Loan.');
                        
                        END ELSE BEGIN
                        
                        IF "Loan Status" = "Loan Status"::Approved THEN BEGIN
                        StatusPermissions.RESET;
                        StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
                        StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::"Bosa Loan Approval");
                        IF StatusPermissions.FIND('-') = FALSE THEN
                        ERROR('You do not have permissions to Approve this Loan.');
                        
                        "Date Approved":=TODAY;
                        END;
                        END;
                        //END;
                        
                        
                        {
                        ccEmail:='';
                        
                        LoanG.RESET;
                        LoanG.SETRANGE(LoanG."Loan No","Loan  No.");
                        IF LoanG.FIND('-') THEN BEGIN
                        REPEAT
                        IF CustE.GET(LoanG."Member No") THEN BEGIN
                        IF CustE."E-Mail" <> '' THEN BEGIN
                        IF ccEmail = '' THEN
                        ccEmail:=CustE."E-Mail"
                        ELSE
                        ccEmail:=ccEmail + ';' + CustE."E-Mail";
                        END;
                        END;
                        UNTIL LoanG.NEXT = 0;
                        END;
                        
                        
                        
                        IF "Loan Status"="Loan Status"::Approved THEN BEGIN
                        CLEAR(Notification);
                        IF CustE.GET("Client Code") THEN BEGIN
                        Notification.NewMessage(CustE."E-Mail",ccEmail,'Loan Status',
                        'We are happy to inform you that your ' + "Loan Product Type" + ' loan application of ' + FORMAT("Requested Amount")
                         + ' has been approved.' + ' (Dynamics NAV ERP)','',FALSE);
                        END;
                        
                        
                        END ELSE IF "Loan Status"="Loan Status"::Appraisal THEN BEGIN
                        DocN:='';
                        DocM:='';
                        DocF:='';
                        DNar:='';
                        
                        IF "Copy of ID"= FALSE THEN BEGIN
                        DocN:='Please avail your ';
                        DocM:='Copy of ID.';
                        DocF:=' to facilitate further processing.'
                        END;
                        
                        IF Contract= FALSE THEN BEGIN
                        DocN:='Please avail your ';
                        DocM:=DocM + ' Contract.';
                        DocF:=' to facilitate further processing.'
                        END;
                        
                        IF Payslip= FALSE THEN BEGIN
                        DocN:='Please avail your ';
                        DocM:=DocM + ' Payslip.';
                        DocF:=' to facilitate further processing.'
                        END;
                        
                        DNar:=DocN + DocM + DocF;
                        
                        
                        CLEAR(Notification);
                        IF CustE.GET("Client Code") THEN BEGIN
                        Notification.NewMessage(CustE."E-Mail",ccEmail,'Loan Status',
                        'Your ' + "Loan Product Type" + ' loan application of Ksh.' + FORMAT("Requested Amount")
                        + ' has been received and it is now at the appraisal stage. ' +
                         DNar + ' (Dynamics NAV ERP)'
                        ,'',FALSE);
                        END;
                        
                        
                        END ELSE BEGIN
                        CLEAR(Notification);
                        
                        IF CustE.GET("Client Code") THEN BEGIN
                        Notification.NewMessage(CustE."E-Mail",ccEmail,'Loan Status',
                        'We are sorry to inform you that your ' + "Loan Product Type" + ' loan application of ' + FORMAT("Requested Amount")
                        + ' has been rejected.' + ' (Dynamics NAV ERP)'
                        ,'',FALSE);
                        END;
                        
                        END;
                        
                        }
                          {
                        //SMS Notification
                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.","Client Code");
                        IF Cust.FIND('-') THEN BEGIN
                        Cust.TESTFIELD(Cust."Phone No.");
                        END;
                        
                        
                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.","Client Code");
                        IF Cust.FIND('-') THEN BEGIN
                        SMSMessage.INIT;
                        SMSMessage."SMS Message":=Cust."Phone No."+'*'+' Your loan app. of date ' + FORMAT("Application Date")
                        + ' of type ' + "Loan Product Type" +' of amount ' +FORMAT("Approved Amount")+' has been issued. Thank you.';
                        SMSMessage."Date Entered":=TODAY;
                        SMSMessage."Time Entered":=TIME;
                        SMSMessage."SMS Sent":=SMSMessage."SMS Sent"::No;
                        SMSMessage.INSERT;
                        END;
                        //SMS Notification
                        }   */

                    end;
                }
                field("Batch No.";"Batch No.")
                {
                    ApplicationArea = Basic;
                    Editable = BatchNoEditable;
                }
                field("Captured By";"Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Top Up Amount";"Top Up Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bridged Amount';
                }
                field("Repayment Frequency";"Repayment Frequency")
                {
                    ApplicationArea = Basic;
                    Editable = RepayFrequencyEditable;
                }
                field("Mode of Disbursement";"Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = ModeofDisburesmentEdit;
                }
                field("Loan Disbursement Date";"Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Cheque No.";"Cheque No.")
                {
                    ApplicationArea = Basic;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        if StrLen("Cheque No.") > 6 then
                          Error('Document No. cannot contain More than 6 Characters.');
                    end;
                }
                field("Repayment Start Date";"Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Date of Completion";"Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("External EFT";"External EFT")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Approval Status";"Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("partially Bridged";"partially Bridged")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Total TopUp Commission";"Total TopUp Commission")
                {
                    ApplicationArea = Basic;
                }
                field("Rejection  Remark";"Rejection  Remark")
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
                field("Basic Pay H";"Basic Pay H")
                {
                    ApplicationArea = Basic;
                    Caption = 'Basic Pay';
                }
                field("House AllowanceH";"House AllowanceH")
                {
                    ApplicationArea = Basic;
                    Caption = 'House Allowance';
                }
                field("Medical AllowanceH";"Medical AllowanceH")
                {
                    ApplicationArea = Basic;
                    Caption = 'Medical Allowance';
                }
                field("Transport/Bus Fare";"Transport/Bus Fare")
                {
                    ApplicationArea = Basic;
                }
                field("Other Income";"Other Income")
                {
                    ApplicationArea = Basic;
                }
                field(GrossPay;GrossPay)
                {
                    ApplicationArea = Basic;
                }
                field(Nettakehome;Nettakehome)
                {
                    ApplicationArea = Basic;
                }
            }
            group("Non-Taxable Deductions")
            {
                Caption = 'Non-Taxable Deductions';
                field("Pension Scheme";"Pension Scheme")
                {
                    ApplicationArea = Basic;
                }
                field("Other Non-Taxable";"Other Non-Taxable")
                {
                    ApplicationArea = Basic;
                }
                field("Other Tax Relief";"Other Tax Relief")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Deductions)
            {
                Caption = 'Deductions';
                field("Monthly Contribution";"Monthly Contribution")
                {
                    ApplicationArea = Basic;
                }
                field(NHIF;NHIF)
                {
                    ApplicationArea = Basic;
                }
                field(NSSF;NSSF)
                {
                    ApplicationArea = Basic;
                }
                field(PAYE;PAYE)
                {
                    ApplicationArea = Basic;
                }
                field("Risk MGT";"Risk MGT")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Insurance";"Medical Insurance")
                {
                    ApplicationArea = Basic;
                }
                field("Life Insurance";"Life Insurance")
                {
                    ApplicationArea = Basic;
                }
                field("Other Liabilities";"Other Liabilities")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Deductions";"Sacco Deductions")
                {
                    ApplicationArea = Basic;
                }
                field("Other Loans Repayments";"Other Loans Repayments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Loan Repayments';
                }
                field(TotalDeductions;TotalDeductions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Deductions';
                }
                field(UtilizableAmount;"Utilizable Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Bridge Amount Release";"Bridge Amount Release")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cleared Loan Repayment';
                }
                field(NetUtilizable;NetUtilizable)
                {
                    ApplicationArea = Basic;
                    Caption = 'Net Utilizable Amount';
                }
            }
            part(Control1000000004;"Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                SubPageLink = "Loan No"=field("Loan  No.");
            }
            part(Control1000000005;"Loan Collateral Security")
            {
                Caption = 'Other Securities';
                SubPageLink = "Loan No"=field("Loan  No.");
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
                    Image = Aging;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.","Loan  No.");
                        if LoanApp.Find('-') then begin
                        Report.Run(51516384,true,false,LoanApp);
                        end;
                    end;
                }
                action("Member Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.","Client Code");
                        Report.Run(51516223,true,false,Cust);
                    end;
                }
                separator(Action1102760046)
                {
                }
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    Image = ViewDetails;
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
                        //EVALUATE(InPeriod,'1D');
                        GrPrinciple:="Grace Period - Principle (M)";
                        GrInterest:="Grace Period - Interest (M)";
                        InitialGraceInt:="Grace Period - Interest (M)";

                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Loan  No.","Loan  No.");
                        if LoansR.Find('-') then begin

                        TestField("Loan Disbursement Date");
                        TestField("Repayment Start Date");

                        RSchedule.Reset;
                        RSchedule.SetRange(RSchedule."Loan No.","Loan  No.");
                        RSchedule.DeleteAll;

                        LoanAmount:=LoansR."Approved Amount";
                        InterestRate:=LoansR.Interest;
                        RepayPeriod:=LoansR.Installments;
                        InitialInstal:=LoansR.Installments+"Grace Period - Principle (M)";
                        LBalance:=LoansR."Approved Amount";
                        LNBalance:=LoansR."Outstanding Balance";
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
                        TestField(Interest);
                        TestField(Installments);
                        //TotalMRepay:=ROUND((InterestRate/12/100) / (1 - POWER((1 + (InterestRate/12/100)),- RepayPeriod)) * LoanAmount,1,'>');
                        TotalMRepay:=(InterestRate/12/100) / (1 - Power((1 + (InterestRate/12/100)),- RepayPeriod)) * LoanAmount;
                        LInterest:=ROUND(LBalance / 100 / 12 * InterestRate);

                        LPrincipal:=TotalMRepay-LInterest;
                        end;



                        if "Repayment Method"="repayment method"::"Straight Line" then begin
                        TestField(Installments);
                        LPrincipal:=ROUND(LoanAmount/RepayPeriod,1,'>');
                        if ("Loan Product Type" = 'INST') or ("Loan Product Type" = 'MAZAO') then begin
                        LInterest:=0;
                        end else begin
                        LInterest:=ROUND((InterestRate/100)*LoanAmount,1,'>');
                        end;

                        Repayment:=LPrincipal+LInterest;
                        "Loan Principle Repayment":=LPrincipal;
                        "Loan Interest Repayment":=LInterest;
                        end;


                        if "Repayment Method"="repayment method"::"Reducing Balance" then begin
                        TestField(Interest);
                        TestField(Installments);
                        LPrincipal:=ROUND(LoanAmount/RepayPeriod,1,'>');
                        LInterest:=ROUND((InterestRate/12/100)*LBalance,1,'>');
                        end;

                        if "Repayment Method"="repayment method"::Constants then begin
                        TestField(Repayment);
                        if LBalance < Repayment then
                        LPrincipal:=LBalance
                        else
                        LPrincipal:=Repayment;
                        LInterest:=Interest;
                        end;


                        //Grace Period
                        if GrPrinciple > 0 then begin
                        LPrincipal:=0
                        end else begin
                        if "Instalment Period" <> InPeriod then
                        LBalance:=LBalance-LPrincipal;

                        end;

                        if GrInterest > 0 then
                        LInterest:=0;

                        GrPrinciple:=GrPrinciple-1;
                        GrInterest:=GrInterest-1;

                        //Grace Period
                        RSchedule.Init;
                        RSchedule."Repayment Code":=RepayCode;
                        RSchedule."Loan No.":="Loan  No.";
                        RSchedule."Loan Amount":=LoanAmount;
                        RSchedule."Instalment No":=InstalNo;
                        RSchedule."Repayment Date":=RunDate;
                        RSchedule."Member No.":="Client Code";
                        RSchedule."Loan Category":="Loan Product Type";
                        RSchedule."Monthly Repayment":=LInterest + LPrincipal;
                        RSchedule."Monthly Interest":=LInterest;
                        RSchedule."Principal Repayment":=LPrincipal;
                        RSchedule.Insert;
                        WhichDay:=Date2dwy(RSchedule."Repayment Date",1);


                        until LBalance < 1

                        end;

                        Commit;

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.","Loan  No.");
                        if LoanApp.Find('-') then
                        if LoanApp."Loan Product Type" <> 'INST' then begin
                        Report.Run(51516231,true,false,LoanApp);
                        end else begin
                        Report.Run(51516231,true,false,LoanApp);

                        end;
                    end;
                }
                separator(Action1102755012)
                {
                }
                action("Loans to Offset")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans to Offset';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Offset Detail List";
                    RunPageLink = "Loan No."=field("Loan  No."),"Client Code"=field("Client Code");
                }
                separator(Action1102760039)
                {
                }
                action("Post Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Loan Appeal';
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;

                    trigger OnAction()
                    begin


                        // FOSA posting

                        if "Mode of Disbursement" = "mode of disbursement"::"Bank Transfer" then begin
                        LoanApps.Reset;
                        LoanApps.SetRange(LoanApps."Batch No.","Batch No.");
                        LoanApps.SetRange(LoanApps."System Created",false);
                        LoanApps.SetFilter(LoanApps."Loan Status",'<>Rejected');
                        if LoanApps.Find('-') then begin
                        repeat
                        LoanApp."Issued Date":=Today;
                        //MESSAGE('');
                        LoanApps.Posted:=true;
                        LoanApps.Modify;


                        LoanApps.CalcFields(LoanApps."Top Up Amount",LoanApps."Topup iNTEREST");
                        TCharges:=0;
                        TopUpComm:=0;
                        TotalTopupComm:=0;







                        GenJournalLine.Init;
                        LineNo:=LineNo+10000;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Document No.":="Loan  No.";
                        GenJournalLine."Posting Date":="Loan Disbursement Date";
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                        GenJournalLine."Account No.":=LoanApps."Client Code";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description:='loans Topup';
                        GenJournalLine.Amount:=LoanApp."Approved Amount";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                        GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
                        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::Loan;
                        GenJournalLine."Loan No":=LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;





                        GenJournalLine.Init;
                        LineNo:=LineNo+10000;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Document No.":="Loan  No.";
                        GenJournalLine."Posting Date":="Loan Disbursement Date";
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=LoanApps."Account No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description:='loan Topup';
                        GenJournalLine.Amount:=LoanApp."Approved Amount";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                        GenJournalLine."Shortcut Dimension 2 Code":='NAIROBI';
                        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::Loan;
                        GenJournalLine."Loan No":=LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        until LoanApps.Next=0;
                        end;
                        end;



                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'PAYMENTS');
                        GenJournalLine.SetRange("Journal Batch Name",'LOANS');
                        if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco",GenJournalLine);
                        end;
                        Posted:=true;
                        Modify;
                        //Post New





                        Message('Loan posted successfully.');
                    end;
                }
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
                        
                        DocumentType:=Documenttype::Loan;
                        ApprovalEntries.Setfilters(Database::"Control-Information",DocumentType,"Loan  No.");
                        ApprovalEntries.Run;

                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                         /*
                        SalDetails.RESET;
                        SalDetails.SETRANGE(SalDetails."Loan No","Loan  No.");
                        IF SalDetails.FIND('-')=FALSE THEN BEGIN
                        ERROR('Please Insert Loan Applicant Salary Information');
                        END;
                           */
                        if "Loan Product Type" <> 'SDV' then begin
                        LGuarantors.Reset;
                        LGuarantors.SetRange(LGuarantors."Loan No","Loan  No.");
                        if LGuarantors.Find('-')=false then begin
                        Error('Please Insert Loan Applicant Guarantor Information');
                        end;
                        end;
                        //TESTFIELD("Approved Amount");
                        TestField("Loan Product Type");
                        TestField("Mode of Disbursement");
                        
                              /*
                        IF "Mode of Disbursement"="Mode of Disbursement"::Cheque THEN
                        ERROR('Mode of disbursment cannot be cheque, all loans are disbursed through FOSA')
                        
                        ELSE IF  ("Mode of Disbursement"="Mode of Disbursement"::"Bank Transfer") AND
                         ("Account No"='') THEN
                         ERROR('Member has no FOSA Savings Account linked to loan thus no means of disbursing the loan,')
                        
                        ELSE IF  (Source=Source::BOSA) AND ("Mode of Disbursement"="Mode of Disbursement"::"FOSA Loans")  THEN
                         ERROR('This is not a FOSA loan thus select correct mode of disbursement')
                        
                        ELSE IF ("Mode of Disbursement"="Mode of Disbursement"::" ")THEN
                        ERROR('Kindly specify mode of disbursement');
                                  */
                        
                        
                        /*
                        RSchedule.RESET;
                        RSchedule.SETRANGE(RSchedule."Loan No.","Loan  No.");
                        IF NOT RSchedule.FIND('-') THEN
                        ERROR('Loan Schedule must be generated and confirmed before loan is attached to batch');
                          */
                        
                        /*
                        LBatches.RESET;
                        LBatches.SETRANGE(LBatches."Loan  No.","Loan  No.");
                        IF LBatches.FIND('-') THEN BEGIN
                           IF LBatches."Approval Status"<>LBatches."Approval Status"::Open THEN
                              ERROR(Text001);
                        END;
                        */
                        //End allocate batch number
                        //ApprovalMgt.SendLoanApprRequest(LBatches);
                        //ApprovalMgt.SendLoanApprRequest(Rec);
                          /* LGuarantors.RESET;
                           LGuarantors.SETRANGE(LGuarantors."Loan No","Loan  No.");
                           IF LGuarantors.FINDFIRST THEN BEGIN
                           REPEAT
                           IF Cust.GET(LGuarantors."Member No") THEN
                           IF  Cust."Mobile Phone No"<>'' THEN
                           Sms.SendSms('Guarantors' ,Cust."Mobile Phone No",'You have guaranteed '+ "Client Name" + ' ' + "Loan Product Type" +' of KES. '+FORMAT("Approved Amount")+
                           '. Call 0720000000 if in dispute. Ekeza Sacco.',Cust."No.");
                           UNTIL LGuarantors.NEXT =0;
                           END
                            */

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                         //ApprovalMgt.SendLoanApprRequest(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Source:=Source::" ";
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        /*IF "Loan Status"="Loan Status"::Approved THEN
        CurrPage.EDITABLE:=FALSE; */

    end;

    trigger OnOpenPage()
    begin
        SetRange(Posted,true);
        /*IF "Loan Status"="Loan Status"::Approved THEN
        CurrPage.EDITABLE:=FALSE;*/

    end;

    var
        Text001: label 'Status Must Be Open';
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


    procedure UpdateControl()
    begin

        if "Loan Status"="loan status"::Application then begin
        MNoEditable:=true;
        ApplcDateEditable:=false;
        LoanStatusEditable:=false;
        LProdTypeEditable:=true;
        InstallmentEditable:=true;
        AppliedAmountEditable:=true;
        ApprovedAmountEditable:=true;
        RepayMethodEditable:=true;
        RepaymentEditable:=true;
        BatchNoEditable:=false;
        RepayFrequencyEditable:=true;
        ModeofDisburesmentEdit:=true;
        DisbursementDateEditable:=false;
        end;

        if "Loan Status"="loan status"::Appraisal then begin
        MNoEditable:=false;
        ApplcDateEditable:=false;
        LoanStatusEditable:=false;
        LProdTypeEditable:=false;
        InstallmentEditable:=false;
        AppliedAmountEditable:=false;
        ApprovedAmountEditable:=true;
        RepayMethodEditable:=true;
        RepaymentEditable:=true;
        BatchNoEditable:=false;
        RepayFrequencyEditable:=false;
        ModeofDisburesmentEdit:=true;
        DisbursementDateEditable:=false;
        end;

        if "Loan Status"="loan status"::Rejected then begin
        MNoEditable:=false;
        AccountNoEditable:=false;
        ApplcDateEditable:=false;
        LoanStatusEditable:=false;
        LProdTypeEditable:=false;
        InstallmentEditable:=false;
        AppliedAmountEditable:=false;
        ApprovedAmountEditable:=false;
        RepayMethodEditable:=false;
        RepaymentEditable:=false;
        BatchNoEditable:=false;
        RepayFrequencyEditable:=false;
        ModeofDisburesmentEdit:=false;
        DisbursementDateEditable:=false;
        RejectionRemarkEditable:=false
        end;

        if "Approval Status"="approval status"::Approved then begin
        MNoEditable:=false;
        AccountNoEditable:=false;
        LoanStatusEditable:=false;
        ApplcDateEditable:=false;
        LProdTypeEditable:=false;
        InstallmentEditable:=false;
        AppliedAmountEditable:=false;
        ApprovedAmountEditable:=false;
        RepayMethodEditable:=false;
        RepaymentEditable:=false;
        BatchNoEditable:=true;
        RepayFrequencyEditable:=false;
        ModeofDisburesmentEdit:=true;
        DisbursementDateEditable:=true;
        RejectionRemarkEditable:=false;
        end;
    end;


    procedure LoanAppPermisions()
    begin
    end;
}

