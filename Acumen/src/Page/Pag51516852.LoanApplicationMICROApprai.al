#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516852 "Loan Application MICRO(Apprai)"
{
    // 
    // {GSetUp.GET();
    // 
    // TESTFIELD("Account No");
    // 
    // //Check if a Member has withstanding withdrawal application
    // 
    // 
    // 
    // SalDetails.RESET;
    // SalDetails.SETRANGE(SalDetails."Loan No","Loan  No.");
    // IF SalDetails.FIND('-')=FALSE THEN BEGIN
    // ERROR('Please Insert Loan Appraisal Details Information');
    // END;
    // 
    // Prof.RESET;
    // Prof.SETRANGE(Prof."Loan No.","Loan  No.");
    // Prof.SETRANGE(Prof."Client Code","Client Code");
    // IF Prof.FIND('-')=FALSE THEN BEGIN
    // ERROR('Please Insert Profitability Information');
    // END;
    // 
    // //***Check Appraisal Details
    // AppExp.RESET;
    // AppExp.SETRANGE(AppExp.Loan,"Loan  No.");
    // AppExp.SETRANGE(AppExp."Client Code","Client Code");
    // IF  AppExp.FIND('-')=FALSE THEN BEGIN
    // ERROR('Please Insert Appraisal Expense Detail');
    // END;
    // 
    // 
    // 
    // IF LoanType.GET("Loan Product Type") THEN BEGIN
    // IF LoanType."Appraise Guarantors" = TRUE THEN BEGIN
    // LGuarantors.RESET;
    // LGuarantors.SETRANGE(LGuarantors."Loan No","Loan  No.");
    // IF LGuarantors.FIND('-')=FALSE THEN BEGIN
    // ERROR('Please Insert Loan Applicant Guarantor Information');
    // END;
    // END;
    // END;
    // 
    // LoanSecurities.RESET;
    // LoanSecurities.SETRANGE(LoanSecurities."Loan No","Loan  No.");
    // IF LoanSecurities.FIND('-')= FALSE THEN BEGIN
    // ERROR(Text002);
    // END;
    // 
    // TotalSecurities:=0;
    // LnSecurities.RESET;
    // LnSecurities.SETRANGE(LnSecurities."Loan No","Loan  No.");
    // IF LnSecurities.FIND('-') THEN BEGIN
    // REPEAT
    // TotalSecurities:=TotalSecurities;
    // UNTIL LnSecurities.NEXT=0;
    // END;
    // 
    // IF TotalSecurities < "Approved Amount" THEN
    // ERROR(Text003);
    // 
    // 
    // 
    // TESTFIELD("Approved Amount");
    // TESTFIELD("Loan Product Type");
    // 
    // IF "Mode of Disbursement"<> "Mode of Disbursement"::"Bank Transfer" THEN
    //  ERROR('Mode of disbursement must be Bank Transfer');
    // 
    // {
    // LBatches.RESET;
    // LBatches.SETRANGE(LBatches."Loan  No.","Loan  No.");
    // IF LBatches.FIND('-') THEN BEGIN
    // IF LBatches."Approval Status"<>LBatches."Approval Status"::Open THEN
    // ERROR(Text001);
    // END;
    // }
    // 
    // LoanG.RESET;
    // LoanG.SETRANGE(LoanG."Loan No","Loan  No.");
    // IF LoanG.FIND('-') THEN BEGIN
    // IF LoanG.COUNT < GSetUp."Max Loan Guarantors BLoans" THEN
    //  ERROR(Text006);
    // END;
    // 
    // //===== Tier control
    // {
    // LoanApps.RESET;
    // LoanApps.SETFILTER(LoanApps.Source,'%1',LoanApps.Source::MICRO);
    // LoanApps.SETRANGE(LoanApps."Loan  No.","Loan  No.");
    // IF LoanApps.FIND('-') THEN BEGIN
    // 
    //   LoanTopUp.RESET;
    //   LoanTopUp.SETRANGE(LoanTopUp."Loan No.",LoanApps."Loan  No.");
    //   IF LoanTopUp.FIND('-') THEN BEGIN
    //    REPEAT
    //     IF LoanApp.GET(LoanTopUp."Loan Top Up") THEN BEGIN
    //      IF LoanApps."Loan Product Type" <> LoanApp."Loan Product Type"  THEN
    //       ERROR(Text007);
    //     END;
    //    UNTIL LoanTopUp.NEXT=0;
    //   END;
    // 
    // END;
    // 
    //   LoanTopUp.RESET;
    //   LoanTopUp.SETRANGE(LoanTopUp."Loan No.","Loan  No.");
    //   IF LoanTopUp.FIND('-') THEN BEGIN
    //    REPEAT
    //     IF LoanApp.GET(LoanTopUp."Loan Top Up") THEN BEGIN
    //      IF LoanApps."Loan Product Type" <> LoanApp."Loan Product Type"  THEN
    //       ERROR(Text007);
    //     END;
    //    UNTIL LoanTopUp.NEXT=0;
    //   END;
    // }
    // //=====  Tier control
    // 
    // 
    // //ApprovalMgt.SendBLoanApprRequest(Rec);
    // //ApprovalMgt.SendLoanApprRequest(Rec);
    // }

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where(Source = const(MICRO),
                            Posted = const(false),
                            "Loan Status" = const(Appraisal));

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
                field("Client Code"; "Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member';
                    Editable = MNoEditable;

                    trigger OnValidate()
                    begin
                        /*
                        Memb.RESET;
                        Memb.SETRANGE(Memb."No.","Client Code");
                        IF Memb."Customer Posting Group"<>'Micro' THEN
                        ERROR('This Member is NOT Registered under Business Loans');
                        */

                    end;
                }
                field("Client Name"; "Client Name")
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
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID NO"; "ID NO")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Group"; "Member Group")
                {
                    ApplicationArea = Basic;
                }
                field("Member Group Name"; "Member Group Name")
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
                }
                field("Group Shares"; "Group Shares")
                {
                    ApplicationArea = Basic;
                }
                field("Shares Balance"; "Shares Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Pension No"; "Pension No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
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
                    Enabled = false;
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
                field("Repayment Method"; "Repayment Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Principle Repayment"; "Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Interest Repayment"; "Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Repayment; Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Status"; "Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;

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
                    Visible = false;
                }
                field("Repayment Frequency"; "Repayment Frequency")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mode of Disbursement"; "Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = ModeofDisburesmentEdit;
                }
                field("Loan Disbursement Date"; "Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
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
                field(Source; Source)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
            }
            part(Control1000000014; "Loan Appraisal Salary Details")
            {
                Caption = 'Salary Details';
                SubPageLink = "Loan No" = field("Loan  No."),
                              "Client Code" = field("Client Code");
                Visible = false;
            }
            part(Control1000000013; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            part(Control1000000012; "Loan Collateral Security")
            {
                Caption = 'Other Securities';
                SubPageLink = "Loan No" = field("Loan  No.");
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
                action("Loan Application Form")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(51516896, true, false, LoanApp);
                        end;
                    end;
                }
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

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(51516452, true, false, LoanApp);
                        end;
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

                            //LoanAmount:=LoansR."Approved Amount";
                            LoanAmount := LoansR."Approved Amount" + LoansR."Capitalized Charges";
                            InterestRate := LoansR.Interest;
                            RepayPeriod := LoansR.Installments;
                            InitialInstal := LoansR.Installments + "Grace Period - Principle (M)";
                            //LBalance:=LoansR."Approved Amount";
                            LBalance := LoansR."Approved Amount" + LoansR."Capitalized Charges";
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
                                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 0.05, '>');
                                    //IF LBalance < Repayment THEN
                                    //LPrincipal:=LBalance
                                    //ELSE
                                    //LPrincipal:=Repayment;
                                    LInterest := Interest;
                                end;
                                //kma



                                //Grace Period
                                if GrPrinciple > 0 then begin
                                    LPrincipal := 0
                                end else begin
                                    //IF "Instalment Period" <> InPeriod THEN

                                    //LBalance:=LoanAmount;
                                    LBalance := LBalance - LPrincipal;


                                end;

                                if GrInterest > 0 then
                                    LInterest := 0;

                                GrPrinciple := GrPrinciple - 1;
                                GrInterest := GrInterest - 1;
                                //Grace Period


                                Evaluate(RepayCode, Format(InstalNo));


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
                            Report.Run(51516852, true, false, LoanApp);
                    end;
                }
                separator(Action1102755012)
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
                    Visible = false;
                }
                separator(Action1102760039)
                {
                }
                separator(Action1102755021)
                {
                }
                action("Post Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Loan';
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*IF Posted = TRUE THEN
                        ERROR('Loan already posted.');
                        
                        
                        "Loan Disbursement Date":=TODAY;
                        TESTFIELD("Loan Disbursement Date");
                        "Posting Date":="Loan Disbursement Date";
                        
                        
                        IF CONFIRM('Are you sure you want to post this loan?',TRUE) = FALSE THEN
                        EXIT;
                        
                        {//PRORATED DAYS
                        EndMonth:=CALCDATE('-1D',CALCDATE('1M',DMY2DATE(1,DATE2DMY("Posting Date",2),DATE2DMY("Posting Date",3))));
                        RemainingDays:=(EndMonth-"Posting Date")+1;
                        TMonthDays:=DATE2DMY(EndMonth,1);
                        //PRORATED DAYS
                        
                        }
                        IF "Mode of Disbursement"="Mode of Disbursement"::"Bank Transfer" THEN BEGIN
                        
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PAYMENTS');
                        GenJournalLine.SETRANGE("Journal Batch Name",'LOANS');
                        GenJournalLine.DELETEALL;
                        
                        
                        GenSetUp.GET();
                        
                        DActivity:='BOSA';
                        DBranch:='';//PKKS'NAIROBI';
                        LoanApps.RESET;
                        LoanApps.SETRANGE(LoanApps."Loan  No.","Loan  No.");
                        LoanApps.SETRANGE(LoanApps."System Created",FALSE);
                        LoanApps.SETFILTER(LoanApps."Loan Status",'<>Rejected');
                        IF LoanApps.FIND('-') THEN BEGIN
                        REPEAT
                        //LoanApps.CALCFIELDS(LoanApps."Bosa Loan Clearances");
                        DActivity:='';
                        DBranch:='';
                        IF Vend.GET(LoanApps."Client Code") THEN BEGIN
                        DActivity:=Vend."Global Dimension 1 Code";
                        DBranch:=Vend."Global Dimension 2 Code";
                        END;
                        
                        LoanDisbAmount:=LoanApps."Approved Amount";
                        
                        {IF (LoanApps."Bosa Loan Clearances" > 0) AND (LoanApps."Bridging Loan Posted" = FALSE) THEN
                        ERROR('Bridging Loans must be posted before the loans are disbursed. ' + LoanApps."Loan  No.");}
                        
                        TCharges:=0;
                        TopUpComm:=0;
                        TotalTopupComm:=0;
                        
                        
                        IF LoanApps."Loan Status"<>LoanApps."Loan Status"::Approved THEN
                        ERROR('Loan status must be Approved for you to post Loan. - ' + LoanApps."Loan  No.");
                        
                        IF LoanApps.Posted = TRUE THEN
                        ERROR('Loan has already been posted. - ' + LoanApps."Loan  No.");
                        
                        
                        LoanApps.CALCFIELDS(LoanApps."Top Up Amount");
                        
                        
                        RunningDate:="Posting Date";
                        
                        
                        //Generate and post Approved Loan Amount
                        IF NOT GenBatch.GET('PAYMENTS','LOANS') THEN
                        BEGIN
                        GenBatch.INIT;
                        GenBatch."Journal Template Name":='PAYMENTS';
                        GenBatch.Name:='LOANS';
                        GenBatch.INSERT;
                        END;
                        
                        PCharges.RESET;
                        PCharges.SETRANGE(PCharges.Code,LoanApps."Loan Product Type");
                        IF PCharges.FIND('-') THEN BEGIN
                        REPEAT
                            PCharges.TESTFIELD(PCharges."G/L Account");
                        
                            LineNo:=LineNo+10000;
                        
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                            GenJournalLine."Account No.":=PCharges."G/L Account";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:=PCharges.Description;
                            IF PCharges."Use Perc" = TRUE THEN BEGIN
                            GenJournalLine.Amount:=(LoanDisbAmount * PCharges.Percentage/100) * -1;
                            END  ELSE BEGIN
                            GenJournalLine.Amount:=PCharges.Amount * -1;
                        
                           END;
                        
                        
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            //Don't top up charges on principle
                            GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                            GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                            //Don't top up charges on principle
                            GenJournalLine."Loan No":=LoanApps."Loan  No.";
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.INSERT;
                        
                            TCharges:=TCharges+(GenJournalLine.Amount*-1);
                        
                        
                        UNTIL PCharges.NEXT = 0;
                        END;
                        
                        
                        
                        
                        //Don't top up charges on principle
                        TCharges:=0;
                        
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                        GenJournalLine."Account No.":="Client Code";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":="Loan  No.";
                        //GenJournalLine."External Document No.":="ID NO";
                        GenJournalLine."Posting Date":="Posting Date";
                        GenJournalLine.Description:='Principal Amount';
                        GenJournalLine.Amount:=LoanDisbAmount+ TCharges;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Loan;
                        GenJournalLine."Loan No":=LoanApps."Loan  No.";
                        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                        IF GenJournalLine.Amount<>0 THEN
                        GenJournalLine.INSERT;
                        
                        
                        
                        
                        IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                        IF LoanApps."Top Up Amount" > 0 THEN BEGIN
                        LoanTopUp.RESET;
                        LoanTopUp.SETRANGE(LoanTopUp."Loan No.",LoanApps."Loan  No.");
                        IF LoanTopUp.FIND('-') THEN BEGIN
                        REPEAT
                            //Principle
                            LineNo:=LineNo+10000;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                            GenJournalLine."Account No.":=LoanApps."Client Code";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            GenJournalLine.Description:='Off Set By - ' +LoanApps."Loan  No.";
                            GenJournalLine.Amount:=LoanTopUp."Principle Top Up" * -1;
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Repayment;
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                            //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.INSERT;
                            //Principle
                            LineNo:=LineNo+10000;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
                            GenJournalLine."Account No.":=LoanApps."Account No";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            GenJournalLine.Description:='Off Set By - ' +LoanApps."Loan  No.";
                            GenJournalLine.Amount:=LoanTopUp."Principle Top Up" ;
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Repayment;
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                            //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.INSERT;
                        
                        
                            //Interest (Reversed if top up)
                            IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                            LineNo:=LineNo+10000;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                            GenJournalLine."Account No.":=LoanApps."Client Code";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Interest paid ' + LoanApps."Loan  No.";
                            GenJournalLine.Amount:=-LoanTopUp."Interest Top Up";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Interest Paid";
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.INSERT;
                        
                        
                            END;
                            IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                            LineNo:=LineNo+10000;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Interest paid ' + LoanApps."Loan  No.";
                            GenJournalLine.Amount:=LoanTopUp."Interest Top Up";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
                            GenJournalLine."Account No.":=LoanApps."Account No";
                            GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Interest Paid";
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.INSERT;
                        
                        
                            END;
                        
                            //Commision
                            IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                            IF LoanType."Top Up Commision" > 0 THEN BEGIN
                            LineNo:=LineNo+10000;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
                            GenJournalLine."Account No.":=LoanApps."Account No";
                        
                            GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                            GenJournalLine."Bal. Account No.":=LoanType."Top Up Commision Account";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Commision on Loan Top Up';
                            TopUpComm:=(LoanTopUp."Principle Top Up") * (LoanType."Top Up Commision"/100);
                            TotalTopupComm:=TotalTopupComm+TopUpComm;
                            GenJournalLine.Amount:=TopUpComm*-1;
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.INSERT;
                        
                            END;
                            END;
                        UNTIL LoanTopUp.NEXT = 0;
                        END;
                        END;
                        END;
                        
                        BatchTopUpAmount:=BatchTopUpAmount+LoanApps."Top Up Amount";
                        BatchTopUpComm:=BatchTopUpComm+TotalTopupComm;
                        UNTIL LoanApps.NEXT = 0;
                        END;
                        
                        LineNo:=LineNo+10000;
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
                        GenJournalLine."Account No.":=LoanApps."Account No";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":="Loan  No.";
                        //GenJournalLine."External Document No.":="ID NO";
                        GenJournalLine."Posting Date":="Posting Date";
                        GenJournalLine.Description:='Principal Amount';
                        GenJournalLine.Amount:=(LoanApps."Approved Amount")*-1;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                        IF GenJournalLine.Amount<>0 THEN
                        GenJournalLine.INSERT;
                        END;
                        
                        
                        
                        IF "Mode of Disbursement"="Mode of Disbursement"::Cheque THEN BEGIN
                        
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PAYMENTS');
                        GenJournalLine.SETRANGE("Journal Batch Name",'LOANS');
                        GenJournalLine.DELETEALL;
                        
                        
                        GenSetUp.GET();
                        
                        DActivity:='BOSA';
                        DBranch:='';//PKKS'NAIROBI';
                        LoanApps.RESET;
                        LoanApps.SETRANGE(LoanApps."Loan  No.","Loan  No.");
                        LoanApps.SETRANGE(LoanApps."System Created",FALSE);
                        LoanApps.SETFILTER(LoanApps."Loan Status",'<>Rejected');
                        IF LoanApps.FIND('-') THEN BEGIN
                        REPEAT
                        //LoanApps.CALCFIELDS(LoanApps."Bosa Loan Clearances");
                        
                        
                        
                        DActivity:='';
                        DBranch:='';
                        IF Vend.GET(LoanApps."Client Code") THEN BEGIN
                        DActivity:=Vend."Global Dimension 1 Code";
                        DBranch:=Vend."Global Dimension 2 Code";
                        END;
                        
                        
                        
                        LoanDisbAmount:=LoanApps."Approved Amount";
                        
                        {IF (LoanApps."Bosa Loan Clearances" > 0) AND (LoanApps."Bridging Loan Posted" = FALSE) THEN
                        ERROR('Bridging Loans must be posted before the loans are disbursed. ' + LoanApps."Loan  No.");}
                        
                        TCharges:=0;
                        TopUpComm:=0;
                        TotalTopupComm:=0;
                        
                        
                        IF LoanApps."Loan Status"<>LoanApps."Loan Status"::Approved THEN
                        ERROR('Loan status must be Approved for you to post Loan. - ' + LoanApps."Loan  No.");
                        
                        IF LoanApps.Posted = TRUE THEN
                        ERROR('Loan has already been posted. - ' + LoanApps."Loan  No.");
                        
                        
                        LoanApps.CALCFIELDS(LoanApps."Top Up Amount");
                        
                        
                        RunningDate:="Posting Date";
                        
                        
                        //Generate and post Approved Loan Amount
                        IF NOT GenBatch.GET('PAYMENTS','LOANS') THEN
                        BEGIN
                        GenBatch.INIT;
                        GenBatch."Journal Template Name":='PAYMENTS';
                        GenBatch.Name:='LOANS';
                        GenBatch.INSERT;
                        END;
                        
                        PCharges.RESET;
                        PCharges.SETRANGE(PCharges.Code,LoanApps."Loan Product Type");
                        IF PCharges.FIND('-') THEN BEGIN
                        REPEAT
                            PCharges.TESTFIELD(PCharges."G/L Account");
                        
                            LineNo:=LineNo+10000;
                        
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                            GenJournalLine."Account No.":=PCharges."G/L Account";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:=PCharges.Description;
                            IF PCharges."Use Perc" = TRUE THEN BEGIN
                            GenJournalLine.Amount:=(LoanDisbAmount * PCharges.Percentage/100) * -1;
                            END  ELSE BEGIN
                            GenJournalLine.Amount:=PCharges.Amount * -1;
                        
                           END;
                        
                        
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            //Don't top up charges on principle
                            //Don't top up charges on principle
                            GenJournalLine."Loan No":=LoanApps."Loan  No.";
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.INSERT;
                        
                            TCharges:=TCharges+(GenJournalLine.Amount*-1);
                        
                        
                        UNTIL PCharges.NEXT = 0;
                        END;
                        
                        
                        
                        
                        //Don't top up charges on principle
                        TCharges:=0;
                        
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                        GenJournalLine."Account No.":="Client Code";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":="Loan  No.";
                        //GenJournalLine."External Document No.":="ID NO";
                        GenJournalLine."Posting Date":="Posting Date";
                        GenJournalLine.Description:='Principal Amount';
                        GenJournalLine.Amount:=LoanDisbAmount+ TCharges;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Loan;
                        GenJournalLine."Loan No":=LoanApps."Loan  No.";
                        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                        IF GenJournalLine.Amount<>0 THEN
                        GenJournalLine.INSERT;
                        
                        
                        
                        
                        IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                        IF LoanApps."Top Up Amount" > 0 THEN BEGIN
                        LoanTopUp.RESET;
                        LoanTopUp.SETRANGE(LoanTopUp."Loan No.",LoanApps."Loan  No.");
                        IF LoanTopUp.FIND('-') THEN BEGIN
                        REPEAT
                            //Principle
                            LineNo:=LineNo+10000;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                            GenJournalLine."Account No.":=LoanApps."Client Code";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            GenJournalLine.Description:='Off Set By - ' +LoanApps."Loan  No.";
                            GenJournalLine.Amount:=LoanTopUp."Principle Top Up" * -1;
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Repayment;
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                           // GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                            //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.INSERT;
                        
                        
                            //Interest (Reversed if top up)
                            IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                            LineNo:=LineNo+10000;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                            GenJournalLine."Account No.":=LoanApps."Client Code";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Interestpaid ' + LoanApps."Loan  No.";
                            GenJournalLine.Amount:=-LoanTopUp."Interest Top Up";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                            //GenJournalLine."Bal. Account No.":=LoanType."Receivable Interest Account";
                            GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Interest Paid";
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.INSERT;
                        
                        
                            END;
                        
                            //Commision
                            IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                            IF LoanType."Top Up Commision" > 0 THEN BEGIN
                            LineNo:=LineNo+10000;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                            GenJournalLine."Account No.":=LoanType."Top Up Commision Account";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Commision on Loan Top Up';
                            TopUpComm:=(LoanTopUp."Principle Top Up") * (LoanType."Top Up Commision"/100);
                            TotalTopupComm:=TotalTopupComm+TopUpComm;
                            GenJournalLine.Amount:=TopUpComm*-1;
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                            //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                        
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.INSERT;
                        
                            END;
                            END;
                        UNTIL LoanTopUp.NEXT = 0;
                        END;
                        END;
                        END;
                        
                        BatchTopUpAmount:=BatchTopUpAmount+LoanApps."Top Up Amount";
                        BatchTopUpComm:=BatchTopUpComm+TotalTopupComm;
                        UNTIL LoanApps.NEXT = 0;
                        END;
                        
                        LineNo:=LineNo+10000;
                        Disbursement.RESET;
                        Disbursement.SETRANGE(Disbursement."Loan Number","Loan  No.");
                        Disbursement.SETRANGE(Disbursement."Posting Date","Loan Disbursement Date");
                        IF Disbursement.FIND('-') THEN BEGIN
                        REPEAT
                        //Disbursement.posted:=TRUE;//mutinda
                        Disbursement.MODIFY;
                        GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        //GenJournalLine."Account Type":=Disbursement.disbusement";             //////////////////mutinda
                        //GenJournalLine."Account No.":=Disbursement."Disbursement Account No.";
                        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":="Loan  No.";
                        //GenJournalLine."External Document No.":="ID NO";
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
                        END;
                        END;
                        
                        
                        
                        //Post New
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PAYMENTS');
                        GenJournalLine.SETRANGE("Journal Batch Name",'LOANS');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJournalLine);
                        END;
                        
                        //Post New
                        
                        Posted:=TRUE;
                        MODIFY;
                        
                        
                        
                        MESSAGE('Loan posted successfully.');
                        
                        //Post
                        
                        LoanAppPermisions()
                        //CurrForm.EDITABLE:=TRUE;
                        //end;
                        */

                    end;
                }
                separator(Action1102755023)
                {
                }
                action(Securities)
                {
                    ApplicationArea = Basic;
                    Caption = 'Securities';
                    Image = AllLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Collateral Security";
                    RunPageLink = "Loan No" = field("Loan  No.");
                    Visible = true;
                }
                action("Salary Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary Appraisal';
                    Enabled = true;
                    Image = StatisticsGroup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Appraisal Salary Details";
                    RunPageLink = "Loan No" = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                    Visible = true;
                }
                action("Profitability Analysis")
                {
                    ApplicationArea = Basic;
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Profitability Analysis";
                    RunPageLink = "Client Code" = field("Client Code"),
                                  "Loan No." = field("Loan  No.");
                }
                action("Appraisal Expenses")
                {
                    ApplicationArea = Basic;
                    Image = ApplicationWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Appraisal Expense";
                    RunPageLink = Loan = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                }
                action(Guarantors)
                {
                    ApplicationArea = Basic;
                    Caption = 'Guarantors';
                    Image = ItemGroup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loans Guarantee Details";
                    RunPageLink = "Loan No" = field("Loan  No."),
                                  "Member Cell" = field(Discard);
                }
                separator(Action1102755001)
                {
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
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
                        ApprovalsMgmt: Codeunit WorkflowIntegration;
                    begin

                        if "Approved Amount" = 0 then Error('Loan Must Be Upraised before sending Approval');

                        TestField("Requested Amount");
                        //TESTFIELD("Recovery Mode");


                        if "Approval Status" <> "approval status"::Open then
                            Error(Text001);

                        //IF ApprovalsMgmt.CheckLoanApplicationApprovalsWorkflowEnabled(Rec) THEN
                        // ApprovalsMgmt.OnSendLoanApplicationForApproval(Rec);

                        GenSetUp.Get();

                        /*IF GenSetUp."Send Loan App SMS"=TRUE THEN BEGIN
                          FnSendReceivedApplicationSMS();
                          END;
                        IF GenSetUp."Send Loan App Email"=TRUE THEN BEGIN
                          FnSendReceivedLoanApplEmail("Loan  No.");
                          END;
                        
                        IF GenSetUp."Send Guarantorship SMS"=TRUE THEN BEGIN
                          FnSendGuarantorAppSMS("Loan  No.");
                          END;
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
                        ApprovalMgt: Codeunit WorkflowIntegration;
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
        UpdateControl();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        LnLoans.Reset;
        LnLoans.SetRange(LnLoans.Posted, false);
        LnLoans.SetRange(LnLoans."Approval Status", LnLoans."approval status"::Open);
        LnLoans.SetRange(LnLoans."Captured By", UserId);
        if LnLoans."Requested Amount" = 0 then begin
            if LnLoans.Count > 0 then begin
                //ERROR(Text008,LnLoans."Approval Status");
            end;
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Source := Source::MICRO;
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
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record "Loan Repayment Schedule";
        RSchedule: Record "Loan Repayment Schedule";
        GP: Text[30];
        CheckTiersEditable: Boolean;
        ReasonsEditable: Boolean;
        ScheduleCode: Code[20];
        PreviewShedule: Record "Loan Repayment Schedule";
        PeriodInterval: Code[10];
        LnLoans: Record "Loans Register";
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
        CustRec: Record "Loans Register";
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sacco General Set-Up";
        PCharges: Record "Loan Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Appraisal Salary Details";
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
        BridgedLoans: Record "Loans Register";
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
        Text001: label 'Status Must Be Open';
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer;
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
        Memb: Record Customer;
        LoanSecurities: Record "Loans Guarantee Details";
        Text002: label 'Please Insert Securities Details';
        LnSecurities: Record "Loans Guarantee Details";
        TotalSecurities: Decimal;
        Text003: label 'Collateral Value cannot be less than Applied Amount';
        Text004: label 'This Member has a Pending withdrawal application';
        AppSched: Integer;
        Text005: label 'This loan application is not appraised';
        GSetUp: Record "Sacco General Set-Up";
        Text006: label 'Number of guarantors less than minimum of 4';
        Text007: label 'You already have a similar running loan, please topup to proceed.';
        Text008: label 'There are still pending applications whose status is -%1, Please utilize them first';
        Prof: Record "Micro Profitability Analysis";
        AppExp: Record "Appraisal Expenses-Micro";
        compinfo: Record "Company Information";
        iEntryNo: Integer;
        LoanAppMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Mafanikio Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your Loan Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>MAFANIKIO SACCO LTD</b></p>';


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
            //WitnessEditable:=TRUE;
            //LoanPurposeEditable:=TRUE;
            //RecoveryModeEditable:=TRUE;
            //RemarksEditable:=TRUE;
            //LoanPurposeEditable:=TRUE;
            //CopyofIDEditable:=TRUE;
            //CopyofPayslipEditable:=TRUE;
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

        end;

        if "Approval Status" = "approval status"::Rejected then begin
            MNoEditable := false;
            //AccountNoEditable:=FALSE;
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

        end;

        if "Approval Status" = "approval status"::Approved then begin
            MNoEditable := false;
            //AccountNoEditable:=FALSE;
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

        end;
    end;


    procedure LoanAppPermisions()
    begin
    end;


    procedure FnSendReceivedApplicationSMS()
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
        SMSMessage."Document No" := "Loan  No.";
        SMSMessage."Account No" := "Account No";
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'LOANAPP';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member,Your Loan of amount ' + Format("Requested Amount") + ' for ' +
        "Client Code" + ' ' + "Client Name" + ' has been received and is being Processed '
        + compinfo.Name + ' ' + GenSetUp."Customer Care No";
        Cust.Reset;
        Cust.SetRange(Cust."No.", "Client Code");
        if Cust.Find('-') then begin
            SMSMessage."Telephone No" := Cust."Mobile Phone No";
        end;
        if Cust."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure FnSendReceivedLoanApplEmail(LoanNo: Code[20])
    var
        LoanRec: Record "Loans Register";
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        Email: Text[50];
    begin
        SMTPSetup.Get();

        LoanRec.Reset;
        LoanRec.SetRange(LoanRec."Loan  No.", LoanNo);
        if LoanRec.Find('-') then begin
            if Cust.Get(LoanRec."Client Code") then begin
                Email := Cust."E-Mail (Personal)";
            end;
            if Email = '' then begin
                Error('Email Address Missing for LoanRecer Application number' + '-' + LoanRec."Loan  No.");
            end;
            if Email <> '' then
                SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Email, 'Loan Application', '', true);
            SMTPMail.AppendBody(StrSubstNo(LoanAppMessage, LoanRec."Client Name", IDNo, UserId));
            SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AddAttachment(FileName, Attachment);
            SMTPMail.Send;
        end;
    end;

    local procedure FnSendGuarantorAppSMS(LoanNo: Code[20])
    var
        Cust: Record Customer;
        Sms: Record "SMS Messages";
    begin
        LGuarantors.Reset;
        LGuarantors.SetRange(LGuarantors."Loan No", "Loan  No.");
        if LGuarantors.FindFirst then begin
            repeat
                if Cust.Get(LGuarantors."Member No") then
                    if Cust."Mobile Phone No" <> '' then


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
                SMSMessage."Document No" := "Loan  No.";
                SMSMessage."Account No" := "Account No";
                SMSMessage."Date Entered" := Today;
                SMSMessage."Time Entered" := Time;
                SMSMessage.Source := 'GUARANTORSHIP';
                SMSMessage."Entered By" := UserId;
                SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                SMSMessage."SMS Message" := 'Dear Member,You have guaranteed ' + Format("Client Name")
                + ' ' + "Loan Product Type" + ' of KES. ' + Format("Approved Amount") + ',' + ' ' + 'Call,' + ' ' + compinfo."Phone No." + ',if in dispute .' + ' ' + compinfo.Name + ' ' + GenSetUp."Customer Care No";
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Client Code");
                if Cust.Find('-') then begin
                    SMSMessage."Telephone No" := Cust."Mobile Phone No";
                end;
                if Cust."Mobile Phone No" <> '' then
                    SMSMessage.Insert;

            until LGuarantors.Next = 0;
        end
    end;
}

