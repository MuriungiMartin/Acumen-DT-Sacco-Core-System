#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516606 "Loan Application Card Savers"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
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
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'FOSA Account No';
                    Editable = MNoEditable;
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
                field("Pension No"; "Pension No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                    TableRelation = "Loan Products Setup" where(Source = const(BOSA));
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
                field("Recommended Amount"; "Recommended Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Qualifying Amount';
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
                    Visible = true;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
                field("Received Copy Of ID"; "Received Copy Of ID")
                {
                    ApplicationArea = Basic;
                }
                field("Received Payslip/Bank Statemen"; "Received Payslip/Bank Statemen")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Method"; "Repayment Method")
                {
                    ApplicationArea = Basic;
                    Editable = RepayMethodEditable;
                }
                field(Repayment; Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = RepaymentEditable;
                }
                field("Loan Status"; "Loan Status")
                {
                    ApplicationArea = Basic;

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
                field("Batch No."; "Batch No.")
                {
                    ApplicationArea = Basic;
                    Editable = BatchNoEditable;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Top Up Amount"; "Top Up Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Frequency"; "Repayment Frequency")
                {
                    ApplicationArea = Basic;
                    Editable = RepayFrequencyEditable;
                }
                field("Mode of Disbursement"; "Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = ModeofDisburesmentEdit;
                }
                field("Loan Disbursement Date"; "Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Editable = DisbursementDateEditable;
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
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Gross Pay"; "Gross Pay")
                {
                    ApplicationArea = Basic;
                    Caption = 'Net Pay';
                }
            }
            part(Control1000000007; "Loan Guarantors FOSA")
            {
                Caption = 'Guarantors  Detail';
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            part(Control1000000006; "Loan Collateral Security")
            {
                Caption = 'Other Securities';
                SubPageLink = "Loan No" = field("Loan  No.");
            }
        }
        area(factboxes)
        {
            part(Control1000000004; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
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
                    Enabled = true;
                    Image = Aging;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        TestField("Mode of Disbursement");
                        ProvidedGuarantors := 0;
                        if ("Loan Product Type" <> 'FL354') or ("Loan Product Type" <> 'FL364') then begin
                            if "Gross Pay" = 0 then
                                Error('Specify the Net pay')
                        end;



                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        LoanApp.SetRange(LoanApp."Loan Product Type", 'FL354');
                        if LoanApp.Find('-') then begin
                            Report.Run(51516527, true, false, LoanApp);
                        end;

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        LoanApp.SetRange(LoanApp."Loan Product Type", 'FL364');
                        if LoanApp.Find('-') then begin
                            Report.Run(51516527, true, false, LoanApp);
                        end;
                    end;
                }
                separator(Action11)
                {
                }
                action("Update PAYE")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        GenSetUp.Get();
                        if Staff = true then
                            Nettakehome := "Basic Pay" * 1 / 3
                        else
                            Nettakehome := "Basic Pay H" * GenSetUp."Minimum take home FOSA";
                        "Net take Home" := Nettakehome;
                        Modify;


                        GrossPay := "Basic Pay H" + "Medical AllowanceH" + "House AllowanceH" + "Other Income" + "Transport/Bus Fare";
                        "Gross Pay" := GrossPay;
                        Modify;

                        CalcFields("Bridge Amount Release");

                        "Utilizable Amount" := 0;
                        NetUtilizable := 0;

                        OTrelief := "Other Tax Relief";

                        if Disabled <> true then begin

                            //CALCULATE PAYE
                            if TAXABLEPAY.Find('-') then begin
                                repeat
                                    if (GrossPay >= TAXABLEPAY."Lower Limit") and (GrossPay <= TAXABLEPAY."Upper Limit") then begin
                                        Chargeable := ROUND(GrossPay - "Pension Scheme" - "Other Non-Taxable", 1);
                                        Taxrelief := 1162;

                                        if TAXABLEPAY."Tax Band" = '01' then begin
                                            BAND1 := 10164 * 0.1;
                                            PAYE := ROUND(BAND1 - Taxrelief - OTrelief);
                                        end else
                                            if TAXABLEPAY."Tax Band" = '02' then begin
                                                BAND1 := 10164 * 0.1;
                                                BAND2 := (Chargeable - TAXABLEPAY."Lower Limit") * 0.15;
                                                PAYE := ROUND(BAND1 + BAND2 - Taxrelief - OTrelief);
                                            end else
                                                if TAXABLEPAY."Tax Band" = '03' then begin
                                                    BAND1 := 10164 * 0.1;
                                                    BAND2 := 9576 * 0.15;
                                                    BAND3 := (Chargeable - TAXABLEPAY."Lower Limit") * 0.2;
                                                    PAYE := ROUND(BAND1 + BAND2 + BAND3 - Taxrelief - OTrelief, 1);
                                                end else begin
                                                    if TAXABLEPAY."Tax Band" = '04' then begin
                                                        BAND1 := 10164 * 0.1;
                                                        BAND2 := 9576 * 0.15;
                                                        BAND3 := 9576 * 0.2;
                                                        BAND4 := (Chargeable - TAXABLEPAY."Lower Limit") * 0.25;
                                                        PAYE := ROUND(BAND1 + BAND2 + BAND3 + BAND4 - Taxrelief - OTrelief);
                                                    end else begin
                                                        if TAXABLEPAY."Tax Band" = '05' then begin
                                                            BAND1 := 10164 * 0.1;
                                                            BAND2 := 9576 * 0.15;
                                                            BAND3 := 9576 * 0.2;
                                                            BAND4 := 9576 * 0.25;
                                                            BAND5 := (Chargeable - TAXABLEPAY."Lower Limit") * 0.3;
                                                            PAYE := ROUND(BAND1 + BAND2 + BAND3 + BAND4 + BAND5 - Taxrelief - OTrelief);
                                                        end;
                                                    end;
                                                end;

                                        xRec.PAYE := PAYE;

                                    end;
                                until TAXABLEPAY.Next = 0;
                            end;
                        end;



                        "Utilizable Amount" := ("Basic Pay H") - ("Monthly Contribution" + NSSF + NHIF + PAYE + "Risk MGT" + "Staff Union Contribution" + "Medical Insurance"
                        + "Life Insurance" + "Other Liabilities" + Nettakehome + "Other Loans Repayments" + "Sacco Deductions");

                        TotalDeductions := "Monthly Contribution" + NSSF + NHIF + PAYE + "Risk MGT" + "Staff Union Contribution" + "Medical Insurance"
                        + "Life Insurance" + "Other Liabilities" + Nettakehome + "Other Loans Repayments" + "Sacco Deductions";

                        NetUtilizable := "Utilizable Amount" + "Bridge Amount Release" + "Non Payroll Payments";
                        "Utilizable Amount" := "Utilizable Amount";
                        "Net Utilizable Amount" := NetUtilizable;
                        "Total DeductionsH" := TotalDeductions;
                        "Net take Home" := Nettakehome;
                        Modify;
                    end;
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
                                    LInterest := ROUND((InterestRate / 1200) * LoanAmount, 0.05, '>');
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

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then
                            Report.Run(51516477, true, false, LoanApp);

                    end;
                }
                separator(Action9)
                {
                }
                action("Loans Top Up")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Top Up';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Offset Detail List";
                    RunPageLink = "Loan No." = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                }
                separator(Action7)
                {
                }
                separator(Action6)
                {
                }
                action("Post Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Loan';

                    trigger OnAction()
                    begin

                        //SMS MESSAGE/// To Applicant
                        SMSMessage.Reset;
                        if SMSMessage.Find('+') then begin
                            iEntryNo := SMSMessage."Entry No";
                            iEntryNo := iEntryNo + 1;
                        end
                        else begin
                            iEntryNo := 1;
                        end;

                        SMSMessage.Reset;
                        SMSMessage.Init;
                        SMSMessage."Entry No" := iEntryNo;
                        SMSMessage."Account No" := "Account No";
                        SMSMessage."Date Entered" := Today;
                        SMSMessage."Time Entered" := Time;
                        SMSMessage.Source := 'LOAN ISSUE';
                        SMSMessage."Entered By" := UserId;
                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                        SMSMessage."SMS Message" := 'Your loan application of KSHs.' + Format("Approved Amount") +
                                                  ' has been issued. HAZINA SACCO LTD';
                        Vend1.Reset;
                        if Vend1.Get("Account No") then
                            SMSMessage."Telephone No" := Vend1."Phone No.";
                        SMSMessage.Insert;


                        // SMS Message to Guarantors
                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", "Loan  No.");
                        if LoanGuar.Find('-') then begin
                            repeat

                                Vend.Reset;
                                Vend.SetRange(Vend."No.", LoanGuar."Account No.");
                                //Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                                if Cust.Find('-') then begin

                                    //SMS MESSAGE

                                    SMSMessages.Reset;
                                    if SMSMessages.Find('+') then begin
                                        iEntryNo := SMSMessages."Entry No";
                                        iEntryNo := iEntryNo + 1;
                                    end
                                    else begin
                                        iEntryNo := 1;
                                    end;

                                    SMSMessages.Init;
                                    SMSMessages."Entry No" := iEntryNo;
                                    SMSMessages."Account No" := LoanGuar."Account No.";
                                    SMSMessages."Date Entered" := Today;
                                    SMSMessages."Time Entered" := Time;
                                    SMSMessages.Source := 'LOAN GUARANTORS';
                                    SMSMessages."Entered By" := UserId;
                                    SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
                                    //IF LoanApp.GET(LoanGuar."Loan No") THEN
                                    SMSMessages."SMS Message" := 'You have guaranteed an amount of ' + Format(LoanGuar."Amount Guaranted")
                                    + ' to ' + "Client Name" + ' ' + 'Staff No:-' + "Staff No" + ' ' +
                                    'Loan Type ' + "Loan Product Type" + ' ' + 'of ' + Format("Requested Amount") + ' at HAZINA SACCO Ltd.'
                                    + ' ' + 'Please call +254712149631 if in dispute.';
                                    SMSMessages."Telephone No" := Vend."Phone No.";
                                    SMSMessages.Insert;
                                    //MESSAGE('%1',Cust."Phone No.");
                                end;
                            until LoanGuar.Next = 0;
                        end;


                        if Posted = true then
                            Error('Loan already posted.');


                        "Loan Disbursement Date" := Today;
                        TestField("Loan Disbursement Date");
                        "Posting Date" := "Loan Disbursement Date";


                        if Confirm('Are you sure you want to post this loan?', true) = false then
                            exit;

                        /*//PRORATED DAYS
                        EndMonth:=CALCDATE('-1D',CALCDATE('1M',DMY2DATE(1,DATE2DMY("Posting Date",2),DATE2DMY("Posting Date",3))));
                        RemainingDays:=(EndMonth-"Posting Date")+1;
                        TMonthDays:=DATE2DMY(EndMonth,1);
                        //PRORATED DAYS
                        
                        */
                        if "Mode of Disbursement" = "mode of disbursement"::"Bank Transfer" then begin

                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                            GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                            GenJournalLine.DeleteAll;


                            GenSetUp.Get();

                            DActivity := 'BOSA';
                            DBranch := '';//PKKS'NAIROBI';
                            LoanApps.Reset;
                            LoanApps.SetRange(LoanApps."Loan  No.", "Loan  No.");
                            LoanApps.SetRange(LoanApps."System Created", false);
                            LoanApps.SetFilter(LoanApps."Loan Status", '<>Rejected');
                            if LoanApps.Find('-') then begin
                                repeat
                                    LoanApps.CalcFields(LoanApps."Special Loan Amount");
                                    DActivity := '';
                                    DBranch := '';
                                    if Vend.Get(LoanApps."Client Code") then begin
                                        DActivity := Vend."Global Dimension 1 Code";
                                        DBranch := Vend."Global Dimension 2 Code";
                                    end;

                                    LoanDisbAmount := LoanApps."Approved Amount";

                                    if (LoanApps."Special Loan Amount" > 0) and (LoanApps."Bridging Loan Posted" = false) then
                                        Error('Bridging Loans must be posted before the loans are disbursed. ' + LoanApps."Loan  No.");

                                    TCharges := 0;
                                    TopUpComm := 0;
                                    TotalTopupComm := 0;


                                    if LoanApps."Loan Status" <> LoanApps."loan status"::Approved then
                                        Error('Loan status must be Approved for you to post Loan. - ' + LoanApps."Loan  No.");

                                    if LoanApps.Posted = true then
                                        Error('Loan has already been posted. - ' + LoanApps."Loan  No.");


                                    LoanApps.CalcFields(LoanApps."Top Up Amount");


                                    RunningDate := "Posting Date";


                                    //Generate and post Approved Loan Amount
                                    if not GenBatch.Get('PAYMENTS', 'LOANS') then begin
                                        GenBatch.Init;
                                        GenBatch."Journal Template Name" := 'PAYMENTS';
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
                                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                            GenJournalLine."Journal Batch Name" := 'LOANS';
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                            GenJournalLine."Account No." := PCharges."G/L Account";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine."Document No." := "Loan  No.";
                                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                            GenJournalLine."Posting Date" := "Posting Date";
                                            GenJournalLine.Description := PCharges.Description;
                                            if PCharges."Use Perc" = true then begin
                                                GenJournalLine.Amount := (LoanDisbAmount * PCharges.Percentage / 100) * -1;
                                            end else begin
                                                GenJournalLine.Amount := PCharges.Amount * -1;

                                            end;


                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            //Don't top up charges on principle
                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                                            GenJournalLine."Bal. Account No." := LoanApps."Account No";
                                            //Don't top up charges on principle
                                            GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;

                                            TCharges := TCharges + (GenJournalLine.Amount * -1);


                                        until PCharges.Next = 0;
                                    end;




                                    //Don't top up charges on principle
                                    TCharges := 0;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                    GenJournalLine."Account No." := "Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := "Loan  No.";
                                    GenJournalLine."External Document No." := "ID NO";
                                    GenJournalLine."Posting Date" := "Posting Date";
                                    GenJournalLine.Description := 'Principal Amount';
                                    GenJournalLine.Amount := LoanDisbAmount + TCharges;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;




                                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                                        if LoanApps."Top Up Amount" > 0 then begin
                                            LoanTopUp.Reset;
                                            LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                                            if LoanTopUp.Find('-') then begin
                                                repeat
                                                    //Principle
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Document No." := "Loan  No.";
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
                                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                                    //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;
                                                    //Principle
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Document No." := "Loan  No.";
                                                    GenJournalLine."Posting Date" := "Posting Date";
                                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                                    GenJournalLine."Account No." := LoanApps."Account No";
                                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                                    GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                                                    GenJournalLine.Amount := LoanTopUp."Principle Top Up";
                                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                                    //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;


                                                    //Interest (Reversed if top up)
                                                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                                                        LineNo := LineNo + 10000;
                                                        GenJournalLine.Init;
                                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                                        GenJournalLine."Account No." := LoanApps."Client Code";
                                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                                        GenJournalLine."Document No." := "Loan  No.";
                                                        GenJournalLine."Posting Date" := "Posting Date";
                                                        GenJournalLine.Description := 'Interest paid ' + LoanApps."Loan  No.";
                                                        GenJournalLine.Amount := -LoanTopUp."Interest Top Up";
                                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                                                        GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                        if GenJournalLine.Amount <> 0 then
                                                            GenJournalLine.Insert;


                                                    end;
                                                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                                                        LineNo := LineNo + 10000;
                                                        GenJournalLine.Init;
                                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                                        GenJournalLine."Document No." := "Loan  No.";
                                                        GenJournalLine."Posting Date" := "Posting Date";
                                                        GenJournalLine.Description := 'Interest paid ' + LoanApps."Loan  No.";
                                                        GenJournalLine.Amount := LoanTopUp."Interest Top Up";
                                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                                        GenJournalLine."Account No." := LoanApps."Account No";
                                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                                                        GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                        if GenJournalLine.Amount <> 0 then
                                                            GenJournalLine.Insert;


                                                    end;

                                                    //Commision
                                                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                                                        if LoanType."Top Up Commision" > 0 then begin
                                                            LineNo := LineNo + 10000;
                                                            GenJournalLine.Init;
                                                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                            GenJournalLine."Journal Batch Name" := 'LOANS';
                                                            GenJournalLine."Line No." := LineNo;
                                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                                            GenJournalLine."Account No." := LoanApps."Account No";

                                                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                                            GenJournalLine."Bal. Account No." := LoanType."Top Up Commision Account";
                                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                                            GenJournalLine."Document No." := "Loan  No.";
                                                            GenJournalLine."Posting Date" := "Posting Date";
                                                            GenJournalLine.Description := 'Commision on Loan Top Up';
                                                            TopUpComm := (LoanTopUp."Principle Top Up") * (LoanType."Top Up Commision" / 100);
                                                            TotalTopupComm := TotalTopupComm + TopUpComm;
                                                            GenJournalLine.Amount := TopUpComm * -1;
                                                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;

                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                            if GenJournalLine.Amount <> 0 then
                                                                GenJournalLine.Insert;

                                                        end;
                                                    end;
                                                until LoanTopUp.Next = 0;
                                            end;
                                        end;
                                    end;

                                    BatchTopUpAmount := BatchTopUpAmount + LoanApps."Top Up Amount";
                                    BatchTopUpComm := BatchTopUpComm + TotalTopupComm;
                                until LoanApps.Next = 0;
                            end;

                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := LoanApps."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := "Loan  No.";
                            GenJournalLine."External Document No." := "ID NO";
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine.Description := 'Principal Amount';
                            GenJournalLine.Amount := (LoanApps."Approved Amount") * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                        end;



                        if "Mode of Disbursement" = "mode of disbursement"::Cheque then begin

                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                            GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                            GenJournalLine.DeleteAll;


                            GenSetUp.Get();

                            DActivity := 'BOSA';
                            DBranch := '';//PKKS'NAIROBI';
                            LoanApps.Reset;
                            LoanApps.SetRange(LoanApps."Loan  No.", "Loan  No.");
                            LoanApps.SetRange(LoanApps."System Created", false);
                            LoanApps.SetFilter(LoanApps."Loan Status", '<>Rejected');
                            if LoanApps.Find('-') then begin
                                repeat
                                    LoanApps.CalcFields(LoanApps."Special Loan Amount");



                                    DActivity := '';
                                    DBranch := '';
                                    if Vend.Get(LoanApps."Client Code") then begin
                                        DActivity := Vend."Global Dimension 1 Code";
                                        DBranch := Vend."Global Dimension 2 Code";
                                    end;



                                    LoanDisbAmount := LoanApps."Approved Amount";

                                    if (LoanApps."Special Loan Amount" > 0) and (LoanApps."Bridging Loan Posted" = false) then
                                        Error('Bridging Loans must be posted before the loans are disbursed. ' + LoanApps."Loan  No.");

                                    TCharges := 0;
                                    TopUpComm := 0;
                                    TotalTopupComm := 0;


                                    if LoanApps."Loan Status" <> LoanApps."loan status"::Approved then
                                        Error('Loan status must be Approved for you to post Loan. - ' + LoanApps."Loan  No.");

                                    if LoanApps.Posted = true then
                                        Error('Loan has already been posted. - ' + LoanApps."Loan  No.");


                                    LoanApps.CalcFields(LoanApps."Top Up Amount");


                                    RunningDate := "Posting Date";


                                    //Generate and post Approved Loan Amount
                                    if not GenBatch.Get('PAYMENTS', 'LOANS') then begin
                                        GenBatch.Init;
                                        GenBatch."Journal Template Name" := 'PAYMENTS';
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
                                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                            GenJournalLine."Journal Batch Name" := 'LOANS';
                                            GenJournalLine."Line No." := LineNo;
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                            GenJournalLine."Account No." := PCharges."G/L Account";
                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                            GenJournalLine."Document No." := "Loan  No.";
                                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                            GenJournalLine."Posting Date" := "Posting Date";
                                            GenJournalLine.Description := PCharges.Description;
                                            if PCharges."Use Perc" = true then begin
                                                GenJournalLine.Amount := (LoanDisbAmount * PCharges.Percentage / 100) * -1;
                                            end else begin
                                                GenJournalLine.Amount := PCharges.Amount * -1;

                                            end;


                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            //Don't top up charges on principle
                                            //Don't top up charges on principle
                                            GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                            if GenJournalLine.Amount <> 0 then
                                                GenJournalLine.Insert;

                                            TCharges := TCharges + (GenJournalLine.Amount * -1);


                                        until PCharges.Next = 0;
                                    end;




                                    //Don't top up charges on principle
                                    TCharges := 0;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                    GenJournalLine."Account No." := "Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := "Loan  No.";
                                    GenJournalLine."External Document No." := "ID NO";
                                    GenJournalLine."Posting Date" := "Posting Date";
                                    GenJournalLine.Description := 'Principal Amount';
                                    GenJournalLine.Amount := LoanDisbAmount + TCharges;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;




                                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                                        if LoanApps."Top Up Amount" > 0 then begin
                                            LoanTopUp.Reset;
                                            LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                                            if LoanTopUp.Find('-') then begin
                                                repeat
                                                    //Principle
                                                    LineNo := LineNo + 10000;
                                                    GenJournalLine.Init;
                                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                                    GenJournalLine."Line No." := LineNo;
                                                    GenJournalLine."Document No." := "Loan  No.";
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
                                                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                    GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                    // GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                                    //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                    if GenJournalLine.Amount <> 0 then
                                                        GenJournalLine.Insert;


                                                    //Interest (Reversed if top up)
                                                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                                                        LineNo := LineNo + 10000;
                                                        GenJournalLine.Init;
                                                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                        GenJournalLine."Journal Batch Name" := 'LOANS';
                                                        GenJournalLine."Line No." := LineNo;
                                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                                        GenJournalLine."Account No." := LoanApps."Client Code";
                                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                                        GenJournalLine."Document No." := "Loan  No.";
                                                        GenJournalLine."Posting Date" := "Posting Date";
                                                        GenJournalLine.Description := 'Interestpaid ' + LoanApps."Loan  No.";
                                                        GenJournalLine.Amount := -LoanTopUp."Interest Top Up";
                                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                                        //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                                                        //GenJournalLine."Bal. Account No.":=LoanType."Receivable Interest Account";
                                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Insurance Contribution";
                                                        GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                        GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                        if GenJournalLine.Amount <> 0 then
                                                            GenJournalLine.Insert;


                                                    end;

                                                    //Commision
                                                    if LoanType.Get(LoanApps."Loan Product Type") then begin
                                                        if LoanType."Top Up Commision" > 0 then begin
                                                            LineNo := LineNo + 10000;
                                                            GenJournalLine.Init;
                                                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                                            GenJournalLine."Journal Batch Name" := 'LOANS';
                                                            GenJournalLine."Line No." := LineNo;
                                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                                            GenJournalLine."Account No." := LoanType."Top Up Commision Account";
                                                            GenJournalLine.Validate(GenJournalLine."Account No.");
                                                            GenJournalLine."Document No." := "Loan  No.";
                                                            GenJournalLine."Posting Date" := "Posting Date";
                                                            GenJournalLine.Description := 'Commision on Loan Top Up';
                                                            TopUpComm := (LoanTopUp."Principle Top Up") * (LoanType."Top Up Commision" / 100);
                                                            TotalTopupComm := TotalTopupComm + TopUpComm;
                                                            GenJournalLine.Amount := TopUpComm * -1;
                                                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                                            GenJournalLine.Validate(GenJournalLine.Amount);
                                                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                                                            //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                                            //GenJournalLine."Bal. Account No.":=LoanApps."Account No";

                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                                            if GenJournalLine.Amount <> 0 then
                                                                GenJournalLine.Insert;

                                                        end;
                                                    end;
                                                until LoanTopUp.Next = 0;
                                            end;
                                        end;
                                    end;

                                    BatchTopUpAmount := BatchTopUpAmount + LoanApps."Top Up Amount";
                                    BatchTopUpComm := BatchTopUpComm + TotalTopupComm;
                                until LoanApps.Next = 0;
                            end;

                            LineNo := LineNo + 10000;
                            /*Disbursement.RESET;
                            Disbursement.SETRANGE(Disbursement."Loan Number","Loan  No.");
                            Disbursement.SETRANGE(Disbursement."Disbursement Date","Loan Disbursement Date");
                            IF Disbursement.FIND('-') THEN BEGIN
                            REPEAT
                            Disbursement.Posted:=TRUE;
                            Disbursement.MODIFY;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=Disbursement."Disbursement Account Type";
                            GenJournalLine."Account No.":=Disbursement."Disbursement Account No.";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."External Document No.":="ID NO";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Principal Amount';
                            GenJournalLine.Amount:=((LoanApps."Approved Amount")-(BatchTopUpAmount+BatchTopUpComm+TCharges))*-1;
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.INSERT;
                            UNTIL Disbursement.NEXT=0;
                            END;*/
                        end;



                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;

                        //Post New

                        Posted := true;
                        Modify;



                        Message('Loan posted successfully.');

                        //Post

                        //LoanAppPermisions()
                        //CurrForm.EDITABLE:=TRUE;
                        //end;

                    end;
                }
                separator(Action4)
                {
                }
                action("Reset Loan Application")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            "Client Code" := '';
                            "Client Name" := '';
                            "ID NO" := '';
                            "Staff No" := '';
                            Installments := 0;
                            Interest := 0;
                            "Requested Amount" := 0;
                            "Approved Amount" := 0;
                        end;
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

                        DocumentType := Documenttype::Loan;
                        ApprovalEntries.Setfilters(Database::"Control-Information", DocumentType, "Loan  No.");
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
                        ApprovalMgt: Codeunit WorkflowIntegration;
                    begin
                        if "Approved Amount" = 0 then Error('Kindly upraise your loan application before sending approval request');

                        LoansRec.Reset;
                        //LoansRec.SETRANGE(LoansRec."Client Code","Client Code");
                        LoansRec.SetRange(LoansRec."BOSA No", "BOSA No");
                        LoansRec.SetRange(LoansRec."Loan Product Type", "Loan Product Type");
                        if LoansRec.Find('-') then begin
                            repeat
                                LoansRec.CalcFields(LoansRec."Outstanding Balance");
                                if LoansRec."Outstanding Balance" > 1 then begin
                                    Error('The Member has an exsiting loan of the same product');
                                end;
                            until LoansRec.Next = 0;
                        end;

                        TestField("Loan Product Type");



                        if "Approval Status" <> "approval status"::Open then
                            Error(Text001);

                        //End allocate batch number
                        Doc_Type := Doc_type::Loan;
                        Table_id := Database::"Loans Register";
                        //IF Approvalmgt.SendApproval(Table_id,"No.",Doc_Type,Status)THEN;

                        /*IF ApprovalsMgmt.IsLoanLoanApplicationApprovalsWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnSendStandingOrderForApproval(Rec);
                         "Approval Status":="Approval Status"::Pending;
                         "Loan Status":="Loan Status"::Appraisal;
                          MODIFY;
                          */

                        TestField("Requested Amount");

                        //ENSURE THAT REQUESTED AMOUNT IS ENTERED
                        TestField("Requested Amount");
                        //SMS MESSAGE

                        SMSMessages.Reset;
                        if SMSMessages.Find('+') then begin
                            iEntryNo := SMSMessages."Entry No";
                            iEntryNo := iEntryNo + 1;
                        end
                        else begin
                            iEntryNo := 1;
                        end;

                        SMSMessages.Reset;
                        SMSMessages.Init;
                        SMSMessages."Entry No" := iEntryNo;
                        SMSMessages."Account No" := "Client Code";
                        SMSMessages."Date Entered" := Today;
                        SMSMessages."Time Entered" := Time;
                        SMSMessages.Source := 'LOAN APPL';
                        SMSMessages."Entered By" := UserId;
                        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
                        SMSMessages."SMS Message" := 'Your loan application of KSHs.' + Format("Requested Amount") +
                                                  ' has been received. Ollin SACCO LTD.';
                        Vend.Reset;
                        if Vend.Get("Client Code") then
                            SMSMessages."Telephone No" := Vend."Phone No.";

                        SMSMessages.Insert;

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
                        ApprovalMgt: Codeunit WorkflowIntegration;
                    begin
                        // ApprovalMgt.SendLoanApprRequest(Rec);
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
        UpdateControl();
    end;

    trigger OnAfterGetRecord()
    begin
        Source := Source::FOSA;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Source := Source::FOSA;
        "Mode of Disbursement" := "mode of disbursement"::"Bank Transfer";
        Discard := Discard::"1"
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        if "Loan Status" = "loan status"::Approved then
            CurrPage.Editable := false;
    end;

    trigger OnOpenPage()
    begin
        SetRange(Posted, false);
    end;

    var
        i: Integer;
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        RunningDate: Date;
        G: Integer;
        LoanGuar: Record "Loan GuarantorsFOSA";
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        Vend1: Record Vendor;
        InstalmentEnddate: Date;
        SMSMessage: Record "SMS Messages";
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        SMSMessages: Record "SMS Messages";
        NoOfGracePeriod: Integer;
        iEntryNo: Integer;
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
        LoanG: Record "Loans Register";
        SpecialComm: Decimal;
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "File Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BridgedLoans: Record "Loan Offset Details";
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
        LBatches: Record "Loan Disburesment-Batching";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loan GuarantorsFOSA";
        Text001: label 'Status Must Be Open';
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
        Interrest: Boolean;
        InterestSal: Decimal;
        EndMonth: Date;
        RemainingDays: Integer;
        PrincipalRepay: Decimal;
        InterestRepay: Decimal;
        TMonthDays: Integer;
        ReceiptAllocations: Record "HISA Allocation";
        ReceiptAllocation: Record "HISA Allocation";
        ApprovalEntry: Record "Approval Entry";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening","Member Closure",Loan;
        ApprovalsMgmt: Codeunit WorkflowIntegration;
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
        GrossPay: Decimal;
        FOSASet: Record "FOSA Guarantors Setup";
        MinGNo: Integer;
        ProvidedGuarantors: Integer;
        LoansRec: Record "Loans Register";


    procedure UpdateControl()
    begin
        if "Loan Status" = "loan status"::Application then begin
            MNoEditable := true;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := true;
            InstallmentEditable := true;
            Interrest := false;
            AppliedAmountEditable := true;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := true;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
        end;

        if "Loan Status" = "loan status"::Appraisal then begin
            MNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            Interrest := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
        end;

        if "Loan Status" = "loan status"::Rejected then begin
            MNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            Interrest := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := false;
            DisbursementDateEditable := false;
        end;

        if "Loan Status" = "loan status"::Approved then begin
            MNoEditable := false;
            LoanStatusEditable := false;
            ApplcDateEditable := false;
            Interrest := false;
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
        end;
    end;


    procedure LoanAppPermisions()
    begin
    end;
}

