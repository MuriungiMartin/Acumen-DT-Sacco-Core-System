#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516511_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516511 "INterest DueMonthly E_Loan"
{
    UsageCategory = Tasks;
    RDLCLayout = './Layouts/INterestDueMonthlyE_Loan.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Loans; "Loans Register")
        {
            DataItemTableView = where("Loan Product Type" = filter('E-LOAN'), "Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Loan  No.";
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            trigger OnPreDataItem();
            begin
                PostDate := Today;
                DocNo := 'E-Loan';
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
                //*********************************************************
                // MESSAGE (FORMAT(Loans."Client Name"));
                LoanDisDate := PostDate - Loans."Loan Disbursement Date";
                // MESSAGE (FORMAT(LoanDisDate));
                if LoanDisDate = 32 then begin
                    // MESSAGE (FORMAT(Loans."Client Name"));
                    //	REPEAT
                    //Datefilter:=FORMAT(CALCDATE('-CM',PostDate))+ '..' + FORMAT(CALCDATE('CM',PostDate));
                    //
                    // // // MESSAGE (FORMAT(Datefilter));
                    // //  MemberLedgerEntry.RESET;
                    // //  MemberLedgerEntry.SETRANGE(MemberLedgerEntry."Loan No",Loans."Loan  No.");
                    // //  MemberLedgerEntry.SETFILTER(MemberLedgerEntry."Posting Date",Datefilter);
                    // //  MemberLedgerEntry.SETRANGE(MemberLedgerEntry.Reversed,FALSE);
                    // //  IF MemberLedgerEntry.FIND ('-') THEN
                    // //  CurrReport.SKIP;
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
                    InterestDue := ROUND((Loans."Approved Amount" * 0.05), 1, '>');
                    GenJournalLine.Amount := InterestDue;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if LoanType.Get(Loans."Loan Product Type") then begin
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := LoanType."Loan Interest Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    end;
                    GenJournalLine."Shortcut Dimension 1 Code" := Format(Loans.Source);
                    GenJournalLine."Shortcut Dimension 2 Code" := Loans."Branch Code";
                    GenJournalLine."Loan No" := Loans."Loan  No.";
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //MESSAGE (FORMAT(Loans."Client Name"));
                    //END;
                    // // UNTIL Loans.NEXT =0;
                    //		 GenJournalLine.RESET;
                    //		GenJournalLine.SETRANGE("Journal Template Name",'General');
                    //		 GenJournalLine.SETRANGE("Journal Batch Name",'INT DUE');
                    //		 IF GenJournalLine.FIND('-') THEN BEGIN
                    //		   MESSAGE ( 'doc is %1',GenJournalLine."Document No.");
                    //				CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJournalLine);
                    //
                    //		END;
                end;
            end;

            trigger OnPostDataItem();
            begin
                // // // //  MESSAGE ('Interest Posted Successfully');
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'General');
                GenJournalLine.SetRange("Journal Batch Name", 'INT DUE');
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                    ///CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco",GenJournalLine);
                end;
                // // ///SFactory.FnPostGnlJournalLine('General','INT_DUE');
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
        GenBatches: Record "Gen. Journal Batch";
        ASAT: Date;
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
        loanapp: Record "Loans Register";
        SDATE: Text[30];
        InterestDue: Decimal;
        ObjInterestDue: Record "Monthly Interest Acrual";
        Datefilter: Text;
        MemberLedgerEntry: Record "Cust. Ledger Entry";
        LoanDisDate: Integer;
        PaymentShecdule: Record "Loans Register";
        SFactory: Codeunit "SURESTEP Factory.";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516511_v6_3_0_2259;
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
