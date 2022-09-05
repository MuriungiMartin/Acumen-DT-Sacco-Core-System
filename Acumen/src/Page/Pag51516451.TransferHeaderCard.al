#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516451 "Transfer Header Card"
{
    PageType = Card;
    SourceTable = "Bank Transfer Header Details";

    layout
    {
        area(content)
        {
            group("EFT Batch")
            {
                Caption = 'EFT Batch';
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank  No"; "Bank  No")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field(Bank; Bank)
                {
                    ApplicationArea = Basic;
                }
                field(Total; Total)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count"; "Total Count")
                {
                    ApplicationArea = Basic;
                    Caption = 'Record Count';
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                }
                field(Transferred; Transferred)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Transferred"; "Date Transferred")
                {
                    ApplicationArea = Basic;
                }
                field("Time Transferred"; "Time Transferred")
                {
                    ApplicationArea = Basic;
                }
                field("Transferred By"; "Transferred By")
                {
                    ApplicationArea = Basic;
                }
                field(RTGS; RTGS)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1; "EFT Details")
            {
                SubPageLink = "Header No" = field(No);
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Get)
            {
                Caption = 'Get';
                action("Standing Orders EFT")
                {
                    ApplicationArea = Basic;
                    Caption = 'Standing Orders EFT';
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Transferred = true then
                            Error('EFT Batch already transfered. Please use another one.');

                        STORegister.Reset;
                        STORegister.SetRange(STORegister.EFT, true);
                        STORegister.SetRange(STORegister."Transfered to EFT", false);
                        if STORegister.Find('-') then begin
                            repeat
                                EFTDetails.Init;
                                EFTDetails.No := '';
                                EFTDetails."Header No" := No;
                                EFTDetails."Account No" := STORegister."Source Account No.";
                                //EFTDetails."Account Name":=STORegister."Account Name";
                                EFTDetails.Validate(EFTDetails."Account No");
                                //IF Accounts.GET(EFTDetails."Account No") THEN BEGIN
                                //EFTDetails."Account Type":=Accounts."Account Type";
                                //EFTDetails."Staff No":=Account."Staff No";
                                //END;
                                EFTDetails.Amount := STORegister."Amount Deducted";
                                EFTDetails."Destination Account Type" := EFTDetails."destination account type"::External;
                                //EFTDetails."Destination Account No":=STORegister."Destination Account No.";
                                if STO.Get(STORegister."Standing Order No.") then begin
                                    EFTDetails."Destination Account No" := STO."Destination Account No.";
                                    EFTDetails."Bank No" := STO."Bank Code";
                                    EFTDetails.Validate(EFTDetails."Bank No");
                                end;
                                EFTDetails."Destination Account Name" := CopyStr(STORegister."Destination Account Name", 1, 28);
                                EFTDetails."Standing Order No" := STORegister."Standing Order No.";
                                EFTDetails."Standing Order Register No" := STORegister."Register No.";
                                EFTDetails.Charges := 0;
                                if EFTDetails.Amount > 0 then
                                    EFTDetails.Insert(true)

                            until STORegister.Next = 0
                        end;
                    end;
                }
                action(Action1102760031)
                {
                    ApplicationArea = Basic;
                    Caption = 'Standing Orders EFT';

                    trigger OnAction()
                    begin
                        /*IF Transferred = TRUE THEN
                        ERROR('EFT Batch already transfered. Please use another one.');
                        
                        EFTHeader.RESET;
                        EFTHeader.SETRANGE(EFTHeader.No,No);
                        IF EFTHeader.FIND('-') THEN
                        REPORT.RUN(,TRUE,TRUE,EFTHeader)
                         */

                    end;
                }
                separator(Action1102760024)
                {
                }
                action("Salary EFT")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary EFT';

                    trigger OnAction()
                    begin
                        /*IF Transferred = TRUE THEN
                        ERROR('EFT Batch already transfered. Please use another one.');
                        
                        EFTHeader.RESET;
                        EFTHeader.SETRANGE(EFTHeader.No,No);
                        IF EFTHeader.FIND('-') THEN
                        REPORT.RUN(,TRUE,TRUE,EFTHeader)
                        */

                    end;
                }
                separator(Action1102760027)
                {
                }
                action("Re-genarate EFT Format")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re-genarate EFT Format';
                    Visible = false;

                    trigger OnAction()
                    begin

                        EFTDetails.Reset;
                        EFTDetails.SetRange(EFTDetails."Header No", No);
                        if EFTDetails.Find('-') then begin
                            repeat
                                EFTDetails.TestField(EFTDetails."Destination Account No");
                                EFTDetails.TestField(EFTDetails.Amount);
                                EFTDetails.TestField(EFTDetails."Destination Account Name");
                                EFTDetails.TestField(EFTDetails."Bank No");

                                if StrLen(EFTDetails."Destination Account Name") > 28 then
                                    Error('Destnation account name of staff no %1 more than 28 characters.', EFTDetails."Staff No");

                                if StrLen(EFTDetails."Destination Account No") > 14 then
                                    Error('Destnation account of staff no %1 more than 14 characters.', EFTDetails."Staff No");

                                //For STIMA, replace staff No with stima
                                ReffNo := 'STIMA';

                                if EFTDetails.Amount <> ROUND(EFTDetails.Amount, 1) then begin
                                    if EFTDetails.Amount <> ROUND(EFTDetails.Amount, 0.1) then begin
                                        EFTDetails.ExportFormat := PadStr('', 14 - StrLen(EFTDetails."Destination Account No"), ' ') + EFTDetails."Destination Account No" +
                                                                 PadStr('', 5, ' ') +
                                                                 PadStr('', 6 - StrLen(EFTDetails."Bank No"), ' ') + EFTDetails."Bank No" + ' ' +
                                                                 EFTDetails."Destination Account Name" + PadStr('', 30 - StrLen(EFTDetails."Destination Account Name"), ' ') +
                                                                 PadStr('', 9 - StrLen(DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                        DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',') +
                                                                 PadStr('', 8 - StrLen(CopyStr(ReffNo, 1, 8)), ' ') + ReffNo;
                                    end else begin
                                        EFTDetails.ExportFormat := PadStr('', 14 - StrLen(EFTDetails."Destination Account No"), ' ') + EFTDetails."Destination Account No" +
                                                                 PadStr('', 5, ' ') +
                                                                 PadStr('', 6 - StrLen(EFTDetails."Bank No"), ' ') + EFTDetails."Bank No" + ' ' +
                                                                 EFTDetails."Destination Account Name" + PadStr('', 30 - StrLen(EFTDetails."Destination Account Name"), ' ') +
                                                                 PadStr('', 8 - StrLen(DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                        DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',') + '0' +
                                                                 PadStr('', 8 - StrLen(CopyStr(ReffNo, 1, 8)), ' ') + ReffNo;
                                    end;
                                end else begin
                                    TextGen := Format(EFTDetails."Staff No");

                                    EFTDetails.ExportFormat := PadStr('', 14 - StrLen(EFTDetails."Destination Account No"), ' ') + EFTDetails."Destination Account No" +
                                                             PadStr('', 5, ' ') +
                                                             PadStr('', 6 - StrLen(EFTDetails."Bank No"), ' ') + EFTDetails."Bank No" + ' ' +
                                                             EFTDetails."Destination Account Name" + PadStr('', 30 - StrLen(EFTDetails."Destination Account Name"), ' ') +
                                                             PadStr('', 7 - StrLen(DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                    DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',') + '00' +
                                                             PadStr('', 8 - StrLen(CopyStr(ReffNo, 1, 8)), ' ') + ReffNo;
                                end;



                                EFTDetails.Modify;
                            until EFTDetails.Next = 0;
                        end;




                        EFTDetails.Reset;
                        EFTDetails.SetRange(EFTDetails."Header No", No);
                        if EFTDetails.Find('-') then
;
                    end;
                }
                separator(Action1102760032)
                {
                }
                action("Dividends EFT")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividends EFT';

                    trigger OnAction()
                    begin
                        //IF Transferred = TRUE THEN
                        //ERROR('EFT Batch already transfered. Please use another one.');
                        /*
                        EFTHeader.RESET;
                        EFTHeader.SETRANGE(EFTHeader.No,No);
                        IF EFTHeader.FIND('-') THEN
                        REPORT.RUN(,TRUE,TRUE,EFTHeader)
                        */

                    end;
                }
                separator(Action1102760035)
                {
                }
                action("Salary Dividends EFT")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary Dividends EFT';

                    trigger OnAction()
                    begin
                        /*IF Transferred = TRUE THEN
                        ERROR('EFT Batch already transfered. Please use another one.');
                        
                        EFTHeader.RESET;
                        EFTHeader.SETRANGE(EFTHeader.No,No);
                        IF EFTHeader.FIND('-') THEN
                        REPORT.RUN(,TRUE,TRUE,EFTHeader)
                        */

                    end;
                }
                separator(Action1102760034)
                {
                }
                action("Generate Dividends EFT")
                {
                    ApplicationArea = Basic;
                    Caption = 'Generate Dividends EFT';

                    trigger OnAction()
                    begin

                        EFTDetails.Reset;
                        EFTDetails.SetRange(EFTDetails."Header No", No);
                        if EFTDetails.Find('-') then begin
                            repeat
                                EFTDetails.TestField(EFTDetails."Destination Account No");
                                EFTDetails.TestField(EFTDetails.Amount);
                                EFTDetails.TestField(EFTDetails."Destination Account Name");
                                EFTDetails.TestField(EFTDetails."Bank No");

                                if StrLen(EFTDetails."Destination Account Name") > 28 then
                                    Error('Destnation account name of staff no %1 more than 28 characters.', EFTDetails."Staff No");

                                if StrLen(EFTDetails."Destination Account No") > 14 then
                                    Error('Destnation account of staff no %1 more than 14 characters.', EFTDetails."Staff No");

                                //For STIMA, replace staff No with stima
                                ReffNo := 'STIMA';

                                if EFTDetails.Amount <> ROUND(EFTDetails.Amount, 1) then begin
                                    if EFTDetails.Amount <> ROUND(EFTDetails.Amount, 0.1) then begin
                                        EFTDetails.ExportFormat := PadStr('', 14 - StrLen(EFTDetails."Destination Account No"), ' ') + EFTDetails."Destination Account No" +
                                                                 PadStr('', 5, ' ') +
                                                                 PadStr('', 6 - StrLen(EFTDetails."Bank No"), ' ') + EFTDetails."Bank No" + ' ' +
                                                                 EFTDetails."Destination Account Name" + PadStr('', 30 - StrLen(EFTDetails."Destination Account Name"), ' ') +
                                                                 PadStr('', 9 - StrLen(DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                        DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',') +
                                                                 PadStr('', 8 - StrLen(CopyStr(ReffNo, 1, 8)), ' ') + ReffNo;
                                    end else begin
                                        EFTDetails.ExportFormat := PadStr('', 14 - StrLen(EFTDetails."Destination Account No"), ' ') + EFTDetails."Destination Account No" +
                                                                 PadStr('', 5, ' ') +
                                                                 PadStr('', 6 - StrLen(EFTDetails."Bank No"), ' ') + EFTDetails."Bank No" + ' ' +
                                                                 EFTDetails."Destination Account Name" + PadStr('', 30 - StrLen(EFTDetails."Destination Account Name"), ' ') +
                                                                 PadStr('', 8 - StrLen(DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                        DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',') + '0' +
                                                                 PadStr('', 8 - StrLen(CopyStr(ReffNo, 1, 8)), ' ') + ReffNo;
                                    end;
                                end else begin
                                    TextGen := Format(EFTDetails."Staff No");

                                    EFTDetails.ExportFormat := PadStr('', 14 - StrLen(EFTDetails."Destination Account No"), ' ') + EFTDetails."Destination Account No" +
                                                             PadStr('', 5, ' ') +
                                                             PadStr('', 6 - StrLen(EFTDetails."Bank No"), ' ') + EFTDetails."Bank No" + ' ' +
                                                             EFTDetails."Destination Account Name" + PadStr('', 30 - StrLen(EFTDetails."Destination Account Name"), ' ') +
                                                             PadStr('', 7 - StrLen(DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                    DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',') + '00' +
                                                             PadStr('', 8 - StrLen(CopyStr(ReffNo, 1, 8)), ' ') + ReffNo;
                                end;



                                EFTDetails.Modify;
                            until EFTDetails.Next = 0;
                        end;




                        EFTDetails.Reset;
                        EFTDetails.SetRange(EFTDetails."Header No", No);
                        if EFTDetails.Find('-') then
;
                    end;
                }
            }
        }
        area(processing)
        {
            action("View Schedule")
            {
                ApplicationArea = Basic;
                Caption = 'View Schedule';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    EFTHeader.Reset;
                    EFTHeader.SetRange(EFTHeader.No, No);
                    if EFTHeader.Find('-') then
                        Report.Run(51516526, true, true, EFTHeader)
                end;
            }
            action(Transfer)
            {
                ApplicationArea = Basic;
                Caption = 'Transfer';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    TestField(Remarks);

                    if Transferred = true then
                        Error('Funds transfers has already been done.');

                    if Confirm('Are you absolutely sure you want to post the EFT/RTGS tranfers.', false) = false then
                        exit;


                    GenJournalLine.Reset;
                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'EFT');
                    if GenJournalLine.Find('-') then
                        GenJournalLine.DeleteAll;

                    EFTDetails.Reset;
                    EFTDetails.SetRange(EFTDetails."Header No", No);
                    if EFTDetails.Find('-') then begin
                        repeat



                            if EFTDetails."Destination Account Type" = EFTDetails."destination account type"::Internal then begin

                                EFTDetails.TestField(EFTDetails."Destination Account No");
                                EFTDetails.TestField(EFTDetails.Amount);
                                EFTDetails.TestField(EFTDetails."Destination Account Name");
                                //EFTDetails.TESTFIELD(EFTDetails."Bank No");


                                //Source Account***************************************************************************
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'EFT';
                                GenJournalLine."Document No." := No;
                                GenJournalLine."External Document No." := CopyStr(EFTDetails."Destination Account No", 1, 20);
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := EFTDetails."Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'EFT to Account ' + EFTDetails."Destination Account No";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := EFTDetails.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Balancing Account*********************************************************************
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'EFT';
                                GenJournalLine."Document No." := No;
                                GenJournalLine."External Document No." := CopyStr(EFTDetails."Destination Account No", 1, 20);
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := EFTDetails."Destination Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'EFT from Account ' + EFTDetails."Account No";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -EFTDetails.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Charges*****************************************************************
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'EFT';
                                GenJournalLine."Document No." := No;
                                GenJournalLine."External Document No." := CopyStr(EFTDetails."Destination Account No", 1, 20);
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := EFTDetails."Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                if RTGS = true then
                                    GenJournalLine.Description := 'RTGS Charges'
                                else
                                    GenJournalLine.Description := 'EFT Charges';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := EFTDetails.Charges;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := EFTDetails."EFT Charges Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Excise Duty*****************************************************************
                                GenSetup.Get();
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'EFT';
                                GenJournalLine."Document No." := No;
                                GenJournalLine."External Document No." := CopyStr(EFTDetails."Destination Account No", 1, 20);
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := EFTDetails."Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Excise Duty';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := EFTDetails.Charges * GenSetup."Excise Duty(%)" / 100;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;



                            end;




                            //External EFT**************************************************************
                            if EFTDetails."Destination Account Type" = EFTDetails."destination account type"::External then begin

                                EFTDetails.TestField(EFTDetails."Bank No");


                                //Source Account***************************************************************************
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'EFT';
                                GenJournalLine."Document No." := No;
                                GenJournalLine."External Document No." := CopyStr(EFTDetails."Destination Account No", 1, 20);
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := EFTDetails."Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                if RTGS = true then
                                    GenJournalLine.Description := 'RTGS' + EFTDetails."Payee Bank Name"
                                else
                                    GenJournalLine.Description := 'EFT to Account' + EFTDetails."Payee Bank Name";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := EFTDetails.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Balancing Account*********************************************************************
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'EFT';
                                GenJournalLine."Document No." := No;
                                GenJournalLine."External Document No." := CopyStr(EFTDetails."Destination Account No", 1, 20);
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                                GenJournalLine."Account No." := "Bank  No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'EFT' + EFTDetails."Account No" + '-' + EFTDetails."Account Name";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -EFTDetails.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Charges*****************************************************************
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'EFT';
                                GenJournalLine."Document No." := No;
                                GenJournalLine."External Document No." := CopyStr(EFTDetails."Destination Account No", 1, 20);
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := EFTDetails."Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                if RTGS = true then
                                    GenJournalLine.Description := 'RTGS Charges'
                                else
                                    GenJournalLine.Description := 'EFT Charges';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := EFTDetails.Charges;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := EFTDetails."EFT Charges Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Excise Duty*****************************************************************
                                GenSetup.Get();
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'EFT';
                                GenJournalLine."Document No." := No;
                                GenJournalLine."External Document No." := CopyStr(EFTDetails."Destination Account No", 1, 20);
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := EFTDetails."Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Excise Duty';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := EFTDetails.Charges * GenSetup."Excise Duty(%)" / 100;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                            end;

                        until EFTDetails.Next = 0;
                    end;


                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                    GenJournalLine.SetRange("Journal Batch Name", 'EFT');
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;


                    Transferred := true;
                    "Date Transferred" := Today;
                    "Time Transferred" := Time;
                    "Transferred By" := UserId;
                    Modify;


                    Message('Transaction Posted successfully.');
                end;
            }
        }
    }

    var
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Account: Record Vendor;
        AccountType: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        LineNo: Integer;
        EFTDetails: Record "EFT Details";
        STORegister: Record "Standing Order Register";
        Accounts: Record Vendor;
        EFTHeader: Record "Bank Transfer Header Details";
        Transactions: Record Transactions;
        TextGen: Text[250];
        STO: Record "Standing Orders";
        ReffNo: Code[20];
        GenSetup: Record "Sacco General Set-Up";
}

