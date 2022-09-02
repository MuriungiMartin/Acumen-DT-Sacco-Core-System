#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516395 "Loans Disbursment Batch List"
{
    ApplicationArea = Basic;
    CardPageID = "Loan Disburesment Batch Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loan Disburesment-Batching";
    SourceTableView = where(Posted=filter(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Batch No.";"Batch No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Source;Source)
                {
                    ApplicationArea = Basic;
                }
                field("Description/Remarks";"Description/Remarks")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("No of Loans";"No of Loans")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mode Of Disbursement";"Mode Of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(LoansB)
            {
                Caption = 'Batch';
                action("Loans Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Schedule';
                    Image = SuggestPayment;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /*LoansBatch.RESET;
                        LoansBatch.SETRANGE(LoansBatch."Batch No.","Batch No.");
                        IF LoansBatch.FIND('-') THEN BEGIN
                        REPORT.RUN(,TRUE,FALSE,LoansBatch);
                        END;
                        */

                    end;
                }
                separator(Action1102755008)
                {
                }
                action("Member Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Card';
                    Image = Customer;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /*
                        LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Loan  No.",CurrPage.LoansSubForm.GetLoanNo);
                        IF LoanApp.FIND('-') THEN BEGIN
                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.",LoanApp."Client Code");
                        IF Cust.FIND('-') THEN
                        PAGE.RUNMODAL(,Cust);
                        END;
                        */

                    end;
                }
                action("Loan Application")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Application Card';
                    Image = Loaners;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /*
                        LoanApp.RESET;
                        //LoanApp.SETRANGE(LoanApp."Loan  No.",CurrPage.LoansSubForm.PAGE.GetLoanNo);
                        IF LoanApp.FIND('-') THEN
                        PAGE.RUNMODAL(,LoanApp);
                         */

                    end;
                }
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Image = Statistics;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /*
                        LoanApp.RESET;
                        //LoanApp.SETRANGE(LoanApp."Loan  No.",CurrPage.LoansSubForm.PAGE.GetLoanNo);
                        IF LoanApp.FIND('-') THEN BEGIN
                        IF COPYSTR(LoanApp."Loan Product Type",1,2) = 'PL' THEN
                        REPORT.RUN(,TRUE,FALSE,LoanApp)
                        ELSE
                        REPORT.RUN(,TRUE,FALSE,LoanApp);
                        END;
                        */

                    end;
                }
                separator(Action1102755004)
                {
                }
                action(Approvals)
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
                        /*DocumentType:=DocumentType::Batches;
                        ApprovalEntries.Setfilters,DocumentType,"Batch No.");
                        ApprovalEntries.RUN;
                        */

                    end;
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        Text001: label 'This Batch is already pending approval';
                    begin
                        LoanApps.Reset;
                        LoanApps.SetRange(LoanApps."Batch No.","Batch No.");
                        if LoanApps.Find('-')=false then
                        Error('You cannot send an empty batch for approval');


                        LBatches.Reset;
                        LBatches.SetRange(LBatches."Batch No.","Batch No.");
                        if LBatches.Find('-') then begin
                           if LBatches.Status<>LBatches.Status::Open then
                              Error(Text001);
                        end;


                        if ("Mode Of Disbursement"="mode of disbursement"::Cheque) or
                         ("Mode Of Disbursement"="mode of disbursement"::"Individual Cheques") then
                        Error('Option not active %1',"Mode Of Disbursement");
                        //End allocate batch number
                        //ApprovalMgt.SendBatchApprRequest(LBatches);
                    end;
                }
                action("Canel Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        //IF ApprovalMgt.CancelBatchAppr(Rec,TRUE,TRUE) THEN;
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        Text001: label 'The Batch need to be approved.';
                    begin
                        if Posted = true then
                        Error('Batch already posted.');
                        
                        if Status<>Status::Approved then
                        Error(Format(Text001));
                        
                        CalcFields(Location);
                        if Confirm('Are you sure you want to post this batch?',true) = false then
                        exit;
                        TestField("Description/Remarks");
                        TestField("Posting Date");
                        TestField("Document No.");
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'Payments');
                        GenJournalLine.SetRange("Journal Batch Name",'LOANS');
                        GenJournalLine.DeleteAll;
                        
                        
                        GenSetUp.Get();
                        
                        DActivity:='';
                        DBranch:='';
                        
                        
                        // fosa posting
                        if "Mode Of Disbursement" = "mode of disbursement"::"Transfer to FOSA" then begin
                        LoanApps.Reset;
                        LoanApps.SetRange(LoanApps."Batch No.","Batch No.");
                        LoanApps.SetRange(LoanApps."System Created",false);
                        LoanApps.SetFilter(LoanApps."Loan Status",'<>Rejected');
                        if LoanApps.Find('-') then begin
                        repeat
                        
                        LoanApps.CalcFields(LoanApps."Top Up Amount");
                        TCharges:=0;
                        TopUpComm:=0;
                        TotalTopupComm:=0;
                        
                        Vend.Reset;
                        Vend.SetRange(Vend."No.",LoanApps."Account No");
                        if Vend.Find('-') then begin
                        DActivity:='FOSA';
                        DBranch:='NAIROBI';
                        
                        end;
                        
                        if LoanApps."Top Up Amount" > 0 then begin
                        LoanTopUp.Reset;
                        LoanTopUp.SetRange(LoanTopUp."Loan No.",LoanApps."Loan  No.");
                        if LoanTopUp.Find('-') then begin
                        repeat
                            //Principle
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Document No.":="Document No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
                            GenJournalLine."Account No.":=LoanApps."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description:='Off Set By - ' +LoanApps."Loan  No.";
                            GenJournalLine.Amount:=LoanTopUp."Principle Top Up"* -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Interest Paid";
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                        
                        
                            //Interest (Reversed if top up)
                           if LoanType.Get(LoanApps."Loan Product Type") then begin
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."bal. account type"::Employee;
                            GenJournalLine."Account No.":=LoanApps."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Document No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Interest Due Paid on top up ' + LoanApps."Loan Product Type Name";
                            GenJournalLine.Amount:=-LoanTopUp."Interest Top Up";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Insurance Contribution";
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                            end;
                            //Commision
                            if LoanType.Get(LoanApps."Loan Product Type") then begin
                            if LoanType."Top Up Commision" > 0 then begin
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Account No.":=LoanType."Top Up Commision Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Document No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Levy on Bridging';
                            TopUpComm:= LoanTopUp.Commision;
                            TotalTopupComm:=TotalTopupComm+TopUpComm;
                            GenJournalLine.Amount:=TopUpComm*-1;
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                            end;
                            end;
                        
                        until LoanTopUp.Next = 0;
                        end;
                        end;
                        
                        LoanApps.CalcFields(LoanApps."Top Up Amount");
                        TCharges:=0;
                        TopUpComm:=0;
                        TotalTopupComm:=0;
                        
                        
                        
                        if LoanApps."Top Up Amount" > 0 then begin
                        LoanTopUp.Reset;
                        LoanTopUp.SetRange(LoanTopUp."Loan No.",LoanApps."Loan  No.");
                        if LoanTopUp.Find('-') then begin
                        repeat
                            //Principle
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Document No.":="Document No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No.":=LoanApps."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description:='Off Set By - ' +LoanApps."Loan  No.";
                            GenJournalLine.Amount:=LoanTopUp."Principle Top Up";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                        
                        
                            //Interest (Reversed if top up)
                           if LoanType.Get(LoanApps."Loan Product Type") then begin
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No.":=LoanApps."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Document No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Interest Due Paid on top up ' + LoanApps."Loan Product Type Name";
                            GenJournalLine.Amount:=-LoanTopUp."Interest Top Up";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Insurance Contribution";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                            end;
                            //Commision
                            if LoanType.Get(LoanApps."Loan Product Type") then begin
                            if LoanType."Top Up Commision" > 0 then begin
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No.":=LoanApps."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Document No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Levy on Bridging';
                            TopUpComm:= LoanTopUp.Commision;
                            TotalTopupComm:=TotalTopupComm+TopUpComm;
                            GenJournalLine.Amount:=TopUpComm*-1;
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                            end;
                            end;
                        
                        until LoanTopUp.Next = 0;
                        end;
                        end;
                        
                        
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=LoanApps."Account No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":="Document No.";
                        GenJournalLine."Posting Date":="Posting Date";
                        GenJournalLine.Description:='transfer to fosa comm';
                        GenJournalLine.Amount:=GenSetUp."Loan Trasfer Fee-FOSA";
                        GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No.":=GenSetUp."Loan Trasfer Fee A/C-FOSA";
                        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Document No.":="Document No.";
                        GenJournalLine."Posting Date":="Posting Date";
                        LoanApps.TestField(LoanApps."Account No");
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=LoanApps."Account No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description:='loans';
                        GenJournalLine.Amount:=LoanApps."Approved Amount";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        until LoanApps.Next=0;
                        end;
                        end;
                        
                        // end of fosa posting
                        
                        
                        // eft posting
                        if "Mode Of Disbursement" = "mode of disbursement"::EFT then begin
                        LoanApps.Reset;
                        LoanApps.SetRange(LoanApps."Batch No.","Batch No.");
                        LoanApps.SetRange(LoanApps."System Created",false);
                        LoanApps.SetFilter(LoanApps."Loan Status",'<>Rejected');
                        if LoanApps.Find('-') then begin
                        repeat
                        
                        LoanApps.CalcFields(LoanApps."Top Up Amount");
                        TCharges:=0;
                        TopUpComm:=0;
                        TotalTopupComm:=0;
                        
                        DActivity:='BOSA';
                        DBranch:='NAIROBI';
                        
                        
                        if LoanApps."Top Up Amount" > 0 then begin
                        LoanTopUp.Reset;
                        LoanTopUp.SetRange(LoanTopUp."Loan No.",LoanApps."Loan  No.");
                        if LoanTopUp.Find('-') then begin
                        repeat
                            //Principle
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Document No.":="Document No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
                            GenJournalLine."Account No.":=LoanApps."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description:='Off Set By - ' +LoanApps."Loan  No.";
                            GenJournalLine.Amount:=LoanTopUp."Principle Top Up"* -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Interest Paid";
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                        
                        
                            //Interest (Reversed if top up)
                           if LoanType.Get(LoanApps."Loan Product Type") then begin
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."bal. account type"::Employee;
                            GenJournalLine."Account No.":=LoanApps."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Document No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Interest Due Paid on top up ' + LoanApps."Loan Product Type Name";
                            GenJournalLine.Amount:=-LoanTopUp."Interest Top Up";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Insurance Contribution";
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                            end;
                            //Commision
                            if LoanType.Get(LoanApps."Loan Product Type") then begin
                            if LoanType."Top Up Commision" > 0 then begin
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Account No.":=LoanType."Top Up Commision Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Document No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Levy on Bridging';
                            TopUpComm:= LoanTopUp.Commision;
                            TotalTopupComm:=TotalTopupComm+TopUpComm;
                            GenJournalLine.Amount:=TopUpComm*-1;
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                            end;
                            end;
                        
                        BatchTopUpAmount:=BatchTopUpAmount+LoanApps."Top Up Amount"+LoanTopUp."Interest Top Up";
                        BatchTopUpComm:=BatchTopUpComm+TotalTopupComm;
                        
                        
                        until LoanTopUp.Next = 0;
                        end;
                        end;
                        
                        
                        
                        
                        
                        
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=GenSetUp."Loan Trasfer Fee A/C-EFT";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":="Document No.";
                        GenJournalLine."Posting Date":="Posting Date";
                        GenJournalLine.Description:='EFT COMMision';
                        GenJournalLine.Amount:=GenSetUp."Loan Trasfer Fee-EFT"*-1;
                        GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        GenJournalLine.Init;
                        LineNo:=LineNo+10000;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Document No.":="Document No.";
                        GenJournalLine."Posting Date":="Posting Date";
                        LoanApps.TestField(LoanApps."Account No");
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
                        GenJournalLine."Account No.":="BOSA Bank Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description:='loans';
                        GenJournalLine.Amount:=LoanApps."Approved Amount"*-1+(GenSetUp."Loan Trasfer Fee-EFT"+BatchTopUpAmount+BatchTopUpComm);
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        
                        GenJournalLine.Init;
                        LineNo:=LineNo+10000;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Document No.":="Document No.";
                        GenJournalLine."Posting Date":="Posting Date";
                        LoanApps.TestField(LoanApps."Account No");
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
                        GenJournalLine."Account No.":=LoanApps."Client Code";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description:='loans';
                        GenJournalLine.Amount:=LoanApps."Approved Amount";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Share Capital";
                        GenJournalLine."Loan No":=LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        until LoanApps.Next=0;
                        end;
                        end;
                        // end of eft
                        // cheque posting
                        if "Mode Of Disbursement" = "mode of disbursement"::Cheque then begin
                        LoanApps.Reset;
                        LoanApps.SetRange(LoanApps."Batch No.","Batch No.");
                        LoanApps.SetRange(LoanApps."System Created",false);
                        LoanApps.SetFilter(LoanApps."Loan Status",'<>Rejected');
                        if LoanApps.Find('-') then begin
                        repeat
                        
                        LoanApps.CalcFields(LoanApps."Top Up Amount");
                        TCharges:=0;
                        TopUpComm:=0;
                        TotalTopupComm:=0;
                        
                        DActivity:='BOSA';
                        DBranch:='NAIROBI';
                        
                        
                        if LoanApps."Top Up Amount" > 0 then begin
                        LoanTopUp.Reset;
                        LoanTopUp.SetRange(LoanTopUp."Loan No.",LoanApps."Loan  No.");
                        if LoanTopUp.Find('-') then begin
                        repeat
                            //Principle
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Document No.":="Document No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
                            GenJournalLine."Account No.":=LoanApps."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description:='Off Set By - ' +LoanApps."Loan  No.";
                            GenJournalLine.Amount:=LoanTopUp."Principle Top Up"* -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Interest Paid";
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                        
                        
                            //Interest (Reversed if top up)
                           if LoanType.Get(LoanApps."Loan Product Type") then begin
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."bal. account type"::Employee;
                            GenJournalLine."Account No.":=LoanApps."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Document No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Interest Due Paid on top up ' + LoanApps."Loan Product Type Name";
                            GenJournalLine.Amount:=-LoanTopUp."Interest Top Up";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Insurance Contribution";
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                            end;
                            //Commision
                            if LoanType.Get(LoanApps."Loan Product Type") then begin
                            if LoanType."Top Up Commision" > 0 then begin
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Account No.":=LoanType."Top Up Commision Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Document No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Levy on Bridging';
                            TopUpComm:= LoanTopUp.Commision;
                            TotalTopupComm:=TotalTopupComm+TopUpComm;
                            GenJournalLine.Amount:=TopUpComm*-1;
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                            end;
                            end;
                        
                        BatchTopUpAmount:=BatchTopUpAmount+LoanApps."Top Up Amount"+LoanTopUp."Interest Top Up";
                        BatchTopUpComm:=BatchTopUpComm+TotalTopupComm;
                        
                        
                        until LoanTopUp.Next = 0;
                        end;
                        end;
                        
                        
                        
                        
                        
                        
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=GenSetUp."Loan Trasfer Fee A/C-Cheque";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":="Document No.";
                        GenJournalLine."Posting Date":="Posting Date";
                        GenJournalLine.Description:='EFT COMM';
                        GenJournalLine.Amount:=GenSetUp."Loan Trasfer Fee-Cheque"*-1;
                        GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        GenJournalLine.Init;
                        LineNo:=LineNo+10000;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Document No.":="Document No.";
                        GenJournalLine."Posting Date":="Posting Date";
                        LoanApps.TestField(LoanApps."Account No");
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
                        GenJournalLine."Account No.":="BOSA Bank Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description:='loans';
                        GenJournalLine.Amount:=LoanApps."Approved Amount"*-1+(GenSetUp."Loan Trasfer Fee-Cheque"+BatchTopUpAmount+BatchTopUpComm);
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        
                        GenJournalLine.Init;
                        LineNo:=LineNo+10000;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Document No.":="Document No.";
                        GenJournalLine."Posting Date":="Posting Date";
                        LoanApps.TestField(LoanApps."Account No");
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
                        GenJournalLine."Account No.":=LoanApps."Client Code";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description:='loans';
                        GenJournalLine.Amount:=LoanApps."Approved Amount";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Share Capital";
                        GenJournalLine."Loan No":=LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        until LoanApps.Next=0;
                        end;
                        end;
                        
                        //rtgs
                        if "Mode Of Disbursement" = "mode of disbursement"::RTGS then begin
                        LoanApps.Reset;
                        LoanApps.SetRange(LoanApps."Batch No.","Batch No.");
                        LoanApps.SetRange(LoanApps."System Created",false);
                        LoanApps.SetFilter(LoanApps."Loan Status",'<>Rejected');
                        if LoanApps.Find('-') then begin
                        repeat
                        
                        LoanApps.CalcFields(LoanApps."Top Up Amount");
                        TCharges:=0;
                        TopUpComm:=0;
                        TotalTopupComm:=0;
                        
                        DActivity:='BOSA';
                        DBranch:='NAIROBI';
                        
                        
                        if LoanApps."Top Up Amount" > 0 then begin
                        LoanTopUp.Reset;
                        LoanTopUp.SetRange(LoanTopUp."Loan No.",LoanApps."Loan  No.");
                        if LoanTopUp.Find('-') then begin
                        repeat
                            //Principle
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Document No.":="Document No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
                            GenJournalLine."Account No.":=LoanApps."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description:='Off Set By - ' +LoanApps."Loan  No.";
                            GenJournalLine.Amount:=LoanTopUp."Principle Top Up"* -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Interest Paid";
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                        
                        
                            //Interest (Reversed if top up)
                           if LoanType.Get(LoanApps."Loan Product Type") then begin
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."bal. account type"::Employee;
                            GenJournalLine."Account No.":=LoanApps."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Document No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Interest Due Paid on top up ' + LoanApps."Loan Product Type Name";
                            GenJournalLine.Amount:=-LoanTopUp."Interest Top Up";
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Insurance Contribution";
                            GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                            end;
                            //Commision
                            if LoanType.Get(LoanApps."Loan Product Type") then begin
                            if LoanType."Top Up Commision" > 0 then begin
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='PAYMENTS';
                            GenJournalLine."Journal Batch Name":='LOANS';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Account No.":=LoanType."Top Up Commision Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":="Document No.";
                            GenJournalLine."Posting Date":="Posting Date";
                            GenJournalLine.Description:='Levy on Bridging';
                            TopUpComm:= LoanTopUp.Commision;
                            TotalTopupComm:=TotalTopupComm+TopUpComm;
                            GenJournalLine.Amount:=TopUpComm*-1;
                            GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                            end;
                            end;
                        
                        BatchTopUpAmount:=BatchTopUpAmount+LoanApps."Top Up Amount"+LoanTopUp."Interest Top Up";
                        BatchTopUpComm:=BatchTopUpComm+TotalTopupComm;
                        
                        
                        until LoanTopUp.Next = 0;
                        end;
                        end;
                        
                        
                        
                        
                        
                        
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=GenSetUp."Loan Trasfer Fee A/C-RTGS";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":="Document No.";
                        GenJournalLine."Posting Date":="Posting Date";
                        GenJournalLine.Description:='EFT COMM';
                        GenJournalLine.Amount:=GenSetUp."Loan Trasfer Fee-RTGS"*-1;
                        GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        GenJournalLine.Init;
                        LineNo:=LineNo+10000;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Document No.":="Document No.";
                        GenJournalLine."Posting Date":="Posting Date";
                        LoanApps.TestField(LoanApps."Account No");
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
                        GenJournalLine."Account No.":="BOSA Bank Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description:='loans';
                        GenJournalLine.Amount:=LoanApps."Approved Amount"*-1+(GenSetUp."Loan Trasfer Fee-RTGS"+BatchTopUpAmount+BatchTopUpComm);
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        
                        GenJournalLine.Init;
                        LineNo:=LineNo+10000;
                        GenJournalLine."Journal Template Name":='PAYMENTS';
                        GenJournalLine."Journal Batch Name":='LOANS';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Document No.":="Document No.";
                        GenJournalLine."Posting Date":="Posting Date";
                        LoanApps.TestField(LoanApps."Account No");
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
                        GenJournalLine."Account No.":=LoanApps."Client Code";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description:='loans';
                        GenJournalLine.Amount:=LoanApps."Approved Amount";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                        GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Share Capital";
                        GenJournalLine."Loan No":=LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        until LoanApps.Next=0;
                        end;
                        end;
                        
                        /*
                        //Post New
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PAYMENTS');
                        GenJournalLine.SETRANGE("Journal Batch Name",'LOANS');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B",GenJournalLine);
                        END;
                        LoanApps.Posted:=TRUE;
                        LoanApps.MODIFY;
                        Posted:=TRUE;
                        MODIFY;
                        
                        
                         */
                        Message('Batch posted successfully.');

                    end;
                }
            }
        }
    }

    var
        MovementTracker: Record "File Movement Tracker";
        FileMovementTracker: Record "File Movement Tracker";
        NextStage: Integer;
        EntryNo: Integer;
        NextLocation: Text[100];
        LoansBatch: Record "Loan Disburesment-Batching";
        i: Integer;
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record "Loan Repayment Schedule";
        RSchedule: Record "Loan Repayment Schedule";
        GP: Text[30];
        ScheduleCode: Code[20];
        PreviewShedule: Record "Loan Repayment Schedule";
        PeriodInterval: Code[10];
        CustomerRecord: Record "Member Register";
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record "Member Register";
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record "Member Register";
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sacco General Set-Up";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        Loans: Record "Loans Register";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        TotalTopupComm: Decimal;
        CustE: Record "Member Register";
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Guarantee Details";
        SpecialComm: Decimal;
        LoanApps: Record "Loans Register";
        Banks: Record "Bank Account";
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        TotalSpecialLoan: Decimal;
        SpecialLoanCl: Record "Loan Special Clearance";
        Loans2: Record "Loans Register";
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        Refunds: Record "Loan Products Setup";
        TotalRefunds: Decimal;
        WithdrawalFee: Decimal;
        NetPayable: Decimal;
        NetRefund: Decimal;
        FWithdrawal: Decimal;
        OutstandingInt: Decimal;
        TSC: Decimal;
        LoanDisbAmount: Decimal;
        NegFee: Decimal;
        DValue: Record "Dimension Value";
        ChBank: Code[20];
        Trans: Record Transactions;
        TransactionCharges: Record "Transaction Charges";
        BChequeRegister: Record "Banker Cheque Register";
        OtherCommitments: Record "Other Commitements Clearance";
        BoostingComm: Decimal;
        BoostingCommTotal: Decimal;
        BridgedLoans: Record "Loan Special Clearance";
        InterestDue: Decimal;
        ContractualShares: Decimal;
        BridgingChanged: Boolean;
        BankersChqNo: Code[20];
        LastPayee: Text[100];
        RunningAmount: Decimal;
        BankersChqNo2: Code[20];
        BankersChqNo3: Code[20];
        EndMonth: Date;
        RemainingDays: Integer;
        PrincipalRepay: Decimal;
        InterestRepay: Decimal;
        TMonthDays: Integer;
        SMSMessage: Record "Loan Appraisal Salary Details";
        iEntryNo: Integer;
        Temp: Record Customer;
        Jtemplate: Code[30];
        JBatch: Code[30];
        LBatches: Record "Loan Disburesment-Batching";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
}

