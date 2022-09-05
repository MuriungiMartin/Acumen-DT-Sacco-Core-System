#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516508_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516508 "Monthly Interest Short Term"
{
    UsageCategory = Tasks;
    RDLCLayout = './Layouts/MonthlyInterestShortTerm.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Loans; "Loans Register")
        {
            CalcFields = "Outstanding Balance";
            DataItemTableView = where(Installments = filter(< 4), "Loan Product Type" = filter('SALADV1' | 'SALADV2' | 'JSORT LOAN'), "Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Date filter", Source, "Repayment Start Date", "Loan  No.", "Client Code", "Account No", "Loan Product Type";
            column(ReportForNavId_4645; 4645) { } // Autogenerated by ForNav - Do not delete
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; Format(ReportForNav.PageNo))
            {
            }
            column(UserId; UserId)
            {
            }
            column(LoanNo; Loans."Loan  No.")
            {
            }
            column(ProductType; Loans."Loan Product Type")
            {
            }
            column(ApprovedAmount; Loans."Approved Amount")
            {
            }
            column(LoansApplicationDate; Loans."Application Date")
            {
            }
            column(IssuedDate; Loans."Issued Date")
            {
            }
            column(RepaymentStartDate; Loans."Repayment Start Date")
            {
            }
            column(ClientCode; Loans."Client Code")
            {
            }
            column(ClientName; Loans."Client Name")
            {
            }
            column(OutstandingBalance; Loans."Outstanding Balance")
            {
            }
            column(InterestDue; InterestDue)
            {
            }
            trigger OnPreDataItem();
            begin
                if PostDate = 0D then
                    Error('Please create Interest period');
                if DocNo = '' then
                    Error('You must specify the Document No.');
                //delete journal line
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'General');
                GenJournalLine.SetRange("Journal Batch Name", 'INT DUE');
                GenJournalLine.DeleteAll;
                //end of deletion
                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name", 'General');
                GenBatches.SetRange(GenBatches.Name, 'INT DUE');
                if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name" := 'General';
                    GenBatches.Name := 'INT DUE';
                    GenBatches.Description := 'Interest Due';
                    GenBatches.Insert;
                end;
                ObjInterestDue.Reset;
                ObjInterestDue.SetRange("Document No", DocNo);
                ObjInterestDue.SetRange(Posted, false);
                ObjInterestDue.DeleteAll;
            end;

            trigger OnAfterGetRecord();
            begin
                // IF Loans."Outstanding Balance" > 0 THEN
                //
                // Datefilter:=FORMAT(CALCDATE('-CM',PostDate))+ '..' + FORMAT(CALCDATE('CM',PostDate));
                //
                // MemberLedgerEntry.RESET;
                // //MemberLedgerEntry.SETRANGE()MemberLedgerEntry."Customer No.",Loans."Client Code");
                // MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Loan No",Loans."Loan  No.");
                // MemberLedgerEntry.SETFILTER(MemberLedgerEntry."Posting Date",Datefilter);
                // MemberLedgerEntry.SETRANGE(MemberLedgerEntry.Reversed,FALSE);
                // IF MemberLedgerEntry.FINDSET THEN
                // CurrReport.SKIP;
                LineNo := LineNo + 10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name" := 'General';
                GenJournalLine."Journal Batch Name" := 'INT DUE';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                GenJournalLine."Account No." := Loans."Client Code";
                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Due";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No." := DocNo;
                GenJournalLine."External Document No." := Loans."Staff No";
                GenJournalLine."Posting Date" := PostDate;
                GenJournalLine.Description := DocNo + ' ' + 'Interest Due';
                //InterestDue:=ROUND(Loans."Outstanding Balance"*(Loans.Interest/1200),0.05,'>');
                //IF Loans."Repayment Method"=Loans."Repayment Method"::"Straight Line"  THEN
                //InterestDue:=ROUND((Loans."Approved Amount"*Loans.Interest/1200),0.05,'>');
                //IF loanapp."Repayment Method"=Loans."Repayment Method"::"Straight Line" THEN
                // IF Loans."Loan Product Type" = 'E-LOAN' THEN BEGIN
                //  InterestDue:=ROUND ((Loans."Approved Amount"*0.05),1,'>');
                //  END ELSE
                InterestDue := ROUND(Loans."Approved Amount" * (Loans.Interest / 1200), 0.05, '>');
                GenJournalLine.Amount := InterestDue;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if LoanType.Get(Loans."Loan Product Type") then begin
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := LoanType."Loan Interest Account";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                end;
                GenJournalLine."Shortcut Dimension 1 Code" := Format(Loans.Source);
                GenJournalLine."Shortcut Dimension 2 Code" := Loans."Branch Code";
                // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                GenJournalLine."Loan No" := Loans."Loan  No.";
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
                ObjInterestDue.Init;
                ObjInterestDue."Document No" := DocNo;
                ObjInterestDue."Transaction Date" := PostDate;
                ObjInterestDue."Member No" := Loans."Client Code";
                ObjInterestDue."Member Name" := Loans."Client Name";
                ObjInterestDue."Employer Code" := Loans."Employer Code";
                ObjInterestDue."Loan Product" := Loans."Loan Product Type";
                ObjInterestDue."Loan No" := Loans."Loan  No.";
                ObjInterestDue."Approved Amount" := Loans."Approved Amount";
                ObjInterestDue."Outstanding Balance" := Loans."Outstanding Balance";
                ObjInterestDue."Interest Rate" := Loans.Interest / 12;
                ObjInterestDue."Interest Accrued" := InterestDue;
                ObjInterestDue."User ID" := UserId;
                ObjInterestDue.Insert;
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
                field(PostDate; PostDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                }
                field(DocNo; DocNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Document No.';
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
        /*//Accounting periods
		AccountingPeriod.SETRANGE(AccountingPeriod.Closed,FALSE);
		IF AccountingPeriod.FIND('-') THEN BEGIN
		  FiscalYearStartDate:= AccountingPeriod."Interest Calcuation Date";
		  PostDate:=(FiscalYearStartDate);
		  DocNo:= AccountingPeriod.Name+'  '+ FORMAT(PostDate);
		END;
		//Accounting periods
		*/
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
        GenBatches: Record "Gen. Journal Batch";
        PDate: Date;
        LoanType: Record "Loan Products Setup";
        PostDate: Date;
        Cust: Record Customer;
        LineNo: Integer;
        DocNo: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        EndDate: Date;
        DontCharge: Boolean;
        Temp: Record "Funds General Setup";
        JBatch: Code[10];
        Jtemplate: Code[10];
        CustLedger: Record "Cust. Ledger Entry";
        AccountingPeriod: Record "Interest Due Period";
        FiscalYearStartDate: Date;
        "ExtDocNo.": Text[30];
        Loan_Application_FormCaptionLbl: label 'Loan Application Form';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        loanapp: Record "Loans Register";
        SDATE: Text[30];
        InterestDue: Decimal;
        ObjInterestDue: Record "Monthly Interest Acrual";
        Datefilter: Text;
        MemberLedgerEntry: Record "Cust. Ledger Entry";

    local procedure FnStaffnumber(MemberNumber: Code[100]): Code[100]
    var
        ObjMembers: Record Customer;
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange("No.", MemberNumber);
        if ObjMembers.Find('-') then begin
            exit(ObjMembers."Personal No");
        end;
    end;

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516508_v6_3_0_2259;
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
