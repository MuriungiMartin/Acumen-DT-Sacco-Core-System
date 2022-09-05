#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516417 "Paybill Processing Header"
{
    // IF Posted=TRUE THEN
    // ERROR('This Check Off has already been posted');
    // 
    // 
    // IF "Account No" = '' THEN
    // ERROR('You must specify the Account No.');
    // 
    // IF "Document No" = '' THEN
    // ERROR('You must specify the Document No.');
    // 
    // 
    // IF "Posting date" = 0D THEN
    // ERROR('You must specify the Posting date.');
    // 
    // IF Amount = 0 THEN
    // ERROR('You must specify the Amount.');
    // 
    // IF "Employer Code"='' THEN
    // ERROR('You must specify Employer Code');
    // 
    // 
    // PDate:="Posting date";
    // DocNo:="Document No";
    // 
    // 
    // "Scheduled Amount":= ROUND("Scheduled Amount");
    // 
    // 
    // IF "Scheduled Amount"<>Amount THEN
    // ERROR('The Amount must be equal to the Scheduled Amount');
    // 
    // 
    // //delete journal line
    // Gnljnline.RESET;
    // Gnljnline.SETRANGE("Journal Template Name",'GENERAL');
    // Gnljnline.SETRANGE("Journal Batch Name",No);
    // Gnljnline.DELETEALL;
    // //end of deletion
    // //delete journal line
    // Gnljnline.RESET;
    // Gnljnline.SETRANGE("Journal Template Name",'GENERAL');
    // Gnljnline.SETRANGE("Journal Batch Name",No);
    // Gnljnline.INSERT;
    // //end of deletion
    // 
    // RunBal:=0;
    // 
    // IF DocNo='' THEN
    // ERROR('Kindly specify the document no.');
    // 
    // ReceiptsProcessingLines.RESET;
    // ReceiptsProcessingLines.SETRANGE(ReceiptsProcessingLines."Receipt Header No",No);
    // ReceiptsProcessingLines.SETRANGE(ReceiptsProcessingLines.Posted,FALSE);
    // IF ReceiptsProcessingLines.FIND('-') THEN BEGIN
    // REPEAT
    // 
    // 
    // ReceiptsProcessingLines.TESTFIELD(ReceiptsProcessingLines."Member No");
    // ReceiptsProcessingLines.TESTFIELD(ReceiptsProcessingLines."Trans Type");
    // {
    // IF (ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sLoan) OR
    // (ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sInterest) OR
    // (ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sInsurance) THEN
    // 
    // ReceiptsProcessingLines.TESTFIELD(ReceiptsProcessingLines."Loan No");
    // }
    // 
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sInterest THEN BEGIN
    // 
    //     LineNo:=LineNo+500;
    //     Gnljnline.INIT;
    //     Gnljnline."Journal Template Name":='GENERAL';
    //     Gnljnline."Journal Batch Name":=No;
    //     Gnljnline."Line No.":=LineNo;
    //     Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::Member;
    //     Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    //     Gnljnline.VALIDATE(Gnljnline."Account No.");
    //     Gnljnline."Document No.":=DocNo;
    //     Gnljnline."Posting Date":=PDate;
    //     Gnljnline.Description:='Interest Paid';
    //     Gnljnline.Amount:=ROUND(-1*ReceiptsProcessingLines.Amount);
    //     Gnljnline.VALIDATE(Gnljnline.Amount);
    //     Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Interest Paid";
    //     Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    //     Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    //     Gnljnline."Loan No":=ReceiptsProcessingLines."Loan No";
    //     IF Gnljnline.Amount<>0 THEN
    //     Gnljnline.INSERT;
    // 
    //     LineNo:=LineNo+1000;
    //     Gnljnline.INIT;
    //     Gnljnline."Journal Template Name":='GENERAL';
    //     Gnljnline."Journal Batch Name":=No;
    //     Gnljnline."Account Type":=Gnljnline."Account Type"::Customer;
    //     Gnljnline."Line No.":=LineNo;
    //     Gnljnline."Account No.":=ReceiptsProcessingLines."Employer Code";
    //     //Gnljnline.VALIDATE(Gnljnline."Account No.");
    //     Gnljnline."Document No.":=DocNo;
    //     Gnljnline."Posting Date":=PDate;
    //     Gnljnline.Description:='Interest Paid'+' '+ReceiptsProcessingLines."Loan No"+' '+ReceiptsProcessingLines."Staff/Payroll No";
    //     Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount);
    //     Gnljnline.VALIDATE(Gnljnline.Amount);
    //     //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Interest Paid";
    //     Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    //     Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    //     Gnljnline."Loan No":=ReceiptsProcessingLines."Loan No";
    //     IF Gnljnline.Amount<>0 THEN
    //     Gnljnline.INSERT;
    // 
    //     END;
    // 
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sLoan THEN BEGIN
    // 
    //     LineNo:=LineNo+500;
    //     Gnljnline.INIT;
    //     Gnljnline."Journal Template Name":='GENERAL';
    //     Gnljnline."Journal Batch Name":=No;
    //     Gnljnline."Line No.":=LineNo;
    //     Gnljnline."Account Type":=Gnljnline."Account Type"::Member;
    //     Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    //     Gnljnline.VALIDATE(Gnljnline."Account No.");
    //     //Gnljnline."Document No.":=DocNo;
    //     Gnljnline."Document No.":=DocNo;
    //     Gnljnline."Posting Date":=PDate;
    //     Gnljnline.Description:='Loan Repayment';
    //     Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*-1);
    //     Gnljnline.VALIDATE(Gnljnline.Amount);
    //     Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::Repayment;
    //     Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    //     Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    //     Gnljnline."Loan No":=ReceiptsProcessingLines."Loan No";
    //     IF Gnljnline.Amount<>0 THEN
    //     Gnljnline.INSERT;
    // 
    // 
    // 
    //     LineNo:=LineNo+1000;
    //     Gnljnline.INIT;
    //     Gnljnline."Journal Template Name":='GENERAL';
    //     Gnljnline."Journal Batch Name":=No;
    //     Gnljnline."Account Type":=Gnljnline."Account Type"::Customer;
    //     Gnljnline."Line No.":=LineNo;
    //     Gnljnline."Account No.":=ReceiptsProcessingLines."Employer Code";
    //     //Gnljnline.VALIDATE(Gnljnline."Account No.");
    //     //Gnljnline."Document No.":=DocNo;
    //     Gnljnline."Document No.":=DocNo;
    //     Gnljnline."Posting Date":=PDate;
    //     Gnljnline.Description:='Loan Repayment'+' '+ReceiptsProcessingLines."Loan No";
    //     Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*1);
    //    // Gnljnline.VALIDATE(Gnljnline.Amount);
    //     Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    //     Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    //     Gnljnline."Loan No":=ReceiptsProcessingLines."Loan No";
    // 
    //     IF Gnljnline.Amount<>0 THEN
    //     Gnljnline.INSERT;
    // 
    //      END;
    // 
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sDeposits THEN BEGIN
    // 
    // LineNo:=LineNo+500;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Account Type"::Member;
    // Gnljnline.VALIDATE(Gnljnline."Account Type");
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    // //Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Document No.":=DocNo;
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Deposit Contribution';
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*-1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Deposit Contribution";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // //Gnljnline."Bal. Account Type":=Gnljnline."Bal. Account Type"::Customer;
    // //Gnljnline.VALIDATE(Gnljnline."Bal. Account Type");
    // //Gnljnline."Bal. Account No.":="ReceiptsProcessingLines"."Employer Code";
    // //Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // LineNo:=LineNo+1000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Account Type"::Customer;
    // Gnljnline.VALIDATE(Gnljnline."Account Type");
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Employer Code";
    // //Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Document No.":=DocNo;
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Deposit Contribution'+ '-'+ReceiptsProcessingLines."Member No";
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Deposit Contribution";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // //Gnljnline."Bal. Account Type":=Gnljnline."Bal. Account Type"::Customer;
    // //Gnljnline.VALIDATE(Gnljnline."Bal. Account Type");
    // //Gnljnline."Bal. Account No.":="ReceiptsProcessingLines"."Employer Code";
    // //Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    // 
    // 
    // 
    // //Benevolent Fund
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sBenevolent THEN BEGIN
    // 
    // LineNo:=LineNo+500;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::Member;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Document No.":=DocNo;
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Benevolent Fund';
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*-1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Benevolent Fund";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // 
    // LineNo:=LineNo+1000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Account Type":=Gnljnline."Account Type"::Customer;
    // //Gnljnline."Account Type":=Gnljnline."Account Type"::"G/L Account";
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Employer Code";
    // //Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Document No.":=DocNo;
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Benevolent Fund'+ReceiptsProcessingLines."Member No";
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*1);
    // //Gnljnline.VALIDATE(Gnljnline.Amount);
    // //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Benevolent Fund";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    // 
    // //Loan Insurance
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sInsurance THEN BEGIN
    // 
    // LineNo:=LineNo+500;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::Member;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Loan Insurance 0.02%'+' '+ReceiptsProcessingLines."Loan No";
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*-1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Insurance Contribution";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // 
    // LineNo:=LineNo+1000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Account Type"::Customer;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Employer Code";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Loan Insurance 0.02%'+' '+ReceiptsProcessingLines."Loan No";
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Insurance Contribution";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    // 
    // 
    // //Share Capital
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sShare THEN BEGIN
    // 
    // LineNo:=LineNo+500;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::Member;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // //Gnljnline."Posting Date":=ReceiptsProcessingLines."Transaction Date";
    // Gnljnline.Description:='Shares Contribution';
    // Gnljnline.Amount:=ReceiptsProcessingLines.Amount*-1;
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Shares Capital";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // LineNo:=LineNo+1000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Account Type"::Customer;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Employer Code";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // Gnljnline."Posting Date":=ReceiptsProcessingLines."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Shares Contribution'+' '+ReceiptsProcessingLines."Staff/Payroll No";
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Insurance Contribution";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    //  {
    // //UAP
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::"9" THEN BEGIN
    // 
    // LineNo:=LineNo+1000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::Member;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline.Description:='UAP Premium';
    // Gnljnline.Amount:=ReceiptsProcessingLines.Amount*-1;
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"UAP Premiums";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // 
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    // 
    // 
    // 
    // IF ReceiptsProcessingLines."Trans Type"=ReceiptsProcessingLines."Trans Type"::sInsurance THEN BEGIN
    // 
    // LineNo:=LineNo+1000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::Member;
    // Gnljnline."Account No.":=ReceiptsProcessingLines."Member No";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // //Gnljnline."Document No.":=DocNo;
    // //Gnljnline."Posting Date":="ReceiptsProcessingLines"."Transaction Date";
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Administration fee paid';
    // Gnljnline.Amount:=ROUND(ReceiptsProcessingLines.Amount*-1);
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Administration Fee Paid";
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // Gnljnline."Loan No":=ReceiptsProcessingLines."Loan No";
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    // }
    // UNTIL ReceiptsProcessingLines.NEXT=0;
    // END;
    //  {
    // //Bank Entry
    // 
    // //BOSA Bank Entry
    // //IF ("Mode Of Disbursement"="Mode Of Disbursement"::Cheque) THEN BEGIN
    // IF(LBatches."Mode Of Disbursement"=LBatches."Mode Of Disbursement"::Cheque) THEN BEGIN
    //      //("Mode Of Disbursement"="Mode Of Disbursement"::"Transfer to FOSA") THEN BEGIN
    // LineNo:=LineNo+10000;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":=Jtemplate;
    // Gnljnline."Journal Batch Name":=JBatch;
    // Gnljnline."Line No.":=LineNo;
    // Gnljnline."Document No.":=DocNo;;
    // Gnljnline."Posting Date":="Posting date";
    // Gnljnline."External Document No.":=LBatches."Document No.";
    // Gnljnline."Account Type":=Gnljnline."Bal. Account Type"::"Bank Account";
    // Gnljnline."Account No.":=LBatches."BOSA Bank Account";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // Gnljnline.Description:=ReceiptsProcessingLines.Name;
    // Gnljnline.Amount:=ReceiptsProcessingLines.Amount*-1;
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // Gnljnline."Shortcut Dimension 1 Code":=DActivityBOSA;
    // Gnljnline."Shortcut Dimension 2 Code":=DBranchBOSA;
    // Gnljnline.VALIDATE(Gnljnline."Shortcut Dimension 1 Code");
    // Gnljnline.VALIDATE(Gnljnline."Shortcut Dimension 2 Code");
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // 
    // END;
    // }
    // {
    // LineN:=LineN+100;
    // 
    // Gnljnline.INIT;
    // Gnljnline."Journal Template Name":='GENERAL';
    // Gnljnline."Journal Batch Name":=No;
    // Gnljnline."Document No.":=DocNo;
    // Gnljnline."External Document No.":=DocNo;
    // Gnljnline."Line No.":=LineN;
    // Gnljnline."Account Type":="Account Type";
    // Gnljnline."Account No.":="Account No";
    // Gnljnline.VALIDATE(Gnljnline."Account No.");
    // Gnljnline."Posting Date":=PDate;
    // Gnljnline.Description:='Check Off transfer';
    // Gnljnline.Amount:=Amount;
    // Gnljnline.VALIDATE(Gnljnline.Amount);
    // Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");
    // Gnljnline."Shortcut Dimension 1 Code":='BOSA';
    // Gnljnline."Shortcut Dimension 2 Code":='NAIROBI';
    // IF Gnljnline.Amount<>0 THEN
    // Gnljnline.INSERT;
    // }
    // 
    // //Post New
    // Gnljnline.RESET;
    // Gnljnline.SETRANGE("Journal Template Name",'GENERAL');
    // Gnljnline.SETRANGE("Journal Batch Name",No);
    // IF Gnljnline.FIND('-') THEN BEGIN
    // CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B",Gnljnline);
    // END;
    // 
    // //Post New
    // Posted:=TRUE;
    // "Posted By":= UPPERCASE(No);
    // MODIFY;
    // 
    // {
    // "ReceiptsProcessingLines".RESET;
    // "ReceiptsProcessingLines".SETRANGE("ReceiptsProcessingLines"."Receipt Header No",No);
    //  IF "ReceiptsProcessingLines".FIND('-') THEN BEGIN
    //  REPEAT
    // "ReceiptsProcessingLines".Posted:=TRUE;
    // "ReceiptsProcessingLines".MODIFY;
    // UNTIL "ReceiptsProcessingLines".NEXT=0;
    // END;
    // MODIFY;
    // }

    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Paybill Processing Header";
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
                field("Total Count"; "Total Count")
                {
                    ApplicationArea = Basic;
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
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount"; "Scheduled Amount")
                {
                    ApplicationArea = Basic;
                }
            }
            part("Bosa receipt lines"; "Paybill Processing Line")
            {
                Caption = 'Paybill Transactions Details';
                SubPageLink = "Receipt Header No" = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<XMLport Import receipts>")
            {
                ApplicationArea = Basic;
                Caption = 'Import Paybill Transactions';
                RunObject = XMLport UnknownXMLport51516039;
            }
            group(ActionGroup1102755021)
            {
            }
            action("Validate Paybill")
            {
                ApplicationArea = Basic;
                Caption = 'Validate Paybill';

                trigger OnAction()
                begin
                    //
                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Receipt Header No", No);
                    if ReceiptLine.Find('-') then
                        Report.Run(51516521, true, false, ReceiptLine);
                end;
            }
            group(ActionGroup1102755019)
            {
            }
            action("Post check off")
            {
                ApplicationArea = Basic;
                Caption = 'Post Paybill Transaction';

                trigger OnAction()
                begin

                    Genstup.Get();
                    if Posted = true then
                        Error('This Paybill Batch has already been posted');
                    if "Account No" = '' then
                        Error('You must specify the Account No.');
                    if "Document No" = '' then
                        Error('You must specify the Document No.');
                    if "Posting date" = 0D then
                        Error('You must specify the Posting date.');
                    Datefilter := '..' + Format("Loan CutOff Date");



                    PDate := "Posting date";
                    DocNo := "Document No";
                    GenBatches.Reset;
                    GenBatches.SetRange(GenBatches."Journal Template Name", 'GENERAL');
                    GenBatches.SetRange(GenBatches.Name, No);
                    if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name" := 'GENERAL';
                        GenBatches.Name := No;
                        GenBatches.Description := 'PAYBILL PROCESS';
                        GenBatches.Validate(GenBatches."Journal Template Name");
                        GenBatches.Validate(GenBatches.Name);
                        GenBatches.Insert;
                    end;



                    //Delete journal
                    Gnljnline.Reset;
                    Gnljnline.SetRange("Journal Template Name", 'GENERAL');
                    Gnljnline.SetRange("Journal Batch Name", No);
                    Gnljnline.DeleteAll;
                    //End of deletion



                    RunBal := 0;
                    CalcFields("Scheduled Amount");

                    Genstup.Get();
                    // MWMBER NOT FOUND
                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No", No);
                    RcptBufLines.SetRange(RcptBufLines.Posted, false);
                    if RcptBufLines.Find('-') then begin
                        repeat
                            //Credit Members Account
                            LineN := LineN + 10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := 'GENERAL';
                            Gnljnline."Journal Batch Name" := No;
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := RcptBufLines."Account Type";
                            Gnljnline."Account No." := RcptBufLines."Member No";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No." := RcptBufLines."Transaction No";
                            Gnljnline."Posting Date" := "Posting date";
                            Gnljnline.Description := RcptBufLines.Description;
                            Gnljnline.Amount := RcptBufLines.Amount * -1;
                            if (RcptBufLines."Transaction Prefix" = 'NORMAL') then begin
                                Gnljnline."Transaction Type" := Gnljnline."transaction type"::Loan
                            end else
                                if (RcptBufLines."Transaction Prefix" = 'FOSA') then begin
                                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"41"
                                end else
                                    if (RcptBufLines."Transaction Prefix" = 'UNALLOCATED') then begin
                                        Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Insurance Paid";
                                    end;
                            Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                            Gnljnline."Shortcut Dimension 2 Code" := 'KIAMBU';
                            Gnljnline.Validate(Gnljnline.Amount);
                            Gnljnline."Bal. Account Type" := Gnljnline."bal. account type"::"Bank Account";
                            Gnljnline."Bal. Account No." := "Account No";
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;


                            if (RcptBufLines.Amount >= 50) and (RcptBufLines.Amount < 999) then
                                ChargeAmount := 0
                            else
                                if (RcptBufLines.Amount >= 1000) and (RcptBufLines.Amount < 2499) then
                                    ChargeAmount := 11
                                else
                                    if (RcptBufLines.Amount >= 2500) and (RcptBufLines.Amount < 4999) then
                                        ChargeAmount := 22
                                    else
                                        if (RcptBufLines.Amount >= 50000) and (RcptBufLines.Amount < 9999) then
                                            ChargeAmount := 50
                                        else
                                            if (RcptBufLines.Amount >= 10000) and (RcptBufLines.Amount < 34999) then
                                                ChargeAmount := 77
                                            else
                                                if (RcptBufLines.Amount >= 35000) and (RcptBufLines.Amount < 49999) then
                                                    ChargeAmount := 153
                                                else
                                                    if RcptBufLines.Amount > 35000 then
                                                        ChargeAmount := 165;





                            Genstup.Get();
                            //Debit Charges
                            LineN := LineN + 10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := 'GENERAL';
                            Gnljnline."Journal Batch Name" := No;
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := RcptBufLines."Account Type";
                            Gnljnline."Account No." := RcptBufLines."Member No";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No." := RcptBufLines."Transaction No";
                            Gnljnline."Posting Date" := "Posting date";
                            Gnljnline.Description := RcptBufLines.Description + ' ' + 'Charge';
                            Gnljnline.Amount := ChargeAmount;
                            if (RcptBufLines."Transaction Prefix" = 'NORMAL') then begin
                                Gnljnline."Transaction Type" := Gnljnline."transaction type"::Loan
                            end else
                                if (RcptBufLines."Transaction Prefix" = 'FOSA') then begin
                                    Gnljnline."Transaction Type" := Gnljnline."transaction type"::"41"
                                end else
                                    if (RcptBufLines."Transaction Prefix" = 'UNALLOCATED') then begin
                                        Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Insurance Paid";
                                    end;
                            Gnljnline."Bal. Account Type" := Gnljnline."bal. account type"::"G/L Account";
                            Gnljnline."Bal. Account No." := Genstup."Paybill Tarrifs";
                            Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                            Gnljnline."Shortcut Dimension 2 Code" := 'KIAMBU';
                            Gnljnline.Validate(Gnljnline.Amount);
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;


                        /*
                        //++++++++++++++++++Balance With Bank Entry+++++++++++++++++++++++//
                         LineN:=LineN+100;
                         Gnljnline.INIT;
                         Gnljnline."Journal Template Name":='GENERAL';
                         Gnljnline."Journal Batch Name":=No;
                         Gnljnline."Line No.":=LineN;
                         Gnljnline."Account Type":=Gnljnline."Account Type"::"Bank Account";
                         Gnljnline."Account No.":="Account No";
                         Gnljnline.VALIDATE(Gnljnline."Account No.");
                         Gnljnline."Document No.":="Document No";
                         Gnljnline."Posting Date":="Posting date";
                         Gnljnline.Description:=Remarks;
                         //Gnljnline.Amount:=Amount;
                         Gnljnline.Amount:=RcptBufLines.Amount;
                         Gnljnline.VALIDATE(Gnljnline.Amount);
                         Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                         IF Gnljnline.Amount<>0 THEN
                         Gnljnline.INSERT;*/
                        until RcptBufLines.Next = 0;
                    end;


                    //
                    //CALCFIELDS("Scheduled Amount");



                    //Post New
                    Gnljnline.Reset;
                    Gnljnline.SetRange("Journal Template Name", 'GENERAL');
                    Gnljnline.SetRange("Journal Batch Name", No);
                    if Gnljnline.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", Gnljnline);
                    end;
                    Posted := true;
                    "Posted By" := No;
                    Modify;

                    Message('Paybill Successfully Generated');

                    Posted := true;
                    Modify;


                end;
            }
        }
    }

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
        ReceiptsProcessingLines: Record "Paybill Processing Lines";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Paybill Processing Header";
        Cust: Record Customer;
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        RcptBufLines: Record "Paybill Processing Lines";
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
        Genstup: Record "Sacco General Set-Up";
        Memb: Record Customer;
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        ReceiptLine: Record "Paybill Processing Lines";
        PaybillTarrifs: Record "Paybill Tarrifs";
        ChargeAmount: Decimal;
}

