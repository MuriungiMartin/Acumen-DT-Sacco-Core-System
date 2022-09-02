#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516058 "Payment Requests List"
{
    CardPageID = "Payment Request Header";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Payment Header.";
    SourceTableView = where("Payment Type"=const(Express),Posted=const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field(Date;Date)
                {
                    ApplicationArea = Basic;
                }
                field(Payee;Payee)
                {
                    ApplicationArea = Basic;
                }
                field("Payment Description";"Payment Description")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code";"Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Amount";"VAT Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("WithHolding Tax Amount";"WithHolding Tax Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Amount(LCY)";"Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No";"Cheque No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755014;Notes)
            {
            }
            systempart(Control1102755015;MyNotes)
            {
            }
            systempart(Control1102755016;Outlook)
            {
            }
            systempart(Control1102755017;Links)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("<Action1102755006>")
            {
                Caption = '&Functions';
                action("<Action1102755024>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //Post PV Entries
                        CurrPage.SaveRecord;
                        CheckPVRequiredItems;
                        PostPaymentVoucher;

                        //Print Here
                        //RESET;
                        //SETFILTER("No.","No.");
                        //REPORT.RUN(55884,TRUE,TRUE,Rec);
                        //RESET;
                        //End Print Here
                    end;
                }
                separator(Action1102755029)
                {
                }
                action("<Action1102755034>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        /*
                        IF "Payment Type"="Payment Type"::Normal THEN
                          DocumentType:=DocumentType::"Payment Voucher"
                        ELSE
                          DocumentType:=DocumentType::"Express Pv";
                        */
                         DocumentType:=Documenttype::Requisition;
                        //ApprovalEntries.Setfilters(DATABASE::"Payments Header",DocumentType,"No.");
                        //ApprovalEntries.RUN;

                    end;
                }
                action("<Action1102755007>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        if not LinesExists then
                           Error('There are no Lines created for this Document');
                        //Ensure No Items That should be committed that are not
                        if LinesCommitmentStatus then
                          Error('There are some lines that have not been committed');

                        //Release the PV for Approval
                        //IF ApprovalMgt.SendPVApprovalRequest(Rec) THEN;
                    end;
                }
                action("<Action1102755028>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                          //IF ApprovalMgt.CancelPVApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                separator(Action1102755025)
                {
                }
                action("<Action1102755031>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Check Budgetary Availability';
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        BCSetup: Record "Budgetary Control Setup";
                    begin
                        BCSetup.Get;
                        if not BCSetup.Mandatory then
                           exit;

                            if not AllFieldsEntered then
                             Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');
                          //First Check whether other lines are already committed.
                          Commitments.Reset;
                          Commitments.SetRange(Commitments."Document Type",Commitments."document type"::"Payment Voucher");
                          Commitments.SetRange(Commitments."Document No.","No.");
                          if Commitments.Find('-') then begin
                            if Confirm('Lines in this Document appear to be committed do you want to re-commit?',false)=false then begin exit end;
                          Commitments.Reset;
                          Commitments.SetRange(Commitments."Document Type",Commitments."document type"::"Payment Voucher");
                          Commitments.SetRange(Commitments."Document No.","No.");
                          Commitments.DeleteAll;
                         end;

                            CheckBudgetAvail.CheckPayments(Rec);
                    end;
                }
                action("<Action1102755032>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Budget Commitment';
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                          if Confirm('Do you Wish to Cancel the Commitment entries for this document',false)=false then begin exit end;

                          Commitments.Reset;
                          Commitments.SetRange(Commitments."Document Type",Commitments."document type"::"Payment Voucher");
                          Commitments.SetRange(Commitments."Document No.","No.");
                          Commitments.DeleteAll;

                          PayLine.Reset;
                          PayLine.SetRange(PayLine."Received From","No.");
                          if PayLine.Find('-') then begin
                            repeat
                              PayLine."Cashier Bank Account":=false;
                              PayLine.Modify;
                            until PayLine.Next=0;
                          end;
                    end;
                }
                separator(Action1102755022)
                {
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Caption = 'Print/Preview';
                    Image = ConfirmAndPrint;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        // IF Status<>Status::Approved THEN
                         //   ERROR('You can only print a Payment Voucher after it is fully Approved');



                        //IF Status=Status::Pending THEN
                           //ERROR('You cannot Print until the document is released for approval');
                        Reset;
                        SetFilter("No.","No.");
                        Report.Run(55903,true,true,Rec);
                        Reset;

                        CurrPage.Update;
                        CurrPage.SaveRecord;
                    end;
                }
                action("<Action1102756004>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Letter';
                    Visible = false;

                    trigger OnAction()
                    var
                        FilterbyPayline: Record "Payment Line.";
                    begin
                        if Status=Status::"Pending Approval" then
                           Error('You cannot Print until the document is released for approval');
                        FilterbyPayline.Reset;
                        FilterbyPayline.SetFilter(FilterbyPayline."Received From","No.");
                        Report.Run(56007,true,true,FilterbyPayline);
                        Reset;
                    end;
                }
                separator(Action1102755019)
                {
                }
                action("<Action1102756006>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Document';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        Text000: label 'Are you sure you want to cancel this Document?';
                        Text001: label 'You have selected not to Cancel the Document';
                    begin
                        TestField(Status,Status::Approved);
                        if Confirm(Text000,true) then  begin
                        //Post Reversal Entries for Commitments
                        Doc_Type:=Doc_type::"Payment Voucher";
                        CheckBudgetAvail.ReverseEntries(Doc_Type,"No.");
                        //Status:=Status::Cancelled;
                        Modify;
                        end else
                          Error(Text001);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        
        if UserMgt.GetPurchasesFilter() <> '' then begin
          FilterGroup(2);
          SetRange("Responsibility Center" ,UserMgt.GetPurchasesFilter());
          FilterGroup(0);
        end;
        
        /*
        IF UserMgt.GetSetDimensions(USERID,2) <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Global Dimension 2 Code",UserMgt.GetSetDimensions(USERID,2));
          FILTERGROUP(0);
        END;
        */

    end;

    var
        PayLine: Record "Payment Line.";
        PVUsers: Record "CshMgt PV Steps Users";
        strFilter: Text[250];
        IntC: Integer;
        IntCount: Integer;
        Payments: Record "Payment Header.";
        RecPayTypes: Record "Funds Transaction Types";
        TarriffCodes: Record "Funds Tax Codes";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Cash Office User Template";
        LineNo: Integer;
        Temp: Record "Cash Office User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        strText: Text[100];
        PVHead: Record "Payment Header.";
        BankAcc: Record "Bank Account";
        CheckBudgetAvail: Codeunit "Budgetary Control";
        Commitments: Record Committment;
        UserMgt: Codeunit "User Setup Management BRr";
        JournlPosted: Codeunit UnknownCodeunit55486;
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,Load,Discharge,"Express Pv";
        DocPrint: Codeunit "Document-Print";
        CheckLedger: Record "Check Ledger Entry";
        CheckManagement: Codeunit CheckManagement;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        [InDataSet]
        "Cheque No.Editable": Boolean;
        [InDataSet]
        "Payment Release DateEditable": Boolean;
        [InDataSet]
        "Cheque TypeEditable": Boolean;
        [InDataSet]
        "Invoice Currency CodeEditable": Boolean;
        [InDataSet]
        "Currency CodeEditable": Boolean;
        [InDataSet]
        GlobalDimension1CodeEditable: Boolean;
        [InDataSet]
        "Payment NarrationEditable": Boolean;
        [InDataSet]
        ShortcutDimension2CodeEditable: Boolean;
        [InDataSet]
        PayeeEditable: Boolean;
        [InDataSet]
        ShortcutDimension3CodeEditable: Boolean;
        [InDataSet]
        ShortcutDimension4CodeEditable: Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        PVLinesEditable: Boolean;
        Text001: label 'This Document no %1 has printed Cheque No %2 which will have to be voided first before reposting.';
        Text000: label 'Do you want to Void Check No %1';
        Text002: label 'You have selected post and generate a computer cheque ensure that your cheque printer is ready do you want to continue?';


    procedure PostPaymentVoucher()
    begin

         // DELETE ANY LINE ITEM THAT MAY BE PRESENT
         GenJnlLine.Reset;
         GenJnlLine.SetRange(GenJnlLine."Journal Template Name",JTemplate);
         GenJnlLine.SetRange(GenJnlLine."Journal Batch Name",JBatch);
         if GenJnlLine.Find('+') then
           begin
             LineNo:=GenJnlLine."Line No."+1000;
           end
         else
           begin
             LineNo:=1000;
           end;
         GenJnlLine.DeleteAll;
         GenJnlLine.Reset;

        Payments.Reset;
        Payments.SetRange(Payments."No.","No.");
        if Payments.Find('-') then begin
          PayLine.Reset;
          PayLine.SetRange(PayLine."Received From",Payments."No.");
          if PayLine.Find('-') then
            begin
              repeat
                PostHeader(Payments);
              until PayLine.Next=0;
            end;

        Post:=false;
        Post:=JournlPosted.PostedSuccessfully();
        if Post then  begin
            Posted:=true;
            Status:=Payments.Status::Posted;
            "Posted By":=UserId;
            "Date Posted":=Today;
            "Time Posted":=Time;
            Modify;

          //Post Reversal Entries for Commitments
          Doc_Type:=Doc_type::"Payment Voucher";
          CheckBudgetAvail.ReverseEntries(Doc_Type,"No.");
          end;
        end;
    end;


    procedure PostHeader(var Payment: Record "Payment Header.")
    begin

        if (Payments."Payment Mode"=Payments."payment mode"::Cheque) and ("Cheque Type"="cheque type"::" ") then
           Error('Cheque type has to be specified');

        if Payments."Payment Mode"=Payments."payment mode"::Cheque then begin
            if (Payments."Cheque No"='') and ("Cheque Type"="cheque type"::"Manual Cheque") then
              begin
                Error('Please ensure that the cheque number is inserted');
              end;
        end;

        if Payments."Payment Mode"=Payments."payment mode"::EFT then
          begin
            if Payments."Cheque No"='' then
              begin
                Error ('Please ensure that the EFT number is inserted');
              end;
          end;

        if Payments."Payment Mode"=Payments."payment mode"::"Letter of Credit" then
          begin
            if Payments."Cheque No"='' then
              begin
                Error('Please ensure that the Letter of Credit ref no. is entered.');
              end;
          end;
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name",JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name",JBatch);

          if GenJnlLine.Find('+') then
            begin
              LineNo:=GenJnlLine."Line No."+1000;
            end
          else
            begin
              LineNo:=1000;
            end;


        LineNo:=LineNo+1000;
        GenJnlLine.Init;
        GenJnlLine."Journal Template Name":=JTemplate;
        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name":=JBatch;
        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No.":=LineNo;
        GenJnlLine."Source Code":='PAYMENTJNL';
        GenJnlLine."Posting Date":=Payment."Payment Release Date";
        if CustomerPayLinesExist then
         GenJnlLine."Document Type":=GenJnlLine."document type"::" "
        else
          GenJnlLine."Document Type":=GenJnlLine."document type"::Payment;
        GenJnlLine."Document No.":=Payments."No.";
        GenJnlLine."External Document No.":=Payments."Cheque No";

        GenJnlLine."Account Type":=GenJnlLine."account type"::"Bank Account";
        GenJnlLine."Account No.":=Payments."Bank Account";
        GenJnlLine.Validate(GenJnlLine."Account No.");

        GenJnlLine."Currency Code":=Payments."Currency Code";
        GenJnlLine.Validate(GenJnlLine."Currency Code");
          //CurrFactor
          GenJnlLine."Currency Factor":=Payments."Currency Factor";
          GenJnlLine.Validate("Currency Factor");

        Payments.CalcFields(Payments."Net Amount",Payments."VAT Amount");
        GenJnlLine.Amount:=-(Payments."Net Amount" );
        GenJnlLine.Validate(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
        GenJnlLine."Bal. Account No.":='';

        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
        GenJnlLine."Shortcut Dimension 1 Code":=PayLine."PV Type";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code":="Global Dimension 2 Code";
        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
        GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");

        GenJnlLine.Description:=CopyStr('Pay To:' + Payments.Payee,1,50);
        GenJnlLine.Validate(GenJnlLine.Description);

        if "Payment Mode"<>"payment mode"::Cheque then  begin
        GenJnlLine."Bank Payment Type":=GenJnlLine."bank payment type"::" "
        end else begin
        if "Cheque Type"="cheque type"::"Computer Cheque" then
         GenJnlLine."Bank Payment Type":=GenJnlLine."bank payment type"::"Computer Check"
        else
           GenJnlLine."Bank Payment Type":=GenJnlLine."bank payment type"::" "

        end;
        if GenJnlLine.Amount<>0 then
        GenJnlLine.Insert;

        //Post Other Payment Journal Entries
        PostPV(Payments);
    end;


    procedure GetAppliedEntries(var LineNo: Integer) InvText: Text[100]
    var
        Appl: Record "CshMgt Application";
    begin

        InvText:='';
        Appl.Reset;
        Appl.SetRange(Appl."Document Type",Appl."document type"::PV);
        Appl.SetRange(Appl."Document No.","No.");
        Appl.SetRange(Appl."Line No.",LineNo);
        if Appl.FindFirst then
          begin
            repeat
              InvText:=CopyStr(InvText + ',' + Appl."Appl. Doc. No",1,50);
            until Appl.Next=0;
          end;
    end;


    procedure InsertApproval()
    var
        LineNo: Integer;
    begin
        /*LineNo:=0;
        Appl.RESET;
        IF Appl.FINDLAST THEN
          BEGIN
            LineNo:=Appl."Line No.";
          END;
        
        LineNo:=LineNo +1;
        
        Appl.RESET;
        Appl.INIT;
          Appl."Line No.":=LineNo;
          Appl."Document Type":=Appl."Document Type"::PV;
          Appl."Document No.":="No.";
          Appl."Document Date":=Date;
          Appl."Process Date":=TODAY;
          Appl."Process Time":=TIME;
          Appl."Process User ID":=USERID;
          Appl."Process Name":="Current Status";
          //Appl."Process Machine":=ENVIRON('COMPUTERNAME');
        Appl.INSERT;
        */

    end;


    procedure LinesCommitmentStatus() Exists: Boolean
    var
        BCSetup: Record "Budgetary Control Setup";
    begin
         if BCSetup.Get() then  begin
            if not BCSetup.Mandatory then  begin
               Exists:=false;
               exit;
            end;
         end else begin
               Exists:=false;
               exit;
         end;
         Exists:=false;
         PayLine.Reset;
         PayLine.SetRange(PayLine."Received From","No.");
         PayLine.SetRange(PayLine."Cashier Bank Account",false);
        // PayLine.SETRANGE(PayLine."Budgetary Control A/C",TRUE);
          if PayLine.Find('-') then
             Exists:=true;
    end;


    procedure CheckPVRequiredItems()
    begin
        if Posted then  begin
            Error('The Document has already been posted');
        end;
        
        TestField(Status,Status::Approved);
        TestField("Bank Account");
        TestField("Payment Mode");
        TestField("Payment Release Date");
        //Confirm whether Bank Has the Cash
        if "Payment Mode"="payment mode"::Cash then
         CheckBudgetAvail.CheckFundsAvailability(Rec);
        
         //Confirm Payment Release Date is today);
        if "Payment Mode"="payment mode"::Cash then
          TestField("Payment Release Date",WorkDate);
        
        /*Check if the user has selected all the relevant fields*/
        Temp.Get(UserId);
        
        JTemplate:=Temp."Payment Journal Template";JBatch:=Temp."Payment Journal Batch";
        
        if JTemplate='' then
          begin
            Error('Ensure the PV Template is set up in Cash Office Setup');
          end;
        if JBatch='' then
          begin
            Error('Ensure the PV Batch is set up in the Cash Office Setup')
          end;
        
        if ("Payment Mode"="payment mode"::Cheque) and ("Cheque Type"="cheque type"::"Computer Cheque") then begin
           if not Confirm(Text002,false) then
              Error('You have selected to Abort PV Posting');
        end;
        //Check whether there is any printed cheques and lines not posted
        CheckLedger.Reset;
        CheckLedger.SetRange(CheckLedger."Document No.","No.");
        CheckLedger.SetRange(CheckLedger."Entry Status",CheckLedger."entry status"::Printed);
        if CheckLedger.Find('-') then begin
        //Ask whether to void the printed cheque
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name",JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name",JBatch);
        GenJnlLine.FindFirst;
        if Confirm(Text000,false,CheckLedger."Check No.") then
          CheckManagement.VoidCheck(GenJnlLine)
          else
           Error(Text001,"No.",CheckLedger."Check No.");
        end;

    end;


    procedure PostPV(var Payment: Record "Payment Header.")
    begin

        PayLine.Reset;
        PayLine.SetRange(PayLine."Received From",Payments."No.");
        if PayLine.Find('-') then begin

        repeat
            strText:=GetAppliedEntries(PayLine."On Behalf Of");
            Payment.TestField(Payment.Payee);
            PayLine.TestField(PayLine.Remarks);
           // PayLine.TESTFIELD(PayLine."Shortcut Dimension 1 Code");

            //BANK
            if PayLine."Budget Center Name"=PayLine."budget center name"::"1" then begin
              CashierLinks.Reset;
              CashierLinks.SetRange(CashierLinks.UserID,UserId);
            end;

            //CHEQUE
            LineNo:=LineNo+1000;
            GenJnlLine.Init;
            GenJnlLine."Journal Template Name":=JTemplate;
            GenJnlLine.Validate(GenJnlLine."Journal Template Name");
            GenJnlLine."Journal Batch Name":=JBatch;
            GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
            GenJnlLine."Source Code":='PAYMENTJNL';
            GenJnlLine."Line No.":=LineNo;
            GenJnlLine."Posting Date":=Payment."Payment Release Date";
            GenJnlLine."Document No.":=PayLine."Received From";
            if PayLine.Posted=PayLine.Posted::"1" then
            GenJnlLine."Document Type":=GenJnlLine."document type"::" "
            else
              GenJnlLine."Document Type":=GenJnlLine."document type"::Payment;
            GenJnlLine."Account Type":=PayLine.Posted;
            GenJnlLine."Account No.":=PayLine."Date Posted";
            GenJnlLine.Validate(GenJnlLine."Account No.");
            GenJnlLine."External Document No.":=Payments."Cheque No";
            GenJnlLine.Description:=CopyStr(PayLine."Posted By" + ':' + Payment.Payee,1,50);
            GenJnlLine."Currency Code":=Payments."Currency Code";
            GenJnlLine.Validate("Currency Code");
            GenJnlLine."Currency Factor":=Payments."Currency Factor";
            GenJnlLine.Validate("Currency Factor");
            if PayLine."VAT Code"='' then
              begin
                GenJnlLine.Amount:=PayLine."PO/INV No" ;
              end
            else
              begin
                GenJnlLine.Amount:=PayLine."PO/INV No";
              end;
            GenJnlLine.Validate(GenJnlLine.Amount);
            GenJnlLine."VAT Prod. Posting Group":=PayLine."Bank Type";
            GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
            //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
            GenJnlLine."Shortcut Dimension 1 Code":=PayLine."PV Type";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
            GenJnlLine."Shortcut Dimension 2 Code":=PayLine."Apply to";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
            GenJnlLine.ValidateShortcutDimCode(3,PayLine."Apply to ID");
            GenJnlLine.ValidateShortcutDimCode(4,PayLine."No of Units");
            GenJnlLine."Applies-to Doc. Type":=GenJnlLine."applies-to doc. type"::Invoice;
            GenJnlLine."Applies-to Doc. No.":=PayLine."Total Expenditure";
            GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
            GenJnlLine."Applies-to ID":=PayLine."Total Commitments";

            if GenJnlLine.Amount<>0 then GenJnlLine.Insert;

            //Post VAT to GL[VAT GL]
            TarriffCodes.Reset;
            TarriffCodes.SetRange(TarriffCodes."Tax Code",PayLine."VAT Code");
            if TarriffCodes.Find('-') then begin
            TarriffCodes.TestField(TarriffCodes."Account No");
            LineNo:=LineNo+1000;
            GenJnlLine.Init;
            GenJnlLine."Journal Template Name":=JTemplate;
            GenJnlLine.Validate(GenJnlLine."Journal Template Name");
            GenJnlLine."Journal Batch Name":=JBatch;
            GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
            GenJnlLine."Source Code":='PAYMENTJNL';
            GenJnlLine."Line No.":=LineNo;
            GenJnlLine."Posting Date":=Payment."Payment Release Date";
            GenJnlLine."Document Type":=GenJnlLine."document type"::Payment;
            GenJnlLine."Document No.":=PayLine."Received From";
            GenJnlLine."External Document No.":=Payments."Cheque No";
            GenJnlLine."Account Type":=GenJnlLine."account type"::"G/L Account";
            GenJnlLine."Account No.":=TarriffCodes."Account No";
            GenJnlLine.Validate(GenJnlLine."Account No.");
            GenJnlLine."Currency Code":=Payments."Currency Code";
            GenJnlLine.Validate(GenJnlLine."Currency Code");
            //CurrFactor
            GenJnlLine."Currency Factor":=Payments."Currency Factor";
            GenJnlLine.Validate("Currency Factor");

            GenJnlLine."Gen. Posting Type":=GenJnlLine."gen. posting type"::" ";
            GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
            GenJnlLine."Gen. Bus. Posting Group":='';
            GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
            GenJnlLine."Gen. Prod. Posting Group":='';
            GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
            GenJnlLine."VAT Bus. Posting Group":='';
            GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
            GenJnlLine."VAT Prod. Posting Group":='';
            GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
            GenJnlLine.Amount:=-PayLine."Withholding Tax Code";
            GenJnlLine.Validate(GenJnlLine.Amount);
            GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
            GenJnlLine."Bal. Account No.":='';
            GenJnlLine.Description:=CopyStr('VAT:' + Format(PayLine.Posted) + '::' + Format(PayLine."Time Posted"),1,50);
            GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
            GenJnlLine."Shortcut Dimension 1 Code":=PayLine."PV Type";
            GenJnlLine."Shortcut Dimension 2 Code":="Global Dimension 2 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
            GenJnlLine.ValidateShortcutDimCode(3,PayLine."Apply to ID");
            GenJnlLine.ValidateShortcutDimCode(4,PayLine."No of Units");

            if GenJnlLine.Amount<>0 then GenJnlLine.Insert;
            end;

            //POST W/TAX to Respective W/TAX GL Account
            TarriffCodes.Reset;
            TarriffCodes.SetRange(TarriffCodes."Tax Code",PayLine."Withholding Tax Amount");
            if TarriffCodes.Find('-') then begin
            TarriffCodes.TestField(TarriffCodes."Account No");
            LineNo:=LineNo+1000;
            GenJnlLine.Init;
            GenJnlLine."Journal Template Name":=JTemplate;
            GenJnlLine.Validate(GenJnlLine."Journal Template Name");
            GenJnlLine."Journal Batch Name":=JBatch;
            GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
            GenJnlLine."Source Code":='PAYMENTJNL';
            GenJnlLine."Line No.":=LineNo;
            GenJnlLine."Posting Date":=Payment."Payment Release Date";
            GenJnlLine."Document Type":=GenJnlLine."document type"::Payment;
            GenJnlLine."Document No.":=PayLine."Received From";
            GenJnlLine."External Document No.":=Payments."Cheque No";
            GenJnlLine."Account Type":=GenJnlLine."account type"::"G/L Account";
            GenJnlLine."Account No.":=TarriffCodes."Account No";
            GenJnlLine.Validate(GenJnlLine."Account No.");
            GenJnlLine."Currency Code":=Payments."Currency Code";
            GenJnlLine.Validate(GenJnlLine."Currency Code");
            //CurrFactor
            GenJnlLine."Currency Factor":=Payments."Currency Factor";
            GenJnlLine.Validate("Currency Factor");

            GenJnlLine."Gen. Posting Type":=GenJnlLine."gen. posting type"::" ";
            GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
            GenJnlLine."Gen. Bus. Posting Group":='';
            GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
            GenJnlLine."Gen. Prod. Posting Group":='';
            GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
            GenJnlLine."VAT Bus. Posting Group":='';
            GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
            GenJnlLine."VAT Prod. Posting Group":='';
            GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
            GenJnlLine.Amount:=-PayLine."Net Amount";
            GenJnlLine.Validate(GenJnlLine.Amount);
            GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
            GenJnlLine."Bal. Account No.":='';
            GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
            GenJnlLine.Description:=CopyStr('W/Tax:' + Format(PayLine."Time Posted") +'::' + strText,1,50);
            GenJnlLine."Shortcut Dimension 1 Code":=PayLine."PV Type";
            GenJnlLine."Shortcut Dimension 2 Code":="Global Dimension 2 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
            GenJnlLine.ValidateShortcutDimCode(3,PayLine."Apply to ID");
            GenJnlLine.ValidateShortcutDimCode(4,PayLine."No of Units");

            if GenJnlLine.Amount<>0 then
            GenJnlLine.Insert;
            end;

            //Post VAT Balancing Entry Goes to Vendor
            LineNo:=LineNo+1000;
            GenJnlLine.Init;
            GenJnlLine."Journal Template Name":=JTemplate;
            GenJnlLine.Validate(GenJnlLine."Journal Template Name");
            GenJnlLine."Journal Batch Name":=JBatch;
            GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
            GenJnlLine."Source Code":='PAYMENTJNL';
            GenJnlLine."Line No.":=LineNo;
            GenJnlLine."Posting Date":=Payment."Payment Release Date";
            GenJnlLine."Document Type":=GenJnlLine."document type"::Payment;
            GenJnlLine."Document No.":=PayLine."Received From";
            GenJnlLine."External Document No.":=Payments."Cheque No";
            GenJnlLine."Account Type":=PayLine.Posted;
            GenJnlLine."Account No.":=PayLine."Date Posted";
            GenJnlLine.Validate(GenJnlLine."Account No.");
            GenJnlLine."Currency Code":=Payments."Currency Code";
            GenJnlLine.Validate(GenJnlLine."Currency Code");
            //CurrFactor
            GenJnlLine."Currency Factor":=Payments."Currency Factor";
            GenJnlLine.Validate("Currency Factor");

            if PayLine."VAT Code"='' then
              begin
                GenJnlLine.Amount:=0;
              end
            else
              begin
                GenJnlLine.Amount:=PayLine."Withholding Tax Code";
              end;
            GenJnlLine.Validate(GenJnlLine.Amount);
            GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
            GenJnlLine."Bal. Account No.":='';
            GenJnlLine.Description:=CopyStr('VAT:' + Format(PayLine.Posted) + '::' + Format(PayLine."Time Posted"),1,50) ;
            GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
            GenJnlLine."Shortcut Dimension 1 Code":=PayLine."PV Type";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
            GenJnlLine."Shortcut Dimension 2 Code":="Global Dimension 2 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
            GenJnlLine.ValidateShortcutDimCode(3,PayLine."Apply to ID");
            GenJnlLine.ValidateShortcutDimCode(4,PayLine."No of Units");
            GenJnlLine."Applies-to Doc. Type":=GenJnlLine."applies-to doc. type"::Invoice;
            GenJnlLine."Applies-to Doc. No.":=PayLine."Total Expenditure";
            GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
            GenJnlLine."Applies-to ID":=PayLine."Total Commitments";
            if GenJnlLine.Amount<>0 then
            GenJnlLine.Insert;

            //Post W/TAX Balancing Entry Goes to Vendor
            LineNo:=LineNo+1000;
            GenJnlLine.Init;
            GenJnlLine."Journal Template Name":=JTemplate;
            GenJnlLine.Validate(GenJnlLine."Journal Template Name");
            GenJnlLine."Journal Batch Name":=JBatch;
            GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
            GenJnlLine."Source Code":='PAYMENTJNL';
            GenJnlLine."Line No.":=LineNo;
            GenJnlLine."Posting Date":=Payment."Payment Release Date";
            GenJnlLine."Document Type":=GenJnlLine."document type"::Payment;
            GenJnlLine."Document No.":=PayLine."Received From";
            GenJnlLine."External Document No.":=Payments."Cheque No";
            GenJnlLine."Account Type":=PayLine.Posted;
            GenJnlLine."Account No.":=PayLine."Date Posted";
            GenJnlLine.Validate(GenJnlLine."Account No.");
            GenJnlLine."Currency Code":=Payments."Currency Code";
            GenJnlLine.Validate(GenJnlLine."Currency Code");
            //CurrFactor
            GenJnlLine."Currency Factor":=Payments."Currency Factor";
            GenJnlLine.Validate("Currency Factor");

            GenJnlLine."Gen. Posting Type":=GenJnlLine."gen. posting type"::" ";
            GenJnlLine.Validate(GenJnlLine."Gen. Posting Type");
            GenJnlLine."Gen. Bus. Posting Group":='';
            GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
            GenJnlLine."Gen. Prod. Posting Group":='';
            GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
            GenJnlLine."VAT Bus. Posting Group":='';
            GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
            GenJnlLine."VAT Prod. Posting Group":='';
            GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
            GenJnlLine.Amount:=PayLine."Net Amount";
            GenJnlLine.Validate(GenJnlLine.Amount);
            GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
            GenJnlLine."Bal. Account No.":='';
            GenJnlLine.Description:=CopyStr('W/Tax:' + strText ,1,50);
            GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
            GenJnlLine."Shortcut Dimension 1 Code":=PayLine."PV Type";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
            GenJnlLine."Shortcut Dimension 2 Code":="Global Dimension 2 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
            GenJnlLine.ValidateShortcutDimCode(3,PayLine."Apply to ID");
            GenJnlLine.ValidateShortcutDimCode(4,PayLine."No of Units");
            GenJnlLine."Applies-to Doc. Type":=GenJnlLine."applies-to doc. type"::Invoice;
            GenJnlLine."Applies-to Doc. No.":=PayLine."Total Expenditure";
            GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
            GenJnlLine."Applies-to ID":=PayLine."Total Commitments";
            if GenJnlLine.Amount<>0 then
            GenJnlLine.Insert;


        until PayLine.Next=0;

        Commit;
        //Post the Journal Lines
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name",JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name",JBatch);
        //Adjust Gen Jnl Exchange Rate Rounding Balances
           AdjustGenJnl.Run(GenJnlLine);
        //End Adjust Gen Jnl Exchange Rate Rounding Balances


        //Before posting if paymode is cheque print the cheque
        if ("Payment Mode"="payment mode"::Cheque) and ("Cheque Type"="cheque type"::"Computer Cheque") then begin
        DocPrint.PrintCheck(GenJnlLine);
        Codeunit.Run(Codeunit::"Adjust Gen. Journal Balance",GenJnlLine);
        //Confirm Cheque printed //Not necessary.
        end;

        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Line",GenJnlLine);
        Post:=false;
        Post:=JournlPosted.PostedSuccessfully();
        if Post then
          begin
            if PayLine.FindFirst then
              begin
                repeat
                  PayLine."Imprest Request No":=Today;
                  PayLine."Batched Imprest Tot":=Time;
                  PayLine."Shortcut Dimension 2 Code":=UserId;
                  PayLine."Petty Cash":=PayLine."petty cash"::"4";
                  PayLine.Modify;
               until PayLine.Next=0;
             end;
          end;

        end;
    end;


    procedure UpdatePageControls()
    begin
             if Status<>Status::Approved then begin
             "Payment Release DateEditable" :=false;
             //CurrForm."Paying Bank Account".EDITABLE:=FALSE;
             //CurrForm."Payment Mode".EDITABLE:=FALSE;
             //CurrForm."Currency Code".EDITABLE:=TRUE;
             "Cheque No.Editable" :=false;
             "Cheque TypeEditable" :=false;
             "Invoice Currency CodeEditable" :=true;
             end else begin
             "Payment Release DateEditable" :=true;
             //CurrForm."Paying Bank Account".EDITABLE:=TRUE;
             //CurrForm."Payment Mode".EDITABLE:=TRUE;
             if "Payment Mode"="payment mode"::Cheque then
               "Cheque TypeEditable" :=true;
             //CurrForm."Currency Code".EDITABLE:=FALSE;
             if "Cheque Type"<>"cheque type"::"Computer Cheque" then
                 "Cheque No.Editable" :=true;
             "Invoice Currency CodeEditable" :=false;

             CurrPage.Update;
             end;


             if Status=Status::"Pending Approval" then begin
             "Currency CodeEditable" :=true;
             GlobalDimension1CodeEditable :=true;
             "Payment NarrationEditable" :=true;
             ShortcutDimension2CodeEditable :=true;
             PayeeEditable :=true;
             ShortcutDimension3CodeEditable :=true;
             ShortcutDimension4CodeEditable :=true;
             DateEditable :=true;
             PVLinesEditable :=true;

             CurrPage.Update;
             end else begin
             "Currency CodeEditable" :=false;
             GlobalDimension1CodeEditable :=false;
             "Payment NarrationEditable" :=false;
             ShortcutDimension2CodeEditable :=false;
             PayeeEditable :=false;
             ShortcutDimension3CodeEditable :=false;
             ShortcutDimension4CodeEditable :=false;
             DateEditable :=false;
             PVLinesEditable :=false;


             CurrPage.Update;
             end
    end;


    procedure LinesExists(): Boolean
    var
        PayLines: Record "Payment Line.";
    begin
         HasLines:=false;
         PayLines.Reset;
         PayLines.SetRange(PayLines."Received From","No.");
          if PayLines.Find('-') then begin
             HasLines:=true;
             exit(HasLines);
          end;
    end;


    procedure AllFieldsEntered(): Boolean
    var
        PayLines: Record "Payment Line.";
    begin
        AllKeyFieldsEntered:=true;
         PayLines.Reset;
         PayLines.SetRange(PayLines."Received From","No.");
          if PayLines.Find('-') then begin
            repeat
             if (PayLines."Date Posted"='') or (PayLines.Remarks<=0) then
             AllKeyFieldsEntered:=false;
            until PayLines.Next=0;
             exit(AllKeyFieldsEntered);
          end;
    end;


    procedure CustomerPayLinesExist(): Boolean
    var
        PayLine: Record "Payment Line.";
    begin
        PayLine.Reset;
        PayLine.SetRange(PayLine."Received From","No.");
        PayLine.SetRange(PayLine.Posted,PayLine.Posted::"1");
        exit(PayLine.FindFirst);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        UpdatePageControls();

        //Set the filters here
        SetRange(Posted,false);
        SetRange("Payment Type","payment type"::Normal);
        SetFilter(Status,'<>Cancelled');
    end;


    procedure SetSelection(var Collection: Record "Payment Header.")
    begin
        CurrPage.SetSelectionFilter(Collection);
    end;
}

