#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516459 "Loan Application Card(FOSA)"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where(Source = const(FOSA),
                            Posted = const(false));

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
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'FOSA Account No';
                    Editable = MNoEditable;
                    Enabled = false;
                    Style = Favorable;
                    StyleExpr = true;
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
                field("Type Of Loan Duration"; "Type Of Loan Duration")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Style = Unfavorable;
                    StyleExpr = true;
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
                field("Boost this Loan"; "Boost this Loan")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Boosted Amount"; "Boosted Amount")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Boosted Amount Interest"; "Boosted Amount Interest")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Boosting Commision"; "Boosting Commision")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
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
                    Enabled = false;
                }
                field(Repayment; Repayment)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Loan Principle Repayment"; "Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                    Caption = ' Principle Repayment';
                    Enabled = false;
                }
                field("Loan Interest Repayment"; "Loan Interest Repayment")
                {
                    ApplicationArea = Basic;
                    Caption = ' Interest Repayment';
                    Enabled = false;
                }
                field("Interest Upfront Amount"; "Interest Upfront Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Status"; "Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;

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
                field("Cashier Branch"; "Cashier Branch")
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
                field("Board Approval Status"; "Board Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Board Approved By"; "Board Approved By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Board Approval Comment"; "Board Approval Comment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field("Recovery Mode"; "Recovery Mode")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Salary Details")
            {
                Caption = 'Salary Details';
            }
            group(Earnings)
            {
                Caption = 'Earnings';
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
                field("Provident Fund"; "Provident Fund")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Non-Taxable Deductions")
            {
                Caption = 'Non-Taxable Deductions';
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
                field(Insurance; Insurance)
                {
                    ApplicationArea = Basic;
                    Caption = 'Insurance Relief';
                    Editable = true;
                }
            }
            group(Deductions)
            {
                Caption = 'Deductions';
                field("Chargeable Pay"; "Chargeable Pay")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(PAYE; PAYE)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(NSSF; NSSF)
                {
                    ApplicationArea = Basic;
                }
                field(NHIF; NHIF)
                {
                    ApplicationArea = Basic;
                }
                field("Staff Union Contribution"; "Staff Union Contribution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Union Dues';
                }
                field("Monthly Contribution"; "Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposits';
                }
                field("Risk MGT"; "Risk MGT")
                {
                    ApplicationArea = Basic;
                    Caption = 'Benevolent Fund';
                }
                field("Medical Insurance"; "Medical Insurance")
                {
                    ApplicationArea = Basic;
                }
                field("Life Insurance"; "Life Insurance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Gold Save / NIS';
                    Visible = false;
                }
                field("Provident Fund (Self)"; "Provident Fund (Self)")
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
                field(UtilizableAmount; "Utilizable Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Net Pay';
                }
                field("Existing Loan Repayments"; "Existing Loan Repayments")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(TotalDeductions; TotalDeductions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Deductions';
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                    Visible = false;
                }
                field("Total Deductions"; "Total Deductions")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Least Retained Amount"; "Least Retained Amount")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                    Visible = false;
                }
                field("Net take home 2"; "Net take home 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Net take Home';
                    Visible = false;
                }
                field("Bridge Amount Release"; "Bridge Amount Release")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cleared Loan Repayment';
                    Editable = false;
                }
                field("Utilizable Amount"; "Utilizable Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Net Utilizable Amount"; "Net Utilizable Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Net Utilizable Amount';
                    Enabled = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
            }
            part(Control3; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            part(Control1000000007; "Loan Guarantors FOSA")
            {
                Caption = 'Guarantors  Detail';
                SubPageLink = "Loan No" = field("Loan  No.");
                Visible = false;
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
                action("Reset Loan Application")
                {
                    ApplicationArea = Basic;
                    Image = RefreshExcise;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        LoanApp.SetFilter(Posted, 'No');
                        if LoanApp.Find('-') then begin
                            "Client Code" := '';
                            "Client Name" := '';
                            "ID NO" := '';
                            "Staff No" := '';
                            Installments := 0;
                            Interest := 0;
                            "Requested Amount" := 0;
                            "Approved Amount" := 0;
                            "Loan Status" := "loan status"::Application;
                            "Application Date" := Today;
                            "Loan Interest Repayment" := 0;
                            "Loan Principle Repayment" := 0;
                            "Loan Repayment" := 0;
                        end;
                    end;
                }
                action("Loan Application Form")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(51516913, true, false, LoanApp);
                        end;
                    end;
                }
                action("Move to Appraisal")
                {
                    ApplicationArea = Basic;
                    Image = Recalculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if "Notify Guarantor SMS" = false then
                            Error('Please %1 notify guarantors before you proceed', UserId);
                        if Confirm('Are you sure you want to move this Loan to Appraisal Stage ?', true) = false then
                            exit;
                        "Loan Status" := "loan status"::Appraisal;
                        Modify;
                    end;
                }
                action("Notify Guarantors")
                {
                    ApplicationArea = Basic;
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to notify Guarantors about this Loan ?', true) = false then
                            exit;
                        if "Notify Guarantor SMS" then begin
                            if Confirm('You have already notified Guarantors about this Loan.Do you want to send another SMS ?', true) = false then
                                exit;
                        end;
                        "Notify Guarantor SMS" := true;
                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", "Loan  No.");
                        if LoanGuar.Find('-') then begin
                            repeat
                                Cust.Reset;
                                Cust.SetRange(Cust."No.", LoanGuar."Account No.");
                                if Cust.Find('-') then begin
                                    SFactory.FnSendSMS('LOAN GUARANTORS', 'You have guaranteed ' + LoanGuar.Name + ' a ' + "Loan Product Type Name" + ' of ' + Format(LoanGuar."Amont Guaranteed")
                                   + '. Call 0705951672 if in dispute', Cust."FOSA Account No.", Cust."Phone No.");
                                end;
                            until LoanGuar.Next = 0;
                        end;
                        SFactory.FnSendSMS('LOAN APPRAISAL',
                       'Your loan application of KSHs.' + Format("Requested Amount") + ' has been received and your qualification is KSHs.' + Format("Approved Amount") + '. The application is being processed',
                       "Client Code", SFactory.FnGetPhoneNumber(Rec));
                        Modify;
                    end;
                }
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Enabled = true;
                    Image = GanttChart;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        TestField("Mode of Disbursement");
                        ProvidedGuarantors := 0;

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(51516384, true, false, LoanApp)
                            //REPORT.RUN(51516399,TRUE,FALSE,LoanApp)
                        end;
                    end;
                }
                action("Update PAYE")
                {
                    ApplicationArea = Basic;
                    Image = PayrollStatistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        /*GenSetUp.GET();
                        Nettakehome:="Gross Pay"*1/3;
                        MODIFY;
                        GrossPay:="Basic Pay H"+"Medical AllowanceH"+"House AllowanceH"+"Other Income"+"Transport/Bus Fare";
                        "Gross Pay":=GrossPay;
                        MODIFY;
                        
                        CALCFIELDS("Bridge Amount Release");
                        
                        "Utilizable Amount":=0;
                        NetUtilizable:=0;
                        
                        OTrelief:="Other Tax Relief";
                        "Chargeable Pay":="Gross Pay"-"Provident Fund"-"Pension Scheme";
                        IF Disabled<>TRUE THEN
                         BEGIN
                             Rec.PAYE:=SFactory.FnCalculatePaye("Chargeable Pay")-"Other Tax Relief";
                        END;
                        TotalDeductions:="Monthly Contribution"+NSSF+NHIF+PAYE+"Risk MGT"+"Staff Union Contribution"+"Medical Insurance"
                        +"Life Insurance"+"Other Liabilities"+"Other Loans Repayments"+"Sacco Deductions"+"Provident Fund (Self)"+"Existing Loan Repayments";
                        MESSAGE('Gross Salary is %1 # Total Deductions=%2 # 1/3 of Basic is %3',"Gross Pay",TotalDeductions,ROUND("Basic Pay H"/3,0.5,'<'));
                        "Utilizable Amount":=GrossPay-(TotalDeductions+"Basic Pay H"/3);
                        IF "Loan Product Type"<>'FOSALOAN' THEN
                          "Utilizable Amount":=GrossPay-TotalDeductions;
                        TotalDeductions:="Monthly Contribution"+NSSF+NHIF+PAYE+"Risk MGT"+"Staff Union Contribution"+"Medical Insurance"
                        +"Life Insurance"+"Other Liabilities"+"Other Loans Repayments"+"Sacco Deductions"+"Provident Fund (Self)"+"Existing Loan Repayments";
                        
                        
                        NetUtilizable:="Utilizable Amount"+"Bridge Amount Release"+"Non Payroll Payments";
                        "Net Utilizable Amount":=NetUtilizable;
                        IF LoanType.GET("Loan Product Type") THEN
                          BEGIN
                            IF "Loan Product Type"<>'FOSALOAN' THEN
                            "Net Utilizable Amount":=NetUtilizable*LoanType."Salary Appraisal Percentage"/100;
                          END;
                        "Total DeductionsH":=TotalDeductions;
                        "Total Deductions":=TotalDeductions;
                        "Net take Home":=Nettakehome;
                        MODIFY;
                        */
                        GenSetUp.Get();
                        Nettakehome := "Gross Pay";//*1/3; //Normally should be 1/3 of Basic
                        //MESSAGE('%1',Nettakehome);
                        /*IF GenSetUp."Minimum Take home"<>0 THEN BEGIN
                          Nettakehome:=GenSetUp."Minimum Take home";
                          END;*/
                        Modify;

                        /*
                        GrossPay:="Basic Pay H"+"Medical AllowanceH"+"House AllowanceH"+"Other Income"+"Transport/Bus Fare";
                        "Gross Pay":=GrossPay;
                        MODIFY;
                        
                        CALCFIELDS("Bridge Amount Release");
                        
                        "Utilizable Amount":=0;
                        NetUtilizable:=0;
                        
                        OTrelief:="Other Tax Relief";
                        "Chargeable Pay":="Gross Pay"-"Provident Fund"-"Pension Scheme";
                        IF Disabled<>TRUE THEN
                         BEGIN
                             Rec.PAYE:=SFactory.FnCalculatePaye("Chargeable Pay")-"Other Tax Relief";
                        END;
                        TotalDeductions:="Monthly Contribution"+NSSF+NHIF+PAYE+"Risk MGT"+"Staff Union Contribution"+"Medical Insurance"
                        +"Life Insurance"+"Other Liabilities"+"Other Loans Repayments"+"Sacco Deductions"+"Provident Fund (Self)"+"Existing Loan Repayments";
                        MESSAGE('Gross Salary is %1 # Total Deductions=%2 # 1/3 of Basic is %3',"Gross Pay",TotalDeductions,ROUND("Basic Pay H"/3,0.5,'<'));
                        "Utilizable Amount":=GrossPay-(TotalDeductions+"Basic Pay H"/3);
                        TotalDeductions:="Monthly Contribution"+NSSF+NHIF+PAYE+"Risk MGT"+"Staff Union Contribution"+"Medical Insurance"
                        +"Life Insurance"+"Other Liabilities"+"Other Loans Repayments"+"Sacco Deductions"+"Provident Fund (Self)"+"Existing Loan Repayments";
                        
                        
                        NetUtilizable:="Utilizable Amount"+"Bridge Amount Release"+"Non Payroll Payments";
                        "Net Utilizable Amount":=NetUtilizable;
                        "Total DeductionsH":=TotalDeductions;
                        "Net take Home":=Nettakehome;
                        MODIFY;
                        
                        IF "Loan Product Type" = 'EMERGENCY 6' THEN BEGIN
                        NetUtilizable:="Gross Pay"-TotalDeductions -5500;
                        "Utilizable Amount":=GrossPay-TotalDeductions - 5500;//"Utilizable Amount"+"Bridge Amount Release"+"Non Payroll Payments";
                        "Net Utilizable Amount":=NetUtilizable;
                        "Total DeductionsH":=TotalDeductions;
                        "Net take Home":=Nettakehome;
                        MODIFY;
                        END;
                        */

                        NetUtilizable := "Utilizable Amount" + "Bridge Amount Release" + "Non Payroll Payments";
                        "Net Utilizable Amount" := "Gross Pay";
                        "Total DeductionsH" := TotalDeductions;
                        "Net take Home" := "Gross Pay";
                        Modify;

                    end;
                }
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        /*IF "Repayment Frequency"="Repayment Frequency"::Daily THEN
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
                        
                        //LoanAmount:=LoansR."Approved Amount";
                        LoanAmount:=LoansR."Approved Amount"+LoansR."Capitalized Charges";
                        InterestRate:=LoansR.Interest;
                        RepayPeriod:=LoansR.Installments;
                        InitialInstal:=LoansR.Installments+"Grace Period - Principle (M)";
                        LBalance:=LoansR."Approved Amount";
                        RunDate:="Repayment Start Date";//"Loan Disbursement Date";
                        //RunDate:=CALCDATE('-1W',RunDate);
                        InstalNo:=0;
                        //EVALUATE(RepayInterval,'1W');
                        //EVALUATE(RepayInterval,InPeriod);
                        
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
                        //RunDate:=CALCDATE("Instalment Period",RunDate);
                        //RunDate:=CALCDATE('1W',RunDate);
                        
                        
                        //Repayment Frequency
                        IF "Repayment Frequency"="Repayment Frequency"::Daily THEN
                        RunDate:=CALCDATE('1D',RunDate)
                        ELSE IF "Repayment Frequency"="Repayment Frequency"::Weekly THEN
                        RunDate:=CALCDATE('1W',RunDate)
                        ELSE IF "Repayment Frequency"="Repayment Frequency"::Monthly THEN
                        RunDate:=CALCDATE('1M',RunDate)
                        ELSE IF "Repayment Frequency"="Repayment Frequency"::Quaterly THEN
                        RunDate:=CALCDATE('1Q',RunDate);
                        //Repayment Frequency
                        
                        //kma
                        IF "Repayment Method"="Repayment Method"::Amortised THEN BEGIN
                        TESTFIELD(Interest);
                        TESTFIELD(Installments);
                        TotalMRepay:=ROUND((InterestRate/12/100) / (1 - POWER((1 +(InterestRate/12/100)),- (RepayPeriod))) * (LoanAmount),0.05,'>');
                        LInterest:=ROUND(LBalance / 100 / 12 * InterestRate,0.05,'>');
                        LPrincipal:=TotalMRepay-LInterest;
                        END;
                        
                        IF "Repayment Method"="Repayment Method"::"Straight Line" THEN BEGIN
                        TESTFIELD(Interest);
                        TESTFIELD(Installments);
                        LPrincipal:=ROUND(LoanAmount/RepayPeriod,0.05,'>');
                        LInterest:=ROUND((InterestRate/1200)*LoanAmount,0.05,'>');
                        //Grace Period Interest
                        LInterest:=ROUND((LInterest*InitialInstal)/(InitialInstal-InitialGraceInt),0.05,'>');
                        END;
                        
                        IF "Repayment Method"="Repayment Method"::"Reducing Balance" THEN BEGIN
                        TESTFIELD(Interest);
                        TESTFIELD(Installments);
                        LPrincipal:=ROUND(LoanAmount/RepayPeriod,0.05,'>');
                        LInterest:=ROUND((InterestRate/12/100)*LBalance,0.05,'>');
                        END;
                        
                        IF "Repayment Method"="Repayment Method"::Constants THEN BEGIN
                        TESTFIELD(Repayment);
                        IF LBalance < Repayment THEN
                        LPrincipal:=LBalance
                        ELSE
                        LPrincipal:=Repayment;
                        LInterest:=Interest;
                        END;
                        //kma
                        
                        
                        
                        //Grace Period
                        IF GrPrinciple > 0 THEN BEGIN
                        LPrincipal:=0
                        END ELSE BEGIN
                        //IF "Instalment Period" <> InPeriod THEN
                        LBalance:=LBalance-LPrincipal;
                        
                        END;
                        
                        IF GrInterest > 0 THEN
                        LInterest:=0;
                        
                        GrPrinciple:=GrPrinciple-1;
                        GrInterest:=GrInterest-1;
                        //Grace Period
                         {
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
                         }
                        
                        EVALUATE(RepayCode,FORMAT(InstalNo));
                         {
                        WhichDay:=DATE2DWY(RunDate,1);
                        IF WhichDay=6 THEN
                         RunDate:=RunDate+2
                        ELSE IF WhichDay=7 THEN
                         RunDate:=RunDate+1;
                             }
                        //MESSAGE('which day is %1',WhichDay);
                        
                        
                        
                        RSchedule.INIT;
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
                        RSchedule.INSERT;
                        //WhichDay:=(DATE2DMY,RSchedule."Repayment Date",1);
                         WhichDay:=DATE2DWY(RSchedule."Repayment Date",1);
                        //MESSAGE('which day is %1',WhichDay);
                        //BEEP(2,10000);
                        UNTIL LBalance < 1
                        
                        END;
                        
                        COMMIT;
                        */
                        SFactory.FnGenerateRepaymentSchedule("Loan  No.");
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", "Loan  No.");
                        if LoanApp.Find('-') then
                            Report.Run(51516477, true, false, LoanApp);

                    end;
                }
                action("Loans Top Up")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Top Up';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Loan Offset Detail List";
                    RunPageLink = "Loan No." = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                }
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
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        if "Loan Product Type" <> 'FIXED ADV' then begin

                            /*
                            LoanGuar.RESET;
                            LoanGuar.SETRANGE("Loan No","Loan  No.");
                            IF NOT LoanGuar.FIND('-') THEN
                              ERROR('Please %1 enter the guarantor information for %2',USERID,"Client Code");
                              */
                        end;

                        if (("Approved Amount" <= 0) or ("Recommended Amount" <= 0)) then Error('Kindly upraise your loan application before sending approval request');

                        TestField("Loan Product Type");
                        TestField("Recovery Mode");
                        /*
                        LoanGuar.RESET;
                        LoanGuar.SETRANGE("Loan No","Loan  No.");
                        IF LoanGuar.FIND('-') THEN BEGIN
                          IF LoanType.GET("Loan Product Type") THEN BEGIN
                          IF LoanGuar.COUNT< LoanType."Min No. Of Guarantors" THEN
                            ERROR('You must capture atleast '+FORMAT(LoanType."Min No. Of Guarantors")+' for '+"Loan Product Type");
                          END;
                          END;
                        */

                        if "Approval Status" <> "approval status"::Open then
                            Error(Text001);

                        //End allocate batch number
                        Doc_Type := Doc_type::LoanApplication;
                        Table_id := Database::"Loans Register";

                        if ApprovalsMgmt.CheckLoanApplicationApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendLoanApplicationForApproval(Rec);

                        TestField("Requested Amount");
                        //ENSURE THAT REQUESTED AMOUNT IS ENTERED
                        TestField("Requested Amount");

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
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin

                        if ApprovalsMgmt.CheckLoanApplicationApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnCancelLoanApplicationApprovalRequest(Rec);
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
        UpdateControl();
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
        LoanGuar: Record "Loans Guarantee Details";
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
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
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
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
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        EditableAction: Boolean;
        SFactory: Codeunit "SURESTEP Factory.";


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

