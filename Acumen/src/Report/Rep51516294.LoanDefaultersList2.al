#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516294_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516294 "Loan Defaulters List2"
{
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/LoanDefaultersList2.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Loans; "Loans Register")
        {
            DataItemTableView = where(Posted = const(true), "Outstanding Balance" = filter(> 0), "Amount in Arrears" = filter(> 0));
            RequestFilterFields = "Loan  No.", "Date filter", "Loan Product Type", "Client Code";
            column(ReportForNavId_1102755000; 1102755000) { } // Autogenerated by ForNav - Do not delete
            column(LoanNo; Loans."Loan  No.")
            {
            }
            column(LoanType; Loans."Loan Product Type")
            {
            }
            column(ClientCode; Loans."Client Code")
            {
            }
            column(ClientName; Loans."Client Name")
            {
            }
            column(ApprovedAmnt; Loans."Approved Amount")
            {
            }
            column(AmountPaid; Amountpaid)
            {
            }
            column(Outstandingbal; totalbal)
            {
            }
            column(TotalActual; TotalActual)
            {
            }
            column(AmountDefaulted; "Amount defaulted")
            {
            }
            column(LaSTpaydate; Loans."Last Pay Date")
            {
            }
            column(IssuedDate; Loans."Issued Date")
            {
            }
            column(Period; Period)
            {
            }
            column(SchBalance; SchBalance)
            {
            }
            column(MembOutstanding; MembOutstanding)
            {
            }
            column(DefaultedAmount2; DefAmount)
            {
            }
            column(CountDays; CountDays)
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(INSTAL; INSTAL)
            {
            }
            column(PrincipalPaid_Loans; Loans."Principal Paid")
            {
            }
            column(AmountinArrears_Loans; Loans."Amount in Arrears")
            {
            }
            column(LoansCategorySASRA_Loans; Loans."Loans Category-SASRA")
            {
            }
            column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
            {
            }
            column(OutstandingBalance_Loans; Loans."Outstanding Balance")
            {
            }
            dataitem(Vendor; Vendor)
            {
                DataItemLink = "BOSA Account No" = field("Client Code");
                column(ReportForNavId_12; 12) { } // Autogenerated by ForNav - Do not delete
                column(Balance_Vendor; Vendor.Balance)
                {
                }
            }
            trigger OnPreDataItem();
            begin
                //CurrDate:=Loans.GETRANGEMAX(Loans."Date filter");
                //Loans.SETRANGE(Loans."Date filter",0D,CurrDate);
                //AsAt:=Loans."Date filter";
            end;

            trigger OnAfterGetRecord();
            begin
                ScheduledLoanBal := 0;
                LSchedule.Reset;
                LSchedule.SetRange(LSchedule."Loan No.", "Loan  No.");
                ///LSchedule.SETRANGE(LSchedule."Repayment Date",;
                LSchedule.SetRange(LSchedule.Reschedule, false);
                if LSchedule.FindFirst then begin
                    ScheduledLoanBal := ROUND(LSchedule."Loan Balance", 1, '>');
                end;
                //  LSchedule.RESET;
                //  LSchedule.SETRANGE(LSchedule."Loan No.","Loan  No.");
                //  LSchedule.SETRANGE(LSchedule."Instalment No",1);
                //
                //	IF LSchedule.FINDFIRST THEN BEGIN
                //
                //	  MonthlyRepayment:=LSchedule."Principal Repayment";//Monthly Repayment
                //	 IF (ScheduledLoanBal=0) AND (LSchedule."Repayment Date">LastMonth) THEN
                //	   ScheduledLoanBal:=ApprovedAmount;
                //	END ELSE BEGIN
                //	  ScheduledLoanBal:=0;
                //	END;
                /*LoanApp.RESET;
				LoanApp.SETRANGE(LoanApp."Loan  No.",Loans."Loan  No.");
				LoanApp.SETFILTER(LoanApp."Date filter",DFILTER);
				IF LoanApp.FIND('-') THEN BEGIN
				LoanApp.CALCFIELDS(LoanApp."Outstanding Balance");
				 IF LoanApp."Outstanding Balance" <=0 THEN BEGIN
				LoanApp."Amount In Arrears":=0;
				 LoanApp."Amount in Default":=0;
				LoanApp."Total Defaulted Amount":=0;
				 LoanApp."Days In Arrears":=0;
				 LoanApp."Days Defaulted":=0;
				  LoanApp.MODIFY;
				 END;
				END; */
                ///IF Loans."Outstanding Balance" >0 THEN BEGIN
                /*
				"Amount defaulted":=0;
				Amountpaid:=0;
				TotalActual:=0;
				Period:=0;
				totalbal:=0;
				"Defaulted install":=0;
				CountDays:=0;
				SchBalance:=0;
				DefAmount:=0;
				RESCHBAL:=0;
				SchedPrincRep:=0;
				Loans.CALCFIELDS(Loans."Last Pay Date",Loans."Outstanding Balance");
				Loans.CALCFIELDS(Loans."Interest Due", Loans."Oustanding Interest");
				Loans.TESTFIELD(Loans."Issued Date");
				DFILTER:='..'+FORMAT(Loans."Loan Rescheduled Date");
				totalbal:=Loans."Outstanding Balance";
				IF Loans."Outstanding Balance" >0 THEN BEGIN
				IF Loans."Expected Date of Completion" > TODAY THEN
				//IF Loans.Rescheduled=FALSE THEN BEGIN
				Amountpaid:=Loans."Approved Amount"-Loans."Outstanding Balance";
				INSTAL:=Loans.Installments;
				TotalActual:=Amountpaid;
				SchBalance:=Loans."Outstanding Balance";
				   Expected:= ROUND((TODAY-Loans."Issued Date")/30,1.0,'<')-1;
				PERIODD:=ROUND((Amountpaid/Loans."Loan Principle Repayment"),1)-1;
				EXPECTEDA:=ROUND((Expected*Loans."Loan Principle Repayment"),1);
				//MESSAGE(FORMAT(EXPECTEDA));
				DefAmount:=ROUND((EXPECTEDA - Amountpaid),1);
				MESSAGE(FORMAT(DefAmount));
				//MESSAGE(FORMAT(EXPECTEDA));
				ADAYS:=ROUND((DefAmount/Loans."Loan Principle Repayment"),1)*30;
				DAYSS:=ADAYS;
				END ELSE BEGIN
				DFILTER:='..'+FORMAT(Loans."Loan Rescheduled Date");
				LoanApp.RESET;
				LoanApp.SETRANGE(LoanApp."Loan  No.",Loans."Loan  No.");
				LoanApp.SETFILTER(LoanApp."Date filter",DFILTER);
				IF LoanApp.FIND('-') THEN BEGIN
				LoanApp.CALCFIELDS(LoanApp."Outstanding Balance");
				RESCHBAL:=Loans."Approved Amount";
				//END;
				END;
				Period:=Loans.Installments;
				IF Loans.Rescheduled=FALSE THEN BEGIN
				IF Schedule.FIND('-') THEN
				Schedule.RESET;
				Schedule.SETRANGE(Schedule."Member No.",Loans."Client Code");
				Schedule.SETRANGE(Schedule."Loan No.",Loans."Loan  No.");
				Schedule.SETFILTER(Schedule."Repayment Date",'<=%1',AsAt);
				IF Schedule.FINDSET THEN BEGIN
				Schedule.CALCSUMS("Principal Repayment");
				TotalActual:=Amountpaid;
				SchBalance:=Loans."Outstanding Balance";
				CountDays:=AsAt-Loans."Issued Date";
				ExpectedP:=(AsAt-Loans."Issued Date")/30;
				PERIODD:=Amountpaid/Schedule."Principal Repayment";
				EXPECTEDA:=ExpectedP*Schedule."Principal Repayment";
				DefAmount:=EXPECTEDA - Amountpaid;
				///MESSAGE(FORMAT(DefAmount));
				END
				END ELSE BEGIN
				Schedule.RESET;
				Schedule.SETRANGE(Schedule."Member No.",Loans."Client Code");
				Schedule.SETRANGE(Schedule."Loan No.",Loans."Loan  No.");
				//Schedule.SETRANGE(Schedule."Closed Schedule",FALSE);
				Schedule.SETFILTER(Schedule."Repayment Date",'<=%1',AsAt);
				IF Schedule.FINDSET THEN BEGIN
				Schedule.CALCSUMS("Principal Repayment");
				Schedule.CALCSUMS("Principal Repayment");
				TotalActual:=Amountpaid;
				SchBalance:=Loans."Outstanding Balance";
				CountDays:=AsAt-Loans."Issued Date";
				ExpectedP:=(AsAt-Loans."Issued Date")/30;
				PERIODD:=Amountpaid/Schedule."Principal Repayment";
				EXPECTEDA:=ExpectedP*Schedule."Principal Repayment";
				DefAmount:=EXPECTEDA - Amountpaid;
				END;
				END;
				Schedule.RESET;
				Schedule.SETRANGE(Schedule."Member No.",Loans."Client Code");
				Schedule.SETRANGE(Schedule."Loan No.",Loans."Loan  No.");
				//Schedule.SETRANGE(Schedule."Closed Schedule",FALSE);
				IF Schedule.FIND('-') THEN BEGIN
				SchedPrincRep:=Schedule."Principal Repayment";
				END;
				IF CountDays<30 THEN BEGIN
				SchBalance:=Loans."Outstanding Balance";
				END;
				IF SchBalance<=0 THEN
				SchBalance:=0;
				// **********************END************************************
				IF   Amountpaid>0 THEN BEGIN
				"Amount defaulted":=DefAmount;
				END ELSE  IF   Amountpaid<0 THEN BEGIN
				Loans."Amount in Arrears":=DefAmount;
				 LoanApp."Days in Arrears":=DAYSS;
				END ELSE  IF SchedPrincRep  < Loans.Installments THEN  BEGIN
				"Defaulted install":=PERIODD;
				IF  "Amount defaulted" >0 THEN BEGIN
				Cust.GET(Loans."Client Code");
				 Cust.Status:= Cust.Status::Defaulter;
				/// MESSAGE(FORMAT(DefAmount));
				  Cust.MODIFY;
				  END;
				  IF (SchedPrincRep > 1) THEN BEGIN
				  IF ("Amount defaulted" > 1) THEN BEGIN
				  LoanApp."Days in Arrears":=DAYSS;
				 END;
				 END;
				 END;
				Loans."Amount in Arrears":=DefAmount;
				 LoanApp."Days in Arrears":=(DAYSS);
				TotalAmountDefaulted:=TotalAmountDefaulted+"Amount defaulted";
				no:=no+1;
				IF DefAmount<=0 THEN
				DefAmount:=0;
						END;
					IF LoanApp.FIND('-') THEN BEGIN
					 ///  LoanApp."Days Defaulted":=DAYSS;
					   LoanApp.MODIFY;
					   END;
					   */

            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                field(AsAt; AsAt)
                {
                    ApplicationArea = Basic;
                    Caption = 'As At Date';
                    Visible = false;
                }
                field(ForNavOpenDesigner; ReportForNavOpenDesigner)
                {
                    ApplicationArea = Basic;
                    Caption = 'Design';
                    Visible = ReportForNavAllowDesign;
                    trigger OnValidate()
                    begin
                        ReportForNav.LaunchDesigner(ReportForNavOpenDesigner);
                        CurrReport.RequestOptionsPage.Close();
                    end;

                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            ReportForNavOpenDesigner := false;
        end;
    }

    trigger OnInitReport()
    begin
        ;
        ReportsForNavInit;

    end;

    trigger OnPostReport()
    begin
        ;
        ReportForNav.Post;
    end;

    trigger OnPreReport()
    begin
        ;
        ReportsForNavPre;
    end;

    var
        "0Month": Decimal;
        "1Month": Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        TShare: Decimal;
        ADAYS: Decimal;
        DAYSS: Integer;
        DFILTER: Text;
        TLApp: Decimal;
        INSTAL: Integer;
        Expected: Decimal;
        SchedPrincRep: Decimal;
        TCheque: Decimal;
        PERIODD: Integer;
        DefAmount: Decimal;
        ExpectedP: Integer;
        DateFilterBF: Text[150];
        RESCHBAL: Decimal;
        TLBalance: Decimal;
        EXPECTEDA: Decimal;
        SchBalance: Decimal;
        GenSetUp: Record "Loan Disburesment-Batching";
        LoanApp: Record "Loans Register";
        PendingApp: Decimal;
        ApprovedApp: Decimal;
        Cust: Record Customer;
        ShowSec: Boolean;
        TLAppB: Decimal;
        TChequeB: Decimal;
        TReq: Decimal;
        Variance: Integer;
        CurrDate: Date;
        Savings: Decimal;
        Tsavings: Decimal;
        vend: Record Vendor;
        TapprovedAmount: Decimal;
        "Amount defaulted": Decimal;
        "Defaulted install": Decimal;
        CountDays: Integer;
        TotalActual: Decimal;
        ExpIntallment: Decimal;
        MonthlyRep: Decimal;
        DefInterest: Decimal;
        MembOutstanding: Decimal;
        DefInterest2: Decimal;
        membledg: Record "Cust. Ledger Entry";
        HesabuWeeks: Decimal;
        ExpectedPrinc: Decimal;
        TotExpPr: Decimal;
        TotExpAmount: Decimal;
        Amountpaid: Decimal;
        TotalAmountDefaulted: Decimal;
        no: Integer;
        totalbal: Decimal;
        Period: Decimal;
        ExpBal: Decimal;
        LastDueDate: Date;
        DFormula: DateFormula;
        LoanProduct: Record "Loan Products Setup";
        FirstMonthDate: Date;
        EndMonthDate: Date;
        AsAt: Date;
        "0MonthC": Integer;
        "1MonthC": Integer;
        "2MonthC": Integer;
        "3MonthC": Integer;
        Over3MonthC: Integer;
        Schedule: Record "Loan Repayment Schedule";
        Schedule2: Record "Loan Repayment Schedule";
        expamount: Decimal;
        ScheduledLoanBal: Decimal;
        LSchedule: Record "Loan Repayment Schedule";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516294_v6_3_0_2259;
        ReportForNavOpenDesigner: Boolean;
        [InDataSet]
        ReportForNavAllowDesign: Boolean;

    local procedure ReportsForNavInit();
    var
        ApplicationSystemConstants: Codeunit "Application System Constants";
        addInFileName: Text;
        tempAddInFileName: Text;
        path: DotNet Path;
        ReportForNavObject: Variant;
    begin
        addInFileName := ApplicationPath() + 'Add-ins\ReportsForNAV_6_3_0_2259\ForNav.Reports.6.3.0.2259.dll';
        if not File.Exists(addInFileName) then begin
            tempAddInFileName := path.GetTempPath() + '\Microsoft Dynamics NAV\Add-Ins\' + ApplicationSystemConstants.PlatformFileVersion() + '\ForNav.Reports.6.3.0.2259.dll';
            if not File.Exists(tempAddInFileName) then
                Error('Please install the ForNAV DLL version 6.3.0.2259 in your service tier Add-ins folder under the file name "%1"\\If you already have the ForNAV DLL on the server, you should move it to this folder and rename it to match this file name.', addInFileName);
        end;
        ReportForNavObject := ReportForNav.GetLatest(CurrReport.OBJECTID, CurrReport.Language, SerialNumber, UserId, CompanyName);
        ReportForNav := ReportForNavObject;
        ReportForNav.Init();
    end;

    local procedure ReportsForNavPre();
    begin
        ReportForNav.OpenDesigner := ReportForNavOpenDesigner;
        if not ReportForNav.Pre() then CurrReport.Quit();
    end;

    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
