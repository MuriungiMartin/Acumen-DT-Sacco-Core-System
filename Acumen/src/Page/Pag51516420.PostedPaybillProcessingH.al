#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516420 "Posted Paybill Processing_H"
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
    SourceTableView = where(Posted=const(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No;No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By";"Entered By")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Date Entered";"Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date";"Posting date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Loan CutOff Date";"Loan CutOff Date")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks;Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count";"Total Count")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By";"Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code";"Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Document No";"Document No")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount";"Scheduled Amount")
                {
                    ApplicationArea = Basic;
                }
            }
            part("Bosa receipt lines";"Paybill Processing Line")
            {
                Caption = 'Paybill Transactions Details';
                SubPageLink = "Receipt Header No"=field(No);
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
                RunObject = XMLport "FIXED ASSETS 2017";
            }
            group(ActionGroup1102755021)
            {
            }
            action("Validate Paybill")
            {
                ApplicationArea = Basic;
                Caption = 'Validate Paybill';
                RunObject = Report UnknownReport50074;
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
                    
                    genstup.Get();
                    if Posted=true then
                    Error('This Paybill Batch has already been posted');
                    if "Account No" = '' then
                    Error('You must specify the Account No.');
                    if "Document No" = '' then
                    Error('You must specify the Document No.');
                    if "Posting date" = 0D then
                    Error('You must specify the Posting date.');
                    Datefilter:='..'+Format("Loan CutOff Date");
                    
                    
                    
                    PDate:="Posting date";
                    DocNo:="Document No";
                    GenBatches.Reset;
                    GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                    GenBatches.SetRange(GenBatches.Name,No);
                    if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name":='GENERAL';
                    GenBatches.Name:=No;
                    GenBatches.Description:='PAYBILL PROCESS';
                    GenBatches.Validate(GenBatches."Journal Template Name");
                    GenBatches.Validate(GenBatches.Name);
                    GenBatches.Insert;
                    end;
                    
                    
                    
                    //Delete journal
                    Gnljnline.Reset;
                    Gnljnline.SetRange("Journal Template Name",'GENERAL');
                    Gnljnline.SetRange("Journal Batch Name",No);
                    Gnljnline.DeleteAll;
                    //End of deletion
                    
                    
                    
                    
                    
                    RunBal:=0;
                     CalcFields("Scheduled Amount");
                     /*
                    IF "Scheduled Amount" <>   Amount THEN BEGIN
                    ERROR('Scheduled Amount Is Not Equal To Cheque Amount');
                    END;
                    */
                    
                    genstup.Get();
                    // MWMBER NOT FOUND
                    RcptBufLines.Reset;
                    RcptBufLines.SetRange(RcptBufLines."Receipt Header No",No);
                    RcptBufLines.SetRange(RcptBufLines.Posted,false);
                    if RcptBufLines.Find('-') then begin
                    repeat
                    
                    
                    RunBal:=RcptBufLines.Amount;
                    
                    if RunBal > 0 then begin
                    
                    Cust.Reset;
                    //Cust.SETRANGE(Cust."No.",RcptBufLines."Member No");
                    //Cust.SETRANGE(Cust."Payroll/Staff No",RcptBufLines."Staff/Payroll No");
                    //Cust.SETRANGE(Cust."Employer Code",RcptBufLines."Employer Code");
                    Cust.SetRange(Cust."No.",RcptBufLines."Member No");
                    if Cust.Find('-') then begin
                    repeat
                    Cust.CalcFields(Cust."Registration Fee Paid");
                    if Cust."Registration Fee Paid"=0 then begin
                    if Cust."Registration Date" <>0D then begin
                    
                    
                    LineN:=LineN+10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name":='GENERAL';
                    Gnljnline."Journal Batch Name":=No;
                    Gnljnline."Line No.":=LineN;
                    Gnljnline."Account Type":=Gnljnline."account type"::Employee;
                    Gnljnline."Account No.":=RcptBufLines."Member No";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No.":="Document No";
                    Gnljnline."Posting Date":="Posting date";
                    Gnljnline.Description:=RcptBufLines."Transaction No"+'-'+Remarks;
                    Gnljnline.Amount:=500*-1;
                    Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Registration Fee";
                    Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                    Gnljnline."Shortcut Dimension 2 Code":='Nairobi';
                    Gnljnline.Validate(Gnljnline.Amount);
                    if Gnljnline.Amount<>0 then
                    Gnljnline.Insert;
                    RunBal:=RunBal+(Gnljnline.Amount);
                    
                    end;
                    end;
                    until Cust.Next=0;
                    end;
                    end;
                    
                    //++++++++++++++Recover Insurance+++++++++++++++++++//
                    LoanType.Reset;
                    LoanType.SetCurrentkey(LoanType."Recovery Priority");
                    LoanType.SetRange(LoanType."Check Off Recovery",true);
                    if LoanType.Find('-') then begin
                    repeat
                    LoanApp.Reset;
                    LoanApp.SetCurrentkey(Source,"Issued Date","Loan Product Type","Client Code");
                    LoanApp.SetRange(LoanApp."Loan Product Type",LoanType.Code);
                    LoanApp.SetRange(LoanApp."Client Code",RcptBufLines."Member No");
                    LoanApp.SetFilter(LoanApp."Issued Date",Datefilter);
                    if LoanApp.Find('-') then begin
                    
                    repeat
                    if RunBal > 0 then begin
                    LoanApp.CalcFields(LoanApp."Outstanding Balance",LoanApp."Loans Insurance");
                    if LoanApp."Outstanding Balance">0 then begin
                    
                        if LoanApp."Issued Date" <= PDate then begin
                        if LoanApp."Approved Amount"> 100000 then begin
                        LineN:=LineN+10000;
                    
                        Gnljnline.Init;
                        Gnljnline."Journal Template Name":='GENERAL';
                        Gnljnline."Journal Batch Name":=No;
                        Gnljnline."Line No.":=LineN;
                        Gnljnline."Account Type":=Gnljnline."bal. account type"::Employee;
                        Gnljnline."Account No.":=LoanApp."Client Code";
                        Gnljnline.Validate(Gnljnline."Account No.");
                        Gnljnline."Document No.":="Document No";
                        Gnljnline."Posting Date":="Posting date";
                        Gnljnline.Description:=RcptBufLines."Transaction No"+'-'+Remarks;
                        //Gnljnline.Amount:=-ROUND(LoanApp."Outstanding Balance"*0.00016667,1,'>');
                         Gnljnline.Amount:=-ROUND(LoanApp."Loans Insurance",1,'>');
                       // INSURANCE:=ROUND(LoanApp."Outstanding Balance"*0.00016667,1,'>');
                        //MESSAGE('INSURANCE%1',ROUND(LoanApp."Outstanding Balance"*0.00016667,1,'>'));
                        Gnljnline.Validate(Gnljnline.Amount);
                        Gnljnline."Transaction Type":=Gnljnline."transaction type"::"37";
                        Gnljnline."Loan No":=LoanApp."Loan  No.";
                        if Gnljnline.Amount<>0 then
                        Gnljnline.Insert;
                        RunBal:=RunBal+(Gnljnline.Amount);
                        end;
                    end;
                    end;
                    end;
                    until LoanApp.Next = 0;
                    end;
                    until LoanType.Next = 0;
                    end;
                    
                    //++++++++++++++bbf+++++++++++++++++++//
                    //Cust.RESET;
                    //Cust.SETRANGE(Cust."No.",RcptBufLines."Member No");
                    //Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                    Cust.Reset;
                    Cust.SetRange(Cust."No.",RcptBufLines."Member No");
                    //Cust.SETRANGE(Cust."Payroll/Staff No",RcptBufLines."Staff/Payroll No");
                    Cust.SetRange(Cust."Employer Code",RcptBufLines."Employer Code");
                    
                    if Cust.Find('-') then begin
                    //++++++++++Recover Shares Deposits++++++++++++++++++//
                    if (Cust.Status = Cust.Status::Active) or
                       (Cust.Status = Cust.Status::Dormant) or
                       (Cust.Status = Cust.Status::"Re-instated") then begin
                    
                    if RunBal > 0 then begin
                    
                    LineN:=LineN+10000;
                    
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name":='GENERAL';
                    Gnljnline."Journal Batch Name":=No;
                    Gnljnline."Line No.":=LineN;
                    Gnljnline."Account Type":=Gnljnline."account type"::Employee;
                    Gnljnline."Account No.":=RcptBufLines."Member No";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No.":="Document No";
                    Gnljnline."Posting Date":="Posting date";
                    Gnljnline.Description:=RcptBufLines."Transaction No"+'-'+Remarks;
                    Gnljnline.Amount:=genstup."Risk Fund Amount"*-1;
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Benevolent Fund";
                    if Gnljnline.Amount<>0 then
                    Gnljnline.Insert;
                    RunBal:=RunBal+(Gnljnline.Amount);
                    end;
                    end;
                    end;
                    
                    //++++++++++++++Recover Interest+++++++++++++++++++//
                    LoanType.Reset;
                    LoanType.SetCurrentkey(LoanType."Recovery Priority");
                    LoanType.SetRange(LoanType."Check Off Recovery",true);
                    if LoanType.Find('-') then begin
                    repeat
                    LoanApp.Reset;
                    LoanApp.SetCurrentkey(Source,"Issued Date","Loan Product Type","Client Code","Staff No","Employer Code");
                    LoanApp.SetRange(LoanApp."Loan Product Type",LoanType.Code);
                    LoanApp.SetRange(LoanApp."Client Code",RcptBufLines."Member No");
                    //LoanApp.SETRANGE(LoanApp."Staff No",RcptBufLines."Staff/Payroll No");
                    //LoanApp.SETRANGE(LoanApp."Employer Code",RcptBufLines."Employer Code");
                    LoanApp.SetFilter(LoanApp."Issued Date",Datefilter);
                    if LoanApp.Find('-') then begin
                    
                    repeat
                    LoanApp.CalcFields(LoanApp."Oustanding Interest");
                    
                    if LoanApp."Oustanding Interest">0 then begin
                    
                    if  RunBal > 0 then begin
                    
                        Interest:=0;
                        Interest:=LoanApp."Oustanding Interest";
                    
                        if Interest > 0 then begin
                        //IF LoanApp."Issued Date" <= PDate THEN BEGIN>NIC
                    
                         if LoanApp."Issued Date"< "Loan CutOff Date" then begin
                    
                        LineN:=LineN+10000;
                        Gnljnline.Init;
                        Gnljnline."Journal Template Name":='GENERAL';
                        Gnljnline."Journal Batch Name":=No;
                        Gnljnline."Line No.":=LineN;
                        Gnljnline."Account Type":=Gnljnline."bal. account type"::Employee;
                        Gnljnline."Account No.":=LoanApp."Client Code";
                        Gnljnline.Validate(Gnljnline."Account No.");
                        Gnljnline."Document No.":="Document No";
                        Gnljnline."Posting Date":="Posting date";
                        Gnljnline.Description:=RcptBufLines."Transaction No"+'-'+Remarks;
                        if RunBal > Interest then
                        Gnljnline.Amount:=-1*Interest
                        else
                        Gnljnline.Amount:=-1*RunBal;
                        Gnljnline.Validate(Gnljnline.Amount);
                        Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Insurance Contribution";
                        Gnljnline."Loan No":=LoanApp."Loan  No.";
                        if Gnljnline.Amount<>0 then
                        Gnljnline.Insert;
                        RunBal:=RunBal+(Gnljnline.Amount);
                        end;
                    
                    end;
                    end;
                    end;
                    until LoanApp.Next = 0;
                    end;
                    until LoanType.Next = 0;
                    end;
                    
                    
                    
                    
                    //++++++++++++++Recover Repayment++++++++++++++++++++//
                    TotalRepay:=0;
                    LoanType.Reset;
                    LoanType.SetCurrentkey(LoanType."Recovery Priority");
                    LoanType.SetRange(LoanType."Check Off Recovery",true);
                    if LoanType.Find('-') then begin
                    repeat
                    MultipleLoan:=0;
                    
                    //+++++++++++++++Check if Multiple Loan++++++++++++++++++++++++++++++++++++//
                    LoanApp.Reset;
                    LoanApp.SetCurrentkey(Source,"Issued Date","Loan Product Type","Client Code","Staff No","Employer Code");
                    LoanApp.SetRange(LoanApp."Loan Product Type",LoanType.Code);
                    LoanApp.SetRange(LoanApp."Client Code",RcptBufLines."Member No");
                    //LoanApp.SETRANGE(LoanApp."Staff No",RcptBufLines."Staff/Payroll No");
                    //LoanApp.SETRANGE(LoanApp."Employer Code",RcptBufLines."Employer Code");
                    LoanApp.SetFilter(LoanApp."Issued Date",Datefilter);
                    if LoanApp.Find('-') then begin
                    repeat
                    LoanApp.CalcFields(LoanApp."Outstanding Balance");
                    if LoanApp."Outstanding Balance" > 0 then begin
                    MultipleLoan:=MultipleLoan+1;
                    end;
                    until LoanApp.Next = 0;
                    end;
                    
                    //+++++++++++++++++++++Check if Multiple Loan+++++++++++++++++++++++++++++++//
                    
                    LoanApp.Reset;
                    LoanApp.SetCurrentkey(Source,"Issued Date","Loan Product Type","Client Code","Staff No","Employer Code");
                    LoanApp.SetRange(LoanApp."Loan Product Type",LoanType.Code);
                    LoanApp.SetRange(LoanApp."Client Code",RcptBufLines."Member No");
                    //LoanApp.SETRANGE(LoanApp."Staff No",RcptBufLines."Staff/Payroll No");
                    //LoanApp.SETRANGE(LoanApp."Employer Code",RcptBufLines."Employer Code");
                    LoanApp.SetFilter(LoanApp."Issued Date",Datefilter);
                    if LoanApp.Find('-') then begin
                    repeat
                    
                    if  RunBal > 0 then begin
                    
                    LoanApp.CalcFields(LoanApp."Outstanding Balance",LoanApp."Oustanding Interest");
                    
                    if LoanApp."Outstanding Balance" > 0 then begin
                    
                        if LoanApp."Approved Amount"> 100000 then begin
                        INSURANCE:=0;
                        INSURANCE:=ROUND(LoanApp."Outstanding Balance"*0.00016667,1,'>');
                        end;
                    
                    
                    
                        LType:=LoanApp."Loan Product Type";
                        LRepayment:=0;
                        if LoanApp."Oustanding Interest">0 then
                        LRepayment:=(LoanApp.Repayment-LoanApp."Oustanding Interest"-INSURANCE)
                        else
                        LRepayment:=LoanApp.Repayment-INSURANCE;
                    
                        if LRepayment > LoanApp."Outstanding Balance" then
                        LRepayment:=LoanApp."Outstanding Balance";
                        if LRepayment = 0 then begin
                        RcptBufLines."No Repayment":=true;
                        RcptBufLines.Modify;
                        end;
                    
                        //IF LoanApp."Issued Date"<= PDate THEN BEGIN>NIC
                        if LoanApp."Issued Date"< "Loan CutOff Date" then begin
                        if  LRepayment > 0 then begin
                        LineN:=LineN+10000;
                        Gnljnline.Init;
                        Gnljnline."Journal Template Name":='GENERAL';
                        Gnljnline."Journal Batch Name":=No;
                        Gnljnline."Line No.":=LineN;
                        Gnljnline."Account Type":=Gnljnline."bal. account type"::Employee;
                        Gnljnline."Account No.":=LoanApp."Client Code";
                        Gnljnline.Validate(Gnljnline."Account No.");
                        Gnljnline."Document No.":="Document No";
                        Gnljnline."Posting Date":="Posting date";
                        Gnljnline.Description:=RcptBufLines."Transaction No"+'-'+Remarks;
                    
                        if RunBal > 0 then begin
                    
                        if RunBal > LRepayment then
                        Gnljnline.Amount:=LRepayment*-1
                        else
                        Gnljnline.Amount:=RunBal*-1;
                        end;
                    
                        Gnljnline.Validate(Gnljnline.Amount);
                        Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Interest Paid";
                        Gnljnline."Loan No":=LoanApp."Loan  No.";
                        if Gnljnline.Amount<>0 then
                        Gnljnline.Insert;
                    
                        RunBal:=RunBal+(Gnljnline.Amount);
                        end;
                        end;
                        end;
                        end;
                    
                    until LoanApp.Next = 0;
                    end;
                    until LoanType.Next = 0;
                    end;
                    
                    /*
                    //++++++++++Recover Shares SHARE CAPIAL++++++++++++++++++//
                    Cust.RESET;
                    Cust.SETRANGE(Cust."No.",RcptBufLines."Member No");
                    //Cust.SETRANGE(Cust."Payroll/Staff No",RcptBufLines."Staff/Payroll No");
                    //Cust.SETRANGE(Cust."Employer Code",RcptBufLines."Employer Code");
                    Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                    IF Cust.FIND('-') THEN BEGIN
                    Cust.CALCFIELDS (Cust."Shares Retained");
                    IF  Cust."Shares Retained" < 5000 THEN BEGIN
                    
                    SHARESCAP:=5000;
                    
                    
                    DIFF:=SHARESCAP-Cust."Shares Retained";
                    IF  DIFF > 250 THEN BEGIN
                    DIFF:=250;
                    END ELSE BEGIN
                    DIFF:= SHARESCAP-Cust."Shares Retained";
                    END;
                    IF (Cust.Status = Cust.Status::Active) OR
                       (Cust.Status = Cust.Status::Dormant) OR
                       (Cust.Status = Cust.Status::"Re-instated") THEN BEGIN
                    
                    IF RunBal > 0 THEN BEGIN
                    ShRec:=Cust."Monthly Contribution";
                    
                    IF RunBal > ShRec THEN
                    ShRec:=ShRec
                    ELSE
                    ShRec:=RunBal;
                    
                    LineN:=LineN+10000;
                    
                    Gnljnline.INIT;
                    Gnljnline."Journal Template Name":='GENERAL';
                    Gnljnline."Journal Batch Name":=No;
                    Gnljnline."Line No.":=LineN;
                    Gnljnline."Account Type":=Gnljnline."Account Type"::Member;
                    Gnljnline."Account No.":=RcptBufLines."Member No";
                    Gnljnline.VALIDATE(Gnljnline."Account No.");
                    Gnljnline."Document No.":="Document No";
                    Gnljnline."Posting Date":="Posting date";
                    Gnljnline.Description:=RcptBufLines."Transaction No"+'-'+Remarks;
                    IF RunBal > DIFF THEN  BEGIN
                    Gnljnline.Amount:=DIFF*-1;
                    END ELSE BEGIN
                    Gnljnline.Amount:=RunBal*-1;
                    END;
                    Gnljnline.VALIDATE(Gnljnline.Amount);
                    Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Shares Capital";
                    IF Gnljnline.Amount<>0 THEN
                    Gnljnline.INSERT;
                    RunBal:=RunBal+(Gnljnline.Amount);
                    END;
                    END;
                    END;
                    END;
                    */
                    
                    
                    
                    Cust.Reset;
                    Cust.SetRange(Cust."No.",RcptBufLines."Member No");
                    //Cust.SETRANGE(Cust."Payroll/Staff No",RcptBufLines."Staff/Payroll No");
                    //Cust.SETRANGE(Cust."Employer Code",RcptBufLines."Employer Code");
                    Cust.SetRange(Cust."Customer Type",Cust."customer type"::Member);
                    if Cust.Find('-') then begin
                    
                    
                    //++++++++++Recover Shares Deposits++++++++++++++++++//
                    if (Cust.Status = Cust.Status::Active) or
                       (Cust.Status = Cust.Status::Dormant) or
                       (Cust.Status = Cust.Status::"Re-instated") then begin
                    
                    if RunBal > 0 then begin
                    ShRec:=Cust."Monthly Contribution";
                    
                    if RunBal > ShRec then
                    ShRec:=ShRec
                    else
                    ShRec:=RunBal;
                    
                    LineN:=LineN+10000;
                    
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name":='GENERAL';
                    Gnljnline."Journal Batch Name":=No;
                    Gnljnline."Line No.":=LineN;
                    Gnljnline."Account Type":=Gnljnline."account type"::Employee;
                    Gnljnline."Account No.":=RcptBufLines."Member No";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No.":="Document No";
                    Gnljnline."Posting Date":="Posting date";
                    Gnljnline.Description:=RcptBufLines."Transaction No"+'-'+Remarks;
                    if RunBal > ShRec then  begin
                    Gnljnline.Amount:=ShRec*-1;
                    end else begin
                    Gnljnline.Amount:=RunBal*-1;
                    end;
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Transaction Type":=Gnljnline."transaction type"::Loan;
                    if Gnljnline.Amount<>0 then
                    Gnljnline.Insert;
                    RunBal:=RunBal+(Gnljnline.Amount);
                    end;
                    end;
                    end;
                    
                    
                    //++++++++++++Excess to Deposit Contribution++++++++++++++++//
                    if RunBal > 0 then begin
                    LineN:=LineN+10000;
                    
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name":='GENERAL';
                    Gnljnline."Journal Batch Name":=No;
                    Gnljnline."Line No.":=LineN;
                    Gnljnline."Account Type":=Gnljnline."account type"::Employee;
                    Gnljnline."Account No.":=RcptBufLines."Member No";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No.":="Document No";
                    Gnljnline."Posting Date":="Posting date";
                    Gnljnline.Description:=RcptBufLines."Transaction No"+'-'+Remarks;
                    Gnljnline.Amount:=RunBal*-1;
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Transaction Type":=Gnljnline."transaction type"::Loan;
                    if Gnljnline.Amount<>0 then
                    Gnljnline.Insert;
                    RunBal:=RunBal-(Gnljnline.Amount*-1);
                    end;
                    until RcptBufLines.Next=0;
                    end;
                    
                    
                    //
                    CalcFields("Scheduled Amount");
                    // END OF MEMBER NOT FOUND
                    //++++++++++++++++++Balance With Bank Entry+++++++++++++++++++++++//
                     LineN:=LineN+100;
                     Gnljnline.Init;
                     Gnljnline."Journal Template Name":='GENERAL';
                     Gnljnline."Journal Batch Name":=No;
                     Gnljnline."Line No.":=LineN;
                     Gnljnline."Account Type":=Gnljnline."account type"::"Bank Account";
                     Gnljnline."Account No.":="Account No";
                     Gnljnline.Validate(Gnljnline."Account No.");
                     Gnljnline."Document No.":="Document No";
                     Gnljnline."Posting Date":="Posting date";
                     Gnljnline.Description:=Remarks;
                     //Gnljnline.Amount:=Amount;
                     Gnljnline.Amount:="Scheduled Amount";
                     Gnljnline.Validate(Gnljnline.Amount);
                     Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                     if Gnljnline.Amount<>0 then
                     Gnljnline.Insert;
                    
                    
                    //Post New
                    Gnljnline.Reset;
                    Gnljnline.SetRange("Journal Template Name",'GENERAL');
                    Gnljnline.SetRange("Journal Batch Name",No);
                    if Gnljnline.Find('-') then begin
                    Codeunit.Run(Codeunit::Codeunit50013,Gnljnline);
                    end;
                    //Posted:=TRUE;
                    "Posted By":=No;
                    Modify;
                    
                    Message('Paybill Successfully Generated');
                    /*
                    Posted:=True;
                    MODIFY;
                     */

                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
           "Posting date":=Today;
           "Date Entered":=Today;
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
        Cust: Record "Member Register";
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
        genstup: Record "Sacco General Set-Up";
        Memb: Record "Member Register";
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        ReceiptLine: Record "Paybill Processing Lines";
}

