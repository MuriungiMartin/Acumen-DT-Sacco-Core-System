#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516341 "Pension Processing Header"
{
    PageType = Card;
    SourceTable = "Pension Processing Headerr";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By"; "Entered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Entered"; "Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date"; "Posting date")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count"; "Total Count")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount"; "Scheduled Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Pre-Post Blocked Status Update"; "Pre-Post Blocked Status Update")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Post-Post Blocked Statu Update"; "Post-Post Blocked Statu Update")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("50000"; "Pension Processing Lines")
            {
                Caption = 'Salary Processing Lines';
                SubPageLink = "Salary Header No." = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Salaries")
            {
                ApplicationArea = Basic;
                Caption = 'Import Salaries';
                RunObject = XMLport UnknownXMLport50025;
            }
            group(ActionGroup1102755021)
            {
                action("UnBlocked Accounts Status")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        PensionBuffer.Reset;
                        PensionBuffer.SetRange(PensionBuffer."Salary Header No.", No);
                        if PensionBuffer.Find('-') then
                            Report.Run(51516862, true, false, PensionBuffer);

                        "Pre-Post Blocked Status Update" := true;
                        Modify;
                    end;
                }
                action("Block Blocked Accounts Status")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        PensionBuffer.Reset;
                        PensionBuffer.SetRange(PensionBuffer."Salary Header No.", No);
                        if PensionBuffer.Find('-') then
                            Report.Run(51516863, true, false, PensionBuffer);

                        "Post-Post Blocked Statu Update" := true;
                        Modify;
                    end;
                }
                action("Validate Salary ")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        TestField(No);
                        TestField("Document No");
                        Counter := 0;

                        PensionBuffer.Reset;
                        PensionBuffer.SetRange(PensionBuffer."Salary Header No.", No);
                        if PensionBuffer.FindSet then begin
                            repeat
                                PensionBuffer."Account Name" := '';
                                PensionBuffer."Account No." := '';
                                PensionBuffer.Modify;
                            until PensionBuffer.Next = 0;
                        end;

                        PensionBuffer.Reset;
                        PensionBuffer.SetRange(PensionBuffer."Salary Header No.", No);
                        if PensionBuffer.FindSet then begin
                            Window.Open('Validating' + ': @1@@@@@@@@@@@@@@@' + 'Record:#2###############');
                            TotalCount := PensionBuffer.Count;
                            repeat
                                Percentage := ROUND(Counter / TotalCount * 10000, 1);
                                Counter := Counter + 1;
                                Window.Update(1, Percentage);
                                Window.Update(2, Counter);

                                ObjVend.Reset;
                                ObjVend.SetRange(ObjVend."Pension No", PensionBuffer."Pension No");
                                if ObjVend.FindSet then begin
                                    PensionBuffer."Account No." := ObjVend."No.";
                                    PensionBuffer.Name := ObjVend.Name;
                                    PensionBuffer."Bosa No" := ObjVend."BOSA Account No";
                                    PensionBuffer."ID No." := ObjVend."ID No.";
                                    PensionBuffer.Modify;
                                end;
                            until PensionBuffer.Next = 0;
                            Window.Close;
                        end;


                        /*PensionBuffer.RESET;
                        PensionBuffer.SETRANGE(PensionBuffer."Salary Header No.",No);
                        IF PensionBuffer.FIND('-') THEN
                        REPORT.RUN(51516353,TRUE,FALSE,PensionBuffer);
                        */

                    end;
                }
                action("Generate Pension Batch")
                {
                    ApplicationArea = Basic;
                    Caption = 'Generate Pension Batch';

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Transfer this Pension to Journals ?') = false then
                            exit;

                        TestField("Document No");
                        TestField(Amount);
                        TestField("Cheque No.");

                        DateFilter := '..' + Format("Posting date");
                        if Amount <> "Scheduled Amount" then
                            Error('Scheduled Amount must be equal to the Cheque Amount');

                        Counter := 0;
                        FnProcessPension();
                    end;
                }
                action("Mark as processed")
                {
                    ApplicationArea = Basic;
                    RunObject = Report UnknownReport39004375;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to mark this process as Complete ?') = false then
                            exit;
                        TestField("Document No");
                        TestField(Amount);
                        Counter := 0;
                        PensionBuffer.Reset;
                        PensionBuffer.SetRange("Salary Header No.", No);
                        if PensionBuffer.Find('-') then begin
                            Window.Open('Sending SMS to Members: @1@@@@@@@@@@@@@@@' + 'Record:#2###############');
                            TotalCount := PensionBuffer.Count;
                            repeat
                                //PensionBuffer.CALCFIELDS(PensionBuffer.);
                                Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                                Counter := Counter + 1;
                                Window.Update(1, Percentage);
                                Window.Update(2, Counter);

                                //IF "Transaction Type"="Transaction Type"::"Salary Processing" THEN
                                SFactory.FnSendSMS('PENSION', 'Your Pension has been processed at Nacico Sacco. Dial *850#', PensionBuffer."Account No.", PensionBuffer."Account No.");
                                //ELSE
                                //SFactory.FnSendSMS('SALARIES','Your Instant savings has been processed at Nacico Sacco. Dial *850#',PensionBuffer."Account No.",PensionBuffer."Mobile Phone Number");
                                if ObjVend.Get(PensionBuffer."Account No.") then begin
                                    if ObjVend."Salary Processing" = false then begin
                                        ObjVend."Salary Processing" := true;
                                        ObjVend.Modify;
                                    end
                                end
                            until PensionBuffer.Next = 0;
                        end;
                        Posted := true;
                        "Posted By" := UserId;
                        Message('Process Completed Successfully. Account Holders will receive Pension processing notification via SMS');
                        Window.Close;
                    end;
                }
            }
            group(ActionGroup1102755019)
            {
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Pension := true;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        LineNo: Integer;
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        Cust: Record Customer;
        PensionBuffer: Record "Pension Processing Lines";
        PensHeader: Record "Pension Processing Headerr";
        Sto: Record "Standing Orders";
        Counter: Integer;
        Window: Dialog;
        TotalCount: Integer;
        Percentage: Integer;
        ObjVend: Record Vendor;
        DateFilter: Text;
        BATCH_TEMPLATE: Code[10];
        BATCH_NAME: Code[10];
        DOCUMENT_NO: Code[10];
        EXTERNAL_DOC_NO: Code[10];
        SMSCODE: Code[10];
        ObjGenSetup: Record "Sacco General Set-Up";
        SFactory: Codeunit "SURESTEP Factory.";

    local procedure FnProcessPension()
    begin
        BATCH_TEMPLATE := 'GENERAL';
        BATCH_NAME := 'SALARIES';
        DOCUMENT_NO := "Document No";
        EXTERNAL_DOC_NO := "Cheque No.";

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;

        ObjGenSetup.Get();

        PensionBuffer.Reset;
        PensionBuffer.SetRange("Salary Header No.", No);
        if PensionBuffer.Find('-') then begin
            Window.Open('Pension Processing' + ': @1@@@@@@@@@@@@@@@' + 'Record:#2###############');
            TotalCount := PensionBuffer.Count;
            repeat
                Percentage := (ROUND(Counter / TotalCount * 10000, 1));
                Counter := Counter + 1;
                Window.Update(1, Percentage);
                Window.Update(2, Counter);

                RunBal := PensionBuffer.Amount;
            //RunBal:=FnPostSalaryToFosa(PensionBuffer,RunBal);
            //RunBal:=FnRecoverStatutories(PensionBuffer,RunBal);
            //RunBal:=FnRecoverMobileLoanInterest(PensionBuffer,RunBal);
            //RunBal:=FnRunInterest(PensionBuffer,RunBal);
            //RunBal:=FnRecoverMobileLoanPrincipal(PensionBuffer,RunBal);
            //RunBal:=FnRunPrinciple(PensionBuffer,RunBal);
            //FnRunStandingOrders(PensionBuffer,RunBal);

            until PensionBuffer.Next = 0;
        end;
        //Balancing Journal Entry
        LineNo := LineNo + 10000;
        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
        "Account Type", "Account No", "Posting date", Amount, 'FOSA', EXTERNAL_DOC_NO, DOCUMENT_NO, '');
        Message('Pension journals Successfully Generated. BATCH NO=PENSION.');
        Window.Close;
    end;
}

