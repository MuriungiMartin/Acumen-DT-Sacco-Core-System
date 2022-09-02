#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516528 "Cheque Receipts Header"
{
    PageType = Card;
    SourceTable = "Cheque Receipts";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Time";"Transaction Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By";"Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By";"Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Unpaid By";"Unpaid By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Refference Document";"Refference Document")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Unpaid;Unpaid)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group(Control13)
            {
                part(Control12;"Cheque Receipt Lines")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Import)
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    RefNoRec.Reset;
                    RefNoRec.SetRange(RefNoRec.CurrUserID,UserId);
                    if RefNoRec.Find('-') then begin
                    RefNoRec."Reference No":="No.";
                    RefNoRec.Modify;
                    end
                    else begin
                    RefNoRec.Init;
                    RefNoRec.CurrUserID:=UserId;
                    RefNoRec."Reference No":="No.";
                    RefNoRec.Insert;
                    end;


                    InwardFile.Reset;
                    InwardFile.SetRange(InwardFile.CurrentUserID,UserId);
                    if InwardFile.Find('-') then
                    InwardFile.DeleteAll;


                    Commit;

                    Xmlport.Run(51516033,true);


                    Commit;

                    Report.Run(51516506,true);


                    Commit;

                    Report.Run(51516505,true);

                    "Created By":=UserId;
                    Modify;
                end;
            }
            action(Post)
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    
                    
                    if Confirm('Are you sure you want post cheques',true)=true then begin
                    GenSetup.Get;
                    
                    if Posted=true then
                    Error('The Transaction has already been posted');
                    
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name",'CHQTRANS');
                    GenJournalLine.DeleteAll;
                    
                    ChqRecLines.Reset;
                    ChqRecLines.SetRange(ChqRecLines."Chq Receipt No","No.");
                    ChqRecLines.SetRange(ChqRecLines.Status,ChqRecLines.Status::Pending);
                    if ChqRecLines.Find('-') then begin
                    repeat
                    
                    
                    
                      LineNo:=LineNo+10000;
                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":='CHQTRANS';
                      GenJournalLine."Document No.":="No.";
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
                      GenJournalLine."Account No.":='BNK0022';
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":="Transaction Date";
                      GenJournalLine."External Document No.":=ChqRecLines."Cheque Serial No";
                      GenJournalLine.Description:='Cheque Issued'+ChqRecLines."Cheque Serial No";
                      GenJournalLine.Amount:=-(ChqRecLines.Amount);
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                      if Vend.Get(ChqRecLines."Account No.") then begin
                      GenJournalLine."Shortcut Dimension 2 Code":=Vend."Global Dimension 2 Code";
                      end;
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                      if GenJournalLine.Amount<>0 then
                     // AllAmount:=AllAmount+(Charges."Charge Amount"+Charges."Charge Amount"*0.1);
                      GenJournalLine.Insert;
                    
                    
                    
                      //Cheque Amounts
                      LineNo:=LineNo+10000;
                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":='CHQTRANS';
                      GenJournalLine."Document No.":="No.";
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                      GenJournalLine."Account No.":=ChqRecLines."Account No.";
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":="Transaction Date";
                      GenJournalLine."External Document No.":=ChqRecLines."Cheque Serial No";
                      GenJournalLine.Description:='Cheque Issued'+ChqRecLines."Cheque Serial No";
                      GenJournalLine.Amount:=ChqRecLines.Amount;
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                     // GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"Bank Account";
                     // GenJournalLine."Bal. Account No.":='175';
                      if Vend.Get(ChqRecLines."Account No.") then begin
                      GenJournalLine."Shortcut Dimension 2 Code":=Vend."Global Dimension 2 Code";
                      end;
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                      if GenJournalLine.Amount<>0 then
                      GenJournalLine.Insert;
                    
                          AllAmount:=0;
                    
                    
                    
                    Charges.Reset;
                    Charges.SetRange(Charges."Charge Type",Charges."charge type"::"Cheque Processing");
                    if Charges.Find('-') then begin
                    Charges.TestField(Charges."GL Account");
                    Charges.TestField(Charges."Charge Amount");
                    Charges.TestField(Charges."Sacco Amount");
                    Charges.TestField(Charges."Bank Account");
                    
                      //Post cheque processing charges
                    
                      LineNo:=LineNo+10000;
                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":='CHQTRANS';
                      GenJournalLine."Document No.":="No.";
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                      GenJournalLine."Account No.":=Charges."GL Account";
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":="Transaction Date";
                      GenJournalLine."External Document No.":=ChqRecLines."Cheque Serial No";
                      GenJournalLine.Description:='Cheque processed Commision';
                      GenJournalLine.Amount:=(Charges."Sacco Amount")*-1;
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                      if Vend.Get(ChqRecLines."Account No.") then begin
                      GenJournalLine."Shortcut Dimension 2 Code":=Vend."Global Dimension 2 Code";
                      end;
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                      if GenJournalLine.Amount<>0 then
                      AllAmount:=AllAmount+Abs(GenJournalLine.Amount);
                      GenJournalLine.Insert;
                    
                    //Excise duty
                      LineNo:=LineNo+10000;
                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":='CHQTRANS';
                      GenJournalLine."Document No.":="No.";
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                      GenJournalLine."Account No.":=GenSetup."Excise Duty Account";//GenSetup."Excise Duty G/L Acc.";
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":="Transaction Date";
                      GenJournalLine."External Document No.":=ChqRecLines."Cheque Serial No";
                      GenJournalLine.Description:='Excise Duty';
                      GenJournalLine.Amount:=-ROUND(Charges."Sacco Amount"*0.1);
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                      if Vend.Get(ChqRecLines."Account No.") then begin
                      GenJournalLine."Shortcut Dimension 2 Code":=Vend."Global Dimension 2 Code";
                      end;
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                      if GenJournalLine.Amount<>0 then
                     AllAmount:=AllAmount+Abs(GenJournalLine.Amount);
                      GenJournalLine.Insert;
                    
                    
                      //Charges Cheque Amounts
                      LineNo:=LineNo+10000;
                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":='CHQTRANS';
                      GenJournalLine."Document No.":="No.";
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
                      GenJournalLine."Account No.":=Charges."Bank Account";
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":="Transaction Date";
                      GenJournalLine."External Document No.":=ChqRecLines."Cheque Serial No";
                      GenJournalLine.Description:='Cheque Processed Charges'+ChqRecLines."Cheque Serial No";
                      GenJournalLine.Amount:=(Charges."Charge Amount"-Charges."Sacco Amount")*-1;
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                      if Vend.Get(ChqRecLines."Account No.") then begin
                      GenJournalLine."Shortcut Dimension 2 Code":=Vend."Global Dimension 2 Code";
                      end;
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                      if GenJournalLine.Amount<>0 then
                      AllAmount:=AllAmount+Abs(GenJournalLine.Amount);
                      GenJournalLine.Insert;
                    
                    
                    
                      //Charges Cheque Amounts
                      LineNo:=LineNo+10000;
                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":='CHQTRANS';
                      GenJournalLine."Document No.":="No.";
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                      GenJournalLine."Account No.":=ChqRecLines."Account No.";
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":="Transaction Date";
                      GenJournalLine."External Document No.":=ChqRecLines."Cheque Serial No";
                      GenJournalLine.Description:='Cheque Processed Charges'+ChqRecLines."Cheque Serial No";
                      GenJournalLine.Amount:=AllAmount;
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                      if Vend.Get(ChqRecLines."Account No.") then begin
                      GenJournalLine."Shortcut Dimension 2 Code":=Vend."Global Dimension 2 Code";
                      end;
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                      if GenJournalLine.Amount<>0 then
                      GenJournalLine.Insert;
                    
                    
                     end;
                    
                    
                    
                    AllAmount:=0;
                    
                    
                    
                    
                    until ChqRecLines.Next=0;
                    end;
                    
                    
                    
                    
                    //Post New
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name",'CHQTRANS');
                    if GenJournalLine.Find('-') then begin
                    //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch",GenJournalLine);
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco",GenJournalLine);
                    end;
                    
                    //Mark cheque book register
                    ChqRecLines.Reset;
                    ChqRecLines.SetRange(ChqRecLines."Chq Receipt No","No.");
                    ChqRecLines.SetRange(ChqRecLines.Status,ChqRecLines.Status::Pending);
                    if ChqRecLines.Find('-') then begin
                    repeat
                    CheqReg.Reset;
                    CheqReg.SetRange(CheqReg."Cheque No.",ChqRecLines."Cheque Serial No");
                    if CheqReg.Find('-') then begin
                    CheqReg.Status:=CheqReg.Status::Approved;
                    CheqReg."Approval Date":=Today;
                    CheqReg.Modify;
                    end;
                    
                    until ChqRecLines.Next=0;
                    end;
                    
                    
                    
                    
                    
                    Posted:=true;
                    "Posted By":=UserId;
                    Modify;
                    
                    //Update cheque register
                    
                    
                    end;
                    Message('Transaction succesfully posted');
                    
                    //////
                    /*
                    IF CONFIRM('Are you sure you want post cheques',TRUE)=TRUE THEN BEGIN
                    GenSetup.GET(0);
                    
                    IF Posted=TRUE THEN
                    ERROR('The Transaction has already been posted');
                    
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                    GenJournalLine.SETRANGE("Journal Batch Name",'CHQTRANS');
                    GenJournalLine.DELETEALL;
                    
                    ChqRecLines.RESET;
                    ChqRecLines.SETRANGE(ChqRecLines."Chq Receipt No","No.");
                    ChqRecLines.SETRANGE(ChqRecLines.Status,ChqRecLines.Status::Pending);
                    IF ChqRecLines.FIND('-') THEN BEGIN
                    REPEAT
                    IF Charges.GET('073') THEN BEGIN
                    Charges.TESTFIELD(Charges."GL Account");
                    Charges.TESTFIELD(Charges."Charge Amount");
                    END;
                    
                    
                      //Post cheque processing charges
                    
                      LineNo:=LineNo+10000;
                      GenJournalLine.INIT;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":='CHQTRANS';
                      GenJournalLine."Document No.":="No.";
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                      GenJournalLine."Account No.":=Charges."GL Account";
                      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":="Transaction Date";
                      GenJournalLine."External Document No.":=ChqRecLines."Cheque Serial No";
                      GenJournalLine.Description:='Cheque processed Commision';
                      GenJournalLine.Amount:=-Charges."Sacco Amount";
                      GenJournalLine.VALIDATE(GenJournalLine.Amount);
                      GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                      IF Vend.GET(ChqRecLines."Account No.") THEN BEGIN
                      GenJournalLine."Shortcut Dimension 2 Code":=Vend."Global Dimension 2 Code";
                      END;
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                      IF GenJournalLine.Amount<>0 THEN
                      AllAmount:=AllAmount+Charges."Sacco Amount";
                      GenJournalLine.INSERT;
                    
                    //Excise duty
                      LineNo:=LineNo+10000;
                      GenJournalLine.INIT;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":='CHQTRANS';
                      GenJournalLine."Document No.":="No.";
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                      GenJournalLine."Account No.":=GenSetup."Excise Duty G/L Acc.";
                      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":="Transaction Date";
                      GenJournalLine."External Document No.":=ChqRecLines."Cheque Serial No";
                      GenJournalLine.Description:='Excise Duty';
                      GenJournalLine.Amount:=-ROUND(Charges."Sacco Amount"*0.1);
                      GenJournalLine.VALIDATE(GenJournalLine.Amount);
                      GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                      IF Vend.GET(ChqRecLines."Account No.") THEN BEGIN
                      GenJournalLine."Shortcut Dimension 2 Code":=Vend."Global Dimension 2 Code";
                      END;
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                      IF GenJournalLine.Amount<>0 THEN
                      AllAmount:=AllAmount+Charges."Sacco Amount"*0.1;
                      GenJournalLine.INSERT;
                    
                    
                    
                    
                    
                    
                      LineNo:=LineNo+10000;
                      GenJournalLine.INIT;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":='CHQTRANS';
                      GenJournalLine."Document No.":="No.";
                      GenJournalLine."Line No.":=LineNo;
                     // GenJournalLine."Account Type":=GenJournalLine."Account Type"::"Bank Account";
                     // GenJournalLine."Account No.":='175';
                      GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                      GenJournalLine."Account No.":='1-00-804-025';
                      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":="Transaction Date";
                      GenJournalLine."External Document No.":=ChqRecLines."Cheque Serial No";
                      GenJournalLine.Description:='Cheque Issued'+ChqRecLines."Cheque Serial No";
                      GenJournalLine.Amount:=-(ChqRecLines.Amount+Charges."Charge Amount"+Charges."Charge Amount"*0.1);
                      GenJournalLine.VALIDATE(GenJournalLine.Amount);
                      GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                      IF Vend.GET(ChqRecLines."Account No.") THEN BEGIN
                      GenJournalLine."Shortcut Dimension 2 Code":=Vend."Global Dimension 2 Code";
                      END;
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                      IF GenJournalLine.Amount<>0 THEN
                      AllAmount:=AllAmount+(Charges."Charge Amount"+Charges."Charge Amount"*0.1);
                      GenJournalLine.INSERT;
                    
                    
                    
                      //Cheque Amounts
                      LineNo:=LineNo+10000;
                      GenJournalLine.INIT;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":='CHQTRANS';
                      GenJournalLine."Document No.":="No.";
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
                      GenJournalLine."Account No.":=ChqRecLines."Account No.";
                      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":="Transaction Date";
                      GenJournalLine."External Document No.":=ChqRecLines."Cheque Serial No";
                      GenJournalLine.Description:='Cheque Issued'+ChqRecLines."Cheque Serial No";
                      GenJournalLine.Amount:=ChqRecLines.Amount;
                      GenJournalLine.VALIDATE(GenJournalLine.Amount);
                      GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                     // GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"Bank Account";
                     // GenJournalLine."Bal. Account No.":='175';
                      IF Vend.GET(ChqRecLines."Account No.") THEN BEGIN
                      GenJournalLine."Shortcut Dimension 2 Code":=Vend."Global Dimension 2 Code";
                      END;
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                      IF GenJournalLine.Amount<>0 THEN
                      GenJournalLine.INSERT;
                    
                    
                      //Charges Cheque Amounts
                      LineNo:=LineNo+10000;
                      GenJournalLine.INIT;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":='CHQTRANS';
                      GenJournalLine."Document No.":="No.";
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
                      GenJournalLine."Account No.":=ChqRecLines."Account No.";
                      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":="Transaction Date";
                      GenJournalLine."External Document No.":=ChqRecLines."Cheque Serial No";
                      GenJournalLine.Description:='Cheque Processed Charges'+ChqRecLines."Cheque Serial No";
                      GenJournalLine.Amount:=AllAmount;
                      GenJournalLine.VALIDATE(GenJournalLine.Amount);
                      GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                     // GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"Bank Account";
                     // GenJournalLine."Bal. Account No.":='175';
                      IF Vend.GET(ChqRecLines."Account No.") THEN BEGIN
                      GenJournalLine."Shortcut Dimension 2 Code":=Vend."Global Dimension 2 Code";
                      END;
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                      IF GenJournalLine.Amount<>0 THEN
                      GenJournalLine.INSERT;
                    
                    AllAmount:=0;
                    
                    
                    
                    
                    UNTIL ChqRecLines.NEXT=0;
                    END;
                    
                    
                    
                    
                    //Post New
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name",'GENERAL');
                    GenJournalLine.SETRANGE("Journal Batch Name",'CHQTRANS');
                    IF GenJournalLine.FIND('-') THEN BEGIN
                    CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch",GenJournalLine);
                    END;
                    
                    //Mark cheque book register
                    ChqRecLines.RESET;
                    ChqRecLines.SETRANGE(ChqRecLines."Chq Receipt No","No.");
                    ChqRecLines.SETRANGE(ChqRecLines.Status,ChqRecLines.Status::Pending);
                    IF ChqRecLines.FIND('-') THEN BEGIN
                    REPEAT
                    CheqReg.RESET;
                    CheqReg.SETRANGE(CheqReg."Cheque No.",ChqRecLines."Cheque Serial No");
                    IF CheqReg.FIND('-') THEN BEGIN
                    CheqReg.Status:=CheqReg.Status::Approved;
                    CheqReg."Approval Date":=TODAY;
                    CheqReg.MODIFY;
                    END;
                    
                    UNTIL ChqRecLines.NEXT=0;
                    END;
                    
                    
                    
                    
                    
                    Posted:=TRUE;
                    "Posted By":=USERID;
                    MODIFY;
                    
                    //Update cheque register
                    
                    
                    END;
                     */

                end;
            }
            action("Post Unpay Accounts")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    
                    if Confirm('Are you sure you want to unpay accounts',false)=true then begin
                    
                    //IF UPPERCASE(USERID)=UPPERCASE("Posted By") THEN
                    //ERROR('This must be done by another user');
                    
                    if Posted=false then
                    Error('It must be posted first');
                    
                    if Unpaid=true then
                    Error('The Transaction has already been unpaid');
                    
                    
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name",'CHQTRANS');
                    GenJournalLine.DeleteAll;
                    
                    ChqRecLines.Reset;
                    ChqRecLines.SetRange(ChqRecLines."Chq Receipt No","No.");
                    ChqRecLines.SetRange(ChqRecLines.Status,ChqRecLines.Status::Pending);
                    if ChqRecLines.Find('-') then begin
                    repeat
                    
                    if ChqRecLines."Un pay Code"<>'' then begin
                    
                    
                    //Cheque Amounts
                    
                      LineNo:=LineNo+10000;
                    
                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":='CHQTRANS';
                      GenJournalLine."Document No.":="No.";
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                      GenJournalLine."Account No.":=ChqRecLines."Account No.";
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":="Transaction Date";
                      GenJournalLine."External Document No.":=ChqRecLines."Cheque Serial No";
                      GenJournalLine.Description:='Cheque Issued'+ChqRecLines."Cheque Serial No";
                      GenJournalLine.Amount:=ChqRecLines.Amount*-1;
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                      GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"Bank Account";
                      GenJournalLine."Bal. Account No.":='BNK0022';
                     // GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                      if GenJournalLine.Amount<>0 then
                      GenJournalLine.Insert;
                    
                      //Post cheque processing charges
                    
                      LineNo:=LineNo+10000;
                    
                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":='CHQTRANS';
                      GenJournalLine."Document No.":="No.";
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                      GenJournalLine."Account No.":=ChqRecLines."Account No.";
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":="Transaction Date";
                      GenJournalLine."External Document No.":=ChqRecLines."Cheque Serial No";
                      GenJournalLine.Description:='Cheque unpay Commision';
                      GenJournalLine.Amount:=ChqRecLines."Un Pay Charge Amount";
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                      GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                      GenJournalLine."Bal. Account No.":='1-00-200-005';
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                      if GenJournalLine.Amount<>0 then
                      GenJournalLine.Insert;
                    
                    //Excise duty
                    GenSetup.Get;
                    
                      LineNo:=LineNo+10000;
                    
                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":='CHQTRANS';
                      GenJournalLine."Document No.":="No.";
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                      GenJournalLine."Account No.":=ChqRecLines."Account No.";
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Posting Date":="Transaction Date";
                      GenJournalLine."External Document No.":=ChqRecLines."Cheque Serial No";
                      GenJournalLine.Description:='Excise Duty';
                      GenJournalLine.Amount:=ChqRecLines."Un Pay Charge Amount"*0.1;
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                      GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                      GenJournalLine."Bal. Account No.":=GenSetup."Excise Duty Account";//GenSetup."Excise Duty G/L Acc.";
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                      if GenJournalLine.Amount<>0 then
                      GenJournalLine.Insert;
                    
                    end;
                    until ChqRecLines.Next=0;
                    end;
                    
                    
                    
                    
                    //Post New
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name",'CHQTRANS');
                    if GenJournalLine.Find('-') then begin
                    //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch",GenJournalLine);
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco",GenJournalLine);
                    end;
                    
                    
                    
                    Unpaid:=true;
                    "Unpaid By":=UserId;
                    Modify;
                    
                    if Unpaid=true then
                    Error('The Transaction has already been unpaid');
                    
                    
                    /*
                    
                    "Unpaid By":=USERID;
                    Unpaid:=TRUE;
                    
                    */
                    end;

                end;
            }
            action("Export Unpay Accounts")
            {
                ApplicationArea = Basic;
                Image = Export;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    ChqRecLines.Reset;
                    ChqRecLines.SetRange(ChqRecLines."Chq Receipt No","No.");
                    Xmlport.Run(51516034);
                end;
            }
        }
    }

    var
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        AccountType: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        LineNo: Integer;
        Accounts: Record Vendor;
        ReffNo: Code[20];
        Account: Record Vendor;
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Vend: Record Vendor;
        ChqRecLines: Record "Cheque Issue Lines";
        AccountTypes: Record "Account Types-Saving Products";
        CheqReg: Record "Cheques Register";
        Charges: Record Charges;
        GenSetup: Record "Sacco General Set-Up";
        RefNoRec: Record "Refference Number";
        AllAmount: Decimal;
        InwardFile: Record "Inward file Buffer";
}

