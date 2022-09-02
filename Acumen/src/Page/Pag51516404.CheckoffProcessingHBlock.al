#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516404 "Checkoff Processing H(Block)"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Checkoff Processing H(Block)";
    SourceTableView = where(Posted = const(false));

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
                    Enabled = false;
                }
                field("Date Entered"; "Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date"; "Posting date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Loan CutOff Date"; "Loan CutOff Date")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count"; "Total Count")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field("Scheduled Amount"; "Scheduled Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("Bosa receipt lines"; "Checkoff Processing Lin(Block)")
            {
                SubPageLink = "Receipt Header No" = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Clear Lines")
            {
                ApplicationArea = Basic;
                Enabled = ActionEnabled;
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('This Action will clear all the Lines for the current Check off. Do you want to Continue') = false then
                        exit;
                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Receipt Header No", No);
                    ReceiptLine.DeleteAll;

                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'CHECKOFF';
                    DOCUMENT_NO := Remarks;
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;
                end;
            }
            action("Import Checkoff Block")
            {
                ApplicationArea = Basic;
                Caption = 'Import Checkoff';
                Enabled = ActionEnabled;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = XMLport "Import Checkoff Lines(Block)";
            }
            group(ActionGroup27)
            {
            }
            action("Validate Checkoff")
            {
                ApplicationArea = Basic;
                Caption = 'Validate Checkoff';
                Enabled = ActionEnabled;
                Image = ViewCheck;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    TestField("Document No");
                    TestField(Amount);

                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'CHECKOFF';
                    DOCUMENT_NO := Remarks;
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;

                    MembLedg.Reset;
                    MembLedg.SetRange(MembLedg."Document No.", No);
                    if MembLedg.Find('-') = true then
                        Error('Sorry,You have already posted this Document. Validation not Allowed.');
                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Receipt Header No", No);
                    if ReceiptLine.FindSet(true, true) then begin
                        repeat
                            ReceiptLine."Member No" := '';
                            ReceiptLine.Name := '';
                            ReceiptLine.Modify;
                        until ReceiptLine.Next = 0;
                    end;

                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Receipt Header No", No);
                    if ReceiptLine.Find('-') then begin
                        repeat
                            Memb.Reset;
                            Memb.SetRange("No.", ReceiptLine."Staff/Payroll No");
                            //  "Personal No"
                            if Memb.Find('-') then begin
                                ReceiptLine."Member No" := Memb."No.";
                                ReceiptLine.Name := Memb.Name;
                                ReceiptLine.Modify;
                            end;
                        until ReceiptLine.Next = 0;
                    end;
                    Message('Validation was successfully completed');
                end;
            }
            group(ActionGroup24)
            {
            }
            action("Process Checkoff")
            {
                ApplicationArea = Basic;
                Caption = 'Process Checkoff';
                Enabled = ActionEnabled;
                Image = Apply;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Transfer this Checkoff to Journals ?') = true then begin
                        TestField("Document No");
                        TestField(Amount);
                        if Amount <> "Scheduled Amount" then
                            Error('Scheduled Amount must be equal to the Cheque Amount');

                        Datefilter := '..' + Format("Posting date");

                        BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'CHECKOFF';
                        DOCUMENT_NO := Remarks;
                        Counter := 0;
                        Percentage := 0;
                        TotalCount := 0;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                        GenJournalLine.DeleteAll;
                        LineNo := 0;
                        ReceiptLine.Reset;
                        ReceiptLine.SetRange("Receipt Header No", No);
                        if ReceiptLine.Find('-') then begin
                            Window.Open('@1@');
                            TotalCount := ReceiptLine.Count;
                            repeat
                                FnUpdateProgressBar();
                                if ReceiptLine."Member No" <> '' then begin
                                    //IF ReceiptLine.FIND('-')
                                    RunBal := 0;

                                    RunBal := ReceiptLine.Amount;
                                    //1. Registration fee
                                    RunBal := FnRunRegFee(ReceiptLine, RunBal);
                                    //2. Sharecapital

                                    RunBal := FnRunShareCapital(ReceiptLine, RunBal);
                                    //3. Loan Interest
                                    RunBal := FnRunInterest(ReceiptLine, RunBal);

                                    //4. Loan Insurance
                                    //to add when testing loans
                                    //5. Loan principal
                                    RunBal := FnRunPrincipal(ReceiptLine, RunBal);
                                    //6. Benevolent fund
                                    //MESSAGE('%1',RunBal);
                                    RunBal := FnRunBenevolentFund(ReceiptLine, RunBal);
                                    //7. Deposits fund
                                    RunBal := FnRunDeposits(ReceiptLine, RunBal);
                                    //FnRunUnAllocated(ReceiptLine,RunBal);
                                end;
                            until ReceiptLine.Next = 0;
                        end;
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        "Account Type", "Account No", "Posting date", Amount, 'BOSA', "Document No",
                        Remarks, '');

                        Window.Close;
                        Message('Checkoff successfully Generated Jouranls ready for posting');
                    end;
                end;
            }
            action("Mark as Posted")
            {
                ApplicationArea = Basic;
                Enabled = not ActionEnabled;
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to mark this Checkoff as Posted ?', false) = true then begin
                        MembLedg.Reset;
                        MembLedg.SetRange(MembLedg."Document No.", Remarks);
                        if MembLedg.Find('-') = false then
                            Error('Sorry,You can only do this process on already posted Checkoffs');
                        Posted := true;
                        "Posted By" := UserId;
                        "Posting date" := Today;
                        Modify;
                    end;
                end;
            }
            action(Journals)
            {
                ApplicationArea = Basic;
                Caption = 'General Journal';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedOnly = true;
                RunObject = Page "General Journal";
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ActionEnabled := true;
        MembLedg.Reset;
        MembLedg.SetRange(MembLedg."Document No.", No);
        if MembLedg.Find('-') then begin
            ActionEnabled := false;
            Message('HERE');
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Posting date" := Today;
        "Date Entered" := Today;
    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        InterestToRecover: Decimal;
        LoanCutoffDate: Date;
        MonthlyRepay: Decimal;
        ScheduleRepayment: Decimal;
        ReceiptsProcessingLines: Record "Checkoff Processing Lin(Block)";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Checkoff Header-Distributed";
        Cust: Record "Member Register";
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        RcptBufLines: Record "Checkoff Processing Lin(Block)";
        LoanType: Record "Loan Products Setup";
        LoanApp: Record "Loans Register";
        Interest: Decimal;
        LineN: Integer;
        TotalRepay: Decimal;
        MultipleLoan: Integer;
        LType: Text;
        MonthlyAmount: Decimal;
        ShRec: Decimal;
        SHARESCAP: Decimal;
        DIFF: Decimal;
        DIFFPAID: Decimal;
        genstup: Record "Sacco General Set-Up";
        Memb: Record "Member Register";
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        ReceiptLine: Record "Checkoff Processing Lin(Block)";
        MembLedg: Record "Cust. Ledger Entry";
        SFactory: Codeunit "SURESTEP Factory.";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        GenJournalLine: Record "Gen. Journal Line";
        ActionEnabled: Boolean;
        XMLCheckOff: XmlPort UnknownXmlPort51516003;
        Window: Dialog;
        TotalCount: Integer;
        Counter: Integer;
        Percentage: Integer;

    local procedure FnGetFosaAccountNo(BosaAccountNo: Code[40]; "Product Code": Code[100]): Code[100]
    var
        ObjVendor: Record Vendor;
    begin
        ObjVendor.Reset;
        ObjVendor.SetRange("BOSA Account No", BosaAccountNo);
        ObjVendor.SetRange("Account Type", "Product Code");
        if ObjVendor.Find('-') then
            exit(ObjVendor."No.");
    end;

    local procedure FnRunInterest(ObjRcptBuffer: Record "Checkoff Processing Lin(Block)"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ReceiptLine: Record "Checkoff Processing Lin(Block)";
    begin
        /*
        IF RunningBalance > 0 THEN BEGIN
        LoanApp.RESET;
        LoanApp.SETCURRENTKEY(Source,"Issued Date","Loan Product Type","Client Code","Staff No");
        LoanApp.SETRANGE(LoanApp."Client Code",ObjRcptBuffer."Member No");
        //LoanApp.SETRANGE(LoanApp."Recovery Mode",LoanApp."Recovery Mode"::Checkoff);
        //LoanApp.SETFILTER(LoanApp."Date filter",Datefilter); //Deduct all interest outstanding regardless of date
        //LoanApp.SETRANGE(LoanApp."Issued Date",startDate,IssueDate);
        IF LoanApp.FIND('-') THEN
          BEGIN
            REPEAT
            LoanApp.CALCFIELDS(LoanApp."Oustanding Interest");
            IF (LoanApp."Oustanding Interest">0) AND (LoanApp."Issued Date"<=LoanCutoffDate) THEN
              BEGIN
                    IF  RunningBalance > 0 THEN //300
                      BEGIN
                        AmountToDeduct:=0;
                        InterestToRecover:=(LoanApp."Oustanding Interest");//100
                        IF RunningBalance >= InterestToRecover THEN
                        AmountToDeduct:=InterestToRecover
                        ELSE
                        AmountToDeduct:=RunningBalance;
        
                        LineN:=LineN+10000;
                        Gnljnline.INIT;
                        Gnljnline."Journal Template Name":='GENERAL';
                        Gnljnline."Journal Batch Name":='CHECKOFF';
                        Gnljnline."Line No.":=LineN;
                        Gnljnline."Account Type":=Gnljnline."Account Type"::Member;
                        Gnljnline."Account No.":=LoanApp."Client Code";
                        Gnljnline.VALIDATE(Gnljnline."Account No.");
                        Gnljnline."Document No.":="Document No";
                        Gnljnline."Posting Date":="Posting date";
                        Gnljnline.Description:=LoanApp."Loan Product Type"+'-Loan Interest Paid ';
                        Gnljnline.Amount:=-1*AmountToDeduct;
                        Gnljnline.VALIDATE(Gnljnline.Amount);
                        Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Interest Paid";
                        Gnljnline."Loan No":=LoanApp."Loan  No.";
        
                       // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                        //Gnljnline."Shortcut Dimension 2 Code":=FnGetMemberBranch(LoanApp."Client Code");
                        Gnljnline.VALIDATE(Gnljnline."Shortcut Dimension 1 Code");
                        Gnljnline.VALIDATE(Gnljnline."Shortcut Dimension 2 Code");
                        IF Gnljnline.Amount<>0 THEN
                        Gnljnline.INSERT;
                        RunningBalance:=RunningBalance-ABS(Gnljnline.Amount);
                    END;
                  END;
          UNTIL LoanApp.NEXT = 0;
          END;
          EXIT(RunningBalance);
        END; */
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            //LoanApp.SETRANGE(LoanApp."Loan  No.",LoanApp."Loan  No.");
            LoanApp.SetFilter(LoanApp.Source, '<>%1', LoanApp.Source::FOSA);
            //LoanApp.SETFILTER(LoanApp."Date filter",Datefilter);
            if LoanApp.Find('-') then begin
                repeat
                    if RunningBalance > 0 then begin
                        LoanApp.CalcFields(LoanApp."Oustanding Interest");

                        if LoanApp."Oustanding Interest" > 0 then begin
                            AmountToDeduct := LoanApp."Oustanding Interest";
                            if AmountToDeduct > RunningBalance then
                                AmountToDeduct := RunningBalance;
                        end;
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", AmountToDeduct * -1, Format(LoanApp.Source), "Document No",
                        Format(GenJournalLine."transaction type"::"Interest Paid"), LoanApp."Loan  No.");
                        RunningBalance := RunningBalance - AmountToDeduct;
                        // MESSAGE(FORMAT(RunningBalance));
                        // END;
                    end;
                until LoanApp.Next = 0;
            end;
            exit(RunningBalance);
        end;

    end;

    local procedure FnRunPrincipal(ObjRcptBuffer: Record "Checkoff Processing Lin(Block)"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ReceiptLine: Record "Checkoff Processing Lin(Block)";
    begin
        /*
        IF RunningBalance > 0 THEN BEGIN
        varTotalRepay:=0;
        varMultipleLoan:=0;
        MonthlyRepay:=0;
        ScheduleRepayment:=0;
        
        LoanApp.RESET;
        LoanApp.SETCURRENTKEY(Source,"Issued Date","Loan Product Type","Client Code","Staff No");
        LoanApp.SETRANGE(LoanApp."Client Code",ObjRcptBuffer."Member No");
        //LoanApp.SETRANGE(LoanApp."Recovery Mode",LoanApp."Recovery Mode"::Checkoff);
        //LoanApp.SETRANGE(LoanApp."Issued Date",startDate,IssueDate);
        IF LoanApp.FIND('-') THEN BEGIN
        
          REPEAT
            IF  RunningBalance > 0 THEN
              BEGIN
                LoanApp.CALCFIELDS(LoanApp."Outstanding Balance",LoanApp."Oustanding Interest");
                IF (LoanApp."Outstanding Balance" > 0) THEN BEGIN
                IF (LoanApp."Issued Date"<=LoanCutoffDate)  THEN
                  BEGIN
        
        //            IF LoanApp."Oustanding Interest">=0 THEN
        //              BEGIN
                        AmountToDeduct:=LoanApp."Loan Principle Repayment";
                        MESSAGE(FORMAT(AmountToDeduct));
                       // NewOutstandingBal:=LoanApp."Outstanding Balance"-RunningBalance;
        // //                IF AmountToDeduct >= (LoanApp.Repayment-LoanApp."Oustanding Interest") THEN
        // //                  BEGIN
        // //                    MonthlyRepay:=LoanApp.Repayment-LoanApp."Oustanding Interest";
        // //                    NewOutstandingBal:=LoanApp."Outstanding Balance"-MonthlyRepay;
                          //END ELSE IF  AmountToDeduct < (LoanApp.Repayment-LoanApp."Oustanding Interest") THEN BEGIN
                            //MonthlyRepay:=AmountToDeduct;
                          //  NewOutstandingBal:=LoanApp."Outstanding Balance"-MonthlyRepay;
                      END;
                  END;
        //           IF  MonthlyRepay >=LoanApp."Outstanding Balance" THEN
        //            BEGIN
        //             // AmountToDeduct:=LoanApp."Outstanding Balance";
                     // NewOutstandingBal:=LoanApp."Outstanding Balance"-AmountToDeduct;
                     // MonthlyRepay:=LoanApp."Outstanding Balance";
                     // NewOutstandingBal:=LoanApp."Outstanding Balance"-MonthlyRepay;
                  //  END;
                   //  IF NewOutstandingBal >0 THEN
                       // FnSaveTempLoanAmount(LoanApp,NewOutstandingBal);
        
                          //GET SCHEDULE REPYAMENT
        
                     //   Lschedule.RESET;
        //                Lschedule.SETRANGE(Lschedule."Loan No.",LoanApp."Loan  No.");
        //                //Lschedule.SETRANGE(Lschedule."Repayment Date","Posting date");
        //                IF Lschedule.FINDFIRST THEN BEGIN
        //                  LoanApp.CALCFIELDS(LoanApp."Outstanding Balance",LoanApp."Oustanding Interest");
        //                  //ScheduleRepayment:=Lschedule."Principal Repayment";
        //                  ScheduleRepayment:=Lschedule."Monthly Repayment"-LoanApp."Oustanding Interest";
        //                  IF ScheduleRepayment>LoanApp."Outstanding Balance" THEN BEGIN
        //                      ScheduleRepayment:=LoanApp."Outstanding Balance"
        //                      END ELSE
        //                      ScheduleRepayment:=ScheduleRepayment;
        //                  END;
        
                        LineN:=LineN+10000;
                        Gnljnline.INIT;
                        Gnljnline."Journal Template Name":='GENERAL';
                        Gnljnline."Journal Batch Name":='CHECKOFF';
                        Gnljnline."Line No.":=LineN;
                        Gnljnline."Account Type":=Gnljnline."Account Type"::Member;
                        Gnljnline."Account No.":=LoanApp."Client Code";
                        Gnljnline.VALIDATE(Gnljnline."Account No.");
                        Gnljnline."Document No.":="Document No";
                        Gnljnline."Posting Date":="Posting date";
                        Gnljnline.Description:=LoanApp."Loan Product Type"+'-Loan Repayment ';
                        IF RunningBalance>ScheduleRepayment THEN BEGIN
                        Gnljnline.Amount:=ScheduleRepayment*-1//MonthlyRepay*-1;
                          END ELSE
                          Gnljnline.Amount:=RunningBalance*-1;
                        Gnljnline.VALIDATE(Gnljnline.Amount);
                        Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Loan Repayment";
                        Gnljnline."Loan No":=LoanApp."Loan  No.";
                        //Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                       // Gnljnline."Shortcut Dimension 2 Code":=FnGetMemberBranch(LoanApp."Client Code");
                        Gnljnline.VALIDATE(Gnljnline."Shortcut Dimension 1 Code");
                        Gnljnline.VALIDATE(Gnljnline."Shortcut Dimension 2 Code");
                        IF Gnljnline.Amount<>0 THEN
                        Gnljnline.INSERT;
                        RunningBalance:=RunningBalance-ABS(Gnljnline.Amount);
                      END;
        //         END;
        //         END;
            UNTIL LoanApp.NEXT = 0;
        END;
        EXIT(RunningBalance);
        END;*/


        if RunningBalance > 0 then begin
            //MESSAGE('%1',RunningBalance);
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            //LoanApp.SETFILTER(LoanApp."Product Code",'<>%1'<>'DIVADV' );
            LoanApp.SetFilter(LoanApp.Source, '<>%1', LoanApp.Source::FOSA);
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            if LoanApp.Find('-') then begin
                if LoanApp.Source = LoanApp.Source::BOSA then begin
                    if LoanApp."Product Code" <> 'DIVADV' then
                        repeat
                            if RunningBalance > 0 then begin
                                LoanApp.CalcFields(LoanApp."Outstanding Balance");
                                if LoanApp."Outstanding Balance" > 0 then begin

                                    varLRepayment := 0;
                                    PRpayment := 0;
                                    LoanApp.CalcFields(LoanApp."Outstanding Balance");
                                    if (LoanApp."Outstanding Balance" > 0) then begin
                                        //  MESSAGE(FORMAT(LoanApp."Outstanding Balance"));
                                        varLRepayment := LoanApp."Loan Principle Repayment";
                                        if varLRepayment > 0 then begin
                                            if varLRepayment > LoanApp."Outstanding Balance" then
                                                varLRepayment := LoanApp."Outstanding Balance";

                                            if RunningBalance > 0 then begin
                                                if RunningBalance > varLRepayment then begin
                                                    AmountToDeduct := varLRepayment;
                                                    // MESSAGE
                                                end
                                                else
                                                    AmountToDeduct := RunningBalance;
                                            end;
                                            LineNo := LineNo + 10000;
                                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                            GenJournalLine."account type"::Member, LoanApp."Client Code", "Posting date", AmountToDeduct * -1, Format('BOSA'), "Document No",
                                            Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");
                                            RunningBalance := RunningBalance - AmountToDeduct;

                                        end;
                                    end;
                                end;
                            end;
                        until LoanApp.Next = 0;
                end;

            end;
            exit(RunningBalance);
        end;

    end;

    local procedure FnRunDeposits(ObjRcptBuffer: Record "Checkoff Processing Lin(Block)"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ReceiptLine: Record "Checkoff Processing Lin(Block)";
        ObjMember: Record "Member Register";
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            //ObjMember.SETFILTER(ObjMember."Date Filter",Datefilter);
            if ObjMember.Find('-') then begin
                //ObjMember.CALCFIELDS("Current Shares");
                if RunningBalance > 0 then begin
                    // IF ObjMember."Monthly Contribution" = 0 THEN
                    //BEGIN
                    //MESSAGE(FORMAT(AmountToDeduct));
                    //            AmountToDeduct:=RunningBalance;//ObjMember."Monthly Contribution";
                    //            IF AmountToDeduct > RunningBalance THEN
                    AmountToDeduct := RunningBalance;
                    // MESSAGE(FORMAT(RunningBalance));
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                    GenJournalLine."account type"::Member, ObjMember."No.", "Posting date", AmountToDeduct * -1, 'BOSA', "Document No",
                    Format(GenJournalLine."transaction type"::"Deposit Contribution"), '');
                    // RunningBalance:=RunningBalance-AmountToDeduct;
                end;
            end;
            //END;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunUnAllocated(ObjRcptBuffer: Record "Checkoff Processing Lin(Block)"; RunningBalance: Decimal)
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ReceiptLine: Record "Checkoff Lines-Distributed";
    begin
        if RunningBalance > 0 then begin
            AmountToDeduct := RunningBalance;
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
            GenJournalLine."account type"::Member, ObjRcptBuffer."Member No", "Posting date", AmountToDeduct * -1, 'BOSA', "Document No",
            Format(GenJournalLine."transaction type"::"Deposit Contribution"), '');
            RunningBalance := 0;
        end;
    end;

    local procedure FnRunPrincipleExcessThirdParty(ObjRcptBuffer: Record "Checkoff Processing Lin(Block)"; RunningBalance: Decimal)
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ReceiptLine: Record "Checkoff Lines-Distributed";
    begin
        if RunningBalance > 0 then begin
            varTotalRepay := 0;
            varMultipleLoan := 0;
            LoanApp.Reset;
            LoanApp.SetCurrentkey(Source, "Issued Date", "Loan Product Type", "Client Code", "Staff No", "Employer Code");
            LoanApp.SetRange(LoanApp."Client Code", ObjRcptBuffer."Member No");
            LoanApp.SetFilter(LoanApp."Date filter", Datefilter);
            LoanApp.SetFilter(LoanApp."Loan Product Type", 'GUR');
            if LoanApp.FindFirst then begin
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                GenJournalLine."account type"::Employee, LoanApp."Client Code", "Posting date", RunningBalance * -1, Format(LoanApp.Source), "Document No",
                Format(GenJournalLine."transaction type"::"Loan Repayment"), LoanApp."Loan  No.");
            end;
        end;
    end;

    local procedure FnInitiateProgressBar()
    begin
    end;

    local procedure FnUpdateProgressBar()
    begin
        Percentage := (ROUND(Counter / TotalCount * 10000, 1));
        Counter := Counter + 1;
        Window.Update(1, Percentage);
    end;

    local procedure FnRunRegFee(ObjRcptBuffer: Record "Checkoff Processing Lin(Block)"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ReceiptLine: Record "Checkoff Processing Lin(Block)";
        ObjMember: Record "Member Register";
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            ObjMember.SetFilter(ObjMember."Date Filter", Datefilter);
            if ObjMember.Find('-') then begin
                if RunningBalance > 0 then begin
                    // ObjMember.CALCFIELDS("Registration Fee Paid");
                    if ObjMember."Registration Fee" > 0 then begin
                        AmountToDeduct := ObjMember."Registration Fee";
                        if AmountToDeduct > RunningBalance then
                            AmountToDeduct := RunningBalance;
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Registration Fee",
                        GenJournalLine."account type"::Member, ObjMember."No.", "Posting date", AmountToDeduct * -1, 'BOSA', "Document No",
                        Format(GenJournalLine."transaction type"::"Registration Fee"), '');
                        RunningBalance := RunningBalance - AmountToDeduct;
                    end;
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunShareCapital(ObjRcptBuffer: Record "Checkoff Processing Lin(Block)"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ReceiptLine: Record "Checkoff Processing Lin(Block)";
        ObjMember: Record "Member Register";
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            ObjMember.SetFilter(ObjMember."Date Filter", Datefilter);
            if ObjMember.Find('-') then begin
                if RunningBalance > 0 then begin
                    ObjMember.CalcFields("Shares Retained");
                    genstup.Get();
                    // MESSAGE(FORMAT(ObjMember."Shares Retained"));
                    if ObjMember."Shares Retained" < genstup."Retained Shares" then
                    //  MESSAGE(FORMAT(ObjMember."Shares Retained"));
                    begin
                        AmountToDeduct := genstup."Share Capital Deduction";
                        if AmountToDeduct > RunningBalance then
                            AmountToDeduct := RunningBalance;
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Share Capital",
                        GenJournalLine."account type"::Member, ObjMember."No.", "Posting date", AmountToDeduct * -1, 'BOSA', "Document No",
                        Format(GenJournalLine."transaction type"::"Share Capital"), '');
                        RunningBalance := RunningBalance - AmountToDeduct;
                    end;
                end;
            end;
            exit(RunningBalance);
        end;
    end;

    local procedure FnRunBenevolentFund(ObjRcptBuffer: Record "Checkoff Processing Lin(Block)"; RunningBalance: Decimal): Decimal
    var
        AmountToDeduct: Decimal;
        ObjReceiptTransactions: Record "Receipt Allocation";
        varTotalRepay: Decimal;
        varMultipleLoan: Decimal;
        varLRepayment: Decimal;
        PRpayment: Decimal;
        ReceiptLine: Record "Checkoff Processing Lin(Block)";
        ObjMember: Record "Member Register";
    begin
        if RunningBalance > 0 then begin
            ObjMember.Reset;
            ObjMember.SetRange(ObjMember."No.", ObjRcptBuffer."Member No");
            ObjMember.SetFilter(ObjMember."Date Filter", Datefilter);
            if ObjMember.Find('-') then begin
                if RunningBalance > 0 then begin
                    genstup.Get();
                    AmountToDeduct := genstup."Risk Fund Amount";
                    if AmountToDeduct > RunningBalance then
                        AmountToDeduct := RunningBalance;
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Benevolent Fund",
                    GenJournalLine."account type"::Member, ObjMember."No.", "Posting date", AmountToDeduct * -1, 'BOSA', "Document No",
                    Format(GenJournalLine."transaction type"::"Benevolent Fund"), '');
                    RunningBalance := RunningBalance - AmountToDeduct;

                end;
            end;
            exit(RunningBalance);
        end;
    end;
}

