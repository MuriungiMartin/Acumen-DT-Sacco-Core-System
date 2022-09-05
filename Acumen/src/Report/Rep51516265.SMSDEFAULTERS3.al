#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{
    assembly("ForNav.Reports.6.3.0.2259")
    {
        type(ForNav.Report_6_3_0_2259; ForNavReport51516265_v6_3_0_2259) { }
    }
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 51516265 "SMS DEFAULTERS 3"
{
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/SMSDEFAULTERS3.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            column(ReportForNavId_1; 1) { } // Autogenerated by ForNav - Do not delete
            trigger OnAfterGetRecord();
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'LOANS');
                GenJournalLine.SetRange(GenJournalLine."Document No.", 'DEFAULTERS');
                if GenJournalLine.Find('-') then
                    GenJournalLine.DeleteAll;
                LGuarantors.Reset;
                LGuarantors.SetRange(LGuarantors."Loan  No.", "Loans Register"."Loan  No.");
                if LGuarantors.Find('-') then begin
                    //REPEAT
                    LGuarantors.CalcFields(LGuarantors."Outstanding Balance");
                    Cust.Reset;
                    Cust.SetRange(Cust."No.", LGuarantors."Client Code");
                    //Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                    if Cust.Find('-') then begin
                        // IF CONFIRM('Do you want to notify Loanee?',FALSE,TRUE) THEN
                        //Steve guarantor SMS
                        SMSMessages.Reset;
                        if SMSMessages.Find('+') then begin
                            iEntryNo := SMSMessages."Entry No";
                            iEntryNo := iEntryNo + 1;
                        end
                        else begin
                            iEntryNo := 1;
                        end;
                        SMSMessages.Init;
                        SMSMessages."Entry No" := iEntryNo;
                        SMSMessages."Account No" := LGuarantors."Client Code";
                        SMSMessages."Date Entered" := Today;
                        SMSMessages."Time Entered" := Time;
                        SMSMessages.Source := 'LOAN DEFAULTER';
                        SMSMessages."Entered By" := UserId;
                        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
                        SMSMessages."SMS Message" := 'Defaulter FINAL Notice: Dear '
                                + LGuarantors."Client Name" + ' kindly note that you have defaulted your loan' + LGuarantors."Loan  No." + ' by KSHs.' + Format(LGuarantors."Amount in Arrears") +
                                                      ' at ACUMEN SACCO LTD. Kindly clear your loan arrears within 14 Days after which we will recover it from your savings';
                        //IF LoanApp.GET(Lguarantors//."Loan No") THEN
                        SMSMessages."Telephone No" := Cust."Mobile Phone No";
                        SMSMessages.Insert;
                        //MESSAGE('%1',Cust."Phone No.");
                        /*LGuarantors.RESET;
                        LGuarantors.SETRANGE(LGuarantors."Loan  No.","Loans Register"."Loan  No.");
                        IF Charge."Sms Charge" <>0 THEN BEGIN
                        IF LGuarantors.FIND('-') THEN BEGIN
                        REPEAT
                          IF Cust.FIND('-') THEN BEGIN
                          Cust.RESET;
                          Cust.SETRANGE(Cust."No.",LGuarantors."Client Code");
                          //Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                            LineNo:=LineNo+10000;
                            GenJournalLine.INIT;
                            GenJournalLine."Journal Template Name":='GENERAL';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Document No.":='DEFAULTERS';
                            GenJournalLine."Posting Date":=TODAY;
                            GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                           // MESSAGE('%1',GenJournalLine."Account Type");
                            GenJournalLine."Account No.":=LGuarantors."Client Code";
                           // MESSAGE('%1',GenJournalLine."Account No.");
                            IF Charge.FIND('-') THEN
                            GenJournalLine.Amount:=Charge."Sms Charge";
                           // MESSAGE('%1',GenJournalLine.Amount);
                            GenJournalLine."Loan No":=LGuarantors."Loan  No.";
                            GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::Loan;
                           // LoanApps.TESTFIELD(LGuarantors."Client Code");
                            GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                            GenJournalLine."Bal. Account No.":='10501';
                           // GenJournalLine."Account No.":=LGuarantors."Client Code";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                           // IF (LoanApps."Account No" = '350011') OR (LoanApps."Account No" = '350012') THEN BEGIN
                            GenJournalLine.Description:=LoanApps."Client Name";
                            IF Cust.GET(LoanApps."Client Code") THEN
                            GenJournalLine."External Document No.":=Cust."ID No.";
                            END ELSE
                           // GenJournalLine.Description:='Bridging Loan Recovery';
                            GenJournalLine.Amount:=5;
                            GenJournalLine.VALIDATE(GenJournalLine.Amount);
                        //	GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        //	GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                           // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            IF GenJournalLine.Amount<>0 THEN
                            GenJournalLine.INSERT;
                        //	//END;
                        // UNTIL LGuarantors.NEXT=0;
                        //  END;
                         CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Line",GenJournalLine);
                            //END;
                         UNTIL LGuarantors.NEXT=0;
                          END;
                          END;*/
                    end;
                    ;
                    //END;
                    //	END;
                    // UNTIL LGuarantors.NEXT=0;
                    //  END;
                    //////bill
                    LGuarantor.Reset;
                    LGuarantor.SetRange(LGuarantor."Loan No", "Loan  No.");
                    if LGuarantor.Find('-') then begin
                        //REPEAT
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", LGuarantor."Member No");
                        //Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                        if Cust.Find('-') then begin
                            // IF CONFIRM('Do you want to notify Guarantors?',FALSE,TRUE) THEN
                            //Steve guarantor SMS
                            SMSMessages.Reset;
                            if SMSMessages.Find('+') then begin
                                iEntryNo := SMSMessages."Entry No";
                                iEntryNo := iEntryNo + 1;
                            end
                            else begin
                                iEntryNo := 1;
                            end;
                            SMSMessages.Init;
                            SMSMessages."Entry No" := iEntryNo;
                            SMSMessages."Account No" := LGuarantor."Member No";
                            SMSMessages."Date Entered" := Today;
                            SMSMessages."Time Entered" := Time;
                            SMSMessages.Source := 'LOAN DEFAULTER';
                            SMSMessages."Entered By" := UserId;
                            SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
                            SMSMessages."SMS Message" := 'Defaulter Final Notice: This is to notify you that '
                                + LGuarantor."Loanees  Name" + ' has defaulted a loan' + LGuarantors."Loan  No." + ' you had guaranteed by KSHs.' + Format(LGuarantor."Amont Guaranteed") +
                                                          ' at ACUMEN SACCO LTD. ';
                            //IF LoanApp.GET(Lguarantors//."Loan No") THEN
                            SMSMessages."Telephone No" := Cust."Mobile Phone No";
                            SMSMessages.Insert;
                            //MESSAGE('%1',Cust."Phone No.");
                        end;
                    end;
                    // UNTIL LGuarantor.NEXT=0;
                    //END;
                    //UNTIL LGuarantor.NEXT=0;
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
        LGuarantors: Record "Loans Register";
        Cust: Record Customer;
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        Charge: Record "Sacco General Set-Up";
        LoanApps: Record "Loans Register";
        LGuarantor: Record "Loans Guarantee Details";

    // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        [WithEvents]
        ReportForNav: DotNet ForNavReport51516265_v6_3_0_2259;
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
