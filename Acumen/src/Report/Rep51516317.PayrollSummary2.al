#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516317_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516317 "Payroll Summary2."
{
    RDLCLayout = './Layouts/PayrollSummary2..rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Dimension Value"; "Dimension Value")
        {
            DataItemTableView = sorting("Dimension Code", Code) where("Dimension Code" = filter('DEPARTMENT'));
            PrintOnlyIfDetail = true;
            column(ReportForNavId_6363; 6363) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Dimension_Value_Name; "Dimension Value".Name)
            {
            }
            column(subTotBasicPay; subTotBasicPay)
            {
            }
            column(SubTotOtherAllow; SubTotOtherAllow)
            {
            }
            column(SubTotGrosspay; SubTotGrosspay)
            {
            }
            column(subTotnonTaxAmount; subTotnonTaxAmount)
            {
            }
            column(subTotstatutoryDed; subTotstatutoryDed)
            {
            }
            column(subTotPension; subTotPension)
            {
            }
            column(subTotNetPay; subTotNetPay)
            {
            }
            column(subtotTotalDeductions; subtotTotalDeductions)
            {
            }
            column(TotBasicPay; TotBasicPay)
            {
            }
            column(TotOtherAllow; TotOtherAllow)
            {
            }
            column(TotGrosspay; TotGrosspay)
            {
            }
            column(TotnonTaxAmount; TotnonTaxAmount)
            {
            }
            column(TotstatutoryDed; TotstatutoryDed)
            {
            }
            column(totTotalDeductions; totTotalDeductions)
            {
            }
            column(TotNetPay; TotNetPay)
            {
            }
            column(TotnonstatutoryDed; TotnonstatutoryDed)
            {
            }
            column(TotPension; TotPension)
            {
            }
            column(TotnegNet; TotnegNet)
            {
            }
            column(NAME_______________________________________; 'NAME........................................................................................')
            {
            }
            column(DESIGNATION_____________________________________________________; 'DESIGNATION....................................................')
            {
            }
            column(SIGNATURE____________________________________________________; 'SIGNATURE...................................................')
            {
            }
            column(DATE____________________________________________________________; 'DATE...........................................................')
            {
            }
            column(NAME________________________________________Control1102756043; 'NAME........................................................................................')
            {
            }
            column(DESIGNATION______________________________________________________Control1102756044; 'DESIGNATION....................................................')
            {
            }
            column(SIGNATURE_____________________________________________________Control1102756046; 'SIGNATURE...................................................')
            {
            }
            column(DATE_____________________________________________________________Control1102756047; 'DATE...........................................................')
            {
            }
            column(Other_AllowancesCaption; Other_AllowancesCaptionLbl)
            {
            }
            column(Gross_Taxable_PayCaption; Gross_Taxable_PayCaptionLbl)
            {
            }
            column(Non_Taxable_AmountCaption; Non_Taxable_AmountCaptionLbl)
            {
            }
            column(Statutory_DeductionsCaption; Statutory_DeductionsCaptionLbl)
            {
            }
            column(Total_DeductionsCaption; Total_DeductionsCaptionLbl)
            {
            }
            column(Net_PayCaption; Net_PayCaptionLbl)
            {
            }
            column(Basic_PayCaption; Basic_PayCaptionLbl)
            {
            }
            column(Employee_Name_Caption; Employee_Name_CaptionLbl)
            {
            }
            column(Payroll_Summary_Per_DepartmentCaption; Payroll_Summary_Per_DepartmentCaptionLbl)
            {
            }
            column(Non_Statutory_DeductionsCaption; Non_Statutory_DeductionsCaptionLbl)
            {
            }
            column(Pension_Staff_Cont_Caption; Pension_Staff_Cont_CaptionLbl)
            {
            }
            column(Negative_Net_PayCaption; Negative_Net_PayCaptionLbl)
            {
            }
            column(Employee_Code_Caption; Employee_Code_CaptionLbl)
            {
            }
            column(Sub_Totals_Caption; Sub_Totals_CaptionLbl)
            {
            }
            column(Totals_Caption; Totals_CaptionLbl)
            {
            }
            column(Checked_byCaption; Checked_byCaptionLbl)
            {
            }
            column(Dimension_Value_Dimension_Code; "Dimension Value"."Dimension Code")
            {
            }
            column(Dimension_Value_Code; "Dimension Value".Code)
            {
            }
            dataitem("Payroll Employee."; "Payroll Employee.")
            {
                DataItemLink = "Global Dimension 1" = field(Code);
                DataItemTableView = sorting("No.");
                column(ReportForNavId_8631; 8631) { } // Autogenerated by ForNav - Do not delete
                column(strEmpName; strEmpName)
                {
                }
                column(BasicPay; BasicPay)
                {
                }
                column(Grosspay; Grosspay)
                {
                }
                column(nonTaxAmount; nonTaxAmount)
                {
                }
                column(statutoryDed; statutoryDed)
                {
                }
                column(NetPay; NetPay)
                {
                }
                column(OtherAllow; OtherAllow)
                {
                }
                column(TotalDeductions; TotalDeductions)
                {
                }
                column(nonstatutoryDed; nonstatutoryDed)
                {
                }
                column(Pension; Pension)
                {
                }
                column(negNet; negNet)
                {
                }
                column(strCodes; strCodes)
                {
                }
                column(HR_Employee_No_; "Payroll Employee."."No.")
                {
                }
                column(HR_Employee_Department_Code; "Payroll Employee."."Global Dimension 1")
                {
                }
                column(TotBasicPay2; TotBasicPay)
                {
                }
                column(TotOtherAllow2; TotOtherAllow)
                {
                }
                column(TotGrosspay2; TotGrosspay)
                {
                }
                column(TotnonTaxAmount2; TotnonTaxAmount)
                {
                }
                column(TotstatutoryDed2; TotstatutoryDed)
                {
                }
                column(totTotalDeductions2; totTotalDeductions)
                {
                }
                column(TotNetPay2; TotNetPay)
                {
                }
                column(TotPension2; TotPension)
                {
                }
                column(TotnegNet2; TotnegNet)
                {
                }
                trigger OnPreDataItem();
                begin
                    if PayrollMode <> Payrollmode::" " then
                        "Payroll Employee.".SetRange("Payroll Employee."."Payment Mode", PayrollMode);
                end;

                trigger OnAfterGetRecord();
                begin
                    strEmpName := Lastname + ' ' + Firstname + ' ' + Surname;
                    strCodes := "No.";
                    BasicPay := 0;
                    Allow := 0;
                    Grosspay := 0;
                    PenGrat := 0;
                    Nssf := 0;
                    HseAllow := 0;
                    statutoryDed := 0;
                    nonstatutoryDed := 0;
                    TaxablePay := 0;
                    Reliefs := 0;
                    OtherAllow := 0;
                    TotalDeductions := 0;
                    NetPay := 0;
                    negNet := 0;
                    nonTaxAmount := 0;
                    Pension := 0;
                    //Loop through the Income/Earnings and deductions************************************************************************
                    PeriodTrans.Reset;
                    PeriodTrans.SetRange(PeriodTrans."Employee Code", "No.");
                    PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                    PeriodTrans.SetCurrentkey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                    PeriodTrans."Group Order", PeriodTrans."Sub Group Order");
                    if PeriodTrans.Find('-') then
                        repeat
                            //Basic Pay************************START
                            if (PeriodTrans."Group Order" = 1) and (PeriodTrans."Sub Group Order" = 1) then begin
                                BasicPay := PeriodTrans.Amount;
                                TotBasicPay := TotBasicPay + BasicPay;
                            end;
                            //Other Allowances************************START
                            if (PeriodTrans."Group Order" = 3) and (PeriodTrans."Sub Group Order" = 0) then begin
                                OtherAllow := OtherAllow + PeriodTrans.Amount;
                                TotOtherAllow := TotOtherAllow + PeriodTrans.Amount;
                            end;
                            //Gross Pay************************START
                            if (PeriodTrans."Group Order" = 4) and (PeriodTrans."Sub Group Order" = 0) then begin
                                Grosspay := Grosspay + PeriodTrans.Amount;
                                TotGrosspay := TotGrosspay + PeriodTrans.Amount;
                            end;
                            //other non taxable*************START
                            TransCodes.Reset;
                            TransCodes.SetRange(TransCodes."Transaction Code", PeriodTrans."Transaction Code");
                            TransCodes.SetRange(TransCodes.Taxable, false);
                            if TransCodes.FindFirst then begin
                                nonTaxAmount := nonTaxAmount + PeriodTrans.Amount;
                                TotnonTaxAmount := TotnonTaxAmount + PeriodTrans.Amount;
                            end;
                            //Statutory Deductions*************START
                            if (PeriodTrans."Group Order" = 7) then begin
                                statutoryDed := statutoryDed + PeriodTrans.Amount;
                                TotstatutoryDed := TotstatutoryDed + PeriodTrans.Amount;
                            end;
                            /*
                            //Non Statutory Deductions*************START
                              IF (PeriodTrans."Group Order"<>7) and (PeriodTrans."Group Order"<>9) AND (PeriodTrans."Group Text"<>'BASIC SALARY') AND
                                (PeriodTrans."Group Text"<>'GROSS PAY') and (PeriodTrans."Group Text"<>'EMPLOYER DEDUCTIONS') THEN
                              BEGIN
                                 nonstatutoryDed:=nonstatutoryDed+PeriodTrans.Amount;
                                 TotnonstatutoryDed:=TotnonstatutoryDed+PeriodTrans.Amount;
                              END;
                             */
                            //Pension *************************** please redo this ;-) dennis tihihihi
                            if (PeriodTrans."Transaction Code" = '0007') then begin
                                Pension := Pension + PeriodTrans.Amount;
                                TotPension := TotPension + PeriodTrans.Amount;
                            end;
                            //Total Deductions***********************
                            if (PeriodTrans."Group Order" = 8) and (PeriodTrans."Sub Group Order" = 9) then begin
                                TotalDeductions := TotalDeductions + PeriodTrans.Amount;
                                totTotalDeductions := totTotalDeductions + PeriodTrans.Amount;
                            end;
                            //Net Pay************************START
                            if (PeriodTrans."Group Order" = 9) and (PeriodTrans."Sub Group Order" = 0) then begin
                                if PeriodTrans.Amount < 0 then begin
                                    NetPay := NetPay + 0;
                                    TotNetPay := TotNetPay + 0;
                                    negNet := PeriodTrans.Amount;
                                    TotnegNet := TotnegNet + PeriodTrans.Amount;
                                end
                                else begin
                                    NetPay := NetPay + PeriodTrans.Amount;
                                    TotNetPay := TotNetPay + PeriodTrans.Amount
                                end;
                            end;
                        until PeriodTrans.Next = 0
                    else
                        CurrReport.Skip;

                end;

            }
            trigger OnAfterGetRecord();
            begin
                //Loop through the Income/Earnings************************************************************************
                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Department Code", "Dimension Value".Code);
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetCurrentkey(PeriodTrans."Employee Code", PeriodTrans."Period Month", PeriodTrans."Period Year",
                PeriodTrans."Group Order", PeriodTrans."Sub Group Order");
                subTotBasicPay := 0;
                subTotHseAllow := 0;
                SubTotOtherAllow := 0;
                SubTotGrosspay := 0;
                subTotnonTaxAmount := 0;
                subTotstatutoryDed := 0;
                subTotnonstatutoryDed := 0;
                subTotPension := 0;
                subTotNetPay := 0;
                if PeriodTrans.Find('-') then
                    repeat
                        //Basic Pay*******************************************************************START
                        if (PeriodTrans."Group Order" = 1) and (PeriodTrans."Sub Group Order" = 1) then begin
                            subTotBasicPay := subTotBasicPay + PeriodTrans.Amount;
                        end;
                        //Other Allowances*************************************************************START
                        if (PeriodTrans."Group Order" = 3) and (PeriodTrans."Sub Group Order" = 0) then begin
                            SubTotOtherAllow := SubTotOtherAllow + PeriodTrans.Amount;
                        end;
                        //Gross Pay********************************************************************START
                        if (PeriodTrans."Group Order" = 4) and (PeriodTrans."Sub Group Order" = 0) then begin
                            SubTotGrosspay := SubTotGrosspay + PeriodTrans.Amount;
                        end;
                        //other non taxable************************************************************START
                        TransCodes.Reset;
                        TransCodes.SetRange(TransCodes."Transaction Code", PeriodTrans."Transaction Code");
                        TransCodes.SetRange(TransCodes.Taxable, false);
                        if TransCodes.Find('-') then begin
                            subTotnonTaxAmount := subTotnonTaxAmount + PeriodTrans.Amount;
                        end;
                        //Statutory Deductions**********************************************************START
                        if (PeriodTrans."Group Order" = 7) then begin
                            subTotstatutoryDed := subTotstatutoryDed + PeriodTrans.Amount;
                        end;
                        //Non Statutory Deductions*************START
                        if (PeriodTrans."Group Order" = 7) then begin
                            subTotnonstatutoryDed := subTotnonstatutoryDed + PeriodTrans.Amount;
                        end;
                        //Pension *************************** please redo this ;-) dennis tihihihi
                        if (PeriodTrans."Transaction Code" = '0007') then begin
                            subTotPension := subTotPension + PeriodTrans.Amount;
                        end;
                        //Total Deductions***********************
                        if (PeriodTrans."Group Order" = 8) and (PeriodTrans."Sub Group Order" = 9) then begin
                            subtotTotalDeductions := subtotTotalDeductions + PeriodTrans.Amount;
                        end;
                        //Net Pay************************START
                        if (PeriodTrans."Group Order" = 9) and (PeriodTrans."Sub Group Order" = 0) then begin
                            if PeriodTrans.Amount < 0 then
                                subTotNetPay := subTotNetPay + 0
                            else
                                subTotNetPay := subTotNetPay + PeriodTrans.Amount;
                        end;
                    until PeriodTrans.Next = 0
                else
                    CurrReport.Skip;
            end;

        }
        dataitem("Payroll Calender."; "Payroll Calender.")
        {
            RequestFilterFields = "Date Opened";
            column(ReportForNavId_4946; 4946) { } // Autogenerated by ForNav - Do not delete
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
        if Usersetup.Get(UserId) then begin
            if Usersetup."View Payroll" = false then Error('You dont have permissions for payroll, Contact your system administrator! ')
        end;
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
        SelectedPeriod := "Payroll Calender.".GetRangeMin("Date Opened");
        ;
        objPeriod.Reset;
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then begin
            PeriodName := objPeriod."Period Name";
        end;
        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
        ;
        ReportsForNavPre;
    end;

    var
        strEmpName: Text[100];
        BasicPay: Decimal;
        Allow: Decimal;
        Grosspay: Decimal;
        PenGrat: Decimal;
        Nssf: Decimal;
        subTotNssf: Decimal;
        TotBasicPay: Decimal;
        TotAllow: Decimal;
        TotGrosspay: Decimal;
        TotPenGrat: Decimal;
        TotNssf: Decimal;
        PeriodTrans: Record "prPeriod Transactions.";
        TransCodes: Record "Payroll Transaction Code.";
        objPeriod: Record "Payroll Calender.";
        SelectedPeriod: Date;
        PeriodName: Text[50];
        HseAllow: Decimal;
        HseTotAllow: Decimal;
        HREmployee: Record "Payroll Employee.";
        subTotNHIF: Decimal;
        TotNHIF: Decimal;
        NHIF: Decimal;
        statutoryDed: Decimal;
        TotstatutoryDed: Decimal;
        subTotstatutoryDed: Decimal;
        TaxablePay: Decimal;
        TotTaxablePay: Decimal;
        SubTotTaxablePay: Decimal;
        Reliefs: Decimal;
        TotReliefs: Decimal;
        TaxCharged: Decimal;
        TotTaxCharged: Decimal;
        UnusedRelief: Decimal;
        SubTotUnusedRelief: Decimal;
        TotUnusedRelief: Decimal;
        PersonalRelief: Decimal;
        SubTotPersonalRelief: Decimal;
        TotPersonalRelief: Decimal;
        PAYETaxDeduction: Decimal;
        TotPAYETaxDeduction: Decimal;
        OtherDeduction: Decimal;
        TotOtherDeduction: Decimal;
        NetPay: Decimal;
        subTotNetPay: Decimal;
        TotNetPay: Decimal;
        subTotBasicPay: Decimal;
        subTotHseAllow: Decimal;
        SubTotGrosspay: Decimal;
        OtherAllow: Decimal;
        TotOtherAllow: Decimal;
        SubTotOtherAllow: Decimal;
        subtotTotalDeductions: Decimal;
        totTotalDeductions: Decimal;
        TotalDeductions: Decimal;
        companyHousing: Decimal;
        TotcompanyHousing: Decimal;
        SubTotcompanyHousing: Decimal;
        subTotReliefs: Decimal;
        SubTotTaxCharged: Decimal;
        subtotPAYETaxDeduction: Decimal;
        subTotOtherDeductions: Decimal;
        nonTaxAmount: Decimal;
        TotnonTaxAmount: Decimal;
        subTotnonTaxAmount: Decimal;
        nonstatutoryDed: Decimal;
        TotnonstatutoryDed: Decimal;
        subTotnonstatutoryDed: Decimal;
        Pension: Decimal;
        TotPension: Decimal;
        subTotPension: Decimal;
        negNet: Decimal;
        TotnegNet: Decimal;
        subTotnegNet: Decimal;
        strCodes: Code[10];
        CompanyInfo: Record "Company Information";
        PayrollMode: Option " ","Bank Transfer",Cheque,Cash,SACCO;
        Other_AllowancesCaptionLbl: label 'Other Allowances';
        Gross_Taxable_PayCaptionLbl: label 'Gross Taxable Pay';
        Non_Taxable_AmountCaptionLbl: label 'Non-Taxable Amount';
        Statutory_DeductionsCaptionLbl: label 'Statutory Deductions';
        Total_DeductionsCaptionLbl: label 'Total Deductions';
        Net_PayCaptionLbl: label 'Net Pay';
        Basic_PayCaptionLbl: label 'Basic Pay';
        Employee_Name_CaptionLbl: label 'Employee Name:';
        Payroll_Summary_Per_DepartmentCaptionLbl: label 'Payroll Summary-Per Department';
        Non_Statutory_DeductionsCaptionLbl: label 'Non Statutory Deductions';
        Pension_Staff_Cont_CaptionLbl: label 'Pension Staff Cont.';
        Negative_Net_PayCaptionLbl: label 'Negative Net Pay';
        Employee_Code_CaptionLbl: label 'Employee Code:';
        Sub_Totals_CaptionLbl: label 'Sub Totals:';
        Totals_CaptionLbl: label 'Totals:';
        Checked_byCaptionLbl: label 'Checked by';
        Usersetup: Record "User Setup";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516317_v6_3_0_2259;
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
