#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516724 "Checkoff Processing Header-Dne"
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
    SourceTable = "Checkoff Header-Distributed";
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
                field("Employer Name"; "Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field("Approval Status"; "Approval Status")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Amount"; "Interest Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("Checkoff Lines-Distributed"; "Checkoff Processing Lines-D")
            {
                Caption = 'Checkoff Lines-Distributed';
                SubPageLink = "Receipt Header No" = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Checkoff Distributed")
            {
                ApplicationArea = Basic;
                Caption = 'Import Checkoff Distributed';
                Image = Import;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = XMLport "Import Checkoff Lines(Block)";
            }
            group(ActionGroup1102755021)
            {
            }
            action("Validate Checkoff")
            {
                ApplicationArea = Basic;
                Caption = 'Validate Checkoff';
                Image = ValueLedger;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    checkoffLine.Reset;
                    checkoffLine.SetRange(checkoffLine."Receipt Header No", No);
                    if checkoffLine.Find('-') then begin
                        repeat
                            Cust.Reset;
                            Cust.SetRange(Cust."No.", checkoffLine."Member No.");
                            if Cust.FindSet then begin
                                checkoffLine."Member No." := Cust."No.";
                                checkoffLine.Name := Cust.Name;
                                if checkoffLine."Fosa Amount" > 0 then begin
                                    checkoffLine."FOSA Account" := Cust."FOSA Account No.";
                                end;
                                checkoffLine.Modify;
                            end;
                            ObjLoans.CalcFields(ObjLoans."Oustanding Interest", ObjLoans."Outstanding Balance");
                            ObjLoans.Reset;
                            ObjLoans.SetRange("Client Code", checkoffLine."Member No.");
                            ObjLoans.SetFilter("Loan Product Type", '%1', checkoffLine."Loan Product Type");
                            ObjLoans.SetFilter("Outstanding Balance", '>%1', 0);
                            if ObjLoans.FindSet then begin
                                ObjLoans.CalcFields(ObjLoans."Oustanding Interest");
                                checkoffLine."Loan No." := ObjLoans."Loan  No.";
                                checkoffLine.Modify;
                            end;
                        until checkoffLine.Next = 0;
                    end;

                end;
            }
            group(ActionGroup1102755019)
            {
            }
            action("Process Checkoff Distributed")
            {
                ApplicationArea = Basic;
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ObjGenBatch: Record "Gen. Journal Batch";
                begin
                    JBatchs := 'CHECKOFF';

                    FnClearBatch();
                    FnPostPrinciple();
                    FnPostInterestPaid();
                    FnPostFOSA();
                    FnPostBENEVOLENT();
                    FnPostNormalShare();
                    FnPostShareCapital();
                    FnPostCapitalReserve();
                    FnPostUnallocated();
                    FnPostBalancing();
                    Message('Processing Complete');
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                begin
                    ApprovalsMgt.OnSendCheckoffForApproval(Rec);
                end;
            }
            action(Journal)
            {
                ApplicationArea = Basic;
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "General Journal";

                trigger OnAction()
                begin
                    ApprovalsMgt.OnSendCheckoffForApproval(Rec);
                end;
            }
            action("Mark As posted")
            {
                ApplicationArea = Basic;
                Image = Archive;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to mark this Checkoff as Posted.Once Marked as posted it will go to posted. ?', false) = true then begin
                        Posted := true;
                        "Posted By" := UserId;
                        "Posting date" := Today;
                        Modify;
                    end;
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
        Vendor: Record Vendor;
        ObjLoans: Record "Loans Register";
        checkoffLine: Record "Checkoff Lines-Distributed";
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "Checkoff Lines-Distributed";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Checkoff Header-Distributed";
        Cust: Record Customer;
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        RcptBufLines: Record "Checkoff Lines-Distributed";
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
        Memb: Record Customer;
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        ReceiptLine: Record "Checkoff Lines-Distributed";
        JBatchs: Code[10];
        ApprovalsMgt: Codeunit WorkflowIntegration;

    local procedure FnPostPrinciple()
    var
        ObjCheckOffLines: Record "Checkoff Lines-Distributed";
    begin
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        if ObjCheckOffLines.FindSet then begin
            repeat
                if ObjCheckOffLines."Principal Amount" > 0 then
                    LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Member;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := "Document No";
                Gnljnline."Posting Date" := "Posting date";
                Gnljnline.Description := ObjCheckOffLines."Trans Type";
                Gnljnline.Amount := -ObjCheckOffLines."Principal Amount";
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := ObjCheckOffLines."Loan No.";
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Loan Repayment";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := Format('%1', ObjCheckOffLines.Source);
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
            until ObjCheckOffLines.Next = 0;
        end;
    end;

    local procedure FnPostInterestPaid()
    var
        ObjCheckOffLines: Record "Checkoff Lines-Distributed";
    begin
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        if ObjCheckOffLines.FindSet then begin
            repeat
                if ObjCheckOffLines."Interest Amount" > 0 then
                    LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Member;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := "Document No";
                Gnljnline."Posting Date" := "Posting date";
                Gnljnline.Description := ObjCheckOffLines."Trans Type";
                Gnljnline.Amount := -ObjCheckOffLines."Interest Amount";
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Loan No" := ObjCheckOffLines."Loan No.";
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Interest Paid";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
            until ObjCheckOffLines.Next = 0;
        end;
    end;

    local procedure FnPostShareCapital()
    var
        ObjCheckOffLines: Record "Checkoff Lines-Distributed";
    begin
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Trans Type", 'SHARES');
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Special Code",'229');
        if ObjCheckOffLines.FindSet then begin
            repeat
                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Member;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := "Document No";
                Gnljnline."Posting Date" := "Posting date";
                Gnljnline.Description := ObjCheckOffLines."Special Code";
                Gnljnline.Amount := -ObjCheckOffLines.Amount;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Share Capital";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
            until ObjCheckOffLines.Next = 0;
        end;
    end;

    local procedure FnPostNormalShare()
    var
        ObjCheckOffLines: Record "Checkoff Lines-Distributed";
    begin
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        if ObjCheckOffLines.FindSet then begin
            repeat
                if ObjCheckOffLines."Deposit Amount" > 0 then
                    LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Member;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := "Document No";
                Gnljnline."Posting Date" := "Posting date";
                Gnljnline.Description := ObjCheckOffLines."Special Code";
                Gnljnline.Amount := -ObjCheckOffLines."Deposit Amount";
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Deposit Contribution";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
            until ObjCheckOffLines.Next = 0;
        end;
    end;

    local procedure FnPostFOSA()
    var
        ObjCheckOffLines: Record "Checkoff Lines-Distributed";
    begin
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        //ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Trans Type",'FOSA');
        if ObjCheckOffLines.FindSet then begin
            repeat
                if ObjCheckOffLines."Fosa Amount" > 0 then
                    LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Vendor;
                Gnljnline."Account No." := ObjCheckOffLines."FOSA Account";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := "Document No";
                Gnljnline."Posting Date" := "Posting date";
                Gnljnline.Description := ObjCheckOffLines."Special Code";
                Gnljnline.Amount := -ObjCheckOffLines."Fosa Amount";
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"FOSA Account";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'FOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
            until ObjCheckOffLines.Next = 0;
        end;
    end;

    local procedure FnPostBENEVOLENT()
    var
        ObjCheckOffLines: Record "Checkoff Lines-Distributed";
    begin
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Trans Type", 'BENEVOLENT');
        if ObjCheckOffLines.FindSet then begin
            repeat
                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Member;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := "Document No";
                Gnljnline."Posting Date" := "Posting date";
                Gnljnline.Description := ObjCheckOffLines."Special Code";
                Gnljnline.Amount := -ObjCheckOffLines.Amount;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Benevolent Fund";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
            until ObjCheckOffLines.Next = 0;
        end;
    end;

    local procedure FnPostBalancing()
    begin
        LineN := LineN + 10000;
        Gnljnline.Init;
        Gnljnline."Journal Template Name" := 'GENERAL';
        Gnljnline."Journal Batch Name" := JBatchs;
        Gnljnline."Line No." := LineN;
        Gnljnline."Account Type" := Gnljnline."account type"::"G/L Account";
        Gnljnline."Account No." := "Account No";
        Gnljnline.Validate(Gnljnline."Account No.");
        Gnljnline."Document No." := "Document No";
        Gnljnline."Posting Date" := "Posting date";
        Gnljnline.Description := No + '-' + "Document No";
        Gnljnline.Amount := Amount;
        Gnljnline.Validate(Gnljnline.Amount);
        Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
        //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
        if Gnljnline.Amount <> 0 then
            Gnljnline.Insert;
    end;

    local procedure FnClearBatch()
    var
        ObjGenBatch: Record "Gen. Journal Batch";
    begin
        ObjGenBatch.Reset;
        ObjGenBatch.SetRange(ObjGenBatch."Journal Template Name", 'GENERAL');
        ObjGenBatch.SetRange(ObjGenBatch.Name, JBatchs);
        if ObjGenBatch.Find('-') = false then begin
            ObjGenBatch.Init;
            ObjGenBatch."Journal Template Name" := 'GENERAL';
            ObjGenBatch.Name := JBatchs;
            ObjGenBatch.Description := 'CHECKOFF PROCESSING';
            ObjGenBatch.Validate(ObjGenBatch."Journal Template Name");
            ObjGenBatch.Validate(ObjGenBatch.Name);
            ObjGenBatch.Insert;
        end;

        Gnljnline.Reset;
        Gnljnline.SetRange("Journal Template Name", 'GENERAL');
        Gnljnline.SetRange("Journal Batch Name", JBatchs);
        Gnljnline.DeleteAll;
    end;

    local procedure FnPostShares()
    begin
    end;

    local procedure FnPostLoanFine()
    begin
    end;

    local procedure FnPostCapitalReserve()
    var
        ObjCheckOffLines: Record "Checkoff Lines-Distributed";
    begin
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        // ObjCheckOffLines.SETRANGE(ObjCheckOffLines."Trans Type",'RESERVE');
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Special Code", '337');
        if ObjCheckOffLines.FindSet then begin
            repeat
                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Member;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := "Document No";
                Gnljnline."Posting Date" := "Posting date";
                Gnljnline.Description := ObjCheckOffLines."Special Code";
                Gnljnline.Amount := -ObjCheckOffLines.Amount;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Capital Reserve";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
            until ObjCheckOffLines.Next = 0;
        end;
    end;

    local procedure FnPostUnallocated()
    var
        ObjCheckOffLines: Record "Checkoff Lines-Distributed";
    begin
        ObjCheckOffLines.Reset;
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Receipt Header No", No);
        ObjCheckOffLines.SetRange(ObjCheckOffLines."Trans Type", 'UNALLOCATED');
        if ObjCheckOffLines.FindSet then begin
            repeat
                LineN := LineN + 10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name" := 'GENERAL';
                Gnljnline."Journal Batch Name" := JBatchs;
                Gnljnline."Line No." := LineN;
                Gnljnline."Account Type" := Gnljnline."account type"::Member;
                Gnljnline."Account No." := ObjCheckOffLines."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No." := "Document No";
                Gnljnline."Posting Date" := "Posting date";
                Gnljnline.Description := ObjCheckOffLines."Special Code";
                Gnljnline.Amount := -ObjCheckOffLines.Amount;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Transaction Type" := Gnljnline."transaction type"::"Unallocated Funds";
                Gnljnline.Validate(Gnljnline."Transaction Type");
                Gnljnline."Shortcut Dimension 1 Code" := 'BOSA';
                //Gnljnline."Shortcut Dimension 1 Code":='BOSA';Branch
                if Gnljnline.Amount <> 0 then
                    Gnljnline.Insert;
            until ObjCheckOffLines.Next = 0;
        end;
    end;
}

