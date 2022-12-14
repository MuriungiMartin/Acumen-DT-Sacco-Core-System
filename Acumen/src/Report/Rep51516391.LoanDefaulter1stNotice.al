#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516391_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516391 "Loan Defaulter 1st Notice"
{
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/LoanDefaulter1stNotice.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(LoansREC; "Loans Register")
        {
            RequestFilterFields = "Loan  No.", "Last Pay Date", "Client Code";
            column(ReportForNavId_1102755000; 1102755000) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
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
            column(Loan_No; LoansREC."Loan  No.")
            {
            }
            column(Loan_Product_type; LoansREC."Loan Product Type")
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
                        SMSMessage."SMS Message" := 'Defaulter First Notice: You have defaulted Loan No. '
                        + Loans."Loan  No." + ' of KSHs.' + Format(Loans."Approved Amount") +
                                                  ' at ACUMEN SACCO LTD. ';
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
                        PersonalNo := '';
                        GAddress := '';
                        if Cust.Get("Loan Guarantors"."Member No") then begin
                            PersonalNo := Cust."Personal No";
                            GAddress := Cust.Address + ' ' + Cust."Address 2" + ' ' + Cust.City;
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
                                SMSMessage."SMS Message" := 'Defaulter First Notice: This is to notify you that '
                                + LoansREC."Client Name" + ' has defaulted a loan you had guaranteed of KSHs.' + Format(Loans."Approved Amount") +
                                                          ' at ACUMEN SACCO LTD. ';
                                Cust1.Reset;
                                if Cust1.Get("Loan Guarantors"."Member No") then
                                    SMSMessage."Telephone No" := Cust1."Phone No.";
                                SMSMessage.Insert;
                            end;
                        end;
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
                            //Amount2:=(GrAmount/FGrAmount)*(Lbal+INTBAL+COMM);
                            until LoanGuar.Next = 0;
                        end;
                        //Defaulter loan clear
                        Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due");
                        Lbal := ROUND(Loans."Outstanding Balance", 0.5, '=');
                        INTBAL := Loans."Interest Due";
                        COMM := Loans."Interest Due" * 0.5;
                        //MESSAGE('BALANCE %1',Lbal);
                        //commisision
                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                        if LoanGuar.Find('-') then begin
                            LoanGuar.Reset;
                            LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                            //DLN:='DLN';
                            repeat
                                GenSetUp.Get();
                                GenSetUp."Defaulter LN" := GenSetUp."Defaulter LN" + 10;
                                GenSetUp.Modify;
                                //DLN:='DLN'+FORMAT(GenSetUp."Defaulter LN");
                                //GrAmount:=LoanGuar."Amount Guarnted";
                                //FGrAmount:=FGrAmount+LoanGuar."Amount Guarnted";
                                //LoanGuar."Amount Guarnted";
                                //TGrAmount:=TGrAmount+GrAmount;
                                //Amount2:=(GrAmount/FGrAmount)*(Lbal+INTBAL+COMM);
                                //MESSAGE('guarnteed Amount %1',FGrAmount);
                                //REPEAT
                                ////Insert jnl lines
                                Cust.Reset;
                                Cust.SetRange(Cust."No.", LoanGuar."Member No");
                                if Cust.Find('-') then begin
                                    Loans."Client Name" := Cust.Name;
                                end;
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
                Notified := true;
                //LoansREC."Notified date":=TODAY;
                Modify;
                Balance := Balance - (LoansREC."Outstanding Balance" + LoansREC."Oustanding Interest");
                SharesB := SharesB - (LoansREC."Outstanding Balance" + LoansREC."Oustanding Interest");
                if SharesB < 0 then
                    BalanceType := 'Debit Balance'
                else
                    BalanceType := 'Credit Balance';
                LoanGuar.Reset;
                LoanGuar.SetRange(LoanGuar."Loan No", LoansREC."Loan  No.");
                if LoanGuar.Find('-') then begin
                    LoanGuar.Reset;
                    LoanGuar.SetRange(LoanGuar."Loan No", LoansREC."Loan  No.");
                    repeat
                        TGrAmount := TGrAmount + GrAmount;
                        GrAmount := LoanGuar."Amont Guaranteed";
                        //LoanGuar."Amount Guarnted";
                        FGrAmount := TGrAmount + LoanGuar."Amont Guaranteed";
                    until LoanGuar.Next = 0;
                end;
                //Defaulter loan clear
                LoansREC.CalcFields(LoansREC."Outstanding Balance", LoansREC."Interest Due", LoansREC."Oustanding Interest");
                Lbal := ROUND(LoansREC."Outstanding Balance", 0.5, '=');
                INTBAL := LoansREC."Oustanding Interest";
                COMM := LoansREC."Oustanding Interest" * 0.5;
                Message('BALANCE %1', Lbal);
                //commisision
                if GenSetUp."Send Loan Disbursement SMS" = true then begin
                    FnSendDisburesmentSMS(LoansREC."Loan  No.", LoansREC."Client Code");
                end;
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
        compinfo: Record "Company Information";
        intcount: Integer;
        Balance: Decimal;
        SenderName: Text[150];
        DearM: Text[60];
        BalanceType: Text[100];
        SharesB: Decimal;
        LastPDate: Date;
        Notified: Boolean;
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
        LBalance1: Decimal;
        SendSMS: Boolean;
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Cust1: Record Customer;
        LoanApps: Record "Loans Register";
        CompanyInformation: Record "Company Information";

    procedure FnSendDisburesmentSMS(LoanNo: Code[20]; AccountNo: Code[20])
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
        //SMSMessage."Batch No":="Batch No.";
        SMSMessage."Document No" := LoanNo;
        SMSMessage."Account No" := AccountNo;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'BATCH';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member,Your Loan has been Approved and posted to your FOSA Account,'
        + compinfo.Name + ' ' + GenSetUp."Customer Care No";
        Cust.Reset;
        Cust.SetRange(Cust."No.", AccountNo);
        if Cust.Find('-') then begin
            SMSMessage."Telephone No" := Cust."Mobile Phone No";
        end;
        if Cust."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516391_v6_3_0_2259;
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
