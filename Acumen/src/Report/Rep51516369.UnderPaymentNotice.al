#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516369_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516369 "UnderPayment Notice"
{
    RDLCLayout = './Layouts/UnderPaymentNotice.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(LoansREC; "Loans Register")
        {
            RequestFilterFields = "Loan  No.", "Last Pay Date", "Client Code";
            column(ReportForNavId_1102755000; 1102755000) { } // Autogenerated by ForNav - Do not delete
            column(Staff_No; Customer."Personal No")
            {
            }
            column(MNo; Customer."No.")
            {
            }
            column(Name; Customer.Name)
            {
            }
            column(Address; Customer.Address)
            {
            }
            column(City; Customer.City)
            {
            }
            column(DearM; DearM)
            {
            }
            column(Loan_Type; LoansR."Loan Product Type")
            {
            }
            column(LBalance1; LBalance1)
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = field("Client Code");
                RequestFilterFields = "No.";
                column(ReportForNavId_1102755005; 1102755005) { } // Autogenerated by ForNav - Do not delete
                column(LBalance2; LBalance1)
                {
                }
                column(LPrincipal; LPrincipal)
                {
                }
                column(Bal; Bal)
                {
                }
                column(SenderName; SenderName)
                {
                }
                column(Current_Payments; LoansR."Current Repayment")
                {
                }
                trigger OnAfterGetRecord();
                begin
                    if Customer.Gender = Customer.Gender::Male then
                        DearM := 'Dear Madam'
                    else
                        DearM := 'Dear Sir';
                    /*
					LastPDate:=0D;
					Balance:=0;
					SharesB:=0;
					SharesAlllocated:=(LBalance/(Customer."Oustanding Balance"+Customer."Reason for Withdrawal"))*("Current Shares"*-1);
					ABFAllocated:=(LBalance/(Customer."Oustanding Balance"+Customer."Reason for Withdrawal"))*(Customer."Insurance Fund"*-0.5);
					SharesB:=SharesAlllocated+ABFAllocated;
					TotalRec:=ROUND(LBalance-SharesB,1,'>');
					IF TotalRec < 0 THEN
					TotalRec:=0;
					AmountT:=ROUND((TotalRec/NoGuarantors),0.05,'>');
					LoansR.RESET;
					LoansR.SETRANGE(LoansR."Client Code",Customer."No.");
					LoansR.SETRANGE(LoansR.Posted,TRUE);
					IF LoansR.FIND('-') THEN BEGIN
					REPEAT
					IF LoansR."Last Pay Date" = 0D THEN BEGIN
					IF LastPDate < LoansR."Issued Date" THEN
					LastPDate:=LoansR."Issued Date"
					END ELSE BEGIN
					IF LastPDate < LoansR."Last Pay Date" THEN
					LastPDate:=LoansR."Last Pay Date";
					END;
					UNTIL LoansR.NEXT = 0;
					END;
					*/

                end;

            }
            dataitem(Loans; "Loans Register")
            {
                DataItemLink = "Loan  No." = field("Loan  No.");
                DataItemTableView = where("Outstanding Balance" = filter(> 0));
                RequestFilterFields = "Current Repayment";
                column(ReportForNavId_1000000008; 1000000008) { } // Autogenerated by ForNav - Do not delete
                column(Loan_No; Loans."Loan  No.")
                {
                }
                column(Loan_Product_type; Loans."Loan Product Type")
                {
                }
                column(Outstanding_Bal; Lbal)
                {
                }
                column(Interest_Due; INTBAL)
                {
                }
                column(Penalty; COMM)
                {
                }
                column(LastPDate; LastPDate)
                {
                }
                column(Total_Amount; Lbal + INTBAL + COMM)
                {
                }
                dataitem("Loan Guarantors"; "Loans Guarantee Details")
                {
                    DataItemLink = "Loan No" = field("Loan  No.");
                    column(ReportForNavId_1000000003; 1000000003) { } // Autogenerated by ForNav - Do not delete
                    column(Member_No; LoanGuar."Member No")
                    {
                    }
                    column(NameG; LoanGuar.Name)
                    {
                    }
                    column(Personal_No; LoanGuar."Staff/Payroll No.")
                    {
                    }
                    column(intcount; intcount)
                    {
                    }
                    column(Outstanding_Bal2; Lbal)
                    {
                    }
                    column(Interest_Due2; INTBAL)
                    {
                    }
                    column(Penalty2; COMM)
                    {
                    }
                    column(Total_Amount2; Lbal + INTBAL + COMM)
                    {
                    }
                    trigger OnPreDataItem();
                    begin
                        TGrAmount := 0;
                        GrAmount := 0;
                        FGrAmount := 0;
                        Amount2 := 0;
                    end;

                    trigger OnAfterGetRecord();
                    begin
                        GAddress := '';
                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                        if LoanGuar.Find('-') then begin
                            LoanGuar.Reset;
                            LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                            repeat
                                PersonalNo := LoanGuar."Staff/Payroll No.";
                                TGrAmount := TGrAmount + GrAmount;
                                GrAmount := LoanGuar."Amont Guaranteed";
                                //LoanGuar."Amount Guarnted";
                                FGrAmount := TGrAmount + LoanGuar."Amont Guaranteed";
                            until LoanGuar.Next = 0;
                        end;
                        /*
						IF Cust.GET("Loan Guarantors"."Member No") THEN BEGIN
						Cust.CALCFIELDS(Cust."Current Shares");
						TotalAss:=Cust."Current Shares"*-1;
						END;
						  */
                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due");
                        Lbal := ROUND(Loans."Outstanding Balance", 0.5, '=');
                        INTBAL := Loans."Interest Due";
                        COMM := Loans."Interest Due" * 0.3;
                        //MESSAGE('BALANCE %1',Lbal);
                        /*
						LoanGuar.RESET;
						LoanGuar.SETRANGE(LoanGuar."Loan No",Loans."Loan  No.");
						IF LoanGuar.FIND('-') THEN BEGIN
						REPEAT
						LoanGuar.CALCFIELDS(LoanGuar."Total Guranted");
						GrAmount:=LoanGuar."Amount Guarnted";
						FGrAmount:=LoanGuar."Total Guranted";
						Amount2:=(GrAmount/FGrAmount)*(Lbal+INTBAL+COMM);
						UNTIL LoanGuar.NEXT=0;
						END;
						*/
                        //commisision
                        /*
						LoanGuar.RESET;
						LoanGuar.SETRANGE(LoanGuar."Loan No",Loans."Loan  No.");
						IF LoanGuar.FIND('-') THEN BEGIN
						LoanGuar.RESET;
						LoanGuar.SETRANGE(LoanGuar."Loan No",Loans."Loan  No.");
						//DLN:='DLN';
						REPEAT
						GenSetUp.GET();
						GenSetUp."Defaulter LN":=GenSetUp."Defaulter LN"+10;
						GenSetUp.MODIFY;
						//DLN:='DLN'+FORMAT(GenSetUp."Defaulter LN");
						//GrAmount:=LoanGuar."Amount Guarnted";
						//FGrAmount:=FGrAmount+LoanGuar."Amount Guarnted";
						//LoanGuar."Amount Guarnted";
						//TGrAmount:=TGrAmount+GrAmount;
						//Amount2:=(GrAmount/FGrAmount)*(Lbal+INTBAL+COMM);
						//MESSAGE('guarnteed Amount %1',FGrAmount);
						//REPEAT
						////Insert jnl lines
						Cust.RESET;
						Cust.SETRANGE(Cust."No.",LoanGuar."Member No");
						IF Cust.FIND('-') THEN BEGIN
						Loans."Client Name":=Cust.Name;
						END;
						UNTIL LoanGuar.NEXT=0;
						END;
						*/
                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                        if LoanGuar.Find('-') then begin
                            LoanGuar.Reset;
                            LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                            //DLN:='DLN';
                            repeat
                                GenSetUp.Get();
                                GenSetUp."Defaulter LN" := GenSetUp."Defaulter LN" + 10;
                                //GenSetUp.MODIFY;
                                TGrAmount := TGrAmount + GrAmount;
                                LoansREC.CalcFields(LoansREC."Total Loan Guaranted");
                                GrAmount := "Amont Guaranteed";
                                //LoanGuar."Amount Guarnted";
                                //MESSAGE('guarnteed Amount %1',FGrAmount);
                                //REPEAT
                                ////Insert jnl lines
                                /*GenJournalLine.INIT;
                                GenJournalLine."Journal Template Name":='general';
                                GenJournalLine."Journal Batch Name":='LNAttach';
                                GenJournalLine."Document No.":="LN Doc";
                                GenJournalLine."External Document No.":="LN Doc";
                                GenJournalLine."Line No.":=GenJournalLine."Line No."+1000;
                                GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Loan;
                                GenJournalLine."Account Type":=GenJournalLine."Account Type"::Customer;
                                GenJournalLine."Account No.":=LoanGuar."Member No";
                                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date":=TODAY;
                                GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                                //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Description:='Defaulted Loan'+' ';
                                */
                                if LoansREC."Total Loan Guaranted" <> 0 then
                                    Amount2 := ROUND((GrAmount / LoansREC."Total Loan Guaranted") * ((Lbal + INTBAL + COMM) - TotalAss), 1, '>');
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Loan No" := DLN;
                                /*Loans.RESET;
                                Loans.SETRANGE(Loans."Loan Product Type",'DEFAULTER');
                                Loans.SETRANGE(Loans."Client Code",LoanGuar."Member No");
                                IF FIND('-') THEN BEGIN
                                GenJournalLine."Loan No":=DLN;
                                //Loans."Loan  No.";
                                END;*/
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                            until LoanGuar.Next = 0;
                        end;

                    end;

                }
                trigger OnAfterGetRecord();
                begin
                    Loans.CalcFields(Loans."Current Repayment", Loans."Loan Repayment", Loans."Outstanding Balance", Loans."Interest Paid");
                    Expected := (Loans."Loan Principle Repayment" * Loans.Installments);
                    if Balance <> 0 then
                        Balance := (Loans."Outstanding Balance" - Abs(Loans."Loan Repayment"));
                    Bal := Abs(ExpectedRepay) - Abs(Loans."Loan Repayment" + Loans."Interest Paid");
                    if excludeshares <> true then begin
                        if Cust.Get(Loans."Client Code") then begin
                            Cust.CalcFields(Cust."Current Shares");
                            TotalAss := Cust."Current Shares" * -1;
                        end;
                    end;
                    SharesB := SharesB - (Loans."Outstanding Balance" + Loans."Interest Due");
                    if SharesB < 0 then
                        BalanceType := 'Debit Balance'
                    else
                        BalanceType := 'Credit Balance';
                    LoanGuar.Reset;
                    LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                    if LoanGuar.Find('-') then begin
                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                        repeat
                            TGrAmount := TGrAmount + GrAmount;
                            GrAmount := LoanGuar."Amont Guaranteed";
                            //LoanGuar."Amount Guarnted";
                            FGrAmount := TGrAmount + LoanGuar."Amont Guaranteed";
                        until LoanGuar.Next = 0;
                    end;
                    //Defaulter loan clear
                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due");
                    Lbal := ROUND(Loans."Outstanding Balance", 0.5, '=');
                    if Loans."Interest Due" > 0 then begin
                        INTBAL := Loans."Interest Due";
                        COMM := ROUND((Loans."Interest Due" * 0.3), 1, '>');
                        //MESSAGE('BALANCE %1',Lbal);
                    end;
                    //commisision
                    NetLiability := TotalAss - (Lbal + INTBAL + COMM);
                    /*
					LoanGuar.RESET;
					LoanGuar.SETRANGE(LoanGuar."Loan No",Loans."Loan  No.");
					IF LoanGuar.FIND('-') THEN BEGIN
					LoanGuar.RESET;
					LoanGuar.SETRANGE(LoanGuar."Loan No",Loans."Loan  No.");
					//DLN:='DLN';
					REPEAT
					GenSetUp.GET();
					GenSetUp."Defaulter LN":=GenSetUp."Defaulter LN"+10;
					GenSetUp.MODIFY;
					//DLN:='DLN'+FORMAT(GenSetUp."Defaulter LN");
					GrAmount:=LoanGuar."Amount Guarnted";
					//LoanGuar."Amount Guarnted";
					TGrAmount:=TGrAmount+GrAmount;
					Amount2:=(GrAmount/TGrAmount)*(Lbal+INTBAL+COMM);
					//MESSAGE('guarnteed Amount %1',FGrAmount);
					//REPEAT
					////Insert jnl lines
					Cust.RESET;
					Cust.SETRANGE(Cust."No.",LoanGuar."Member No");
					IF Cust.FIND('-') THEN BEGIN
					Loans."Client Name":=Cust.Name;
					END;
					UNTIL LoanGuar.NEXT=0;
					END;*/
                    /*
					LoanGuar.RESET;
					LoanGuar.SETRANGE(LoanGuar."Loan No",Loans."Loan  No.");
					IF LoanGuar.FIND('-') THEN BEGIN
					LoanGuar.RESET;
					LoanGuar.SETRANGE(LoanGuar."Loan No",Loans."Loan  No.");
					//DLN:='DLN';
					REPEAT
					GenSetUp.GET();
					GenSetUp."Defaulter LN":=GenSetUp."Defaulter LN"+10;
					GenSetUp.MODIFY;
					//DLN:='DLN'+FORMAT(GenSetUp."Defaulter LN");
					TGrAmount:=TGrAmount+GrAmount;
					GrAmount:=LoanGuar."Amount Guarnted";
					//LoanGuar."Amount Guarnted";
					MESSAGE('guarnteed Amount %1',FGrAmount);
					//REPEAT
					////Insert jnl lines
					{GenJournalLine.INIT;
					GenJournalLine."Journal Template Name":='general';
					GenJournalLine."Journal Batch Name":='LNAttach';
					GenJournalLine."Document No.":="LN Doc";
					GenJournalLine."External Document No.":="LN Doc";
					GenJournalLine."Line No.":=GenJournalLine."Line No."+1000;
					GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Loan;
					GenJournalLine."Account Type":=GenJournalLine."Account Type"::Customer;
					GenJournalLine."Account No.":=LoanGuar."Member No";
					GenJournalLine.VALIDATE(GenJournalLine."Account No.");
					GenJournalLine."Posting Date":=TODAY;
					GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
					//GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
					GenJournalLine.Description:='Defaulted Loan'+' ';
					}
					Amount2:=ROUND((GrAmount/FGrAmount)*(Lbal+INTBAL+COMM),0.5,'=');
					{
					GenJournalLine.VALIDATE(GenJournalLine.Amount);
					GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
					GenJournalLine."Loan No":=DLN;
					{Loans.RESET;
					Loans.SETRANGE(Loans."Loan Product Type",'DEFAULTER');
					Loans.SETRANGE(Loans."Client Code",LoanGuar."Member No");
					IF FIND('-') THEN BEGIN
					GenJournalLine."Loan No":=DLN;
					//Loans."Loan  No.";
					END;}
					IF GenJournalLine.Amount<>0 THEN
					GenJournalLine.INSERT;
					}
					UNTIL LoanGuar.NEXT=0;
					END;	  */

                end;

            }
            trigger OnPreDataItem();
            begin
                SenderName := '';
                if PeriodF = 0D then
                    Error(Text001);
            end;

            trigger OnAfterGetRecord();
            begin
                //= Schedule expectation
                RepaymentSchedule.Reset;
                RepaymentSchedule.SetRange(RepaymentSchedule."Loan No.", LoansREC."Loan  No.");
                RepaymentSchedule.SetRange(RepaymentSchedule."Repayment Date", CalcDate('-CM', PeriodF), CalcDate('CM', PeriodF));
                if RepaymentSchedule.Find('-') then begin
                    LPrincipal := RepaymentSchedule."Monthly Repayment";
                    // MESSAGE(FORMAT(RepaymentSchedule."Repayment Date"));
                end;
                checkDate := CalcDate('CM', PeriodF);
                //= payment expectation
                RepaymentSchedule.Reset;
                RepaymentSchedule.SetRange(RepaymentSchedule."Loan No.", LoansREC."Loan  No.");
                RepaymentSchedule.SetFilter(RepaymentSchedule."Repayment Date", '<' + Format(checkDate));
                if RepaymentSchedule.Find('-') then begin
                    repeat
                        ExpectedRepay := ExpectedRepay + RepaymentSchedule."Monthly Repayment";
                    until RepaymentSchedule.Next = 0;
                    Message('ExpectedRepay= ' + Format(ExpectedRepay));
                end;
                LoansREC.CalcFields(LoansREC."Outstanding Balance", LoansREC."Oustanding Interest", LoansREC."No. Of Guarantors",
                "Current Repayment");
                NoGuarantors := LoansREC."No. Of Guarantors";
                if NoGuarantors = 0 then
                    NoGuarantors := 1;
                LBalance := LoansREC."Outstanding Balance" + LoansREC."Oustanding Interest";
                LBalance1 := LoansREC."Outstanding Balance";
                //LoansREC.Notified:=TRUE;
                //LoansREC."Notified date":=TODAY;
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
                field(Period_Filter; PeriodF)
                {
                    ApplicationArea = Basic;
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
        intcount: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        Balance: Decimal;
        DLN: Code[10];
        SenderName: Text[150];
        DearM: Text[60];
        BalanceType: Text[100];
        SharesB: Decimal;
        LastPDate: Date;
        LoansR: Record "Loans Register";
        SharesAlllocated: Decimal;
        ABFAllocated: Decimal;
        LBalance: Decimal;
        PersonalNo: Code[50];
        GAddress: Text[250];
        Cust: Record Customer;
        TotalRec: Decimal;
        NoGuarantors: Integer;
        AmountT: Decimal;
        LoanGuar: Record "Loans Guarantee Details";
        TGrAmount: Decimal;
        GrAmount: Decimal;
        FGrAmount: Decimal;
        Lbal: Decimal;
        INTBAL: Decimal;
        COMM: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        Amount2: Decimal;
        TotalAss: Decimal;
        NetLiability: Decimal;
        excludeshares: Boolean;
        LBalance1: Decimal;
        Expected: Decimal;
        TotalMRepay: Decimal;
        LPrincipal: Decimal;
        LInterest: Decimal;
        InterestRate: Decimal;
        LoanAmount: Decimal;
        RepayPeriod: Decimal;
        RepaymentSchedule: Record "Loan Repayment Schedule";
        PeriodF: Date;
        checkDate: Date;
        ExpectedRepay: Decimal;
        Bal: Decimal;
        Text001: label 'Please specify period for analysis on option tab.';

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516369_v6_3_0_2259;
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
