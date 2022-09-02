#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516392 "Loans Rejected Card"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Loans Register";
    SourceTableView = where("Loan Status"=const(Rejected));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
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
                    Caption = 'Member No';

                    trigger OnValidate()
                    begin
                          ClientCodeOnAfterValidate;
                    end;
                }
                field("Client Name";"Client Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Name';
                    Editable = false;
                }
                field("ID NO";"ID NO")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date";"Application Date")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                         TestField(Posted,false);
                    end;
                }
                field("Loan Product Type";"Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        TestField(Posted,false);
                        if "Loan Product Type"='BELA' then
                        "Loan Status":="loan status"::Approved;

                        if "Top Up Amount" = 0 then begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Client Code","Client Code");
                        LoanApp.SetRange(LoanApp."Loan Product Type","Loan Product Type");
                        LoanApp.SetRange(LoanApp.Posted,true);
                        if LoanApp.Find('-') then begin
                        repeat
                        LoanApp.CalcFields(LoanApp."Outstanding Balance");
                        if LoanApp."Outstanding Balance" > 0 then
                        if Confirm('Member has an oustanding similar loan product. Do you wish to continue?') = false then
                        "Loan Product Type" := '';
                        until LoanApp.Next = 0;
                        end;
                        end;
                    end;
                }
                field(Installments;Installments)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        TestField(Posted,false);
                    end;
                }
                field(Interest;Interest)
                {
                    ApplicationArea = Basic;
                }
                field("Rejection  Remark";"Rejection  Remark")
                {
                    ApplicationArea = Basic;
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

                    trigger OnValidate()
                    begin
                         TestField(Posted,false);
                    end;
                }
                field("Approved Amount";"Approved Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Amount';
                    Editable = true;

                    trigger OnValidate()
                    begin
                        TestField(Posted,false);
                    end;
                }
                field("Recommended Amount";"Recommended Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Purpose";"Loan Purpose")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks;Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("External EFT";"External EFT")
                {
                    ApplicationArea = Basic;
                }
                field("Captured By";"Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Repayment Method";"Repayment Method")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Repayment;Repayment)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status";"Loan Status")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
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
                }
                field("Outstanding Balance";"Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Top Up Amount";"Top Up Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Other Commitments Clearance";"Other Commitments Clearance")
                {
                    ApplicationArea = Basic;
                }
                field("Boosting Commision";"Boosting Commision")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Mode of Disbursement";"Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Disbursement Date";"Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No.";"Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("Bank code";"Bank code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name";"Bank Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank Branch";"Bank Branch")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Date of Completion";"Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Loan  No.","Loan  No.");
                        IF LoanApp.FIND('-') THEN BEGIN
                        REPORT.RUN(,TRUE,FALSE,LoanApp);
                        END;
                        END;
                        */

                    end;
                }
                separator(Action1102760046)
                {
                }
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
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
                        RunDate:="Repayment Start Date";//"Loan Disbursement Date";
                        //RunDate:=CALCDATE('-1W',RunDate);
                        InstalNo:=0;
                        //EVALUATE(RepayInterval,'1W');
                        //EVALUATE(RepayInterval,InPeriod);
                        
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
                        //RunDate:=CALCDATE("Instalment Period",RunDate);
                        //RunDate:=CALCDATE('1W',RunDate);
                        
                        
                        //Repayment Frequency
                        if "Repayment Frequency"="repayment frequency"::Daily then
                        RunDate:=CalcDate('1D',RunDate)
                        else if "Repayment Frequency"="repayment frequency"::Weekly then
                        RunDate:=CalcDate('1W',RunDate)
                        else if "Repayment Frequency"="repayment frequency"::Monthly then
                        RunDate:=CalcDate('1M',RunDate)
                        else if "Repayment Frequency"="repayment frequency"::Quaterly then
                        RunDate:=CalcDate('1Q',RunDate);
                        //Repayment Frequency
                        
                        //kma
                        if "Repayment Method"="repayment method"::Amortised then begin
                        TestField(Interest);
                        TestField(Installments);
                        TotalMRepay:=ROUND((InterestRate/12/100) / (1 - Power((1 +(InterestRate/12/100)),- (RepayPeriod))) * (LoanAmount),0.05,'>');
                        LInterest:=ROUND(LBalance / 100 / 12 * InterestRate,0.05,'>');
                        LPrincipal:=TotalMRepay-LInterest;
                        end;
                        
                        if "Repayment Method"="repayment method"::"Straight Line" then begin
                        TestField(Interest);
                        TestField(Installments);
                        LPrincipal:=ROUND(LoanAmount/RepayPeriod,0.05,'>');
                        LInterest:=ROUND((InterestRate/12/100)*LoanAmount,0.05,'>');
                        //Grace Period Interest
                        LInterest:=ROUND((LInterest*InitialInstal)/(InitialInstal-InitialGraceInt),0.05,'>');
                        end;
                        
                        if "Repayment Method"="repayment method"::"Reducing Balance" then begin
                        TestField(Interest);
                        TestField(Installments);
                        LPrincipal:=ROUND(LoanAmount/RepayPeriod,0.05,'>');
                        LInterest:=ROUND((InterestRate/12/100)*LBalance,0.05,'>');
                        end;
                        
                        if "Repayment Method"="repayment method"::Constants then begin
                        TestField(Repayment);
                        if LBalance < Repayment then
                        LPrincipal:=LBalance
                        else
                        LPrincipal:=Repayment;
                        LInterest:=Interest;
                        end;
                        //kma
                        
                        
                        
                        //Grace Period
                        if GrPrinciple > 0 then begin
                        LPrincipal:=0
                        end else begin
                        //IF "Instalment Period" <> InPeriod THEN
                        LBalance:=LBalance-LPrincipal;
                        
                        end;
                        
                        if GrInterest > 0 then
                        LInterest:=0;
                        
                        GrPrinciple:=GrPrinciple-1;
                        GrInterest:=GrInterest-1;
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
                        
                        Evaluate(RepayCode,Format(InstalNo));
                         /*
                        WhichDay:=DATE2DWY(RunDate,1);
                        IF WhichDay=6 THEN
                         RunDate:=RunDate+2
                        ELSE IF WhichDay=7 THEN
                         RunDate:=RunDate+1;
                        */
                        //MESSAGE('which day is %1',WhichDay);
                        
                        
                        
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
                        //WhichDay:=(DATE2DMY,RSchedule."Repayment Date",1);
                         WhichDay:=Date2dwy(RSchedule."Repayment Date",1);
                        //MESSAGE('which day is %1',WhichDay);
                        //BEEP(2,10000);
                        until LBalance < 1
                        
                        end;
                        
                        Commit;
                        /*
                        LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Loan  No.","Loan  No.");
                        IF LoanApp.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,LoanApp);
                        */

                    end;
                }
                separator(Action1102760048)
                {
                }
                action("Loans Top Up")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Top Up';
                    RunObject = Page "HR Job Requirements";
                    RunPageLink = "Job ID"=field("Loan  No."),
                                  "No of Posts"=field("Client Code");
                    Visible = false;
                }
                separator(Action1102760039)
                {
                }
                separator(Action1102755021)
                {
                }
                action(Action1102760062)
                {
                    ApplicationArea = Basic;
                    Caption = 'Mark As Posted';
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to mark this loan as posted?') = true then begin
                        Posted := true;
                        Modify;
                        end;
                    end;
                }
                action("Post Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Loan';
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Posted = true then
                        Error('Loan already posted.');
                        
                        
                        "Loan Disbursement Date":=Today;
                        TestField("Loan Disbursement Date");
                        "Posting Date":="Loan Disbursement Date";
                        
                        
                        if Confirm('Are you sure you want to post this loan?',true) = false then
                        exit;
                        
                        /*//PRORATED DAYS
                        EndMonth:=CALCDATE('-1D',CALCDATE('1M',DMY2DATE(1,DATE2DMY("Posting Date",2),DATE2DMY("Posting Date",3))));
                        RemainingDays:=(EndMonth-"Posting Date")+1;
                        TMonthDays:=DATE2DMY(EndMonth,1);
                        //PRORATED DAYS
                        
                        */
                        if "Mode of Disbursement"="mode of disbursement"::"Bank Transfer" then begin
                        
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'PAYMENTS');
                        GenJournalLine.SetRange("Journal Batch Name",'LOANS');
                        GenJournalLine.DeleteAll;
                        
                        
                        GenSetUp.Get();
                        
                        DActivity:='BOSA';
                        DBranch:='';//PKKS'NAIROBI';
                        LoanApps.Reset;
                        LoanApps.SetRange(LoanApps."Loan  No.","Loan  No.");
                        LoanApps.SetRange(LoanApps."System Created",false);
                        LoanApps.SetFilter(LoanApps."Loan Status",'<>Rejected');
                        if LoanApps.Find('-') then begin
                        repeat
                        LoanApps.CalcFields(LoanApps."Special Loan Amount");
                        DActivity:='';
                        DBranch:='';
                        if Vend.Get(LoanApps."Client Code") then begin
                        DActivity:=Vend."Global Dimension 1 Code";
                        DBranch:=Vend."Global Dimension 2 Code";
                        end;
                        
                        LoanDisbAmount:=LoanApps."Approved Amount";
                        
                        if (LoanApps."Special Loan Amount" > 0) and (LoanApps."Bridging Loan Posted" = false) then
                        Error('Bridging Loans must be posted before the loans are disbursed. ' + LoanApps."Loan  No.");
                        
                        TCharges:=0;
                        TopUpComm:=0;
                        TotalTopupComm:=0;
                        
                        
                        if LoanApps."Loan Status"<>LoanApps."loan status"::Approved then
                        Error('Loan status must be Approved for you to post Loan. - ' + LoanApps."Loan  No.");
                        
                        if LoanApps.Posted = true then
                        Error('Loan has already been posted. - ' + LoanApps."Loan  No.");
                        
                        
                        LoanApps.CalcFields(LoanApps."Top Up Amount");
                        
                        
                        RunningDate:="Posting Date";
                        
                        
                        //Generate and post Approved Loan Amount
                        if not GenBatch.Get('PAYMENTS','LOANS') then
                        begin
                        GenBatch.Init;
                        GenBatch."Journal Template Name":='PAYMENTS';
                        GenBatch.Name:='LOANS';
                        GenBatch.Insert;
                        end;
                        
                        PCharges.Reset;
                        PCharges.SetRange(PCharges."Product Code",LoanApps."Loan Product Type");
                        if PCharges.Find('-') then begin
                        repeat
                            PCharges.TestField(PCharges."G/L Account");
                        
                            LineNo:=LineNo+10000;
                        
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No.":=PCharges."G/L Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:=PCharges.Description;
                            if PCharges."Use Perc" = true then begin
                            GenJournalLine.Amount:=(LoanDisbAmount * PCharges.Percentage/100) * -1;
                            end  else begin
                            GenJournalLine.Amount:=PCharges.Amount * -1;
                        
                           end;
                        
                        
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            //Don't top up charges on principle
                            GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::Vendor;
                            GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                            //Don't top up charges on principle
                            GenJournalLine."Loan No":=LoanApps."Loan  No.";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                        
                            TCharges:=TCharges+(GenJournalLine.Amount*-1);
                        
                        
                        until PCharges.Next = 0;
                        end;
                        
                        
                        
                        
                        //Don't top up charges on principle
                        TCharges:=0;
                        
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
                        GenJournalLine."Account No.":="Client Code";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":="Loan  No.";
                        GenJournalLine."External Document No.":="ID NO";
                        GenJournalLine."Posting Date":="Posting Date";
                        GenJournalLine.Description:='Principal Amount';
                        GenJournalLine.Amount:=LoanDisbAmount+ TCharges;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Share Capital";
                        GenJournalLine."Loan No":=LoanApps."Loan  No.";
                        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        
                        
                        
                        if LoanType.Get(LoanApps."Loan Product Type") then begin
                        if LoanApps."Top Up Amount" > 0 then begin
                        LoanTopUp.Reset;
                        LoanTopUp.SetRange(LoanTopUp."Loan No.",LoanApps."Loan  No.");
                        if LoanTopUp.Find('-') then begin
                        repeat
                            //Principle
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
                            GenJournalLine."Account No.":=LoanApps."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description:='Off Set By - ' +LoanApps."Loan  No.";
                            GenJournalLine.Amount:=LoanTopUp."Principle Top Up" * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Interest Paid";
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                            //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                            //Principle
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No.":=LoanApps."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description:='Off Set By - ' +LoanApps."Loan  No.";
                            GenJournalLine.Amount:=LoanTopUp."Principle Top Up" ;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Interest Paid";
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                            //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                        
                        
                            //Interest (Reversed if top up)
                            if LoanType.Get(LoanApps."Loan Product Type") then begin
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
                            GenJournalLine."Account No.":=LoanApps."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Interest paid ' + LoanApps."Loan  No.";
                            GenJournalLine.Amount:=-LoanTopUp."Interest Top Up";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Insurance Contribution";
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                        
                        
                            end;
                            if LoanType.Get(LoanApps."Loan Product Type") then begin
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Interest paid ' + LoanApps."Loan  No.";
                            GenJournalLine.Amount:=LoanTopUp."Interest Top Up";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No.":=LoanApps."Account No";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Insurance Contribution";
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                        
                        
                            end;
                        
                            //Commision
                            if LoanType.Get(LoanApps."Loan Product Type") then begin
                            if LoanType."Top Up Commision" > 0 then begin
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No.":=LoanApps."Account No";
                        
                            GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No.":=LoanType."Top Up Commision Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Commision on Loan Top Up';
                            TopUpComm:=(LoanTopUp."Principle Top Up") * (LoanType."Top Up Commision"/100);
                            TotalTopupComm:=TotalTopupComm+TopUpComm;
                            GenJournalLine.Amount:=TopUpComm*-1;
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                        
                            end;
                            end;
                        until LoanTopUp.Next = 0;
                        end;
                        end;
                        end;
                        
                        BatchTopUpAmount:=BatchTopUpAmount+LoanApps."Top Up Amount";
                        BatchTopUpComm:=BatchTopUpComm+TotalTopupComm;
                        until LoanApps.Next = 0;
                        end;
                        
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=LoanApps."Account No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":="Loan  No.";
                        GenJournalLine."External Document No.":="ID NO";
                        GenJournalLine."Posting Date":="Posting Date";
                        GenJournalLine.Description:='Principal Amount';
                        GenJournalLine.Amount:=(LoanApps."Approved Amount")*-1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        end;
                        
                        
                        
                        if "Mode of Disbursement"="mode of disbursement"::Cheque then begin
                        
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'PAYMENTS');
                        GenJournalLine.SetRange("Journal Batch Name",'LOANS');
                        GenJournalLine.DeleteAll;
                        
                        
                        GenSetUp.Get();
                        
                        DActivity:='BOSA';
                        DBranch:='';//PKKS'NAIROBI';
                        LoanApps.Reset;
                        LoanApps.SetRange(LoanApps."Loan  No.","Loan  No.");
                        LoanApps.SetRange(LoanApps."System Created",false);
                        LoanApps.SetFilter(LoanApps."Loan Status",'<>Rejected');
                        if LoanApps.Find('-') then begin
                        repeat
                        LoanApps.CalcFields(LoanApps."Special Loan Amount");
                        
                        
                        
                        DActivity:='';
                        DBranch:='';
                        if Vend.Get(LoanApps."Client Code") then begin
                        DActivity:=Vend."Global Dimension 1 Code";
                        DBranch:=Vend."Global Dimension 2 Code";
                        end;
                        
                        
                        
                        LoanDisbAmount:=LoanApps."Approved Amount";
                        
                        if (LoanApps."Special Loan Amount" > 0) and (LoanApps."Bridging Loan Posted" = false) then
                        Error('Bridging Loans must be posted before the loans are disbursed. ' + LoanApps."Loan  No.");
                        
                        TCharges:=0;
                        TopUpComm:=0;
                        TotalTopupComm:=0;
                        
                        
                        if LoanApps."Loan Status"<>LoanApps."loan status"::Approved then
                        Error('Loan status must be Approved for you to post Loan. - ' + LoanApps."Loan  No.");
                        
                        if LoanApps.Posted = true then
                        Error('Loan has already been posted. - ' + LoanApps."Loan  No.");
                        
                        
                        LoanApps.CalcFields(LoanApps."Top Up Amount");
                        
                        
                        RunningDate:="Posting Date";
                        
                        
                        //Generate and post Approved Loan Amount
                        if not GenBatch.Get('PAYMENTS','LOANS') then
                        begin
                        GenBatch.Init;
                        GenBatch."Journal Template Name":='PAYMENTS';
                        GenBatch.Name:='LOANS';
                        GenBatch.Insert;
                        end;
                        
                        PCharges.Reset;
                        PCharges.SetRange(PCharges."Product Code",LoanApps."Loan Product Type");
                        if PCharges.Find('-') then begin
                        repeat
                            PCharges.TestField(PCharges."G/L Account");
                        
                            LineNo:=LineNo+10000;
                        
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No.":=PCharges."G/L Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:=PCharges.Description;
                            if PCharges."Use Perc" = true then begin
                            GenJournalLine.Amount:=(LoanDisbAmount * PCharges.Percentage/100) * -1;
                            end  else begin
                            GenJournalLine.Amount:=PCharges.Amount * -1;
                        
                           end;
                        
                        
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            //Don't top up charges on principle
                            //Don't top up charges on principle
                            GenJournalLine."Loan No":=LoanApps."Loan  No.";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                        
                            TCharges:=TCharges+(GenJournalLine.Amount*-1);
                        
                        
                        until PCharges.Next = 0;
                        end;
                        
                        
                        
                        
                        //Don't top up charges on principle
                        TCharges:=0;
                        
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
                        GenJournalLine."Account No.":="Client Code";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":="Loan  No.";
                        GenJournalLine."External Document No.":="ID NO";
                        GenJournalLine."Posting Date":="Posting Date";
                        GenJournalLine.Description:='Principal Amount';
                        GenJournalLine.Amount:=LoanDisbAmount+ TCharges;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Share Capital";
                        GenJournalLine."Loan No":=LoanApps."Loan  No.";
                        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        
                        
                        
                        if LoanType.Get(LoanApps."Loan Product Type") then begin
                        if LoanApps."Top Up Amount" > 0 then begin
                        LoanTopUp.Reset;
                        LoanTopUp.SetRange(LoanTopUp."Loan No.",LoanApps."Loan  No.");
                        if LoanTopUp.Find('-') then begin
                        repeat
                            //Principle
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
                            GenJournalLine."Account No.":=LoanApps."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description:='Off Set By - ' +LoanApps."Loan  No.";
                            GenJournalLine.Amount:=LoanTopUp."Principle Top Up" * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Interest Paid";
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                           // GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                            //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                        
                        
                            //Interest (Reversed if top up)
                            if LoanType.Get(LoanApps."Loan Product Type") then begin
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
                            GenJournalLine."Account No.":=LoanApps."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Interestpaid ' + LoanApps."Loan  No.";
                            GenJournalLine.Amount:=-LoanTopUp."Interest Top Up";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                            //GenJournalLine."Bal. Account No.":=LoanType."Receivable Interest Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Insurance Contribution";
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                        
                        
                            end;
                        
                            //Commision
                            if LoanType.Get(LoanApps."Loan Product Type") then begin
                            if LoanType."Top Up Commision" > 0 then begin
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No.":=LoanType."Top Up Commision Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Loan  No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Commision on Loan Top Up';
                            TopUpComm:=(LoanTopUp."Principle Top Up") * (LoanType."Top Up Commision"/100);
                            TotalTopupComm:=TotalTopupComm+TopUpComm;
                            GenJournalLine.Amount:=TopUpComm*-1;
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                            //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                        
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                        
                            end;
                            end;
                        until LoanTopUp.Next = 0;
                        end;
                        end;
                        end;
                        
                        BatchTopUpAmount:=BatchTopUpAmount+LoanApps."Top Up Amount";
                        BatchTopUpComm:=BatchTopUpComm+TotalTopupComm;
                        until LoanApps.Next = 0;
                        end;
                        
                        LineNo:=LineNo+10000;
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
                        
                        
                        /*
                        //Post New
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PAYMENTS');
                        GenJournalLine.SETRANGE("Journal Batch Name",'LOANS');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                        END;
                        */
                        //Post New
                        
                        Posted:=true;
                        Modify;
                        
                        
                        
                        Message('Loan posted successfully.');
                        
                        //Post
                        
                        LoanAppPermisions()
                        //CurrForm.EDITABLE:=TRUE;
                        //end;

                    end;
                }
                separator(Action1102755023)
                {
                }
                action("Salary Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary Details';
                    RunObject = Page "HR Jobs Factbox";
                    RunPageLink = "Job ID"=field("Client Code");
                    Visible = false;
                }
                action("Loan Securities")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Securities';
                    RunObject = Page "HR Employee Kin SF";
                    RunPageLink = "Employee Code"=field("Loan  No.");
                    ShortCutKey = 'Shift+Ctrl+L';
                }
                action(Guarantors)
                {
                    ApplicationArea = Basic;
                    Caption = 'Guarantors';
                    RunObject = Page "HR Employee Kin";
                    RunPageLink = "No."=field("Loan  No.");
                }
                action("ReAppraise Loan Application")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if "Approval Status"="approval status"::Rejected then begin
                        if Confirm('Are you sure you want to Reappraise this loan?',false)=true then begin

                        ApprovalComment.Reset;
                        ApprovalComment.SetRange(ApprovalComment."Document No.","Loan  No.");
                        if ApprovalComment.Find ('-') then begin
                        ApprovalComment.Comment:='';
                        ApprovalComment.Modify;
                        end
                        end;
                        "Loan Status":="loan status"::Application;
                        "Approval Status":="approval status"::Open;
                        Modify
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Source:=Source::" ";
        OnAfterGetCurrRecord;
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
        ApprovalComment: Record "Approval Comment Line";


    procedure LoanAppPermisions()
    begin
        
        //CurrForm.EDITABLE:=TRUE;
        /*
        IF "Batch No." <> '' THEN BEGIN
        MovementTracker.RESET;
        MovementTracker.SETCURRENTKEY(MovementTracker."Document No.");
        MovementTracker.SETRANGE(MovementTracker."Document No.","Batch No.");
        IF MovementTracker.FIND('+') THEN BEGIN
        IF (MovementTracker.Station <> 'LOANS OFFICE') AND (MovementTracker.Station <> 'REGISTRY')
           AND (MovementTracker.Station <> 'ELD') AND (MovementTracker.Station <> 'PERSONAL LOANS')
           AND (MovementTracker.Station <> 'KCB - (PERSONAL LOANS)') THEN
        ERROR('You dont have permisions to modify loan applications.')//CurrForm.EDITABLE:=FALSE
        ELSE BEGIN
        ApprovalUsers.RESET;
        ApprovalUsers.SETRANGE(ApprovalUsers."Approval Type",MovementTracker."Approval Type");
        ApprovalUsers.SETRANGE(ApprovalUsers.Stage,MovementTracker.Stage);
        ApprovalUsers.SETRANGE(ApprovalUsers."User ID",USERID);
        IF ApprovalUsers.FIND('-') THEN BEGIN
        CurrForm.EDITABLE:=TRUE;
        END ELSE BEGIN
        ERROR('You dont have permisions to modify a loan application that is out of your desk.')//CurrForm.EDITABLE:=FALSE;
        
        END;
        END;
        END;
        END;
        */

    end;

    local procedure ClientCodeOnAfterValidate()
    begin
        TestField(Posted,false);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        
        
        DiscountingAmount:=0;
        
        /*
        SpecialComm:=0;
        IF "Special Loan Amount" + "Other Commitments Clearance" > 0 THEN
        SpecialComm:=("Special Loan Amount"+"Other Commitments Clearance")*0.05;
        */
        
        //Special Commision
        SpecialComm:=0;
        BridgedLoans.Reset;
        BridgedLoans.SetCurrentkey(BridgedLoans."Loan No.");
        BridgedLoans.SetRange(BridgedLoans."Loan No.","Loan  No.");
        if BridgedLoans.Find('-') then begin
        repeat
        if BridgedLoans.Source = BridgedLoans.Source::FOSA then begin
        if BridgedLoans."Loan Type" = 'SUPER' then
        SpecialComm:=SpecialComm+(BridgedLoans."Total Off Set"*0.1)
        else
        SpecialComm:=SpecialComm+(BridgedLoans."Total Off Set"*0.1);
        end else begin
        SpecialComm:=SpecialComm+(BridgedLoans."Total Off Set"*0.1);
        end;
        until BridgedLoans.Next = 0;
        end;
        
        
        
        /*IDNo:='';
        FOSAName:='';
        IF Cust.GET("Client Code") THEN BEGIN
        IDNo:=Cust."ID No.";
        IF Vend.GET("Account No") THEN BEGIN
        FOSAName:=Vend.Name;
        END;
        END; */
        
        //LoanAppPermisions();

    end;

    local procedure OtherCommitmentsClearanceOnDea()
    begin
        CurrPage.Update:=true;
    end;
}

