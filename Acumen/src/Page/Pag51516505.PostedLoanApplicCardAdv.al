#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516505 "Posted Loan Applic Card Adv"
{
    DeleteAllowed = false;
    Editable = false;
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
                field("BOSA Deposits"; "BOSA Deposits")
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
                    Editable = Interrest;
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
                field("Bank Bridge Amount"; "Bank Bridge Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Recommended Amount"; "Recommended Amount")
                {
                    ApplicationArea = Basic;
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
                    Editable = true;
                    Visible = true;
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
                field("Loan Status"; "Loan Status")
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
                    Enabled = false;
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
                    Editable = true;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Recovery Mode"; "Recovery Mode")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1000000008; "Loan Appraisal Salary Details")
            {
                SubPageLink = "Loan No" = field("Loan  No."),
                              "Client Code" = field("Client Code");
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
                action("HISA Allocation")
                {
                    ApplicationArea = Basic;
                    RunObject = Page "HISA Allocation";
                    RunPageLink = "Document No" = field("Loan  No.");
                }
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Enabled = false;
                    Image = Aging;
                    Promoted = true;
                    PromotedCategory = "Report";
                }
                separator(Action11)
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
                        /*//IF Posted=TRUE THEN
                        //ERROR('Loan has been posted, Can only preview schedule');
                        
                        IF "Repayment Frequency"="Repayment Frequency"::Daily THEN
                        EVALUATE(InPeriod,'1D')
                        ELSE IF "Repayment Frequency"="Repayment Frequency"::Weekly THEN
                        EVALUATE(InPeriod,'1W')
                        ELSE IF "Repayment Frequency"="Repayment Frequency"::Monthly THEN
                        EVALUATE(InPeriod,'1M')
                        ELSE IF "Repayment Frequency"="Repayment Frequency"::Quaterly THEN
                        EVALUATE(InPeriod,'1Q');
                        
                        
                        QCounter:=0;
                        QCounter:=3;
                        //EVALUATE(InPeriod,'1D');
                        GrPrinciple:="Grace Period - Principle (M)";
                        GrInterest:="Grace Period - Interest (M)";
                        InitialGraceInt:="Grace Period - Interest (M)";
                        
                        LoansR.RESET;
                        LoansR.SETRANGE(LoansR."Loan  No.","Loan  No.");
                        IF LoansR.FIND('-') THEN BEGIN
                        
                        TESTFIELD("Loan Disbursement Date");
                        TESTFIELD("Repayment Start Date");
                        
                        RSchedule.RESET;
                        RSchedule.SETRANGE(RSchedule."Loan No.","Loan  No.");
                        RSchedule.DELETEALL;
                        
                        LoanAmount:=LoansR."Approved Amount";
                        InterestRate:=LoansR.Interest;
                        RepayPeriod:=LoansR.Installments;
                        InitialInstal:=LoansR.Installments+"Grace Period - Principle (M)";
                        LBalance:=LoansR."Approved Amount";
                        LNBalance:=LoansR."Outstanding Balance";
                        RunDate:="Repayment Start Date";
                        
                        InstalNo:=0;
                        EVALUATE(RepayInterval,'1W');
                        
                        //Repayment Frequency
                        IF "Repayment Frequency"="Repayment Frequency"::Daily THEN
                        RunDate:=CALCDATE('-1D',RunDate)
                        ELSE IF "Repayment Frequency"="Repayment Frequency"::Weekly THEN
                        RunDate:=CALCDATE('-1W',RunDate)
                        ELSE IF "Repayment Frequency"="Repayment Frequency"::Monthly THEN
                        RunDate:=CALCDATE('-1M',RunDate)
                        ELSE IF "Repayment Frequency"="Repayment Frequency"::Quaterly THEN
                        RunDate:=CALCDATE('-1Q',RunDate);
                        //Repayment Frequency
                        
                        
                        REPEAT
                        InstalNo:=InstalNo+1;
                        
                        
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
                            //TotalMRepay:=ROUND((InterestRate/12/100) / (1 - POWER((1 + (InterestRate/12/100)),- RepayPeriod)) * LoanAmount,1,'>');
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
                                LInterest := ROUND((InterestRate / 100) * LoanAmount, 1, '>');
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
                        RSchedule."Repayment Date" := RunDate;
                        RSchedule."Member No." := "Client Code";
                        RSchedule."Loan Category" := "Loan Product Type";
                        RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                        RSchedule."Monthly Interest" := LInterest;
                        RSchedule."Principal Repayment" := LPrincipal;
                        RSchedule.Insert;
                        WhichDay := Date2dwy(RSchedule."Repayment Date", 1);
                        LBalance < 1
                        
                        end;
                        Report                        ReportPage "HR Job Requirements";
                            RunPageLink = "Job ID"=                         CODEUNITCODEUNITPage "Approval Entries";
Codeunit WorkflowIntegrationCodeunit WorkflowIntegrationCodeunit "Gen. Jnl.-Post Line"Codeunit ""
