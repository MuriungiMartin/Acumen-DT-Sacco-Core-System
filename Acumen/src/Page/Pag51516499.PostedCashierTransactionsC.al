#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516499 "Posted Cashier Transactions C"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Transactions;
    SourceTableView = where(Posted=filter(true));

    layout
    {
        area(content)
        {
            group(Transactions)
            {
                Caption = 'Transactions';
                field(No;No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Savings Product";"Savings Product")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if Posted = true then
                        Error('You cannot modify an already posted record.');
                        
                        CalcAvailableBal;
                        
                        Clear(AccP.Picture);
                        Clear(AccP.Signature);
                        if AccP.Get("Account No") then begin
                        /*//Hide Accounts
                        IF AccP.Hide = TRUE THEN BEGIN
                        IF UsersID.GET(USERID) THEN BEGIN
                        IF UsersID."Show Hiden" = FALSE THEN
                        ERROR('You do not have permission to transact on this account.');
                        END;
                        END; */
                        //Hide Accounts
                        AccP.CalcFields(AccP.Picture,AccP.Signature);
                        end;
                        
                        CalcFields("Uncleared Cheques");
                        if AccP.Get("Account No") then begin
                        Picture:=AccP.Picture;
                        
                        end;

                    end;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if Posted = true then
                        Error('You cannot modify an already posted record.');

                        FChequeVisible :=false;
                        BChequeVisible :=false;
                        BReceiptVisible :=false;
                        BOSAReceiptChequeVisible :=false;
                        "Branch RefferenceVisible" :=false;
                        LRefVisible :=false;


                        if TransactionTypes.Get("Transaction Type") then begin
                        if TransactionTypes.Type = TransactionTypes.Type::"Cheque Deposit" then begin
                        FChequeVisible :=true;
                        if ("Account No" = '502-00-000300-00') or ("Account No" = '502-00-000303-00') then
                        BOSAReceiptChequeVisible :=true;
                        end;
                        if TransactionTypes.Type = TransactionTypes.Type::"Bankers Cheque" then
                        BChequeVisible :=true;

                        if "Transaction Type" = 'BOSA' then
                        BReceiptVisible :=true;

                        if TransactionTypes.Type = TransactionTypes.Type::Encashment then
                        BReceiptVisible :=true;



                        end;

                        if "Branch Transaction" = true then begin
                        "Branch RefferenceVisible" :=true;
                        LRefVisible :=true;
                        end;

                        if Acc.Get("Account No") then begin
                        if Acc."Account Category" = Acc."account category"::Project then begin
                        "Branch RefferenceVisible" :=true;
                        LRefVisible :=true;
                        end;
                        end;


                        CalcAvailableBal;
                    end;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                group(BCheque)
                {
                    Caption = '.';
                    Visible = BChequeVisible;
                    field("Bankers Cheque No";"Bankers Cheque No")
                    {
                        ApplicationArea = Basic;
                    }
                    field(Payee;Payee)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Post Dated";"Post Dated")
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                            "Transaction DateEditable" := false;
                            if "Post Dated" = true then
                            "Transaction DateEditable" := true
                            else
                            "Transaction Date":=Today;
                        end;
                    }
                }
                group(BReceipt)
                {
                    Caption = '.';
                    Visible = BReceiptVisible;
                    field("BOSA Account No";"BOSA Account No")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Allocated Amount";"Allocated Amount")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(FCheque)
                {
                    Caption = '.';
                    Visible = FChequeVisible;
                    field("Cheque Type";"Cheque Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Cheque No";"Cheque No")
                    {
                        ApplicationArea = Basic;

                        trigger OnValidate()
                        begin
                             if StrLen("Cheque No") <> 6 then
                              Error('Cheque No. cannot contain More or less than 6 Characters.');
                        end;
                    }
                    field("Bank Code";"Bank Code")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Bank';
                    }
                    field("Expected Maturity Date";"Expected Maturity Date")
                    {
                        ApplicationArea = Basic;
                    }
                    field(Status;Status)
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                    }
                    field("50048";"Banking Posted")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Banked';
                        Editable = false;
                    }
                    field("Bank Account";"Bank Account")
                    {
                        ApplicationArea = Basic;
                        Visible = false;
                    }
                    field("Cheque Date";"Cheque Date")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Cheque Deposit Remarks";"Cheque Deposit Remarks")
                    {
                        ApplicationArea = Basic;
                    }
                    group(BOSAReceiptCheque)
                    {
                        Caption = '.';
                        Visible = BOSAReceiptChequeVisible;
                    }
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Description";"Transaction Description")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Branch Refference";"Branch Refference")
                {
                    ApplicationArea = Basic;
                    Caption = 'REF';
                    Visible = "Branch RefferenceVisible";
                }
                field("Book Balance";"Book Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Uncleared Cheques";"Uncleared Cheques")
                {
                    ApplicationArea = Basic;
                }
                field(AvailableBalance;AvailableBalance)
                {
                    ApplicationArea = Basic;
                    Caption = 'Available Balance';
                    Editable = false;
                }
                field("N.A.H Balance";"N.A.H Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No";"ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Cashier;Cashier)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = "Transaction DateEditable";
                }
                field("Transaction Time";"Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field(Authorised;Authorised)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Picture;Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature;Signature)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Transaction)
            {
                Caption = 'Transaction';
                action("Account Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Card';
                    Image = Vendor;
                    Promoted = true;
                    RunObject = Page "FOSA Account Card";
                    RunPageLink = "No."=field("Account No");
                }
                separator(Action1102760031)
                {
                }
            }
            action("Account Statement")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin

                    Vend.Reset;
                    Vend.SetRange(Vend."No.","Account No");
                    if Vend.Find('-') then
                    Report.Run(51516476,true,false,Vend)
                end;
            }
        }
        area(processing)
        {
            action("Reprint Slip")
            {
                ApplicationArea = Basic;
                Caption = 'Reprint Slip';
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    TestField(Posted);

                    Trans.Reset;
                    Trans.SetRange(Trans.No,No);
                    if Trans.Find('-') then begin
                    if Type = 'Cash Deposit' then
                    Report.Run(51516498,true,true,Trans)
                    else if Type = 'Withdrawal' then
                    Report.Run(51516499,true,true,Trans)
                    else if Type = 'Cheque Deposit' then
                    Report.Run(51516500,true,true,Trans)
                    else if Type = 'BOSA Receipt' then
                    Report.Run(51516516,true,true,Trans)
                    //REPORT.RUN(51516486,FALSE,TRUE,Trans)
                    else if Type = 'Transfer' then
                    Report.Run(51516524,true,true,Trans);
                    end;
                end;
            }
            action(SendMail)
            {
                ApplicationArea = Basic;
                Caption = 'SendMail';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    MailContent:='Bankers cheque transaction' + ' ' + 'of Kshs'+ ' '+ Format(Amount) + ' '+ 'for'
                    +' ' +"Account Name"+' '+'needs your approval';


                       SendEmail;
                end;
            }
            action("Clear Cheque")
            {
                ApplicationArea = Basic;
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if "Clearing Posted" = true then
                      Error ('Cheque aready cleared');
                    if  Confirm('Are yo sure you want to bank the selected cheques?',false) = true then begin
                    ///////////......................................................................posted clearing fee
                      //*********************Get User Batches**************************//
                    // IF ObjFundSetUp.GET(USERID) THEN
                    //  BEGIN
                    //    JTemplate:=ObjFundSetUp."FosaTrans Journal Template";
                    //    JBatch:=ObjFundSetUp."FosaTrans Journal Batch";
                    //    END ELSE
                    //    ERROR('contact Administrator for Permission');
                    //*******************End Get User Batches**************************//
                    /////////////////////////////////////

                    //MESSAGE ('jb is %1',JBatch);
                    JTemplate:='General';
                    JBatch:='REGFEE';
                      GenJournalLine.Reset;
                      GenJournalLine.SetRange("Journal Template Name",JTemplate);
                      GenJournalLine.SetRange("Journal Batch Name",JBatch);
                      GenJournalLine.DeleteAll;
                    //////////////////////////////////////////////////////////////////////////////////////////////
                    // // ChargeAmount:=0;
                    // // LineNo:=LineNo+10000;
                    // // ClearingCharge:=0;
                    // // ChargeAmount:=0;
                    // // RegCharge.RESET;
                    // // RegCharge.SETRANGE(RegCharge.Code,'10');
                    // // IF RegCharge.FIND ('-') THEN
                    // //  BEGIN
                    // // ChargeAmount:=RegCharge."Charge Amount";
                    // // END;
                    // // ClearingCharge:=ChargeAmount;
                    // EXIT;
                     ChargeAmount:=0;
                     LineNo:=LineNo+10000;
                     ClearingCharge:=0;
                     ChequeTypes.Reset;
                     if ChequeTypes.Get("Cheque Type") then begin
                     if ChequeTypes."Use %" = true then begin
                     ClearingCharge:=((ChequeTypes."% Of Amount"*0.01)*Amount);
                     end else
                     ClearingCharge:= ChequeTypes."Clearing Charges";


                    //MESSAGE('ClearingCharge%1',ClearingCharge);

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":=JTemplate;
                    GenJournalLine."Journal Batch Name":=JBatch;
                    GenJournalLine."Document No.":=No;
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No.":="Account No";
                    GenJournalLine."External Document No.":="ID No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date":="Cheque Date";
                    GenJournalLine.Description:='Clearing Charges';
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount:=ClearingCharge;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No.":=ChequeTypes."Clearing Charges GL Account";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                    // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                    // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;
                    //Post Charges



                    //Excise Duty
                    genSetup.Get(0);

                    LineNo:=LineNo+10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":=JTemplate;
                    GenJournalLine."Journal Batch Name":=JBatch;
                    GenJournalLine."Document No.":=No;
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No.":="Account No";
                    GenJournalLine."External Document No.":="ID No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date":="Cheque Date";
                    GenJournalLine.Description:='Excise Duty cheque clearingfee';
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount:=(ClearingCharge*genSetup."Excise Duty(%)")/100;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No.":=genSetup."Excise Duty Account";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                    // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                    // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;
                    //
                       GenJournalLine.Reset;
                       GenJournalLine.SetRange("Journal Template Name",JTemplate);
                       GenJournalLine.SetRange("Journal Batch Name",JBatch);
                       if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco",GenJournalLine);
                       end;

                      ///...........................................................................................end
                          "Cheque Processed":="cheque processed"::"1";
                          "Clear Cheque":=true;
                          "Date Cleared":=Today;
                             Modify;
                    end;
                          end;
                            Message ('Cheque  cleared successfully');
                            CurrPage.Close;
                end;
            }
            action("Bounce Cheque")
            {
                ApplicationArea = Basic;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if  Confirm('Are yo sure you want to bank the selected cheques?',false) = true then begin
                    ///////////......................................................................posted clearing fee
                      //*********************Get User Batches**************************//
                    if ObjFundSetUp.Get(UserId) then
                      begin
                        JTemplate:=ObjFundSetUp."FosaTrans Journal Template";
                        JBatch:=ObjFundSetUp."FosaTrans Journal Batch";
                        end else
                        Error('contact Administrator for Permission');
                    //*******************End Get User Batches**************************//

                    if ChequeTypes.Get("Cheque Type") then begin
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name",JTemplate);
                    GenJournalLine.SetRange("Journal Batch Name",JBatch);
                    GenJournalLine.DeleteAll;

                    LineNo:=LineNo+10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":=JTemplate;
                    GenJournalLine."Journal Batch Name":=JBatch;
                    GenJournalLine."Document No.":=No;
                    GenJournalLine."External Document No.":="Cheque No";
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No.":="Account No";

                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date":="Cheque Date";
                    GenJournalLine.Description:='Reversed Cheque'+"Cheque No";;
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount:=(Amount);
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                    //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                    //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;

                    LineNo:=LineNo+10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":=JTemplate;
                    GenJournalLine."Journal Batch Name":=JBatch;
                    GenJournalLine."Document No.":=No;
                    GenJournalLine."External Document No.":="Cheque No";
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No.":="Cheque Clearing Bank Code";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date":="Cheque Date";
                    GenJournalLine.Description:='Reversed Cheque'+"Cheque No";
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount:=Amount*-1;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                    // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                    // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;
                    end;
                    /////................................................................................................////////////////////////////////////
                    ChargeAmount:=0;
                     LineNo:=LineNo+10000;
                     ClearingCharge:=0;
                     ChequeTypes.Reset;
                     if ChequeTypes.Get("Cheque Type") then begin
                     ClearingCharge:= ChequeTypes."Bounced Charges";


                    Message('ClearingCharge%1',ClearingCharge);

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":=JTemplate;
                    GenJournalLine."Journal Batch Name":=JBatch;
                    GenJournalLine."Document No.":=No;
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No.":="Account No";
                    GenJournalLine."External Document No.":="ID No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date":="Cheque Date";
                    GenJournalLine.Description:='Clearing Charges';
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount:=ClearingCharge;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No.":=ChequeTypes."Clearing Charges GL Account";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                    // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                    // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;
                    //Post Charges



                    //Excise Duty
                    genSetup.Get(0);

                    LineNo:=LineNo+10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":=JTemplate;
                    GenJournalLine."Journal Batch Name":=JBatch;
                    GenJournalLine."Document No.":=No;
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No.":="Account No";
                    GenJournalLine."External Document No.":="ID No";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Posting Date":="Cheque Date";
                    GenJournalLine.Description:='Excise Duty';
                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                    GenJournalLine.Amount:=(ClearingCharge*genSetup."Excise Duty(%)")/100;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No.":=genSetup."Excise Duty Account";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                    // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                    // GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;
                    end;
                      ///...........................................................................................end
                          "Cheque Processed":="cheque processed"::"1";
                          "Bounce Cheque":=true;
                          "Date Cleared":=Today;
                             Modify;

                          end;
                            Message ('Cheque  cleared successfully');
                            CurrPage.Close;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        /*CalcAvailableBal;
        CLEAR(AccP.Picture);
        CLEAR(AccP.Signature);
        IF AccP.GET("Account No") THEN BEGIN
        AccP.CALCFIELDS(AccP.Picture);
        AccP.CALCFIELDS(AccP.Signature);
        END;
         */
        FChequeVisible :=false;
        BChequeVisible :=false;
        BReceiptVisible :=false;
        BOSAReceiptChequeVisible :=false;
        
        if Type = 'Cheque Deposit' then begin
        FChequeVisible :=true;
        if ("Account No" = '502-00-000300-00') or ("Account No" = '502-00-000303-00') then
        BOSAReceiptChequeVisible :=true;
        
        end;
        
        "Branch RefferenceVisible" :=false;
        LRefVisible :=false;
        
        
        if Type = 'Bankers Cheque' then
        BChequeVisible :=true;
        
        if Type = 'Encashment' then
        BReceiptVisible :=true;
        
        
        if "Transaction Type" = 'BOSA' then
        BReceiptVisible :=true;
        
        if "Branch Transaction" = true then begin
        "Branch RefferenceVisible" :=true;
        LRefVisible :=true;
        end;
        
        if Acc.Get("Account No") then begin
        if Acc."Account Category" = Acc."account category"::Project then begin
        "Branch RefferenceVisible" :=true;
        LRefVisible :=true;
        end;
        end;
        
        
        "Transaction DateEditable" := false;
        if "Post Dated" = true then
        "Transaction DateEditable" := true;

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if Posted = true then
        Error('You cannot delete an already posted record.');
    end;

    trigger OnInit()
    begin
        "Transaction DateEditable" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Clear(Acc.Picture);
        Clear(Acc.Signature);

        "Needs Approval":="needs approval"::No;
        FChequeVisible :=false;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if xRec.Posted = true then begin
        if Posted = true then
        Error('You cannot modify an already posted record.');
        end;
    end;

    trigger OnOpenPage()
    begin
        /*IF UsersID.GET(USERID) THEN BEGIN
        IF UsersID.Branch <> '' THEN
        SETRANGE("Transacting Branch",UsersID.Branch);
        END;*/
        
        
        if Posted = true then
        CurrPage.Editable:=false

    end;

    var
        RegCharge: Record Charges;
        JTemplate: Code[50];
        JBatch: Code[50];
        LoanBalance: Decimal;
        AvailableBalance: Decimal;
        UnClearedBalance: Decimal;
        LoanSecurity: Decimal;
        LoanGuaranteed: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        window: Dialog;
        Account: Record Vendor;
        TransactionTypes: Record "Transaction Types";
        TransactionCharges: Record "Transaction Charges";
        TCharges: Decimal;
        LineNo: Integer;
        AccountTypes: Record "Account Types-Saving Products";
        GenLedgerSetup: Record "General Ledger Setup";
        MinAccBal: Decimal;
        FeeBelowMinBal: Decimal;
        AccountNo: Code[30];
        NewAccount: Boolean;
        CurrentTellerAmount: Decimal;
        TellerTill: Record "Bank Account";
        IntervalPenalty: Decimal;
        StandingOrders: Record "Standing Orders";
        AccountAmount: Decimal;
        STODeduction: Decimal;
        Charges: Record Charges;
        "Total Deductions": Decimal;
        STODeductedAmount: Decimal;
        NoticeAmount: Decimal;
        AccountNotices: Record "Account Notices";
        Cust: Record "Member Register";
        AccountHolders: Record Vendor;
        ChargesOnFD: Decimal;
        TotalGuaranted: Decimal;
        VarAmtHolder: Decimal;
        chqtransactions: Record Transactions;
        Trans: Record Transactions;
        TotalUnprocessed: Decimal;
        CustAcc: Record "Member Register";
        AmtAfterWithdrawal: Decimal;
        TransactionsRec: Record Transactions;
        LoansTotal: Decimal;
        Interest: Decimal;
        InterestRate: Decimal;
        OBal: Decimal;
        Principal: Decimal;
        ATMTrans: Decimal;
        ATMBalance: Decimal;
        TotalBal: Decimal;
        DenominationsRec: Record Denominations;
        TillNo: Code[20];
        FOSASetup: Record "Purchases & Payables Setup";
        Acc: Record Vendor;
        ChequeTypes: Record "Cheque Types";
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        ChBank: Code[20];
        DValue: Record "Dimension Value";
        ReceiptAllocations: Record "Receipt Allocation";
        Loans: Record "Loans Register";
        Commision: Decimal;
        Cheque: Boolean;
        LOustanding: Decimal;
        TotalCommision: Decimal;
        TotalOustanding: Decimal;
        BOSABank: Code[20];
        InterestPaid: Decimal;
        PaymentAmount: Decimal;
        RunBal: Decimal;
        Recover: Boolean;
        genSetup: Record "Sacco General Set-Up";
        MailContent: Text[150];
        supervisor: Record "Supervisors Approval Levels";
        TEXT1: label 'YOU HAVE A TRANSACTION AWAITING APPROVAL';
        AccP: Record Vendor;
        LoansR: Record "Loans Register";
        ClearingCharge: Decimal;
        ClearingRate: Decimal;
        [InDataSet]
        FChequeVisible: Boolean;
        [InDataSet]
        BChequeVisible: Boolean;
        [InDataSet]
        BReceiptVisible: Boolean;
        [InDataSet]
        BOSAReceiptChequeVisible: Boolean;
        [InDataSet]
        "Branch RefferenceVisible": Boolean;
        [InDataSet]
        LRefVisible: Boolean;
        [InDataSet]
        "Transaction DateEditable": Boolean;
        Excise: Decimal;
        Echarge: Decimal;
        BankLedger: Record "Bank Account Ledger Entry";
        Vend: Record Vendor;
        ObjFundSetUp: Record "Funds User Setup";


    procedure CalcAvailableBal()
    begin
        ATMBalance:=0;

        TCharges:=0;
        AvailableBalance:=0;
        MinAccBal:=0;
        TotalUnprocessed:=0;
        IntervalPenalty:=0;


        if Account.Get("Account No") then begin
        Account.CalcFields(Account.Balance,Account."Uncleared Cheques",Account."ATM Transactions");

        AccountTypes.Reset;
        AccountTypes.SetRange(AccountTypes.Code,"Savings Product");
        if AccountTypes.Find('-') then begin
        MinAccBal:=AccountTypes."Minimum Balance";
        FeeBelowMinBal:=AccountTypes."Fee Below Minimum Balance";


        //Check Withdrawal Interval
        if Account.Status <> Account.Status::New then begin
        if Type='Withdrawal' then begin
        AccountTypes.Reset;
        AccountTypes.SetRange(AccountTypes.Code,"Savings Product");
        if Account."Last Withdrawal Date"<>0D then begin
        if CalcDate(AccountTypes."Withdrawal Interval",Account."Last Withdrawal Date") > Today then
        IntervalPenalty:=AccountTypes."Withdrawal Penalty";
        end;
        end;
        //Check Withdrawal Interval

        //Fixed Deposit
        ChargesOnFD:=0;
        if AccountTypes."Fixed Deposit"=true then begin
        if  Account."Expected Maturity Date" > Today then
        ChargesOnFD:=AccountTypes."Charge Closure Before Maturity";
        end;
        //Fixed Deposit


        //Current Charges
        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type","Transaction Type");
        if TransactionCharges.Find('-') then begin
        repeat
        if TransactionCharges."Use Percentage"=true then begin
        TransactionCharges.TestField("Percentage of Amount");
        TCharges:=TCharges+(TransactionCharges."Percentage of Amount"/100)*"Book Balance";
        end else begin
        TCharges:=TCharges+TransactionCharges."Charge Amount";
        end;
        until TransactionCharges.Next=0;
        end;


        TotalUnprocessed:=Account."Uncleared Cheques";
        ATMBalance:=Account."ATM Transactions";

        //FD
        if AccountTypes."Fixed Deposit"=false then begin
        if Account.Balance < MinAccBal then
        AvailableBalance:=Account.Balance - FeeBelowMinBal - TCharges - IntervalPenalty - MinAccBal - TotalUnprocessed - ATMBalance -
                          Account."EFT Transactions"
        else
        AvailableBalance:=Account.Balance - TCharges - IntervalPenalty - MinAccBal - TotalUnprocessed - ATMBalance -
                          Account."EFT Transactions";
        end else begin
        AvailableBalance:=Account.Balance - TCharges - ChargesOnFD - Account."ATM Transactions";
        end;
        end;
        //FD

        end;
        end;

        if "N.A.H Balance"<>0 then
        AvailableBalance:="N.A.H Balance";
        Message('Available balance is %1',AvailableBalance);
    end;


    procedure PostChequeDep()
    begin
        DValue.Reset;
        DValue.SetRange(DValue."Global Dimension No.",2);
        //DValue.SETRANGE(DValue.Code,DBranch);`
        DValue.SetRange(DValue.Code,'NAIROBI');
        if DValue.Find('-') then begin
        //DValue.TESTFIELD(DValue."Clearing Bank Account");
        ChBank:="Cheque Clearing Bank Code";//DValue."Clearing Bank Account";
        end else
        //ERROR('Branch not set.');
        ChBank:="Bank Account";

        if ChequeTypes.Get("Cheque Type") then begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
        GenJournalLine.DeleteAll;

        LineNo:=LineNo+10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."External Document No.":="Cheque No";
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No.":="Account No";

        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        if "Branch Transaction" = true then
        GenJournalLine.Description:="Transaction Type" + '-' + "Branch Refference"
        else
        GenJournalLine.Description:="Transaction Description" +'-'+ Description ;
        //Project Accounts
        if Acc.Get("Account No") then begin
        if Acc."Account Category" = Acc."account category"::Project then
        GenJournalLine.Description:="Transaction Type" + '-' + "Branch Refference"
        end;
        //Project Accounts
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=-Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;

        LineNo:=LineNo+10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."External Document No.":="Cheque No";
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No.":=ChBank;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:="Account Name";
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;

        //Post Charges
        ChargeAmount:=0;

        LineNo:=LineNo+10000;
        ClearingCharge:=0;
        if ChequeTypes."Use %" = true then begin
        ClearingCharge:=((ChequeTypes."% Of Amount"*0.01)*Amount);
        end else
        ClearingCharge:=ChequeTypes."Clearing Charges";
        //MESSAGE('ClearingCharge%1',ClearingCharge);
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        GenJournalLine."External Document No.":="ID No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:='Clearing Charges';
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=ClearingCharge;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No.":=ChequeTypes."Clearing Charges GL Account";
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        //Post Charges



        //Excise Duty
        genSetup.Get(0);

        LineNo:=LineNo+10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        GenJournalLine."External Document No.":="ID No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:='Excise Duty';
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=(ClearingCharge*genSetup."Excise Duty(%)")/100;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No.":=genSetup."Excise Duty Account";
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;




        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
        if GenJournalLine.Find('-') then begin
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco",GenJournalLine);
        end;

        //Post New


        Posted:=true;
        Authorised:=Authorised::Yes;
        "Supervisor Checked":=true;
        "Needs Approval":="needs approval"::No;
        "Frequency Needs Approval":="frequency needs approval"::No;
        "Date Posted":=Today;
        "Time Posted":=Time;
        "Posted By":=UserId;
        if ChequeTypes."Clearing  Days" = 0 then begin
        Status:=Status::Honoured;
        "Cheque Processed":="cheque processed"::"1";
        "Date Cleared":=Today;
        end;

        Modify;



        Message('Cheque deposited successfully.');

        Trans.Reset;
        Trans.SetRange(Trans.No,No);
        if Trans.Find('-') then
        Report.Run(51516294,false,true,Trans);


        end;
    end;


    procedure PostBankersCheq()
    begin
        //Block Payments
        if Acc.Get("Account No") then begin
        if Acc.Blocked = Acc.Blocked::Payment then
        Error('This account has been blocked from receiving payments.');
        end;
        
        
        DValue.Reset;
        DValue.SetRange(DValue."Global Dimension No.",2);
        DValue.SetRange(DValue.Code,'Nairobi');
        //DValue.SETRANGE(DValue.Code,DBranch);
        if DValue.Find('-') then begin
        //DValue.TESTFIELD(DValue."Banker Cheque Account");
        ChBank:="Cheque Clearing Bank Code";//DValue."Banker Cheque Account";
        end else
        Error('Branch not set.');
        
        CalcAvailableBal;
        
        //Check withdrawal limits
        if Type = 'Bankers Cheque' then begin
        if AvailableBalance < Amount then begin
        if Authorised=Authorised::Yes then begin
        Overdraft:=true;
        Modify;
        end;
        
        if Authorised=Authorised::No then begin
        if "Branch Transaction" = false then begin
        "Authorisation Requirement":='Bankers Cheque - Over draft';
        Modify;
        Message('You cannot issue a Bankers cheque more than the available balance unless authorised.');
        SendEmail;
        exit;
        end;
        end;
        if Authorised = Authorised::Rejected then
        Error('Bankers cheque transaction has been rejected and therefore cannot proceed.');
        //SendEmail;
        end;
        end;
        //Check withdrawal limits
        
        
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
        GenJournalLine.DeleteAll;
        
        LineNo:=LineNo+10000;
        
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."External Document No.":="Bankers Cheque No";
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        
        GenJournalLine."Posting Date":="Transaction Date";
        if "Branch Transaction" = true then
        GenJournalLine.Description:="Transaction Type" + '-' + "Branch Refference"
        else
        GenJournalLine.Description:="Transaction Description"+'-'+Description ;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        LineNo:=LineNo+10000;
        
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."External Document No.":="Bankers Cheque No";
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No.":=ChBank;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:=Payee;//"Account Name";
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=-Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        
        //Charges
        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type","Transaction Type");
        if TransactionCharges.Find('-') then begin
        repeat
        LineNo:=LineNo+10000;
        
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."External Document No.":="Bankers Cheque No";
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:=TransactionCharges.Description;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=TransactionCharges."Charge Amount";
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No.":=TransactionCharges."G/L Account";
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        if TransactionCharges."Due Amount" > 0 then begin
        LineNo:=LineNo+10000;
        
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."External Document No.":="Bankers Cheque No";
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
        GenJournalLine."Account No.":=TransactionCharges."G/L Account";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:=TransactionCharges.Description;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=TransactionCharges."Due Amount";
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"Bank Account";
        GenJournalLine."Bal. Account No.":=ChBank;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        
        end;
        
        until TransactionCharges.Next = 0;
        end;
        
        //Charges
        
        //Excise Duty
        genSetup.Get(0);
        
        LineNo:=LineNo+10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        GenJournalLine."External Document No.":="ID No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:='Excise Duty';
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=(TransactionCharges."Charge Amount"*genSetup."Excise Duty(%)")/100;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No.":=genSetup."Excise Duty Account";
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        
        
        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
        if GenJournalLine.Find('-') then begin
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco",GenJournalLine);
        end;
        
        //Post New
        
        
        "Transaction Available Balance":=AvailableBalance;
        Posted:=true;
        Authorised:=Authorised::Yes;
        "Supervisor Checked":=true;
        "Needs Approval":="needs approval"::No;
        "Frequency Needs Approval":="frequency needs approval"::No;
        "Date Posted":=Today;
        "Time Posted":=Time;
        "Posted By":=UserId;
        Modify;
        /*IF CONFIRM('Are you sure you want to print this bankers cheque?',TRUE)=TRUE THEN BEGIN
        REPORT.RUN(,TRUE,TRUE,Trans)
        END;*/
        
        
        Message('Bankers cheque posted successfully.');

    end;


    procedure PostEncashment()
    begin
        
        //Block Payments
        if Acc.Get("Account No") then begin
        if Acc.Blocked = Acc.Blocked::Payment then
        Error('This account has been blocked from receiving payments.');
        end;
        
        
        CalcAvailableBal;
        
        //Check withdrawal limits
        if Type = 'Encashment' then begin
        if AvailableBalance < Amount then begin
        if Authorised=Authorised::Yes then begin
        Overdraft:=true;
        Modify;
        end;
        
        if Authorised=Authorised::No then begin
        "Authorisation Requirement":='Encashment - Over draft';
        Modify;
        Message('You cannot issue an encashment more than the available balance unless authorised.');
        MailContent:='Withdrawal transaction' + 'TR. No.'+' '+No+' ' + 'of Kshs'+ ' '+ Format(Amount) + ' '+ 'for'
        +' ' +"Account Name"+' '+'needs your authorization';
        SendEmail;
        
        //SendEmail;
        exit;
        end;
        if Authorised = Authorised::Rejected then begin
        MailContent:='Bankers cheque transaction' + ' ' + 'of Kshs'+ ' '+ Format(Amount) + ' '+ 'for'
        +' ' +"Account Name"+' '+'needs your approval';
        SendEmail;
        Error('Transaction has been rejected and therefore cannot proceed.');
        
        end;
        end;
        end;
        //Check withdrawal limits
        
        
        
        //Check Teller Balances
        //ADDED DActivity:='';
        //ADDED DBranch:='';
        
        TillNo:='';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type",TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID,UserId);
        if TellerTill.Find('-') then begin
        //ADDED DActivity:=TellerTill."Global Dimension 1 Code";
        //ADDED DBranch:=TellerTill."Global Dimension 2 Code";
        TillNo:=TellerTill."No.";
        TellerTill.CalcFields(TellerTill.Balance);
        
        CurrentTellerAmount:=TellerTill.Balance;
        
        if CurrentTellerAmount-Amount<=TellerTill."Min. Balance" then
        Message('You need to add more money from the treasury since your balance has gone below the teller replenishing level.');
        
        if ("Transaction Type" = 'Withdrawal') or ("Transaction Type" = 'Encashment') then begin
        if (CurrentTellerAmount - Amount) < 0 then
        Error('You do not have enough money to carry out this transaction.');
        
        end;
        
        if ("Transaction Type" = 'Withdrawal') or ("Transaction Type" = 'Encashment') then begin
        if CurrentTellerAmount - Amount>=TellerTill."Maximum Teller Withholding" then
        Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');
        
        end else begin
        if CurrentTellerAmount + Amount>=TellerTill."Maximum Teller Withholding" then
        Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');
        end;
        
        
        end;
        
        if TillNo = '' then
        Error('Teller account not set-up.');
        
        //Check Teller Balances
        
        
        
        
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
        GenJournalLine.DeleteAll;
        
        LineNo:=LineNo+10000;
        
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."External Document No.":="ID No";
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        if ("Account No"='00-0000003000') or  ("Account No"='00-0200003000') then
        GenJournalLine."External Document No.":="ID No";
        
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:=Payee;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        
        //Charges
        TCharges:=0;
        //ADDED
        TChargeAmount:=0;
        
        
        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type","Transaction Type");
        if TransactionCharges.Find('-') then begin
        repeat
        LineNo:=LineNo+10000;
        
        ChargeAmount:=0;
        if TransactionCharges."Use Percentage" = true then
        ChargeAmount:=(Amount*TransactionCharges."Percentage of Amount")*0.01
        else
        ChargeAmount:=TransactionCharges."Charge Amount";
        
        if (TransactionCharges."Minimum Amount" <> 0) and (ChargeAmount < TransactionCharges."Minimum Amount") then
        ChargeAmount := TransactionCharges."Minimum Amount";
        
        if (TransactionCharges."Maximum Amount" <> 0) and (ChargeAmount > TransactionCharges."Maximum Amount") then
        ChargeAmount := TransactionCharges."Maximum Amount";
        
        
        
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."External Document No.":="ID No";
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
        GenJournalLine."Account No.":=TransactionCharges."G/L Account";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:=Payee;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=-ChargeAmount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        TChargeAmount:=TChargeAmount+ChargeAmount;
        
        until TransactionCharges.Next = 0;
        end;
        
        //Charges
        
        
        //Teller Entry
        LineNo:=LineNo+10000;
        
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."External Document No.":="ID No";
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No.":=TillNo;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:=Payee;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=-(Amount-TChargeAmount);
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        
        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
        if GenJournalLine.Find('-') then begin
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco",GenJournalLine);
        end;
        
        //Post New
        
        
        "Transaction Available Balance":=AvailableBalance;
        Posted:=true;
        Authorised:=Authorised::Yes;
        "Supervisor Checked":=true;
        "Needs Approval":="needs approval"::No;
        "Frequency Needs Approval":="frequency needs approval"::No;
        "Date Posted":=Today;
        "Time Posted":=Time;
        "Posted By":=UserId;
        Modify;
        
        
        
        /*
        Trans.RESET;
        Trans.SETRANGE(Trans.No,No);
        IF Trans.FIND('-') THEN
        REPORT.RUN(39004326,FALSE,TRUE,Trans); */

    end;


    procedure PostCashDepWith()
    begin
        CalcAvailableBal;
        
        //Check withdrawal limits - Available Bal
        if Type = 'Withdrawal' then begin
        //Block Payments
        if Acc.Get("Account No") then begin
        if Acc.Blocked = Acc.Blocked::Payment then
        Error('This account has been blocked from receiving payments.');
        end;
        
        if AvailableBalance < Amount then begin
        if Authorised=Authorised::Yes then begin
        Overdraft:=true;
        Modify;
        end;
        
        if Authorised=Authorised::No then begin
        if "Branch Transaction" = false then begin
        "Authorisation Requirement":='Over draft';
        Modify;
        MailContent:='Withdrawal transaction' + 'TR. No.'+' '+No+' ' + 'of Kshs'+ ' '+ Format(Amount) + ' '+ 'for'
        +' ' +"Account Name"+' '+'needs your approval';
         SendEmail;
        Message('You cannot withdraw more than the available balance unless authorised.');
        
        exit;
        end;
        if Authorised = Authorised::Rejected then
        Error('Transaction has been rejected and therefore cannot proceed.');
        
        end;
        end;
        end;
        //Check withdrawal limits - Available Bal
        
        
        
        //Check Teller Balances
        //ADDED DActivity:='';
        //ADDED DBranch:='';
        
        TillNo:='';
        TellerTill.Reset;
        TellerTill.SetRange(TellerTill."Account Type",TellerTill."account type"::Cashier);
        TellerTill.SetRange(TellerTill.CashierID,UserId);
        if TellerTill.Find('-') then begin
        TillNo:=TellerTill."No.";
        TellerTill.CalcFields(TellerTill.Balance);
        
        CurrentTellerAmount:=TellerTill.Balance;
        
        if CurrentTellerAmount-Amount<=TellerTill."Min. Balance" then
        Message('You need to add more money from the treasury since your balance has gone below the teller replenishing level.');
        
        if ("Transaction Type"='Withdrawal') or ("Transaction Type"='Encashment') then begin
        if (CurrentTellerAmount - Amount) < 0 then
        Error('You do not have enough money to carry out this transaction.');
        exit;
        end;
        Message('CurrentTellerAmount %1',CurrentTellerAmount);
        if (TransactionTypes.Type=TransactionTypes.Type::Withdrawal) or (TransactionTypes.Type=TransactionTypes.Type::Encashment) then begin
        if CurrentTellerAmount - Amount>=TellerTill."Maximum Teller Withholding" then
        Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');
        
        end else begin
        if CurrentTellerAmount + Amount>=TellerTill."Maximum Teller Withholding" then
        Message('You need to transfer money back to the treasury since your balance has gone above the teller maximum withholding.');
        end;
        
        //Check teller transaction limits
        if Type = 'Withdrawal' then begin
        if Amount > TellerTill."Max Withdrawal Limit" then begin
        if Authorised=Authorised::No then begin
        "Authorisation Requirement":='Withdrawal Above teller Limit';
        Modify;
        
        MailContent:='The' + ' ' + 'Cashier'+' '+Cashier+ ' '+
        'cannot withdraw more than allowed ,limit, Maximum limit is'+ ''+Format(TellerTill."Max Withdrawal Limit")+
        'you need to authorise';
          SendEmail;
        Message('You cannot withdraw more than your allowed limit of %1 unless authorised.',TellerTill."Max Withdrawal Limit");
        
        exit;
        end;
        if Authorised = Authorised::Rejected then
        Error('Transaction has been rejected and therefore cannot proceed.');
        
        end;
        end;
        
        
        //Prevent teller from Overdrawing Till
        
        if Type = 'Withdrawal' then begin
        TellerTill.CalcFields(TellerTill.Balance);
        if Amount > TellerTill.Balance then begin
        Error('you cannot transact below your Till balance.');
        end;
        end;
        
        //Prevent teller from Overdrawing Till
        
        
        
        if Type = 'Cash Deposit' then begin
        if Amount > TellerTill."Max Deposit Limit" then begin
        if Authorised=Authorised::No then begin
        "Authorisation Requirement":='Deposit above teller Limit';
        Modify;
        MailContent:='The' + ' ' + 'Cashier'+' '+Cashier+ ' '+
        'cannot deposit more than allowed limit, Maximum limit is'+ ''+Format(TellerTill."Max Deposit Limit")+ 'you need to authorise';
         SendEmail;
        Message('You cannot deposit more than your allowed limit of %1 unless authorised.',TellerTill."Max Deposit Limit");
        exit;
        end;
        if Authorised = Authorised::Rejected then
         //SendEmail;
        Error('Transaction has been rejected therefore you cannot proceed.');
        
        end;
        end;
        
        //Check teller transaction limits
        end;
        
        
        
        if TillNo = '' then
        Error('Teller account not set-up.');
        
        //Check Teller Balances
        
        
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
        GenJournalLine.DeleteAll;
        
        LineNo:=LineNo+10000;
        
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Document No.":=No;
        if ("Transaction Type" = 'BOSA') or ("Transaction Type" = 'Encashment') then
        GenJournalLine."External Document No.":="BOSA Account No";
        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        if "Account No"='00-0000000000' then
        GenJournalLine."External Document No.":="ID No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        if ("Transaction Type" = 'BOSA') or ("Transaction Type" = 'Encashment') then
        GenJournalLine.Description:=Payee
        else begin
        if "Branch Transaction" = true then
        GenJournalLine.Description:="Transaction Type" + '-' + "Branch Refference"
        else
        GenJournalLine.Description:=Type + '-' + Description;
        end;
        //Project Accounts
        if Acc.Get("Account No") then begin
        if Acc."Account Category" = Acc."account category"::Project then
        GenJournalLine.Description:="Transaction Type" + '-' + "Branch Refference"
        end;
        //Project Accounts
        
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        if (Type='Cash Deposit') or (Type='BOSA Receipt') then
        GenJournalLine.Amount:=-Amount
        else
        GenJournalLine.Amount:=Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"Bank Account";
        GenJournalLine."Bal. Account No.":=TillNo;
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        if (Acc."Mobile Phone No"<>'') then begin
            //Sms.SendSms('Withrawal',Acc."Mobile Phone No",'You have made a cash withdrawal of '+FORMAT(Amount) +'. Waumini SACCO',Acc."No.");
        
        end;
        
        //Charges
        TCharges:=0;
        
        //IF Amount < 20000 THEN BEGIN
        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type","Transaction Type");
        if TransactionCharges.Find('-') then begin
        if TransactionCharges."Charge Code"<>'009' then
        repeat
        
        LineNo:=LineNo+10000;
        
        ChargeAmount:=0;
        if TransactionCharges."Use Percentage" = true then
        ChargeAmount:=(Amount*TransactionCharges."Percentage of Amount")*0.01
        else  ChargeAmount:=TransactionCharges."Charge Amount";
        if "Account Type"='DIVIDEND' then begin
        if (Amount>=300)  and (Amount<1000) then
        ChargeAmount:=160
        else if  (Amount>=1001) and (Amount<2500) then
        ChargeAmount:=200
        else if (Amount>=2501) and (Amount<5000) then
        ChargeAmount:=250
        else if (Amount>=50001) and (Amount<100000) then
        ChargeAmount:=300
        else if (Amount>=10001) and (Amount<200000) then
        ChargeAmount:=350
        else if Amount>200000 then
        ChargeAmount:=400
        end; //ELSE
        //ChargeAmount:=TransactionCharges."Charge Amount";
        Echarge:=ChargeAmount;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        if "Account No"='00-0000000000' then
        GenJournalLine."External Document No.":="ID No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:=TransactionCharges.Description;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        //IF (TransactionCharges."Charge Code",'<>SD') AND (Amount > 20000)  THEN
        //ChargeAmount:=200 ELSE
        GenJournalLine.Amount:=ChargeAmount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No.":=TransactionCharges."G/L Account";
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        TChargeAmount:=TChargeAmount+ChargeAmount;
        
        until TransactionCharges.Next = 0;
        end;
        //END;
        
        
        
        
        
        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type","Transaction Type");
        TransactionCharges.SetRange(TransactionCharges."Charge Code",'0001');
        if TransactionCharges.Find('-') then begin
        //IF TransactionCharges."Charge Code"='0001' THEN
        
        //Charges
         //Excise:=0;
        //Excise Duty
        //genSetup.GET(0);
        Excise:=TransactionCharges."Charge Amount";
        //MESSAGE('Excise is %1',Echarge);
        LineNo:=LineNo+10000;
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        GenJournalLine."External Document No.":="ID No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:='Excise Duty';
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=(Excise*(genSetup."Excise Duty(%)"/100));
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No.":=genSetup."Excise Duty Account";
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        end;
        
        //ABOVE 20K
        //Charges
        TCharges:=0;
        //IF Amount > 20000 THEN BEGIN
        
        TransactionCharges.Reset;
        TransactionCharges.SetRange(TransactionCharges."Transaction Type","Transaction Type");
        TransactionCharges.SetRange(TransactionCharges."Charge Code",'SD');
        if TransactionCharges.Find('-') then begin
        //REPEAT
        LineNo:=LineNo+10000;
         /*
        ChargeAmount:=200;
        
        
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        IF "Account No"='00-0000000000' THEN
        GenJournalLine."External Document No.":="ID No";
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:=TransactionCharges.Description;
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=ChargeAmount;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
        GenJournalLine."Bal. Account No.":=TransactionCharges."G/L Account";
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
        IF GenJournalLine.Amount<>0 THEN
        GenJournalLine.INSERT;
          */
        LineNo:=LineNo+10000;
        
        ChargeAmount:=2;
        
        
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        if "Account No"='00-0000000000' then
        GenJournalLine."External Document No.":="ID No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:='Stamp Duty';
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=ChargeAmount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No.":='2-10-000193';
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        TChargeAmount:=TChargeAmount+ChargeAmount;
        
        //UNTIL TransactionCharges.NEXT = 0;
        //END;
        
        //Charges
        end;
        
        
        
        
        //ABOVE 20K
        //Charge withdrawal Freq
        if Type = 'Withdrawal' then begin
        if Account.Get("Account No") then begin
        if AccountTypes.Get(Account."Account Type") then begin
        if Account."Last Withdrawal Date" = 0D then begin
        Account."Last Withdrawal Date":=Today;
        Account.Modify;
        end else begin
        if CalcDate(AccountTypes."Withdrawal Interval",Account."Last Withdrawal Date") > Today then begin
        //IF CALCDATE(AccountTypes."Withdrawal Interval",Account."Last Withdrawal Date") <= CALCDATE('1D',TODAY) THEN BEGIN
        LineNo:=LineNo+10000;
        
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        if "Account No"='00-0000000000' then
        GenJournalLine."External Document No.":="ID No";
        
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:='Commision on Withdrawal Freq.';
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=AccountTypes."Withdrawal Penalty";
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No.":=AccountTypes."Withdrawal Interval Account";
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        end;
        Account."Last Withdrawal Date":=Today;
        Account.Modify;
        
        end;
        end;
        end;
        
        //NON-CUSTOMER CHARGE
        if "Account No" = '507-10000-00' then;
        //NON-CUSTOMER CHARGE
        
        end;
        //Charge withdrawal Freq
        
        
        //Charge 2% commisio
        if Overdraft = true then begin
        if "Transacting Branch" = 'MBSA' then begin
        LineNo:=LineNo+10000;
        
        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
        GenJournalLine."Account No.":="Account No";
        if "Account No"='00-0000000000' then
        GenJournalLine."External Document No.":="ID No";
        
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:='Commision on Overdraft';
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=Amount*0.02;
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
        GenJournalLine."Bal. Account No.":='100005';
        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;
        
        
        end;
        end;
        
        //BOSA Entries
        //IF Type = 'Cash Deposit' THEN BEGIN
        if ("Account No" = '502-00-000300-00') or ("Account No" = '502-00-000303-00') then
        PostBOSAEntries();
        //END;
        
        
        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
        GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
        if GenJournalLine.Find('-') then begin
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco",GenJournalLine);
        end;
        //Post New
        
        
        "Transaction Available Balance":=AvailableBalance;
        Posted:=true;
        Authorised:=Authorised::Yes;
        "Supervisor Checked":=true;
        "Needs Approval":="needs approval"::No;
        "Frequency Needs Approval":="frequency needs approval"::No;
        "Date Posted":=Today;
        "Time Posted":=Time;
        "Posted By":=UserId;
        Modify;
        
        
        
        Trans.Reset;
        Trans.SetRange(Trans.No,No);
        if Trans.Find('-') then begin
        if Type = 'Cash Deposit' then
        Report.Run(51516292,false,true,Trans)
        /*ELSE IF Type = 'BOSA Receipt' THEN
        REPORT.RUN(51516292,FALSE,TRUE,Trans)*/
        else
        if Type = 'Withdrawal' then
        Report.Run(51516293,false,true,Trans)
        end;

    end;


    procedure PostBOSAEntries()
    var
        ReceiptAllocation: Record "Receipt Allocation";
    begin
        //BOSA Cash Book Entry
        if "Account No" = '502-00-000300-00' then
        BOSABank:='13865'
        else if "Account No" = '502-00-000303-00' then
        BOSABank:='070006';


        LineNo:=LineNo+10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Document No.":=No;
        GenJournalLine."External Document No.":="Cheque No";
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
        GenJournalLine."Account No.":=BOSABank;
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine.Description:=Payee;
        GenJournalLine.Validate(GenJournalLine."Currency Code");
        GenJournalLine.Amount:=Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;

        ReceiptAllocations.Reset;
        ReceiptAllocations.SetRange(ReceiptAllocations."Document No",No);
        if ReceiptAllocations.Find('-') then begin
        repeat

        LineNo:=LineNo+10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Document No.":=No;
        GenJournalLine."External Document No.":="Cheque No";
        GenJournalLine."Posting Date":="Transaction Date";
        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Interest Paid" then begin
        GenJournalLine."Account Type":=GenJournalLine."bal. account type"::"G/L Account";
        if "Account No" = '502-00-000303-00' then
        GenJournalLine."Account No.":='080023'
        else
        GenJournalLine."Account No.":='045003';
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description:=Payee;
        end else begin
        GenJournalLine."Account Type":=GenJournalLine."bal. account type"::Customer;
        GenJournalLine."Account No.":=ReceiptAllocations."Member No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description:=Format(ReceiptAllocations."Transaction Type");
        end;
        GenJournalLine.Amount:=-ReceiptAllocations.Amount;
        GenJournalLine.Validate(GenJournalLine.Amount);
        if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Deposit Contribution" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Benevolent Fund"
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Share Capital" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::Loan
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Benevolent Fund" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Loan Insurance Paid"
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Interest Paid"
        else if ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Loan Repayment" then
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Registration Fee";
        GenJournalLine."Loan No":=ReceiptAllocations."Loan No.";
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;

        if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee") and
           (ReceiptAllocations."Interest Amount" > 0) then begin
        LineNo:=LineNo+10000;

        GenJournalLine.Init;
        GenJournalLine."Journal Template Name":='PURCHASES';
        GenJournalLine."Journal Batch Name":='FTRANS';
        GenJournalLine."Line No.":=LineNo;
        GenJournalLine."Document No.":=No;
        GenJournalLine."External Document No.":="Cheque No";
        GenJournalLine."Posting Date":="Transaction Date";
        GenJournalLine."Account Type":=GenJournalLine."bal. account type"::Customer;
        GenJournalLine."Account No.":=ReceiptAllocations."Member No";
        GenJournalLine.Validate(GenJournalLine."Account No.");
        GenJournalLine.Description:='Interest Paid';
        GenJournalLine.Amount:=-ReceiptAllocations."Interest Amount";
        GenJournalLine.Validate(GenJournalLine.Amount);
        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Insurance Contribution";
        GenJournalLine."Loan No":=ReceiptAllocations."Loan No.";
        if GenJournalLine.Amount<>0 then
        GenJournalLine.Insert;

        end;


        //Generate Advice
        if (ReceiptAllocations."Transaction Type" = ReceiptAllocations."transaction type"::"Registration Fee") then begin
        if LoansR.Get(ReceiptAllocations."Loan No.") then begin
        LoansR.CalcFields(LoansR."Outstanding Balance");
        LoansR.Advice:=true;
        if((LoansR."Outstanding Balance" - ReceiptAllocations.Amount) < LoansR."Loan Principle Repayment") then
        LoansR."Advice Type" := LoansR."advice type"::Stoppage
        else
        LoansR."Advice Type" := LoansR."advice type"::Adjustment;
        LoansR.Modify;
        end;
        end;
        //Generate Advice

        until ReceiptAllocations.Next = 0;
        end;
    end;


    procedure SuggestBOSAEntries()
    begin
        TestField(Posted,false);
        TestField("BOSA Account No");

        ReceiptAllocations.Reset;
        ReceiptAllocations.SetRange(ReceiptAllocations."Document No",No);
        ReceiptAllocations.DeleteAll;

        PaymentAmount:=Amount;
        RunBal:=PaymentAmount;

        Loans.Reset;
        Loans.SetCurrentkey(Loans.Source,Loans."Client Code");
        Loans.SetRange(Loans."Client Code","BOSA Account No");
        Loans.SetRange(Loans.Source,Loans.Source::" ");
        if Loans.Find('-') then begin
        repeat
        Loans.CalcFields(Loans."Outstanding Balance",Loans."Interest Due");
        Recover := true;

        if (Loans."Outstanding Balance") > 0 then begin
        if ((Loans."Outstanding Balance"-Loans."Loan Principle Repayment") <= 0) and (Cheque = false)  then
        Recover:=false;

        if Recover = true then begin

        Commision:=0;
        if Cheque = true then begin
        Commision:=(Loans."Outstanding Balance")*0.1;
        LOustanding:=Loans."Outstanding Balance";
        if Loans."Interest Due" > 0 then
        InterestPaid:=Loans."Interest Due";
        end else begin
        LOustanding:=(Loans."Outstanding Balance"-Loans."Loan Principle Repayment");
        if LOustanding < 0 then
        LOustanding:=0;
        if Loans."Interest Due" > 0 then
        InterestPaid:=Loans."Interest Due";
        if (Loans."Outstanding Balance"-Loans."Loan Principle Repayment") > 0 then begin
        if (Loans."Outstanding Balance"-Loans."Loan Principle Repayment") > (Loans."Approved Amount"*1/3) then
        Commision:=LOustanding*0.1;
        end;
        end;

        if PaymentAmount > 0 then begin
        if RunBal < (LOustanding+Commision+InterestPaid) then begin
        if RunBal < InterestPaid then
        InterestPaid:=RunBal;
        //Commision:=(RunBal-InterestPaid)*0.1;
        Commision:=(RunBal-InterestPaid)-((RunBal-InterestPaid)/1.1);
        LOustanding:=(RunBal-InterestPaid)-Commision;

        end;
        end;


        TotalCommision:=TotalCommision+Commision;
        TotalOustanding:=TotalOustanding+LOustanding+InterestPaid+Commision;

        RunBal:=RunBal-(LOustanding+InterestPaid+Commision);

        if (LOustanding + InterestPaid) > 0 then begin
        ReceiptAllocations.Init;
        ReceiptAllocations."Document No":=No;
        ReceiptAllocations."Member No":="BOSA Account No";
        ReceiptAllocations."Transaction Type":=ReceiptAllocations."transaction type"::"Registration Fee";
        ReceiptAllocations."Loan No.":=Loans."Loan  No.";
        ReceiptAllocations.Amount:=ROUND(LOustanding,0.01);
        ReceiptAllocations."Interest Amount":=ROUND(InterestPaid,0.01);
        ReceiptAllocations."Total Amount":=ReceiptAllocations.Amount+ReceiptAllocations."Interest Amount";
        ReceiptAllocations.Insert;
        end;

        if Commision > 0 then begin
        ReceiptAllocations.Init;
        ReceiptAllocations."Document No":=No;
        ReceiptAllocations."Member No":="BOSA Account No";
        ReceiptAllocations."Transaction Type":=ReceiptAllocations."transaction type"::"Interest Paid";
        ReceiptAllocations."Loan No.":=Loans."Loan  No.";
        ReceiptAllocations.Amount:=ROUND(Commision,0.01);
        ReceiptAllocations."Interest Amount":=0;
        ReceiptAllocations."Total Amount":=ReceiptAllocations.Amount+ReceiptAllocations."Interest Amount";
        ReceiptAllocations.Insert;
        end;

        end;
        end;

        until Loans.Next = 0;
        end;

        if RunBal > 0 then begin
        ReceiptAllocations.Init;
        ReceiptAllocations."Document No":=No;
        ReceiptAllocations."Member No":="BOSA Account No";
        ReceiptAllocations."Transaction Type":=ReceiptAllocations."transaction type"::"Benevolent Fund";
        ReceiptAllocations."Loan No.":='';
        ReceiptAllocations.Amount:=RunBal;
        ReceiptAllocations."Interest Amount":=0;
        ReceiptAllocations."Total Amount":=ReceiptAllocations.Amount+ReceiptAllocations."Interest Amount";
        ReceiptAllocations.Insert;

        end;
    end;


    procedure SendEmail()
    begin
        /*
        //send e-mail to supervisor
        supervisor.RESET;
        supervisor.SETFILTER(supervisor."Transaction Type",'withdrawal');
        IF supervisor.FIND('-') THEN BEGIN
         // MailContent:=TEXT1;
        REPEAT
        
         genSetup.GET(0);
         SMTPMAIL.NewMessage(genSetup."Sender Address",'Transactions' +''+'');
         SMTPMAIL.SetWorkMode();
         SMTPMAIL.ClearAttachments();
         SMTPMAIL.ClearAllRecipients();
         SMTPMAIL.SetDebugMode();
         SMTPMAIL.SetFromAdress(genSetup."Sender Address");
         SMTPMAIL.SetHost(genSetup."Outgoing Mail Server");
         SMTPMAIL.SetUserID(genSetup."Sender User ID");
         SMTPMAIL.AddLine(MailContent);
         SMTPMAIL.SetToAdress(supervisor."E-mail Address");
         SMTPMAIL.Send;
         UNTIL supervisor.NEXT=0;
        END;
        */

    end;
}

