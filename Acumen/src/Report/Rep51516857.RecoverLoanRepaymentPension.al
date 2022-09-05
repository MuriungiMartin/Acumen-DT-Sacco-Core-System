#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516857_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516857 "Recover Loan Repayment Pension"
{
    RDLCLayout = './Layouts/RecoverLoanRepaymentPension.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            RequestFilterFields = "Loan  No.", "Client Code", "Account No", "Repayment Start Date", "Date filter";
            column(ReportForNavId_1000000000; 1000000000) { } // Autogenerated by ForNav - Do not delete
            column(LoanNo_LoansRegister; "Loans Register"."Loan  No.")
            {
            }
            column(ApprovedAmount_LoansRegister; "Loans Register"."Approved Amount")
            {
            }
            column(Interest_LoansRegister; "Loans Register".Interest)
            {
            }
            trigger OnAfterGetRecord();
            var
                FOSABalance: Decimal;
            begin
                CalcFields("Outstanding Balance", "Interest Due", "Oustanding Interest");
                FOSABalance := 0;
                ObjVendors.Reset;
                ObjVendors.SetRange(ObjVendors."No.", "Account No");
                if ObjVendors.Find('-') then begin
                    ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                    AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");
                    ObjAccTypes.Reset;
                    ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                    if ObjAccTypes.Find('-') then
                        AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                end;
                //FOSABalance:=FnGetAvailableBalance("Account No");
                FOSABalance := AvailableBal;
                BosaSetUp.Get();
                RunBal := FOSABalance;
                //All Loan Penalties
                if RunBal > 0 then begin
                    Loans.Reset;
                    Loans.SetCurrentkey(Loans.Source, Loans."Client Code");
                    //Loans.SETRANGE(Loans."Client Code","Client Code");
                    Loans.SetRange(Loans."Account No", "Account No");
                    Loans.SetRange(Loans."Recovery Mode", Loans."recovery mode"::Pension);
                    if Loans.Find('-') then begin
                        repeat
                            Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due", Loans."Loans Insurance", Loans."Oustanding Interest", Loans."Penalty Charged");
                            if (Loans."Penalty Charged" > 0) and (RunBal > 0) then begin
                                LOustanding := 0;
                                LineNo := LineNo + 10000;
                                GeneralJnl.Init;
                                GeneralJnl."Journal Template Name" := 'GENERAL';
                                GeneralJnl."Journal Batch Name" := 'RECOVERY';
                                GeneralJnl."Posting Date" := Today;
                                GeneralJnl.Description := 'Loan Penalty';
                                GeneralJnl."Document No." := "Loan  No.";
                                GeneralJnl."Line No." := LineNo;
                                GeneralJnl."Account No." := "Client Code";
                                GeneralJnl."Account Type" := GeneralJnl."account type"::Employee;
                                GeneralJnl."Transaction Type" := GeneralJnl."transaction type"::"23";
                                GeneralJnl."Loan No" := Loans."Loan  No.";
                                if RunBal > Loans."Penalty Charged" then
                                    GeneralJnl.Amount := (Loans."Penalty Charged" * -1)
                                else
                                    GeneralJnl.Amount := RunBal * -1;
                                GeneralJnl."Shortcut Dimension 1 Code" := 'BOSA';
                                GeneralJnl."Bal. Account Type" := GeneralJnl."bal. account type"::Vendor;
                                GeneralJnl."Bal. Account No." := "Account No";
                                //GeneralJnl."Shortcut Dimension 2 Code":=SURESETPFactory.FnGetUserBranch();
                                GeneralJnl.Insert;
                                RunBal := RunBal - GeneralJnl.Amount;
                            end;
                        until Loans.Next = 0;
                    end;
                end;
                //Interest Due
                if RunBal > 0 then begin
                    Loans.Reset;
                    Loans.SetCurrentkey(Loans.Source, Loans."Client Code");
                    //Loans.SETRANGE(Loans."Client Code","Client Code");
                    Loans.SetRange(Loans."Account No", "Account No");
                    Loans.SetRange(Loans."Recovery Mode", Loans."recovery mode"::Pension);
                    if Loans.Find('-') then begin
                        repeat
                            Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due", Loans."Loans Insurance", Loans."Oustanding Interest", Loans."Penalty Charged");
                            if (Loans."Oustanding Interest" > 0) and (RunBal > 0) then begin
                                LOustanding := 0;
                                LineNo := LineNo + 10000;
                                GeneralJnl.Init;
                                GeneralJnl."Journal Template Name" := 'GENERAL';
                                GeneralJnl."Journal Batch Name" := 'RECOVERY';
                                GeneralJnl."Posting Date" := Today;
                                GeneralJnl.Description := 'Interest Due';
                                GeneralJnl."Document No." := "Loan  No.";
                                GeneralJnl."Line No." := LineNo;
                                GeneralJnl."Account Type" := GeneralJnl."account type"::Employee;
                                GeneralJnl."Account No." := "Client Code";
                                GeneralJnl."Transaction Type" := GeneralJnl."transaction type"::"Insurance Contribution";
                                GeneralJnl."Loan No" := Loans."Loan  No.";
                                if RunBal > Loans."Oustanding Interest" then
                                    GeneralJnl.Amount := (Loans."Oustanding Interest" * -1)
                                else
                                    GeneralJnl.Amount := RunBal * -1;
                                GeneralJnl."Shortcut Dimension 1 Code" := 'BOSA';
                                GeneralJnl."Bal. Account Type" := GeneralJnl."bal. account type"::Vendor;
                                GeneralJnl."Bal. Account No." := "Account No";
                                //GeneralJnl."Shortcut Dimension 2 Code":=SURESETPFactory.FnGetUserBranch();
                                GeneralJnl.Insert;
                                RunBal := RunBal - GeneralJnl.Amount;
                            end;
                        until Loans.Next = 0;
                    end;
                end;
                //Loan Repayments
                if RunBal > 0 then begin
                    Loans.Reset;
                    Loans.SetCurrentkey(Loans.Source, Loans."Client Code");
                    //Loans.SETRANGE(Loans."Client Code","Client Code");
                    Loans.SetRange(Loans."Account No", "Account No");
                    Loans.SetRange(Loans."Recovery Mode", Loans."recovery mode"::Pension);
                    if Loans.Find('-') then begin
                        repeat
                            Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due", Loans."Loans Insurance", Loans."Oustanding Interest", Loans."Penalty Charged");
                            if (Loans."Outstanding Balance" > 0) and (RunBal > 0) then begin
                                LineNo := LineNo + 10000;
                                GeneralJnl.Init;
                                GeneralJnl."Journal Template Name" := 'GENERAL';
                                GeneralJnl."Journal Batch Name" := 'RECOVERY';
                                GeneralJnl."Posting Date" := Today;
                                GeneralJnl.Description := 'Principal Repayment';
                                GeneralJnl."Document No." := "Loan  No.";
                                GeneralJnl."Line No." := LineNo;
                                GeneralJnl."Account No." := "Client Code";
                                GeneralJnl."Account Type" := GeneralJnl."account type"::Employee;
                                GeneralJnl."Transaction Type" := GeneralJnl."transaction type"::"Interest Paid";
                                GeneralJnl."Loan No" := Loans."Loan  No.";
                                GeneralJnl.Amount := Loans."Loan Principle Repayment" * -1;
                                if RunBal > Loans."Loan Principle Repayment" then
                                    GeneralJnl.Amount := (Loans."Loan Principle Repayment" * -1)
                                else
                                    GeneralJnl.Amount := RunBal * -1;
                                GeneralJnl."Shortcut Dimension 1 Code" := 'BOSA';
                                GeneralJnl."Bal. Account Type" := GeneralJnl."bal. account type"::Vendor;
                                GeneralJnl."Bal. Account No." := "Account No";
                                //GeneralJnl."Shortcut Dimension 2 Code":=SURESETPFactory.FnGetUserBranch();
                                GeneralJnl.Insert;
                                RunBal := RunBal - GeneralJnl.Amount;
                            end;
                        until Loans.Next = 0;
                    end;
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
        Loans: Record "Loans Register";
        ReceiptAllocations: Record "Receipt Allocation";
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        InterestDueAmt: Decimal;
        PrincipleRepaymentAmt: Decimal;
        GeneralJnl: Record "Gen. Journal Line";
        BosaSetUp: Record "Sacco General Set-Up";
        RunBal: Decimal;
        Cust: Record Customer;
        LOustanding: Decimal;
        LineNo: Integer;

    local procedure FnGetAvailableBalance(AccountNo: Code[50]) AvBalance: Decimal
    begin
        ObjVendors.Reset;
        ObjVendors.SetRange(ObjVendors."No.", AccountNo);
        if ObjVendors.Find('-') then begin
            ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
            AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");
            ObjAccTypes.Reset;
            ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
            if ObjAccTypes.Find('-') then
                AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
        end;
        AvBalance := AvailableBal;
        exit(AvBalance);
    end;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516857_v6_3_0_2259;
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
