#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516393_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516393 "Defaulter Final Notice"
{
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/DefaulterFinalNotice.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(LoansREC; "Loans Register")
        {
            RequestFilterFields = "Loan  No.", "Last Pay Date", "Client Code";
            column(ReportForNavId_1102755000; 1102755000) { } // Autogenerated by ForNav - Do not delete
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(CompanyAddress; CompanyInformation.Address)
            {
            }
            column(Address2; CompanyInformation."Address 2")
            {
            }
            column(PostCode; CompanyInformation."Post Code")
            {
            }
            column(City; CompanyInformation.City)
            {
            }
            column(Country; CompanyInformation."Country/Region Code")
            {
            }
            column(CompanyPhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(CompanyFaxNo; CompanyInformation."Fax No.")
            {
            }
            column(E_mail; CompanyInformation."E-Mail")
            {
            }
            column(CPic; CompanyInformation.Picture)
            {
            }
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
            column(CustCity; Customer.City)
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
                trigger OnAfterGetRecord();
                begin
                    if Customer.Gender = Customer.Gender::Male then
                        DearM := 'Dear Madam'
                    else
                        DearM := 'Dear Sir';
                    LastPDate := 0D;
                    Balance := 0;
                    SharesB := 0;
                    Customer.CalcFields(Customer."Outstanding Balance", Customer."Current Shares");
                    SharesAlllocated := (LBalance / (Customer."Outstanding Balance" + Customer."Withdrawal Fee")) * ("Current Shares" * -1);
                    ABFAllocated := (LBalance / (Customer."Outstanding Balance" + Customer."Withdrawal Fee")) * (Customer."Insurance Fund" * -0.5);
                    SharesB := SharesAlllocated + ABFAllocated;
                    TotalRec := ROUND(LBalance - SharesB, 1, '>');
                    if TotalRec < 0 then
                        TotalRec := 0;
                    AmountT := ROUND((TotalRec / NoGuarantors), 0.05, '>');
                    LoansR.Reset;
                    LoansR.SetRange(LoansR."Client Code", Customer."No.");
                    LoansR.SetRange(LoansR.Posted, true);
                    if LoansR.Find('-') then begin
                        repeat
                            if LoansR."Last Pay Date" = 0D then begin
                                if LastPDate < LoansR."Issued Date" then
                                    LastPDate := LoansR."Issued Date"
                            end else begin
                                if LastPDate < LoansR."Last Pay Date" then
                                    LastPDate := LoansR."Last Pay Date";
                            end;
                        until LoansR.Next = 0;
                    end;
                    if SendSMS = true then begin
                        //SMS MESSAGE
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
                        SMSMessage."Account No" := Loans."Client Code";
                        SMSMessage."Date Entered" := Today;
                        SMSMessage."Time Entered" := Time;
                        SMSMessage.Source := 'LOAN DEF1';
                        SMSMessage."Entered By" := UserId;
                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                        SMSMessage."SMS Message" := 'Defaulter Attach Notice: Guarantors will be attached to Loan No. '
                        + LoansREC."Loan  No." + ' of KSHs.' + Format(Loans."Approved Amount") +
                                                  ' at HAZINA SACCO LTD. ';
                        Cust.Reset;
                        if Cust.Get(Loans."Client Code") then
                            SMSMessage."Telephone No" := Cust."Phone No.";
                        SMSMessage.Insert;
                    end;
                end;

            }
            dataitem(Loans; "Loans Register")
            {
                DataItemLink = "Loan  No." = field("Loan  No.");
                DataItemTableView = where("Outstanding Balance" = filter(> 0));
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
                        intcount := intcount + 1;
                        TGrAmount := 0;
                        GrAmount := 0;
                        FGrAmount := 0;
                        Amount2 := 0;
                    end;

                    trigger OnAfterGetRecord();
                    begin
                        TGrAmount := 0;
                        GrAmount := 0;
                        FGrAmount := 0;
                        Amount2 := 0;
                        GAddress := '';
                        /*
						LoanGuar.RESET;
						LoanGuar.SETRANGE(LoanGuar."Loan No",Loans."Loan  No.");
						IF LoanGuar.FIND('-') THEN BEGIN
						LoanGuar.RESET;
						LoanGuar.SETRANGE(LoanGuar."Loan No",Loans."Loan  No.");
						REPEAT
						PersonalNo:=LoanGuar."PF Number";
						TGrAmount:=TGrAmount+GrAmount;
						GrAmount:=LoanGuar."Amount Guarnted";
						//LoanGuar."Amount Guarnted";
						FGrAmount:=TGrAmount+LoanGuar."Amount Guarnted";
						UNTIL LoanGuar.NEXT=0;
						END;
						*/
                        if SendSMS = true then begin
                            //SMS MESSAGE
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
                            SMSMessage."Account No" := "Loan Guarantors"."Member No";
                            SMSMessage."Date Entered" := Today;
                            SMSMessage."Time Entered" := Time;
                            SMSMessage.Source := 'LOAN DEF1';
                            SMSMessage."Entered By" := UserId;
                            SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                            SMSMessage."SMS Message" := 'Defaulter Attach Notice: You have been attached as guarantor to Loan No. '
                            + LoansREC."Loan  No." + ' of ' + LoansREC."Client Name" + ' of KSHs.' + Format(Loans."Approved Amount") +
                                                      ' at HAZINA SACCO LTD. ';
                            Cust1.Reset;
                            if Cust1.Get("Loan Guarantors"."Member No") then
                                SMSMessage."Telephone No" := Cust1."Phone No.";
                            SMSMessage.Insert;
                        end;
                        /*
						IF Cust.GET("Loan Guarantors"."Member No") THEN BEGIN
						Cust.CALCFIELDS(Cust."Current Shares");
						TotalAss:=Cust."Current Shares"*-1;
						END;
						  */
                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due");
                        Lbal := ROUND(Loans."Outstanding Balance", 0.5, '=');
                        INTBAL := Loans."Oustanding Interest";
                        COMM := Loans."Oustanding Interest" * 0.5;
                        //MESSAGE('BALANCE %1',Lbal);
                        ////{
                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", LoansREC."Loan  No.");
                        if LoanGuar.Find('-') then begin
                            //LoanGuar.RESET;
                            //LoanGuar.SETRANGE(LoanGuar."Loan No",Loans."Loan  No.");
                            repeat
                                LoanGuar.CalcFields(LoanGuar."Total Loans Guaranteed");
                                GrAmount := LoanGuar."Amont Guaranteed";
                                FGrAmount := LoanGuar."Total Loans Guaranteed";
                                //MESSAGE('the total amount guaranteed %1',FGrAmount);
                                //FGrAmount+LoanGuar."Amount Guarnted";
                                Amount2 := (GrAmount / FGrAmount) * (Lbal + INTBAL + COMM);
                            until LoanGuar.Next = 0;
                        end;
                        //Defaulter loan clear
                        //MESSAGE('BALANCE %1',Amount2);
                        //}
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
                        LoanGuar.SetRange(LoanGuar."Loan No", LoansREC."Loan  No.");
                        if LoanGuar.Find('-') then begin
                            LoanGuar.Reset;
                            LoanGuar.SetRange(LoanGuar."Loan No", LoansREC."Loan  No.");
                            //DLN:='DLN';
                            repeat
                                GenSetUp.Get();
                                GenSetUp."Defaulter LN" := GenSetUp."Defaulter LN" + 10;
                                GenSetUp.Modify;
                                //DLN:='DLN'+FORMAT(GenSetUp."Defaulter LN");
                                TGrAmount := TGrAmount + GrAmount;
                                CalcFields("Total Loans Guaranteed");
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
                            //Amount2:=ROUND((GrAmount/FGrAmount)*((Lbal+INTBAL+COMM)),1,'>');
                            //((GrAmount/FGrAmount)*(Lbal+INTBAL+COMM))
                            /*
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
                            */
                            until LoanGuar.Next = 0;
                        end;

                    end;

                }
            }
            trigger OnPreDataItem();
            begin
                SenderName := 'Mrs E. MIUNDO';
                CompanyInformation.Get();
                CompanyInformation.CalcFields(CompanyInformation.Picture);
            end;

            trigger OnAfterGetRecord();
            begin
                LoansREC.CalcFields(LoansREC."Outstanding Balance", LoansREC."Oustanding Interest", LoansREC."No. Of Guarantors");
                NoGuarantors := LoansREC."No. Of Guarantors";
                if NoGuarantors = 0 then
                    NoGuarantors := 1;
                LBalance := LoansREC."Outstanding Balance" + LoansREC."Oustanding Interest";
                LBalance1 := LoansREC."Outstanding Balance";
                Balance := Balance - (LoansREC."Outstanding Balance" + LoansREC."Interest Due");
                if excludeshares <> true then begin
                    if Cust.Get(LoansREC."Client Code") then begin
                        Cust.CalcFields(Cust."Current Shares");
                        TotalAss := Cust."Current Shares" * -1;
                    end;
                end;
                SharesB := SharesB - (LoansREC."Outstanding Balance" + LoansREC."Interest Due");
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
                LoansREC.CalcFields(LoansREC."Outstanding Balance", LoansREC."Oustanding Interest");
                Lbal := ROUND(LoansREC."Outstanding Balance", 0.5, '=');
                if LoansREC."Oustanding Interest" > 0 then begin
                    INTBAL := LoansREC."Oustanding Interest";
                    COMM := ROUND((LoansREC."Oustanding Interest" * 0.5), 1, '>');
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
				Amount2:=((GrAmount/FGrAmount)*(Lbal+INTBAL+COMM));//(GrAmount/TGrAmount)*(Lbal+INTBAL+COMM);
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
				GrAmount:=LoanGuar."Amount Guarnted";
				//LoanGuar."Amount Guarnted";
				TGrAmount:=TGrAmount+GrAmount;
				Amount2:=(GrAmount/TGrAmount)*(Lbal+INTBAL+COMM);
				//Amount2:=ROUND((GrAmount/FGrAmount)*(Lbal+INTBAL+COMM),0.5,'=');  //xyz
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
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
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
        Balance: Decimal;
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
        SendSMS: Boolean;
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Cust1: Record Customer;
        CompanyInformation: Record "Company Information";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516393_v6_3_0_2259;
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
