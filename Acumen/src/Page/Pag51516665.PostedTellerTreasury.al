#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516665 "Posted Teller & Treasury"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Treasury Transactions";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Enabled = VarTreasuryTransTypeEditable;

                    trigger OnValidate()
                    begin
                        ExcessShortageVisible := false;

                        if "Transaction Type" = "transaction type"::"End of Day Return to Treasury" then begin
                            ExcessShortageVisible := true;
                        end;

                        FnshowTreasuryCustodiantab();
                    end;
                }
                field("From Account"; "From Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'From';
                    Editable = VarFromEditable;
                }
                field("From Account User"; "From Account User")
                {
                    ApplicationArea = Basic;
                    Caption = 'User';
                    Editable = false;
                }
                field("Source Account Balance"; "Source Account Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("To Account"; "To Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'To';
                    Editable = VarToEditable;
                }
                field("To Account User"; "To Account User")
                {
                    ApplicationArea = Basic;
                    Caption = 'User.';
                    Editable = false;
                }
                field("Destination Account Balance"; "Destination Account Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                    Editable = VarAmountEditable;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque/Document No.';
                    Editable = VarDocumentNoEditable;
                }
                field(Issued; Issued)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Issued"; "Date Issued")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Issued"; "Time Issued")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Issued By"; "Issued By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Received; Received)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Received"; "Date Received")
                {
                    ApplicationArea = Basic;
                }
                field("Time Received"; "Time Received")
                {
                    ApplicationArea = Basic;
                }
                field("Received By"; "Received By")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field(Approved; Approved)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                group("Treasury/IntraDayIssue")
                {
                    Caption = 'Custodian Issue Details';
                    Visible = VarTreasuryIntrDayIssueVisible;
                    field("Custodian 1 Confirm Issue"; "Custodian 1 Confirm Issue")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Custodian 1 Confirmed Issue';
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Custodian 1 Name_Issue"; "Custodian 1 Name_Issue")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Custodian 1 Name';
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Custodian 2 Confirm Issue"; "Custodian 2 Confirm Issue")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Custodian 2 Confirmed Issue';
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Custodian 2 Name_Issue"; "Custodian 2 Name_Issue")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Custodian 2 Name';
                        Editable = false;
                        Importance = Additional;
                    }
                }
                group("Treasury/IntraDayReceipt")
                {
                    Caption = 'Custodian Receipt Details';
                    Visible = VarTreasuryIntrDayReceiptVisible;
                    field("Custodian 1 Confirm Receipt"; "Custodian 1 Confirm Receipt")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Custodian 1 Confirmed Receipt';
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Custodian 1 Name_Receipt"; "Custodian 1 Name_Receipt")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Custodian 1 Name';
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Custodian 2 Confirm Receipt"; "Custodian 2 Confirm Receipt")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Custodian 2 Confirmed Receipt';
                        Editable = false;
                        Importance = Additional;
                    }
                    field("Custodian 2 Name_Receipt"; "Custodian 2 Name_Receipt")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Custodian 2 Name';
                        Editable = false;
                        Importance = Additional;
                    }
                }
                group(DepositSlip)
                {
                    Caption = 'Excess/Shortage';
                    Visible = ExcessShortageVisible;
                    field("Actual Teller Till Balance"; "Actual Teller Till Balance")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Teller Till Balance';
                        Editable = false;
                    }
                    field("Actual Cash At Hand"; "Actual Cash At Hand")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("Excess Amount"; "Excess Amount")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Shortage Amount"; "Shortage Amount")
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
            part(Control1102755000; "Treasury Coinage")
            {
                SubPageLink = No = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(CustodianConfirmIssue)
            {
                ApplicationArea = Basic;
                Caption = 'Custodian Confirm Issue';
                Image = IssueFinanceCharge;
                Promoted = true;
                PromotedCategory = Process;
                Visible = VarTreasuryIntrDayIssueVisible;

                trigger OnAction()
                begin

                    ObjCustodians.Reset;
                    ObjCustodians.SetRange(ObjCustodians."User ID", UserId);
                    ObjCustodians.SetRange(ObjCustodians."Custodian Of", ObjCustodians."custodian of"::Treasury);
                    if ObjCustodians.Find('-') = true then begin
                        if ("Custodian 1 Name_Issue" = '') and ("Custodian 2 Name_Issue" <> UserId) then begin
                            "Custodian 1 Confirm Issue" := true;
                            "Custodian 1 Name_Issue" := UserId
                        end else
                            if ("Custodian 2 Name_Issue" = '') and ("Custodian 1 Name_Issue" <> UserId) then begin
                                "Custodian 2 Confirm Issue" := true;
                                "Custodian 2 Name_Issue" := UserId;
                            end;
                    end;

                    ObjCustodians.Reset;
                    ObjCustodians.SetRange(ObjCustodians."User ID", UserId);
                    ObjCustodians.SetRange(ObjCustodians."Custodian Of", ObjCustodians."custodian of"::Treasury);
                    if ObjCustodians.Find('-') = false then begin
                        Error('You are not authorized to Issue  %1  Transaction', "Transaction Type");
                    end;
                end;
            }
            action(CustodianConfirmReceipt)
            {
                ApplicationArea = Basic;
                Caption = 'Custodian Confirm Receipt';
                Image = Receipt;
                Promoted = true;
                PromotedCategory = Process;
                Visible = VarTreasuryIntrDayReceiptVisible;

                trigger OnAction()
                begin
                    ObjCustodians.Reset;
                    ObjCustodians.SetRange(ObjCustodians."User ID", UserId);
                    ObjCustodians.SetRange(ObjCustodians."Custodian Of", ObjCustodians."custodian of"::Treasury);
                    if ObjCustodians.Find('-') = true then begin
                        if ("Custodian 1 Name_Receipt" = '') and ("Custodian 2 Name_Receipt" <> UserId) then begin
                            "Custodian 1 Confirm Receipt" := true;
                            "Custodian 1 Name_Receipt" := UserId
                        end else
                            if ("Custodian 2 Name_Receipt" = '') and ("Custodian 1 Name_Receipt" <> UserId) then begin
                                "Custodian 2 Confirm Receipt" := true;
                                "Custodian 2 Name_Receipt" := UserId
                            end;
                    end;
                    ObjCustodians.Reset;
                    ObjCustodians.SetRange(ObjCustodians."User ID", UserId);
                    ObjCustodians.SetRange(ObjCustodians."Custodian Of", ObjCustodians."custodian of"::Treasury);
                    if ObjCustodians.Find('-') = false then begin
                        Error('You are not authorized to Receive  %1 Transactions', "Transaction Type");
                    end;
                end;
            }
            action("Issue/Return")
            {
                ApplicationArea = Basic;
                Caption = 'Issue/Return';
                Image = Interaction;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //--------------------Confirm Both Custodians has Confirmed Issue----------------------------------
                    if ("Transaction Type" = "transaction type"::"Issue To Teller") or ("Transaction Type" = "transaction type"::"Treasury to Intra-Day") or
                      ("Transaction Type" = "transaction type"::"Intra-Day to Teller") or ("Transaction Type" = "transaction type"::"Issue From Bank")
                      or ("Transaction Type" = "transaction type"::"Return To Bank") or ("Transaction Type" = "transaction type"::"Branch Treasury Transactions") or
                      ("Transaction Type" = "transaction type"::"Intra-Day to Treasury") then begin
                        if ("Custodian 1 Confirm Issue" <> true) or ("Custodian 2 Confirm Issue" <> true) then begin
                            Error('Custodians have to Confirm issue before you can do %1 ', "Transaction Type");
                        end;
                    end;
                    //--------------------End Confirm Both Custodians has Confirmed Issue----------------------------------





                    TestField(Amount);
                    TestField("From Account");
                    TestField("To Account");



                    if ("Transaction Type" = "transaction type"::"Return To Bank") or ("Transaction Type" = "transaction type"::"Issue From Bank") then begin
                        if Status <> Status::Approved then begin
                            Error('This Transaction is not Approved');
                        end;
                    end;


                    if ("Transaction Type" = "transaction type"::"Issue To Teller") or
                    ("Transaction Type" = "transaction type"::"Return To Treasury") or
                    ("Transaction Type" = "transaction type"::"Inter Teller Transfers") or
                    ("Transaction Type" = "transaction type"::"End of Day Return to Treasury") or
                    ("Transaction Type" = "transaction type"::"Intra-Day to Treasury") or
                    ("Transaction Type" = "transaction type"::"Intra-Day to Teller") or
                    ("Transaction Type" = "transaction type"::"Teller to Intra-Day") or
                    ("Transaction Type" = "transaction type"::"11") or
                    ("Transaction Type" = "transaction type"::"Treasury to Intra-Day")
                     then begin
                        if Issued = Issued::Yes then
                            Error('The money has already been issued.');

                        TellerTill.Reset;
                        TellerTill.SetRange(TellerTill."No.", "From Account");
                        if TellerTill.Find('-') then begin
                            if UpperCase(UserId) <> TellerTill.CashierID then
                                Error('You do not have permission to transact on this teller till/Account.');
                        end;





                        Banks.Reset;
                        Banks.SetRange(Banks."No.", "From Account");
                        if Banks.Find('-') then begin
                            Banks.CalcFields(Banks."Balance (LCY)");
                            BankBal := Banks."Balance (LCY)";
                            if Amount > BankBal then begin
                                Error('You cannot issue more than the account balance.')
                            end;
                        end;
                        //confirm
                        TellerTill.Reset;
                        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
                        TellerTill.SetRange(TellerTill."No.", "To Account");
                        if TellerTill.Find('-') then begin
                            if UpperCase(UserId) <> TellerTill.CashierID then
                                Error('You do not have permission to transact on this teller till/Account.');

                            TellerTill.CalcFields(TellerTill.Balance);
                            CurrentTellerAmount := TellerTill.Balance;
                            if CurrentTellerAmount + Amount > TellerTill."Maximum Teller Withholding" then
                                Error('The transaction will result in the teller having a balance more than the maximum allowable therefor terminated.');
                            //MESSAGE('CONTINUE TRANSACTION');
                        end;



                        if Confirm('Are you sure you want to make this issue?', false) = true then begin
                            Issued := Issued::Yes;
                            "Date Issued" := Today;
                            "Time Issued" := Time;
                            "Issued By" := UpperCase(UserId);
                            Modify;
                        end;


                        Message('Money successfully issued/Returned.');
                    end else begin
                        if "Transaction Type" = "transaction type"::"Return To Bank" then begin
                            TestField(Amount);
                            TestField("From Account");
                            TestField("To Account");


                            Banks.Reset;
                            Banks.SetRange(Banks."No.", "From Account");
                            if Banks.Find('-') then begin
                                Banks.CalcFields("Balance (LCY)");
                                if Amount > Banks."Balance (LCY)" then
                                    Error('You cannot receive more than balance in ' + "From Account")
                            end;

                            if Confirm('Are you sure you want to make this return?', false) = false then
                                exit;

                            //Delete any items present
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                            GenJournalLine.DeleteAll;

                            if DefaultBatch.Get('GENERAL', 'FTRANS') = false then begin
                                DefaultBatch.Init;
                                DefaultBatch."Journal Template Name" := 'GENERAL';
                                DefaultBatch.Name := 'FTRANS';
                                DefaultBatch.Insert;
                            end;


                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'GENERAL';
                            GenJournalLine."Journal Batch Name" := 'FTRANS';
                            GenJournalLine."Document No." := No;
                            GenJournalLine."External Document No." := "Cheque No.";
                            GenJournalLine."Line No." := 10000;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                            GenJournalLine."Account No." := "From Account";
                            GenJournalLine."Posting Date" := Today;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description := Description;
                            GenJournalLine."Currency Code" := "Currency Code";
                            GenJournalLine.Validate(GenJournalLine."Currency Code");
                            GenJournalLine.Amount := -Amount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                            GenJournalLine."Bal. Account No." := "To Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            GenJournalLine.Reset;
                            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                            if GenJournalLine.Find('-') then
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);



                            //GenJournalLine.RESET;
                            //GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name",'GENERAL');
                            //GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name",'FTRANS');
                            //IF GenJournalLine.FIND('-') = FALSE THEN BEGIN
                            Posted := true;
                            "Date Posted" := Today;
                            "Time Posted" := Time;
                            "Posted By" := UpperCase(UserId);

                            Received := Received::Yes;
                            "Date Received" := Today;
                            "Time Received" := Time;
                            "Received By" := UpperCase(UserId);
                            Modify;

                            //END;


                        end else
                            Message('Only applicable for teller, treasury & Bank Issues/Returns.');

                    end;
                end;
            }
            action(Receive)
            {
                ApplicationArea = Basic;
                Caption = 'Receive';
                Image = ReceiveLoaner;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*//----------------Confirm Receipt from Both Custodians-----------------------------------------
                    IF ("Transaction Type"="Transaction Type"::"Return To Treasury") OR ("Transaction Type"="Transaction Type"::"Teller to Intra-Day") OR
                      ("Transaction Type"="Transaction Type"::"Intra-Day to Treasury") OR ("Transaction Type"="Transaction Type"::"Branch Treasury Transactions")
                      OR ("Transaction Type"="Transaction Type"::"Treasury to Intra-Day")
                      THEN
                        BEGIN
                          IF ("Custodian 1 Confirm Receipt"<>TRUE) OR ("Custodian 2 Confirm Receipt"<>TRUE) THEN
                            BEGIN
                              ERROR('Both Custodians have to Confirm receipt before you can do %1 ',"Transaction Type");
                              END;
                        END;
                    //----------------End Confirm Receipt from Both Custodians-----------------------------------------
                    
                    ////cONFIRM WETHER THEY HAVE CUSTODIANS
                    */


                    TestField(Amount);
                    TestField("From Account");
                    TestField("To Account");

                    if "Transaction Type" = "transaction type"::"Issue From Bank" then
                        TestField("Cheque No.");

                    CurrentTellerAmount := 0;
                    if Posted = true then
                        Error('The transaction has already been received and posted.');

                    if "Transaction Type" = "transaction type"::"Inter Teller Transfers" then begin
                        if Approved = false then
                            Error('Inter Teller Transfers must be approved.');
                    end;

                    //IF ("Transaction Type"="Transaction Type"::"Return To Treasury") THEN
                    //ERROR('The issue has not yet been made and therefore you cannot continue with this transaction.');

                    if ("Transaction Type" = "transaction type"::"Issue To Teller") or
                    ("Transaction Type" = "transaction type"::"Branch Treasury Transactions") or
                    ("Transaction Type" = "transaction type"::"Inter Teller Transfers") or
                     ("Transaction Type" = "transaction type"::"Teller to Intra-Day") or
                     ("Transaction Type" = "transaction type"::"Treasury to Intra-Day") then begin
                        if Issued = Issued::No then
                            Error('The issue has not yet been made and therefore you cannot continue with this transaction.');

                        TellerTill.Reset;
                        TellerTill.SetRange(TellerTill."Account Type", TellerTill."account type"::Cashier);
                        TellerTill.SetRange(TellerTill."No.", "To Account");
                        if TellerTill.Find('-') then begin
                            if UpperCase(UserId) <> TellerTill.CashierID then
                                Error('You do not have permission to transact on this teller till/Account.');

                            TellerTill.CalcFields(TellerTill.Balance);
                            CurrentTellerAmount := TellerTill.Balance;
                            if CurrentTellerAmount + Amount > TellerTill."Maximum Teller Withholding" then
                                Error('The transaction will result in the teller having a balance more than the maximum allowable therefor terminated.');
                            //MESSAGE('CONTINUE TRANSACTION');
                        end;
                    end;



                    if Confirm('Are you sure you want to make this receipt?', false) = true then begin
                        //EXIT;

                        //Delete any items present
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                        GenJournalLine.DeleteAll;

                        if DefaultBatch.Get('GENERAL', 'FTRANS') = false then begin
                            DefaultBatch.Init;
                            DefaultBatch."Journal Template Name" := 'GENERAL';
                            DefaultBatch.Name := 'FTRANS';
                            DefaultBatch.Insert;
                        end;


                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Document No." := No;
                        GenJournalLine."Line No." := 10000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                        GenJournalLine."Account No." := "From Account";
                        GenJournalLine."External Document No." := "Cheque No.";
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description := Description;
                        GenJournalLine."Currency Code" := "Currency Code";
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount := -Amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"Bank Account";
                        GenJournalLine."Bal. Account No." := "To Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;


                        /*//Post
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                        GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                        REPEAT
                        GLPosting.RUN(GenJournalLine);
                        UNTIL GenJournalLine.NEXT = 0;
                        END;*/

                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;

                        //Post New

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        GenJournalLine.DeleteAll;
                        //Post

                        //GenJournalLine.RESET;
                        //GenJournalLine.SETRANGE(GenJournalLine."Journal Template Name",'GENERAL');
                        //GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name",'FTRANS');
                        //IF GenJournalLine.FIND('-') = FALSE THEN BEGIN
                        Posted := true;
                        "Date Posted" := Today;
                        "Time Posted" := Time;
                        "Posted By" := UpperCase(UserId);

                        Received := Received::Yes;
                        "Date Received" := Today;
                        "Time Received" := Time;
                        "Received By" := UpperCase(UserId);
                        Modify;

                    end;

                end;
            }
            action("Reprint Issue")
            {
                ApplicationArea = Basic;
                Caption = 'Reprint Issue';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Trans.Reset;
                    Trans.SetRange(Trans.No, No);
                    Trans.SetRange(Trans."Date Posted", "Date Posted");
                    if Trans.Find('-') then
                        Report.Run(51516507, true, true, Trans)
                end;
            }
            action("EOD Report")
            {
                ApplicationArea = Basic;
                Caption = 'End Of Day Report';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Trans.Reset;
                    Trans.SetRange(Trans.No, No);
                    Trans.SetRange(Trans."Date Posted", "Date Posted");
                    if Trans.Find('-') then
                        Report.Run(51516882, true, true, Trans)
                end;
            }
            action(SENDMAIL)
            {
                ApplicationArea = Basic;
                Caption = 'SENDMAIL';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin


                    //SENDMAIL;
                end;
            }
            action(Approve)
            {
                ApplicationArea = Basic;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    TestField("From Account");
                    TestField("To Account");
                    TestField(Amount);

                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Inter Teller Approval");
                    if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to approve inter teller transactions.');


                    Approved := true;
                    Message('Transaction Approved');
                    Modify;
                end;
            }
            action("Update Excess/Shortage")
            {
                ApplicationArea = Basic;
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //FnGetCoinageAmount(No);
                    //FnGetActualAccountBalance();

                    "Shortage Amount" := 0;
                    "Excess Amount" := 0;

                    ExcessShortage := "Actual Cash At Hand" - "Total Cash on Treasury Coinage";
                    if ExcessShortage < 0 then begin
                        "Excess Amount" := ExcessShortage
                    end else
                        "Shortage Amount" := ExcessShortage;


                    //MESSAGE('ActualTillBalance is %1',ActualTillBalance);
                    //"Actual Cash At Hand":=ActualTillBalance;
                    //"Total Cash on Treasury Coinage":=TotalTCoinage;
                end;
            }
            group(Approvals)
            {
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::TreasuryTransactions;
                        ApprovalEntries.Setfilters(Database::"Treasury Transactions", DocumentType, No);
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit WorkflowIntegration;
                    begin

                        if ApprovalsMgmt.CheckTTransactionsApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendTTransactionsForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit WorkflowIntegration;
                    begin

                        //IF Approvalmgt.CancelFOSASTOApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FnGetExcessshortageAmount();
    end;

    trigger OnAfterGetRecord()
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        EnableSendForApprovalBanksOnly := true;

        if ("Transaction Type" <> "transaction type"::"Issue From Bank") or ("Transaction Type" <> "transaction type"::"Return To Bank") then begin
            EnableSendForApprovalBanksOnly := false;
        end;

        VarTreasuryTransTypeEditable := true;
        VarAmountEditable := true;
        VarDocumentNoEditable := true;
        VarFromEditable := true;
        VarToEditable := true;

        if Issued = Issued::Yes then begin
            VarTreasuryTransTypeEditable := false;
            VarAmountEditable := false;
            VarDocumentNoEditable := false;
            VarFromEditable := false;
            VarToEditable := false;
        end;

        FnshowTreasuryCustodiantab();
    end;

    trigger OnOpenPage()
    begin


        ExcessShortageVisible := false;

        if "Transaction Type" = "transaction type"::"End of Day Return to Treasury" then begin
            ExcessShortageVisible := true;
        end;

        if Posted = true then
            CurrPage.Editable := false;

        TellerTill.Reset;
        TellerTill.SetRange(TellerTill.CashierID, UserId);
        TellerTill.CalcFields(TellerTill.Balance);
        if TellerTill.FindSet then begin
            //IF "Transaction Type"="Transaction Type"::"End of Day Return to Treasury" THEN BEGIN
            Amount := TellerTill.Balance;
            "From Account" := TellerTill."No.";
            "From Account User" := TellerTill.CashierID;
            //VALIDATE("From Account");
            //END;
        end;

        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        EnableSendForApprovalBanksOnly := true;

        if ("Transaction Type" <> "transaction type"::"Issue From Bank") or ("Transaction Type" <> "transaction type"::"Return To Bank") then begin
            EnableSendForApprovalBanksOnly := false;
        end;


        VarTreasuryTransTypeEditable := true;
        VarAmountEditable := true;
        VarDocumentNoEditable := true;
        VarFromEditable := true;
        VarToEditable := true;

        if Issued = Issued::Yes then begin
            VarTreasuryTransTypeEditable := false;
            VarAmountEditable := false;
            VarDocumentNoEditable := false;
            VarFromEditable := false;
            VarToEditable := false;
        end;


        FnshowTreasuryCustodiantab();
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        window: Dialog;
        CurrentTellerAmount: Decimal;
        TellerTill: Record "Bank Account";
        Banks: Record "Bank Account";
        BankBal: Decimal;
        TotalBal: Decimal;
        DenominationsRec: Record Denominations;
        TillNo: Code[20];
        Trans: Record "Treasury Transactions";
        UsersID: Record User;
        StatusPermissions: Record "Status Change Permision";
        "Gen-Setup": Record "Sacco General Set-Up";
        SendToAddress: Text[30];
        BankAccount: Record "Bank Account";
        MailContent: Text[150];
        SenderName: Code[20];
        TreauryTrans: Record "Treasury Transactions";
        Coinage: Record "Treasury Coinage";
        ObjCoinage: Record "Treasury Coinage";
        TotalTCoinage: Decimal;
        ActualTillBalance: Decimal;
        ExcessShortage: Decimal;
        "Excess/Shortage": Integer;
        ExcessShortageVisible: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions;
        OpenApprovalEntriesExist: Boolean;
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        EnableSendForApprovalBanksOnly: Boolean;
        VarTreasuryTransTypeEditable: Boolean;
        VarFromEditable: Boolean;
        VarToEditable: Boolean;
        VarAmountEditable: Boolean;
        VarDocumentNoEditable: Boolean;
        VarTreasuryIntrDayIssueVisible: Boolean;
        VarTreasuryIntrDayReceiptVisible: Boolean;
        ObjCustodians: Record "Safe Custody Custodians";

    local procedure FnGetExcessshortageAmount()
    var
        VarExcessShortage: Decimal;
    begin
        VarExcessShortage := 0;

        CalcFields("Actual Cash At Hand");

        VarExcessShortage := "Actual Teller Till Balance" - "Actual Cash At Hand";

        if VarExcessShortage > 0 then begin
            "Shortage Amount" := VarExcessShortage
        end else
            if VarExcessShortage < 0 then begin
                "Excess Amount" := VarExcessShortage * -1
            end else
                if VarExcessShortage = 0 then begin
                    "Shortage Amount" := 0;
                    "Excess Amount" := 0;
                end;
    end;

    local procedure FnshowTreasuryCustodiantab()
    begin
        VarTreasuryIntrDayIssueVisible := false;

        if ("Transaction Type" = "transaction type"::"Issue To Teller") or ("Transaction Type" = "transaction type"::"Treasury to Intra-Day") or
          ("Transaction Type" = "transaction type"::"Intra-Day to Teller") or ("Transaction Type" = "transaction type"::"Issue From Bank")
          or ("Transaction Type" = "transaction type"::"Return To Bank") or ("Transaction Type" = "transaction type"::"Branch Treasury Transactions") or
          ("Transaction Type" = "transaction type"::"Intra-Day to Treasury") then begin
            VarTreasuryIntrDayIssueVisible := true;
        end;

        VarTreasuryIntrDayReceiptVisible := false;

        if ("Transaction Type" = "transaction type"::"Return To Treasury") or ("Transaction Type" = "transaction type"::"Teller to Intra-Day") or
          ("Transaction Type" = "transaction type"::"Intra-Day to Treasury") or ("Transaction Type" = "transaction type"::"Branch Treasury Transactions")
          or ("Transaction Type" = "transaction type"::"Treasury to Intra-Day")
          then begin
            VarTreasuryIntrDayReceiptVisible := true;
        end;
    end;
}

