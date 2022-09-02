#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516000 "Funds Management"
{

    trigger OnRun()
    begin
    end;

    var
        TaxCodes: Record "Funds Tax Codes";
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        DocPrint: Codeunit "Document-Print";
        ReversalEntry: Record "Reversal Entry";
        GLEntry: Record "G/L Entry";
        TransactionNo: Integer;


    procedure PostPayment("Payment Header": Record "Payment Header.";"Journal Template": Code[20];"Journal Batch": Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        PaymentLine: Record "Payment Line.";
        PaymentHeader: Record "Payment Header.";
        SourceCode: Code[20];
        BankLedgers: Record "Bank Account Ledger Entry";
        PaymentLine2: Record "Payment Line.";
        PaymentHeader2: Record "Payment Header.";
    begin
            PaymentHeader.TransferFields("Payment Header",true);
            SourceCode:='PAYMENTJNL';

            //Delete Journal Lines if Exist
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name","Journal Template");
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name","Journal Batch");
            if GenJnlLine.FindSet then begin
              GenJnlLine.DeleteAll;
            end;
            //End Delete

            LineNo:=1000;
            //********************************************Add to Bank(Payment Header)*******************************************************//
            PaymentHeader.CalcFields(PaymentHeader."Net Amount");
            GenJnlLine.Init;
            GenJnlLine."Journal Template Name":="Journal Template";
            GenJnlLine.Validate(GenJnlLine."Journal Template Name");
            GenJnlLine."Journal Batch Name":="Journal Batch";
            GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
            GenJnlLine."Line No.":=LineNo;
            GenJnlLine."Source Code":=SourceCode;
            GenJnlLine."Posting Date":=PaymentHeader."Posting Date";
            if CustomerLinesExist(PaymentHeader) then
              GenJnlLine."Document Type":=GenJnlLine."document type"::" "
            else
              GenJnlLine."Document Type":=GenJnlLine."document type"::Payment;
            GenJnlLine."Document No.":=PaymentHeader."No.";
            GenJnlLine."External Document No.":=PaymentHeader."Cheque No";
            GenJnlLine."Account Type":=GenJnlLine."account type"::"Bank Account";
            GenJnlLine."Account No.":=PaymentHeader."Bank Account";
            GenJnlLine.Validate(GenJnlLine."Account No.");
            GenJnlLine."Currency Code":=PaymentHeader."Currency Code";
            GenJnlLine.Validate(GenJnlLine."Currency Code");
            GenJnlLine."Currency Factor":=PaymentHeader."Currency Factor";
            GenJnlLine.Validate("Currency Factor");
            GenJnlLine.Amount:=-(PaymentHeader."Net Amount");  //Credit Amount
            GenJnlLine.Validate(GenJnlLine.Amount);
            GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
            GenJnlLine."Bal. Account No.":='';
            GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
            GenJnlLine."Shortcut Dimension 1 Code":=PaymentHeader."Global Dimension 1 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
            GenJnlLine."Shortcut Dimension 2 Code":=PaymentHeader."Global Dimension 2 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
            GenJnlLine.ValidateShortcutDimCode(3,PaymentHeader."Shortcut Dimension 3 Code");
            GenJnlLine.ValidateShortcutDimCode(4,PaymentHeader."Shortcut Dimension 4 Code");
            GenJnlLine.ValidateShortcutDimCode(5,PaymentHeader."Shortcut Dimension 5 Code");
            GenJnlLine.ValidateShortcutDimCode(6,PaymentHeader."Shortcut Dimension 6 Code");
            GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
            GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
            GenJnlLine.Description:=UpperCase(CopyStr(PaymentHeader."Payment Description",1,90));
            GenJnlLine.Text:=UpperCase(CopyStr(PaymentHeader.Payee,1,50));
            GenJnlLine.Validate(GenJnlLine.Description);
            if PaymentHeader."Payment Mode"<>PaymentHeader."payment mode"::Cheque then  begin
              GenJnlLine."Bank Payment Type":=GenJnlLine."bank payment type"::" "
            end else begin
              if PaymentHeader."Cheque Type"=PaymentHeader."cheque type"::" " then
               GenJnlLine."Bank Payment Type":=GenJnlLine."bank payment type"::"Computer Check"
              else
                 GenJnlLine."Bank Payment Type":=GenJnlLine."bank payment type"::" "
            end;
            if GenJnlLine.Amount<>0 then
               GenJnlLine.Insert;
            //************************************************End Add to Bank***************************************************************//

            //***********************************************Add Payment Lines**************************************************************//
                   PaymentLine.Reset;
                   PaymentLine.SetRange(PaymentLine.No,PaymentHeader."No.");
                   PaymentLine.SetFilter(PaymentLine.Amount,'<>%1',0);
                   if PaymentLine.FindSet then begin
                     repeat
                    //****************************************Add Line NetAmounts***********************************************************//
                        LineNo:=LineNo+1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name":="Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name":="Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Source Code":=SourceCode;
                        GenJnlLine."Line No.":=LineNo;
                        GenJnlLine."Posting Date":=PaymentHeader."Posting Date";
                        GenJnlLine."Document No.":=PaymentLine.No;
                        if CustomerLinesExist(PaymentHeader) then
                         GenJnlLine."Document Type":=GenJnlLine."document type"::" "
                        else
                          GenJnlLine."Document Type":=GenJnlLine."document type"::Payment;
                        GenJnlLine."Account Type":=PaymentLine."Account Type";
                        GenJnlLine."Account No.":=PaymentLine."Account No.";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."External Document No.":=PaymentHeader."Cheque No";
                        GenJnlLine."Currency Code":=PaymentHeader."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine."Currency Factor":=PaymentHeader."Currency Factor";
                        GenJnlLine.Validate("Currency Factor");
                        GenJnlLine.Amount:=PaymentLine."Net Amount";  //Debit Amount
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                        GenJnlLine."Bal. Account No.":='';
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Gen. Bus. Posting Group":=PaymentLine."Gen. Bus. Posting Group";
                        GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group":=PaymentLine."Gen. Prod. Posting Group";
                        GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group":=PaymentLine."VAT Bus. Posting Group";
                        GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group":=PaymentLine."VAT Prod. Posting Group";
                        GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                        GenJnlLine."Shortcut Dimension 1 Code":=PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code":=PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3,PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4,PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5,PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6,PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description:=UpperCase(CopyStr(PaymentLine."Payment Description",1,90));
                        GenJnlLine.Text:=UpperCase(CopyStr(PaymentHeader.Payee,1,50));
                        GenJnlLine.Validate(GenJnlLine.Description);
                        GenJnlLine."Applies-to Doc. Type":=GenJnlLine."applies-to doc. type"::Invoice;
                        GenJnlLine."Applies-to Doc. No.":=PaymentLine."Applies-to Doc. No.";
                        GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID":=PaymentLine."Applies-to ID";

                        if GenJnlLine.Amount<>0 then
                           GenJnlLine.Insert;
                   //*************************************End add Line NetAmounts**********************************************************//

                   //****************************************Add VAT Amounts***************************************************************//
                     if PaymentLine."VAT Code"<>'' then begin
                       TaxCodes.Reset;
                       TaxCodes.SetRange(TaxCodes."Tax Code",PaymentLine."VAT Code");
                       if TaxCodes.FindFirst then begin
                          TaxCodes.TestField(TaxCodes."Account No");
                          LineNo:=LineNo+1;
                          GenJnlLine.Init;
                          GenJnlLine."Journal Template Name":="Journal Template";
                          GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                          GenJnlLine."Journal Batch Name":="Journal Batch";
                          GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                          GenJnlLine."Line No.":=LineNo;
                          GenJnlLine."Source Code":=SourceCode;
                          GenJnlLine."Posting Date":=PaymentHeader."Posting Date";
                          if CustomerLinesExist(PaymentHeader) then
                           GenJnlLine."Document Type":=GenJnlLine."document type"::" "
                          else
                           GenJnlLine."Document Type":=GenJnlLine."document type"::Payment;
                          GenJnlLine."Document No.":=PaymentLine.No;
                          GenJnlLine."External Document No.":=PaymentHeader."Cheque No";
                          GenJnlLine."Account Type":=TaxCodes."Account Type";
                          GenJnlLine."Account No.":=TaxCodes."Account No";
                          GenJnlLine.Validate(GenJnlLine."Account No.");
                          GenJnlLine."Currency Code":=PaymentHeader."Currency Code";
                          GenJnlLine.Validate(GenJnlLine."Currency Code");
                          GenJnlLine."Currency Factor":=PaymentHeader."Currency Factor";
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
                          GenJnlLine.Amount:=-(PaymentLine."VAT Amount");   //Credit Amount
                          GenJnlLine.Validate(GenJnlLine.Amount);
                          GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                          GenJnlLine."Bal. Account No.":='';
                          GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                          GenJnlLine."Shortcut Dimension 1 Code":=PaymentHeader."Global Dimension 1 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                          GenJnlLine."Shortcut Dimension 2 Code":=PaymentHeader."Global Dimension 2 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                          GenJnlLine.ValidateShortcutDimCode(3,PaymentHeader."Shortcut Dimension 3 Code");
                          GenJnlLine.ValidateShortcutDimCode(4,PaymentHeader."Shortcut Dimension 4 Code");
                          GenJnlLine.ValidateShortcutDimCode(5,PaymentHeader."Shortcut Dimension 5 Code");
                          GenJnlLine.ValidateShortcutDimCode(6,PaymentHeader."Shortcut Dimension 6 Code");
                          GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                          GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                          GenJnlLine.Description:=UpperCase(CopyStr('VAT:' + Format(PaymentLine."Account Type") + '::' + Format(PaymentLine."Account Name"),1,90));
                          GenJnlLine.Text:=UpperCase(CopyStr(PaymentHeader.Payee,1,50));
                          if GenJnlLine.Amount<>0 then
                            GenJnlLine.Insert;

                          //VAT Balancing goes to Vendor
                          LineNo:=LineNo+1;
                          GenJnlLine.Init;
                          GenJnlLine."Journal Template Name":="Journal Template";
                          GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                          GenJnlLine."Journal Batch Name":="Journal Batch";
                          GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                          GenJnlLine."Line No.":=LineNo;
                          GenJnlLine."Source Code":=SourceCode;
                          GenJnlLine."Posting Date":=PaymentHeader."Posting Date";
                          if CustomerLinesExist(PaymentHeader) then
                           GenJnlLine."Document Type":=GenJnlLine."document type"::" "
                          else
                            GenJnlLine."Document Type":=GenJnlLine."document type"::Payment;
                          GenJnlLine."Document No.":=PaymentLine.No;
                          GenJnlLine."External Document No.":=PaymentHeader."Cheque No";
                          GenJnlLine."Account Type":=PaymentLine."Account Type";
                          GenJnlLine."Account No.":=PaymentLine."Account No.";
                          GenJnlLine.Validate(GenJnlLine."Account No.");
                          GenJnlLine."Currency Code":=PaymentHeader."Currency Code";
                          GenJnlLine.Validate(GenJnlLine."Currency Code");
                          GenJnlLine."Currency Factor":=PaymentHeader."Currency Factor";
                          GenJnlLine.Validate("Currency Factor");
                          GenJnlLine.Amount:=PaymentLine."VAT Amount";   //Debit Amount
                          GenJnlLine.Validate(GenJnlLine.Amount);
                          GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                          GenJnlLine."Bal. Account No.":='';
                          GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                          GenJnlLine."Shortcut Dimension 1 Code":=PaymentHeader."Global Dimension 1 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                          GenJnlLine."Shortcut Dimension 2 Code":=PaymentHeader."Global Dimension 2 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                          GenJnlLine.ValidateShortcutDimCode(3,PaymentHeader."Shortcut Dimension 3 Code");
                          GenJnlLine.ValidateShortcutDimCode(4,PaymentHeader."Shortcut Dimension 4 Code");
                          GenJnlLine.ValidateShortcutDimCode(5,PaymentHeader."Shortcut Dimension 5 Code");
                          GenJnlLine.ValidateShortcutDimCode(6,PaymentHeader."Shortcut Dimension 6 Code");
                          GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                          GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                          GenJnlLine.Description:=UpperCase(CopyStr('VAT:' + Format(PaymentLine."Account Type") + '::' + Format(PaymentLine."Account Name"),1,50)) ;
                          GenJnlLine.Text:=UpperCase(CopyStr(PaymentHeader.Payee,1,50));
                          GenJnlLine."Applies-to Doc. Type":=GenJnlLine."applies-to doc. type"::Invoice;
                          GenJnlLine."Applies-to Doc. No.":=PaymentLine."Applies-to Doc. No.";
                          GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                          GenJnlLine."Applies-to ID":=PaymentLine."Applies-to ID";
                          if GenJnlLine.Amount<>0 then
                             GenJnlLine.Insert;

                       end;
                     end;
                   //*************************************End Add VAT Amounts**************************************************************//

                   //****************************************Add W/TAX Amounts*************************************************************//
                     if PaymentLine."W/TAX Code"<>'' then begin
                       TaxCodes.Reset;
                       TaxCodes.SetRange(TaxCodes."Tax Code",PaymentLine."W/TAX Code");
                       if TaxCodes.FindFirst then begin
                          TaxCodes.TestField(TaxCodes."Account No");
                          LineNo:=LineNo+1;
                          GenJnlLine.Init;
                          GenJnlLine."Journal Template Name":="Journal Template";
                          GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                          GenJnlLine."Journal Batch Name":="Journal Batch";
                          GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                          GenJnlLine."Line No.":=LineNo;
                          GenJnlLine."Source Code":=SourceCode;
                          GenJnlLine."Posting Date":=PaymentHeader."Posting Date";
                          if CustomerLinesExist(PaymentHeader) then
                           GenJnlLine."Document Type":=GenJnlLine."document type"::" "
                          else
                           GenJnlLine."Document Type":=GenJnlLine."document type"::Payment;
                          GenJnlLine."Document No.":=PaymentLine.No;
                          GenJnlLine."External Document No.":=PaymentHeader."Cheque No";
                          GenJnlLine."Account Type":=TaxCodes."Account Type";
                          GenJnlLine."Account No.":=TaxCodes."Account No";
                          GenJnlLine.Validate(GenJnlLine."Account No.");
                          GenJnlLine."Currency Code":=PaymentHeader."Currency Code";
                          GenJnlLine.Validate(GenJnlLine."Currency Code");
                          GenJnlLine."Currency Factor":=PaymentHeader."Currency Factor";
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
                          GenJnlLine.Amount:=-(PaymentLine."W/TAX Amount");   //Credit Amount
                          GenJnlLine.Validate(GenJnlLine.Amount);
                          GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                          GenJnlLine."Bal. Account No.":='';
                          GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                          GenJnlLine."Shortcut Dimension 1 Code":=PaymentHeader."Global Dimension 1 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                          GenJnlLine."Shortcut Dimension 2 Code":=PaymentHeader."Global Dimension 2 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                          GenJnlLine.ValidateShortcutDimCode(3,PaymentHeader."Shortcut Dimension 3 Code");
                          GenJnlLine.ValidateShortcutDimCode(4,PaymentHeader."Shortcut Dimension 4 Code");
                          GenJnlLine.ValidateShortcutDimCode(5,PaymentHeader."Shortcut Dimension 5 Code");
                          GenJnlLine.ValidateShortcutDimCode(6,PaymentHeader."Shortcut Dimension 6 Code");
                          GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                          GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                          GenJnlLine.Description:=UpperCase(CopyStr('W/TAX:' + Format(PaymentLine."Account Type") + '::' + Format(PaymentLine."Account Name"),1,90));
                          GenJnlLine.Text:=UpperCase(CopyStr(PaymentHeader.Payee,1,50));
                          if GenJnlLine.Amount<>0 then
                            GenJnlLine.Insert;

                          //W/TAX Balancing goes to Vendor
                          LineNo:=LineNo+1;
                          GenJnlLine.Init;
                          GenJnlLine."Journal Template Name":="Journal Template";
                          GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                          GenJnlLine."Journal Batch Name":="Journal Batch";
                          GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                          GenJnlLine."Line No.":=LineNo;
                          GenJnlLine."Source Code":=SourceCode;
                          GenJnlLine."Posting Date":=PaymentHeader."Posting Date";
                          if CustomerLinesExist(PaymentHeader) then
                           GenJnlLine."Document Type":=GenJnlLine."document type"::" "
                          else
                            GenJnlLine."Document Type":=GenJnlLine."document type"::Payment;
                          GenJnlLine."Document No.":=PaymentLine.No;
                          GenJnlLine."External Document No.":=PaymentHeader."Cheque No";
                          GenJnlLine."Account Type":=PaymentLine."Account Type";
                          GenJnlLine."Account No.":=PaymentLine."Account No.";
                          GenJnlLine.Validate(GenJnlLine."Account No.");
                          GenJnlLine."Currency Code":=PaymentHeader."Currency Code";
                          GenJnlLine.Validate(GenJnlLine."Currency Code");
                          GenJnlLine."Currency Factor":=PaymentHeader."Currency Factor";
                          GenJnlLine.Validate("Currency Factor");
                          GenJnlLine.Amount:=PaymentLine."W/TAX Amount";   //Debit Amount
                          GenJnlLine.Validate(GenJnlLine.Amount);
                          GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                          GenJnlLine."Bal. Account No.":='';
                          GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                          GenJnlLine."Shortcut Dimension 1 Code":=PaymentHeader."Global Dimension 1 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                          GenJnlLine."Shortcut Dimension 2 Code":=PaymentHeader."Global Dimension 2 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                          GenJnlLine.ValidateShortcutDimCode(3,PaymentHeader."Shortcut Dimension 3 Code");
                          GenJnlLine.ValidateShortcutDimCode(4,PaymentHeader."Shortcut Dimension 4 Code");
                          GenJnlLine.ValidateShortcutDimCode(5,PaymentHeader."Shortcut Dimension 5 Code");
                          GenJnlLine.ValidateShortcutDimCode(6,PaymentHeader."Shortcut Dimension 6 Code");
                          GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                          GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                          GenJnlLine.Description:=UpperCase(CopyStr('W/TAX:' + Format(PaymentLine."Account Type") + '::' + Format(PaymentLine."Account Name"),1,90));
                          GenJnlLine.Text:=UpperCase(CopyStr(PaymentHeader.Payee,1,50));
                          GenJnlLine."Applies-to Doc. Type":=GenJnlLine."applies-to doc. type"::Invoice;
                          GenJnlLine."Applies-to Doc. No.":=PaymentLine."Applies-to Doc. No.";
                          GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                          GenJnlLine."Applies-to ID":=PaymentLine."Applies-to ID";
                          if GenJnlLine.Amount<>0 then
                             GenJnlLine.Insert;

                       end;
                     end;

                   //*************************************End Add W/TAX Amounts************************************************************//

                   //*************************************Add Retention Amounts************************************************************//
                   //***********************************End Add Retention Amounts**********************************************************//
                      until PaymentLine.Next=0;
                   end;

            //*********************************************End Add Payment Lines************************************************************//
            Commit;
            //********************************************Post the Journal Lines************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name","Journal Template");
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name","Journal Batch");
            //Adjust GenJnlLine Exchange Rate Rounding Balances
               AdjustGenJnl.Run(GenJnlLine);
            //End Adjust GenJnlLine Exchange Rate Rounding Balances


            //Before posting if its computer cheque,print the cheque
            if (PaymentHeader."Payment Mode"=PaymentHeader."payment mode"::Cheque) and
            (PaymentHeader."Cheque Type"=PaymentHeader."cheque type"::" ") then begin
              DocPrint.PrintCheck(GenJnlLine);
              Codeunit.Run(Codeunit::"Adjust Gen. Journal Balance",GenJnlLine);
            end;

            //Now Post the Journal Lines
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post",GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            BankLedgers.Reset;
            BankLedgers.SetRange(BankLedgers."Document No.",PaymentHeader."No.");
            if BankLedgers.FindFirst then begin
              PaymentHeader2.Reset;
              PaymentHeader2.SetRange(PaymentHeader2."No.",PaymentHeader."No.");
              if PaymentHeader2.FindFirst then begin
                PaymentHeader2.Status:=PaymentHeader2.Status::Posted;
                PaymentHeader2.Posted:=true;
                PaymentHeader2."Posted By":=UserId;
                PaymentHeader2."Date Posted":=Today;
                PaymentHeader2."Time Posted":=Time;
                PaymentHeader2.Modify;
                PaymentLine2.Reset;
                PaymentLine2.SetRange(PaymentLine2.No,PaymentHeader2."No.");
                if PaymentLine2.FindSet then begin
                  repeat
                      PaymentLine2.Status:=PaymentLine2.Status::Posted;
                      PaymentLine2.Posted:=true;
                      PaymentLine2."Posted By":=UserId;
                      PaymentLine2."Date Posted":=Today;
                      PaymentLine2."Time Posted":=Time;
                      PaymentLine2.Modify;
                  until PaymentLine2.Next=0;
                end;
              end;
            end;

            //***********************************************End Update Document************************************************************//
    end;


    procedure PostBoardPayment("Payment Header": Record "Payment Header.";"Journal Template": Code[20];"Journal Batch": Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        PaymentLine: Record "Payment Line.";
        PaymentHeader: Record "Payment Header.";
        SourceCode: Code[20];
        BankLedgers: Record "Bank Account Ledger Entry";
        PaymentLine2: Record "Payment Line.";
        PaymentHeader2: Record "Payment Header.";
    begin
            PaymentHeader.TransferFields("Payment Header",true);
            SourceCode:='PAYMENTJNL';
        
            //Delete Journal Lines if Exist
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name","Journal Template");
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name","Journal Batch");
            if GenJnlLine.FindSet then begin
              GenJnlLine.DeleteAll;
            end;
            //End Delete
        
            LineNo:=1000;
            //********************************************Add to Bank(Payment Header)*******************************************************//
            PaymentHeader.CalcFields(PaymentHeader."Net Amount");
            GenJnlLine.Init;
            GenJnlLine."Journal Template Name":="Journal Template";
            GenJnlLine.Validate(GenJnlLine."Journal Template Name");
            GenJnlLine."Journal Batch Name":="Journal Batch";
            GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
            GenJnlLine."Line No.":=LineNo;
            GenJnlLine."Source Code":=SourceCode;
            GenJnlLine."Posting Date":=PaymentHeader."Posting Date";
            if CustomerLinesExist(PaymentHeader) then
              GenJnlLine."Document Type":=GenJnlLine."document type"::" "
            else
              GenJnlLine."Document Type":=GenJnlLine."document type"::Payment;
            GenJnlLine."Document No.":=PaymentHeader."No.";
            GenJnlLine."External Document No.":=PaymentHeader."Cheque No";
            GenJnlLine."Account Type":=GenJnlLine."account type"::"Bank Account";
            GenJnlLine."Account No.":=PaymentHeader."Bank Account";
            GenJnlLine.Validate(GenJnlLine."Account No.");
            GenJnlLine."Currency Code":=PaymentHeader."Currency Code";
            GenJnlLine.Validate(GenJnlLine."Currency Code");
            GenJnlLine."Currency Factor":=PaymentHeader."Currency Factor";
            GenJnlLine.Validate("Currency Factor");
            GenJnlLine.Amount:=-(PaymentHeader."Net Amount");  //Credit Amount
            GenJnlLine.Validate(GenJnlLine.Amount);
            GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
            GenJnlLine."Bal. Account No.":='';
            GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
            GenJnlLine."Shortcut Dimension 1 Code":=PaymentHeader."Global Dimension 1 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
            GenJnlLine."Shortcut Dimension 2 Code":=PaymentHeader."Global Dimension 2 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
            GenJnlLine.ValidateShortcutDimCode(3,PaymentHeader."Shortcut Dimension 3 Code");
            GenJnlLine.ValidateShortcutDimCode(4,PaymentHeader."Shortcut Dimension 4 Code");
            GenJnlLine.ValidateShortcutDimCode(5,PaymentHeader."Shortcut Dimension 5 Code");
            GenJnlLine.ValidateShortcutDimCode(6,PaymentHeader."Shortcut Dimension 6 Code");
            GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
            GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
            GenJnlLine.Description:=CopyStr(PaymentHeader."Payment Description",1,50);
            GenJnlLine.Text:=UpperCase(CopyStr(PaymentHeader.Payee,1,50));
            GenJnlLine.Validate(GenJnlLine.Description);
            if PaymentHeader."Payment Mode"<>PaymentHeader."payment mode"::Cheque then  begin
              GenJnlLine."Bank Payment Type":=GenJnlLine."bank payment type"::" "
            end else begin
              if PaymentHeader."Cheque Type"=PaymentHeader."cheque type"::" " then
               GenJnlLine."Bank Payment Type":=GenJnlLine."bank payment type"::"Computer Check"
              else
                 GenJnlLine."Bank Payment Type":=GenJnlLine."bank payment type"::" "
            end;
            if GenJnlLine.Amount<>0 then
               GenJnlLine.Insert;
            //************************************************End Add to Bank***************************************************************//
        
            //***********************************************Add Payment Lines**************************************************************//
                   PaymentLine.Reset;
                   PaymentLine.SetRange(PaymentLine.No,PaymentHeader."No.");
                   PaymentLine.SetFilter(PaymentLine.Amount,'<>%1',0);
                   if PaymentLine.FindSet then begin
                     repeat
                    //****************************************Add Line NetAmounts***********************************************************//
                        LineNo:=LineNo+1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name":="Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name":="Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Source Code":=SourceCode;
                        GenJnlLine."Line No.":=LineNo;
                        GenJnlLine."Posting Date":=PaymentHeader."Posting Date";
                        GenJnlLine."Document No.":=PaymentLine.No;
                        if CustomerLinesExist(PaymentHeader) then
                         GenJnlLine."Document Type":=GenJnlLine."document type"::" "
                        else
                          GenJnlLine."Document Type":=GenJnlLine."document type"::Payment;
                        GenJnlLine."Account Type":=PaymentLine."Account Type";
                        GenJnlLine."Account No.":=PaymentLine."Account No.";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."External Document No.":=PaymentHeader."Cheque No";
                        GenJnlLine."Currency Code":=PaymentHeader."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine."Currency Factor":=PaymentHeader."Currency Factor";
                        GenJnlLine.Validate("Currency Factor");
                        GenJnlLine.Amount:=PaymentLine.Amount;  //Debit Amount
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                        GenJnlLine."Bal. Account No.":='';
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Gen. Bus. Posting Group":=PaymentLine."Gen. Bus. Posting Group";
                        GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group":=PaymentLine."Gen. Prod. Posting Group";
                        GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group":=PaymentLine."VAT Bus. Posting Group";
                        GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group":=PaymentLine."VAT Prod. Posting Group";
                        GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                        GenJnlLine."Shortcut Dimension 1 Code":=PaymentHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code":=PaymentHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3,PaymentHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4,PaymentHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5,PaymentHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6,PaymentHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description:=CopyStr(PaymentLine."Payment Description",1,50);
                        GenJnlLine.Text:=UpperCase(CopyStr(PaymentHeader.Payee,1,50));
                        GenJnlLine.Validate(GenJnlLine.Description);
                        GenJnlLine."Applies-to Doc. Type":=GenJnlLine."applies-to doc. type"::Invoice;
                        GenJnlLine."Applies-to Doc. No.":=PaymentLine."Applies-to Doc. No.";
                        GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID":=PaymentLine."Applies-to ID";
        
                        if GenJnlLine.Amount<>0 then
                           GenJnlLine.Insert;
                   //*************************************End add Line NetAmounts**********************************************************//
        
                   //****************************************Add VAT Amounts***************************************************************//
                     if PaymentLine."VAT Code"<>'' then begin
                       TaxCodes.Reset;
                       TaxCodes.SetRange(TaxCodes."Tax Code",PaymentLine."VAT Code");
                       if TaxCodes.FindFirst then begin
                          TaxCodes.TestField(TaxCodes."Account No");
                          LineNo:=LineNo+1;
                          GenJnlLine.Init;
                          GenJnlLine."Journal Template Name":="Journal Template";
                          GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                          GenJnlLine."Journal Batch Name":="Journal Batch";
                          GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                          GenJnlLine."Line No.":=LineNo;
                          GenJnlLine."Source Code":=SourceCode;
                          GenJnlLine."Posting Date":=PaymentHeader."Posting Date";
                          if CustomerLinesExist(PaymentHeader) then
                           GenJnlLine."Document Type":=GenJnlLine."document type"::" "
                          else
                           GenJnlLine."Document Type":=GenJnlLine."document type"::Payment;
                          GenJnlLine."Document No.":=PaymentLine.No;
                          GenJnlLine."External Document No.":=PaymentHeader."Cheque No";
                          GenJnlLine."Account Type":=TaxCodes."Account Type";
                          GenJnlLine."Account No.":=TaxCodes."Account No";
                          GenJnlLine.Validate(GenJnlLine."Account No.");
                          GenJnlLine."Currency Code":=PaymentHeader."Currency Code";
                          GenJnlLine.Validate(GenJnlLine."Currency Code");
                          GenJnlLine."Currency Factor":=PaymentHeader."Currency Factor";
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
                          GenJnlLine.Amount:=PaymentLine."VAT Amount";   //Debit Expense
                          GenJnlLine.Validate(GenJnlLine.Amount);
                          GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                          GenJnlLine."Bal. Account No.":='';
                          GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                          GenJnlLine."Shortcut Dimension 1 Code":=PaymentHeader."Global Dimension 1 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                          GenJnlLine."Shortcut Dimension 2 Code":=PaymentHeader."Global Dimension 2 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                          GenJnlLine.ValidateShortcutDimCode(3,PaymentHeader."Shortcut Dimension 3 Code");
                          GenJnlLine.ValidateShortcutDimCode(4,PaymentHeader."Shortcut Dimension 4 Code");
                          GenJnlLine.ValidateShortcutDimCode(5,PaymentHeader."Shortcut Dimension 5 Code");
                          GenJnlLine.ValidateShortcutDimCode(6,PaymentHeader."Shortcut Dimension 6 Code");
                          GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                          GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                          GenJnlLine.Description:=CopyStr('VAT:' + Format(PaymentLine."Account Type") + '::' + Format(PaymentLine."Account Name"),1,50);
                          GenJnlLine.Text:=UpperCase(CopyStr(PaymentHeader.Payee,1,50));
                          if GenJnlLine.Amount<>0 then
                            GenJnlLine.Insert;
        
                          //Credit goes to Liabilty
                          LineNo:=LineNo+1;
                          GenJnlLine.Init;
                          GenJnlLine."Journal Template Name":="Journal Template";
                          GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                          GenJnlLine."Journal Batch Name":="Journal Batch";
                          GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                          GenJnlLine."Line No.":=LineNo;
                          GenJnlLine."Source Code":=SourceCode;
                          GenJnlLine."Posting Date":=PaymentHeader."Posting Date";
                          if CustomerLinesExist(PaymentHeader) then
                           GenJnlLine."Document Type":=GenJnlLine."document type"::" "
                          else
                            GenJnlLine."Document Type":=GenJnlLine."document type"::Payment;
                          GenJnlLine."Document No.":=PaymentLine.No;
                          GenJnlLine."External Document No.":=PaymentHeader."Cheque No";
                          GenJnlLine."Account Type":=GenJnlLine."account type"::"G/L Account";
                          TaxCodes.TestField(TaxCodes."Liability Account");
                          GenJnlLine."Account No.":=TaxCodes."Liability Account";
                          GenJnlLine.Validate(GenJnlLine."Account No.");
                          GenJnlLine."Currency Code":=PaymentHeader."Currency Code";
                          GenJnlLine.Validate(GenJnlLine."Currency Code");
                          GenJnlLine."Currency Factor":=PaymentHeader."Currency Factor";
                          GenJnlLine.Validate("Currency Factor");
                          GenJnlLine.Amount:=-(PaymentLine."VAT Amount");   //Credit Liability
                          GenJnlLine.Validate(GenJnlLine.Amount);
                          GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                          GenJnlLine."Bal. Account No.":='';
                          GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                          GenJnlLine."Shortcut Dimension 1 Code":=PaymentHeader."Global Dimension 1 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                          GenJnlLine."Shortcut Dimension 2 Code":=PaymentHeader."Global Dimension 2 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                          GenJnlLine.ValidateShortcutDimCode(3,PaymentHeader."Shortcut Dimension 3 Code");
                          GenJnlLine.ValidateShortcutDimCode(4,PaymentHeader."Shortcut Dimension 4 Code");
                          GenJnlLine.ValidateShortcutDimCode(5,PaymentHeader."Shortcut Dimension 5 Code");
                          GenJnlLine.ValidateShortcutDimCode(6,PaymentHeader."Shortcut Dimension 6 Code");
                          GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                          GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                          GenJnlLine.Description:=CopyStr('VAT:' + Format(PaymentLine."Account Type") + '::' + Format(PaymentLine."Account Name"),1,50) ;
                          GenJnlLine.Text:=UpperCase(CopyStr(PaymentHeader.Payee,1,50));
                          GenJnlLine."Applies-to Doc. Type":=GenJnlLine."applies-to doc. type"::Invoice;
                          GenJnlLine."Applies-to Doc. No.":=PaymentLine."Applies-to Doc. No.";
                          GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                          GenJnlLine."Applies-to ID":=PaymentLine."Applies-to ID";
                          if GenJnlLine.Amount<>0 then
                             GenJnlLine.Insert;
        
                       end;
                     end;
                   //*************************************End Add VAT Amounts**************************************************************//
        
                   //****************************************Add W/TAX Amounts*************************************************************//
                     if PaymentLine."W/TAX Code"<>'' then begin
                       TaxCodes.Reset;
                       TaxCodes.SetRange(TaxCodes."Tax Code",PaymentLine."W/TAX Code");
                       if TaxCodes.FindFirst then begin
                          TaxCodes.TestField(TaxCodes."Account No");
                          LineNo:=LineNo+1;
                          GenJnlLine.Init;
                          GenJnlLine."Journal Template Name":="Journal Template";
                          GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                          GenJnlLine."Journal Batch Name":="Journal Batch";
                          GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                          GenJnlLine."Line No.":=LineNo;
                          GenJnlLine."Source Code":=SourceCode;
                          GenJnlLine."Posting Date":=PaymentHeader."Posting Date";
                          if CustomerLinesExist(PaymentHeader) then
                           GenJnlLine."Document Type":=GenJnlLine."document type"::" "
                          else
                           GenJnlLine."Document Type":=GenJnlLine."document type"::Payment;
                          GenJnlLine."Document No.":=PaymentLine.No;
                          GenJnlLine."External Document No.":=PaymentHeader."Cheque No";
                          GenJnlLine."Account Type":=TaxCodes."Account Type";
                          GenJnlLine."Account No.":=TaxCodes."Account No";      //Debit Expense
                          GenJnlLine.Validate(GenJnlLine."Account No.");
                          GenJnlLine."Currency Code":=PaymentHeader."Currency Code";
                          GenJnlLine.Validate(GenJnlLine."Currency Code");
                          GenJnlLine."Currency Factor":=PaymentHeader."Currency Factor";
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
                          GenJnlLine.Amount:=PaymentLine."W/TAX Amount";   //Debit Expense
                          GenJnlLine.Validate(GenJnlLine.Amount);
                          GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                          GenJnlLine."Bal. Account No.":='';
                          GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                          GenJnlLine."Shortcut Dimension 1 Code":=PaymentHeader."Global Dimension 1 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                          GenJnlLine."Shortcut Dimension 2 Code":=PaymentHeader."Global Dimension 2 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                          GenJnlLine.ValidateShortcutDimCode(3,PaymentHeader."Shortcut Dimension 3 Code");
                          GenJnlLine.ValidateShortcutDimCode(4,PaymentHeader."Shortcut Dimension 4 Code");
                          GenJnlLine.ValidateShortcutDimCode(5,PaymentHeader."Shortcut Dimension 5 Code");
                          GenJnlLine.ValidateShortcutDimCode(6,PaymentHeader."Shortcut Dimension 6 Code");
                          GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                          GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                          GenJnlLine.Description:=CopyStr('PAYE:' + Format(PaymentLine."Account Type") + '::' + Format(PaymentLine."Account Name"),1,50);
                          GenJnlLine.Text:=UpperCase(CopyStr(PaymentHeader.Payee,1,50));
                          /*IF GenJnlLine.Amount<>0 THEN
                            GenJnlLine.INSERT;*/
        
                          //Credit goes to liability
                          LineNo:=LineNo+1;
                          GenJnlLine.Init;
                          GenJnlLine."Journal Template Name":="Journal Template";
                          GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                          GenJnlLine."Journal Batch Name":="Journal Batch";
                          GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                          GenJnlLine."Line No.":=LineNo;
                          GenJnlLine."Source Code":=SourceCode;
                          GenJnlLine."Posting Date":=PaymentHeader."Posting Date";
                          if CustomerLinesExist(PaymentHeader) then
                           GenJnlLine."Document Type":=GenJnlLine."document type"::" "
                          else
                            GenJnlLine."Document Type":=GenJnlLine."document type"::Payment;
                          GenJnlLine."Document No.":=PaymentLine.No;
                          GenJnlLine."External Document No.":=PaymentHeader."Cheque No";
                          GenJnlLine."Account Type":=GenJnlLine."account type"::"G/L Account";
                          TaxCodes.TestField(TaxCodes."Liability Account");
                          GenJnlLine."Account No.":=TaxCodes."Liability Account";
                          GenJnlLine.Validate(GenJnlLine."Account No.");
                          GenJnlLine."Currency Code":=PaymentHeader."Currency Code";
                          GenJnlLine.Validate(GenJnlLine."Currency Code");
                          GenJnlLine."Currency Factor":=PaymentHeader."Currency Factor";
                          GenJnlLine.Validate("Currency Factor");
                          GenJnlLine.Amount:=-(PaymentLine."W/TAX Amount");   //Credit Liability
                          GenJnlLine.Validate(GenJnlLine.Amount);
                          GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                          GenJnlLine."Bal. Account No.":='';
                          GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                          GenJnlLine."Shortcut Dimension 1 Code":=PaymentHeader."Global Dimension 1 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                          GenJnlLine."Shortcut Dimension 2 Code":=PaymentHeader."Global Dimension 2 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                          GenJnlLine.ValidateShortcutDimCode(3,PaymentHeader."Shortcut Dimension 3 Code");
                          GenJnlLine.ValidateShortcutDimCode(4,PaymentHeader."Shortcut Dimension 4 Code");
                          GenJnlLine.ValidateShortcutDimCode(5,PaymentHeader."Shortcut Dimension 5 Code");
                          GenJnlLine.ValidateShortcutDimCode(6,PaymentHeader."Shortcut Dimension 6 Code");
                          GenJnlLine.ValidateShortcutDimCode(7,PaymentHeader."Shortcut Dimension 7 Code");
                          GenJnlLine.ValidateShortcutDimCode(8,PaymentHeader."Shortcut Dimension 8 Code");
                          GenJnlLine.Description:=CopyStr(Format(TaxCodes."Tax Code")+':' + Format(PaymentLine."Account Type") + '::' + Format(PaymentLine."Account Name"),1,50) ;
                          GenJnlLine.Text:=UpperCase(CopyStr(PaymentHeader.Payee,1,50));
                          GenJnlLine."Applies-to Doc. Type":=GenJnlLine."applies-to doc. type"::Invoice;
                          GenJnlLine."Applies-to Doc. No.":=PaymentLine."Applies-to Doc. No.";
                          GenJnlLine.Validate(GenJnlLine."Applies-to Doc. No.");
                          GenJnlLine."Applies-to ID":=PaymentLine."Applies-to ID";
                          if GenJnlLine.Amount<>0 then
                             GenJnlLine.Insert;
        
                       end;
                     end;
        
                   //*************************************End Add W/TAX Amounts************************************************************//
        
                   //*************************************Add Retention Amounts************************************************************//
                   //***********************************End Add Retention Amounts**********************************************************//
                      until PaymentLine.Next=0;
                   end;
        
            //*********************************************End Add Payment Lines************************************************************//
            Commit;
            //********************************************Post the Journal Lines************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name","Journal Template");
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name","Journal Batch");
            //Adjust GenJnlLine Exchange Rate Rounding Balances
               AdjustGenJnl.Run(GenJnlLine);
            //End Adjust GenJnlLine Exchange Rate Rounding Balances
        
        
            //Before posting if its computer cheque,print the cheque
            if (PaymentHeader."Payment Mode"=PaymentHeader."payment mode"::Cheque) and
            (PaymentHeader."Cheque Type"=PaymentHeader."cheque type"::" ") then begin
              DocPrint.PrintCheck(GenJnlLine);
              Codeunit.Run(Codeunit::"Adjust Gen. Journal Balance",GenJnlLine);
            end;
        
            //Now Post the Journal Lines
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post",GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            BankLedgers.Reset;
            BankLedgers.SetRange(BankLedgers."Document No.",PaymentHeader."No.");
            if BankLedgers.FindFirst then begin
              PaymentHeader2.Reset;
              PaymentHeader2.SetRange(PaymentHeader2."No.",PaymentHeader."No.");
              if PaymentHeader2.FindFirst then begin
                PaymentHeader2.Status:=PaymentHeader2.Status::Posted;
                PaymentHeader2.Posted:=true;
                PaymentHeader2."Posted By":=UserId;
                PaymentHeader2."Date Posted":=Today;
                PaymentHeader2."Time Posted":=Time;
                PaymentHeader2.Modify;
                PaymentLine2.Reset;
                PaymentLine2.SetRange(PaymentLine2.No,PaymentHeader2."No.");
                if PaymentLine2.FindSet then begin
                  repeat
                      PaymentLine2.Status:=PaymentLine2.Status::Posted;
                      PaymentLine2.Posted:=true;
                      PaymentLine2."Posted By":=UserId;
                      PaymentLine2."Date Posted":=Today;
                      PaymentLine2."Time Posted":=Time;
                      PaymentLine2.Modify;
                  until PaymentLine2.Next=0;
                end;
              end;
            end;
        
            //***********************************************End Update Document************************************************************//

    end;


    procedure PostReceipt("Receipt Header": Record "Receipt Header";"Journal Template": Code[20];"Journal Batch": Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        ReceiptLine: Record "Receipt Line";
        ReceiptHeader: Record "Receipt Header";
        SourceCode: Code[20];
        BankLedgers: Record "Bank Account Ledger Entry";
        ReceiptLine2: Record "Receipt Line";
        ReceiptHeader2: Record "Receipt Header";
    begin
            ReceiptHeader.TransferFields("Receipt Header",true);
            SourceCode:='RECEIPTJNL';
           // "Journal Batch":='RECEIPTS';
            //Delete Journal Lines if Exist
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name","Journal Template");
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name","Journal Batch");
            if GenJnlLine.FindSet then begin
              GenJnlLine.DeleteAll;
            end;
            //End Delete
        
            LineNo:=1000;
            //********************************************Add to Bank(Payment Header)*******************************************************//
            ReceiptHeader.CalcFields(ReceiptHeader."Total Amount");
            GenJnlLine.Init;
            GenJnlLine."Journal Template Name":="Journal Template";
          //  GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
            GenJnlLine."Journal Batch Name":="Journal Batch";
            //GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
            GenJnlLine."Line No.":=LineNo;
            GenJnlLine."Source Code":=SourceCode;
            GenJnlLine."Posting Date":=ReceiptHeader."Posting Date";
            //IF CustomerLinesExist(ReceiptHeader) THEN
              //GenJnlLine."Document Type":=GenJnlLine."Document Type"::" "
            //ELSE
              //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
            GenJnlLine."Document No.":=ReceiptHeader."No.";
            GenJnlLine."Document Type":=GenJnlLine."document type"::"7";
            GenJnlLine."External Document No.":=ReceiptHeader."Cheque No";
            GenJnlLine."Account Type":=GenJnlLine."account type"::"Bank Account";
            GenJnlLine."Account No.":=ReceiptHeader."Bank Code";
            GenJnlLine.Validate(GenJnlLine."Account No.");
            GenJnlLine."Currency Code":=ReceiptHeader."Currency Code";
            GenJnlLine.Validate(GenJnlLine."Currency Code");
            GenJnlLine."Currency Factor":=ReceiptHeader."Currency Factor";
            GenJnlLine.Validate("Currency Factor");
            GenJnlLine.Amount:=ReceiptHeader."Total Amount";  //Debit Amount
            GenJnlLine.Validate(GenJnlLine.Amount);
            GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
            GenJnlLine."Bal. Account No.":='';
            GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
            GenJnlLine."Shortcut Dimension 1 Code":=ReceiptHeader."Global Dimension 1 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
            GenJnlLine."Shortcut Dimension 2 Code":=ReceiptHeader."Global Dimension 2 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
            GenJnlLine.ValidateShortcutDimCode(3,ReceiptHeader."Shortcut Dimension 3 Code");
            GenJnlLine.ValidateShortcutDimCode(4,ReceiptHeader."Shortcut Dimension 4 Code");
            GenJnlLine.ValidateShortcutDimCode(5,ReceiptHeader."Shortcut Dimension 5 Code");
            GenJnlLine.ValidateShortcutDimCode(6,ReceiptHeader."Shortcut Dimension 6 Code");
            GenJnlLine.ValidateShortcutDimCode(7,ReceiptHeader."Shortcut Dimension 7 Code");
            GenJnlLine.ValidateShortcutDimCode(8,ReceiptHeader."Shortcut Dimension 8 Code");
            GenJnlLine.Description:=CopyStr(ReceiptHeader.Description,1,50);
            GenJnlLine.Text:=UpperCase(CopyStr("Receipt Header"."Received From",1,50));
            GenJnlLine.Validate(GenJnlLine.Description);
            if GenJnlLine.Amount<>0 then
               GenJnlLine.Insert;
            //************************************************End Add to Bank***************************************************************//
        
            //***********************************************Add Receipt Lines**************************************************************//
                   ReceiptLine.Reset;
                   ReceiptLine.SetRange(ReceiptLine."Document No",ReceiptHeader."No.");
                   ReceiptLine.SetFilter(ReceiptLine.Amount,'<>%1',0);
                   if ReceiptLine.FindSet then begin
                     repeat
                    //****************************************Add Line NetAmounts***********************************************************//
                        LineNo:=LineNo+1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name":="Journal Template";
                      //  GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name":="Journal Batch";
                        //GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Source Code":=SourceCode;
                        GenJnlLine."Line No.":=LineNo;
                        GenJnlLine."Posting Date":=ReceiptHeader."Posting Date";
                        GenJnlLine."Document No.":=ReceiptLine."Document No";
                        GenJnlLine."Document Type":=GenJnlLine."document type"::"7";
                        GenJnlLine."Account Type":=ReceiptLine."Account Type";
                        GenJnlLine."Account No.":=ReceiptLine."Account Code";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."External Document No.":=ReceiptHeader."Cheque No";
                        GenJnlLine."Currency Code":=ReceiptHeader."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine."Currency Factor":=ReceiptHeader."Currency Factor";
                        GenJnlLine.Validate("Currency Factor");
                        GenJnlLine.Amount:=-(ReceiptLine.Amount);  //Credit Amount
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                        GenJnlLine."Bal. Account No.":='';
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Gen. Bus. Posting Group":=ReceiptLine."Gen. Bus. Posting Group";
                        GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group":=ReceiptLine."Gen. Prod. Posting Group";
                        GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group":=ReceiptLine."VAT Bus. Posting Group";
                        GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group":=ReceiptLine."VAT Prod. Posting Group";
                        GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                        GenJnlLine."Shortcut Dimension 1 Code":=ReceiptHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code":=ReceiptHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3,ReceiptHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4,ReceiptHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5,ReceiptHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6,ReceiptHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7,ReceiptHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8,ReceiptHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description:=CopyStr(ReceiptHeader.Description,1,50);
                        GenJnlLine.Text:=UpperCase(CopyStr("Receipt Header"."Received From",1,50));
                        GenJnlLine.Validate(GenJnlLine.Description);
                        /*GenJnlLine."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Invoice;
                        GenJnlLine."Applies-to Doc. No.":=PaymentLine."Applies-to Doc. No.";
                        GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID":=PaymentLine."Applies-to ID"; */
        
                        if GenJnlLine.Amount<>0 then
                           GenJnlLine.Insert;
                   //*************************************End add Line NetAmounts**********************************************************//
        
                   //****************************************Add VAT Amounts***************************************************************//
                     if ReceiptLine."VAT Code"<>'' then begin
                       TaxCodes.Reset;
                       TaxCodes.SetRange(TaxCodes."Tax Code",ReceiptLine."VAT Code");
                       if TaxCodes.FindFirst then begin
                          TaxCodes.TestField(TaxCodes."Account No");
                          LineNo:=LineNo+1;
                          GenJnlLine.Init;
                          GenJnlLine."Journal Template Name":="Journal Template";
                         // GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                          GenJnlLine."Journal Batch Name":="Journal Batch";
                         // GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                          GenJnlLine."Line No.":=LineNo;
                          GenJnlLine."Source Code":=SourceCode;
                          GenJnlLine."Posting Date":=ReceiptHeader."Posting Date";
                          GenJnlLine."Document No.":=ReceiptLine."Document No";
                          GenJnlLine."Document Type":=GenJnlLine."document type"::"7";
                          GenJnlLine."External Document No.":=ReceiptHeader."Cheque No";
                          GenJnlLine."Account Type":=TaxCodes."Account Type";
                          GenJnlLine."Account No.":=TaxCodes."Account No";
                          GenJnlLine.Validate(GenJnlLine."Account No.");
                          GenJnlLine."Currency Code":=ReceiptHeader."Currency Code";
                          GenJnlLine.Validate(GenJnlLine."Currency Code");
                          GenJnlLine."Currency Factor":=ReceiptHeader."Currency Factor";
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
                          GenJnlLine.Amount:=-(ReceiptLine."VAT Amount");   //Credit Amount
                          GenJnlLine.Validate(GenJnlLine.Amount);
                          GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                          GenJnlLine."Bal. Account No.":='';
                          GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                          GenJnlLine."Shortcut Dimension 1 Code":=ReceiptHeader."Global Dimension 1 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                          GenJnlLine."Shortcut Dimension 2 Code":=ReceiptHeader."Global Dimension 2 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                          GenJnlLine.ValidateShortcutDimCode(3,ReceiptHeader."Shortcut Dimension 3 Code");
                          GenJnlLine.ValidateShortcutDimCode(4,ReceiptHeader."Shortcut Dimension 4 Code");
                          GenJnlLine.ValidateShortcutDimCode(5,ReceiptHeader."Shortcut Dimension 5 Code");
                          GenJnlLine.ValidateShortcutDimCode(6,ReceiptHeader."Shortcut Dimension 6 Code");
                          GenJnlLine.ValidateShortcutDimCode(7,ReceiptHeader."Shortcut Dimension 7 Code");
                          GenJnlLine.ValidateShortcutDimCode(8,ReceiptHeader."Shortcut Dimension 8 Code");
                          GenJnlLine.Description:=CopyStr('VAT:' + Format(ReceiptLine."Account Type") + '::' + Format(ReceiptLine."Account Name"),1,50);
                          GenJnlLine.Text:=UpperCase(CopyStr("Receipt Header"."Received From",1,50));
                          if GenJnlLine.Amount<>0 then
                            GenJnlLine.Insert;
        
                          //VAT Balancing goes to Vendor
                          LineNo:=LineNo+1;
                          GenJnlLine.Init;
                          GenJnlLine."Journal Template Name":="Journal Template";
                         // GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                          GenJnlLine."Journal Batch Name":="Journal Batch";
                         // GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                          GenJnlLine."Line No.":=LineNo;
                          GenJnlLine."Source Code":=SourceCode;
                          GenJnlLine."Posting Date":=ReceiptHeader."Posting Date";
                          GenJnlLine."Document No.":=ReceiptLine."Document No";
                          GenJnlLine."Document Type":=GenJnlLine."document type"::"7";
                          GenJnlLine."External Document No.":=ReceiptHeader."Cheque No";
                          GenJnlLine."Account Type":=ReceiptLine."Account Type";
                          GenJnlLine."Account No.":=ReceiptLine."Account Code";
                          GenJnlLine.Validate(GenJnlLine."Account No.");
                          GenJnlLine."Currency Code":=ReceiptHeader."Currency Code";
                          GenJnlLine.Validate(GenJnlLine."Currency Code");
                          GenJnlLine."Currency Factor":=ReceiptHeader."Currency Factor";
                          GenJnlLine.Validate("Currency Factor");
                          GenJnlLine.Amount:=ReceiptLine."VAT Amount";   //Debit Amount
                          GenJnlLine.Validate(GenJnlLine.Amount);
                          GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                          GenJnlLine."Bal. Account No.":='';
                          GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                          GenJnlLine."Shortcut Dimension 1 Code":=ReceiptHeader."Global Dimension 1 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                          GenJnlLine."Shortcut Dimension 2 Code":=ReceiptHeader."Global Dimension 2 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                          GenJnlLine.ValidateShortcutDimCode(3,ReceiptHeader."Shortcut Dimension 3 Code");
                          GenJnlLine.ValidateShortcutDimCode(4,ReceiptHeader."Shortcut Dimension 4 Code");
                          GenJnlLine.ValidateShortcutDimCode(5,ReceiptHeader."Shortcut Dimension 5 Code");
                          GenJnlLine.ValidateShortcutDimCode(6,ReceiptHeader."Shortcut Dimension 6 Code");
                          GenJnlLine.ValidateShortcutDimCode(7,ReceiptHeader."Shortcut Dimension 7 Code");
                          GenJnlLine.ValidateShortcutDimCode(8,ReceiptHeader."Shortcut Dimension 8 Code");
                          GenJnlLine.Description:=CopyStr('VAT:' + Format(ReceiptLine."Account Type") + '::' + Format(ReceiptLine."Account Name"),1,50) ;
                          GenJnlLine.Text:=UpperCase(CopyStr("Receipt Header"."Received From",1,50));
                          /*GenJnlLine."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Invoice;
                          GenJnlLine."Applies-to Doc. No.":=PaymentLine."Applies-to Doc. No.";
                          GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                          GenJnlLine."Applies-to ID":=PaymentLine."Applies-to ID";*/
                          if GenJnlLine.Amount<>0 then
                             GenJnlLine.Insert;
        
                       end;
                     end;
                   //*************************************End Add VAT Amounts**************************************************************//
        
                   //****************************************Add W/TAX Amounts*************************************************************//
                     if ReceiptLine."W/TAX Code"<>'' then begin
                       TaxCodes.Reset;
                       TaxCodes.SetRange(TaxCodes."Tax Code",ReceiptLine."W/TAX Code");
                       if TaxCodes.FindFirst then begin
                          TaxCodes.TestField(TaxCodes."Account No");
                          LineNo:=LineNo+1;
                          GenJnlLine.Init;
                          GenJnlLine."Journal Template Name":="Journal Template";
                         // GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                          GenJnlLine."Journal Batch Name":="Journal Batch";
                         // GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                          GenJnlLine."Line No.":=LineNo;
                          GenJnlLine."Source Code":=SourceCode;
                          GenJnlLine."Posting Date":=ReceiptHeader."Posting Date";
                          GenJnlLine."Document No.":=ReceiptLine."Document No";
                          GenJnlLine."Document Type":=GenJnlLine."document type"::"7";
                          GenJnlLine."External Document No.":=ReceiptHeader."Cheque No";
                          GenJnlLine."Account Type":=TaxCodes."Account Type";
                          GenJnlLine."Account No.":=TaxCodes."Account No";
                          GenJnlLine.Validate(GenJnlLine."Account No.");
                          GenJnlLine."Currency Code":=ReceiptHeader."Currency Code";
                          GenJnlLine.Validate(GenJnlLine."Currency Code");
                          GenJnlLine."Currency Factor":=ReceiptHeader."Currency Factor";
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
                          GenJnlLine.Amount:=-(ReceiptLine."W/TAX Amount");   //Credit Amount
                          GenJnlLine.Validate(GenJnlLine.Amount);
                          GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                          GenJnlLine."Bal. Account No.":='';
                          GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                          GenJnlLine."Shortcut Dimension 1 Code":=ReceiptHeader."Global Dimension 1 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                          GenJnlLine."Shortcut Dimension 2 Code":=ReceiptHeader."Global Dimension 2 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                          GenJnlLine.ValidateShortcutDimCode(3,ReceiptHeader."Shortcut Dimension 3 Code");
                          GenJnlLine.ValidateShortcutDimCode(4,ReceiptHeader."Shortcut Dimension 4 Code");
                          GenJnlLine.ValidateShortcutDimCode(5,ReceiptHeader."Shortcut Dimension 5 Code");
                          GenJnlLine.ValidateShortcutDimCode(6,ReceiptHeader."Shortcut Dimension 6 Code");
                          GenJnlLine.ValidateShortcutDimCode(7,ReceiptHeader."Shortcut Dimension 7 Code");
                          GenJnlLine.ValidateShortcutDimCode(8,ReceiptHeader."Shortcut Dimension 8 Code");
                          GenJnlLine.Description:=CopyStr('W/TAX:' + Format(ReceiptLine."Account Type") + '::' + Format(ReceiptLine."Account Name"),1,50);
                          if GenJnlLine.Amount<>0 then
                            GenJnlLine.Insert;
        
                          //W/TAX Balancing goes to Vendor
                          LineNo:=LineNo+1;
                          GenJnlLine.Init;
                          GenJnlLine."Journal Template Name":="Journal Template";
                         // GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                          GenJnlLine."Journal Batch Name":="Journal Batch";
                         // GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                          GenJnlLine."Line No.":=LineNo;
                          GenJnlLine."Source Code":=SourceCode;
                          GenJnlLine."Posting Date":=ReceiptHeader."Posting Date";
                          GenJnlLine."Document No.":=ReceiptLine."Document No";
                          GenJnlLine."Document Type":=GenJnlLine."document type"::"7";
                          GenJnlLine."External Document No.":=ReceiptHeader."Cheque No";
                          GenJnlLine."Account Type":=ReceiptLine."Account Type";
                          GenJnlLine."Account No.":=ReceiptLine."Account Code";
                          GenJnlLine.Validate(GenJnlLine."Account No.");
                          GenJnlLine."Currency Code":=ReceiptHeader."Currency Code";
                          GenJnlLine.Validate(GenJnlLine."Currency Code");
                          GenJnlLine."Currency Factor":=ReceiptHeader."Currency Factor";
                          GenJnlLine.Validate("Currency Factor");
                          GenJnlLine.Amount:=ReceiptLine."W/TAX Amount";   //Debit Amount
                          GenJnlLine.Validate(GenJnlLine.Amount);
                          GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                          GenJnlLine."Bal. Account No.":='';
                          GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                          GenJnlLine."Shortcut Dimension 1 Code":=ReceiptHeader."Global Dimension 1 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                          GenJnlLine."Shortcut Dimension 2 Code":=ReceiptHeader."Global Dimension 2 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                          GenJnlLine.ValidateShortcutDimCode(3,ReceiptHeader."Shortcut Dimension 3 Code");
                          GenJnlLine.ValidateShortcutDimCode(4,ReceiptHeader."Shortcut Dimension 4 Code");
                          GenJnlLine.ValidateShortcutDimCode(5,ReceiptHeader."Shortcut Dimension 5 Code");
                          GenJnlLine.ValidateShortcutDimCode(6,ReceiptHeader."Shortcut Dimension 6 Code");
                          GenJnlLine.ValidateShortcutDimCode(7,ReceiptHeader."Shortcut Dimension 7 Code");
                          GenJnlLine.ValidateShortcutDimCode(8,ReceiptHeader."Shortcut Dimension 8 Code");
                          GenJnlLine.Description:=CopyStr('W/TAX:' + Format(ReceiptLine."Account Type") + '::' + Format(ReceiptLine."Account Name"),1,50);
        
                          /*GenJnlLine."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Invoice;
                          GenJnlLine."Applies-to Doc. No.":=PaymentLine."Applies-to Doc. No.";
                          GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                          GenJnlLine."Applies-to ID":=PaymentLine."Applies-to ID";*/
                          if GenJnlLine.Amount<>0 then
                             GenJnlLine.Insert;
        
                       end;
                     end;
        
                   //*************************************End Add W/TAX Amounts************************************************************//
        
                   //*************************************Add Retention Amounts************************************************************//
                   //***********************************End Add Retention Amounts**********************************************************//
        
        
                      until ReceiptLine.Next=0;
                   end;
        
            //*********************************************End Add Payment Lines************************************************************//
            Commit;
            //********************************************Post the Journal Lines************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name","Journal Template");
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name","Journal Batch");
            //Adjust GenJnlLine Exchange Rate Rounding Balances
               AdjustGenJnl.Run(GenJnlLine);
            //End Adjust GenJnlLine Exchange Rate Rounding Balances
        
            //Now Post the Journal Lines
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post",GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            BankLedgers.Reset;
            BankLedgers.SetRange(BankLedgers."Document No.",ReceiptHeader."No.");
            if BankLedgers.FindFirst then begin
              ReceiptHeader2.Reset;
              ReceiptHeader2.SetRange(ReceiptHeader2."No.",ReceiptHeader."No.");
              if ReceiptHeader2.FindFirst then begin
                ReceiptHeader2.Status:=ReceiptHeader2.Status::Posted;
                ReceiptHeader2.Posted:=true;
                ReceiptHeader2."Posted By":=UserId;
                ReceiptHeader2."Date Posted":=Today;
                ReceiptHeader2."Time Posted":=Time;
                ReceiptHeader2.Modify;
                ReceiptLine2.Reset;
                ReceiptLine2.SetRange(ReceiptLine2."Document No",ReceiptHeader2."No.");
                if ReceiptLine2.FindSet then begin
                  repeat
                      ReceiptLine2.Status:=ReceiptLine2.Status::Posted;
                      ReceiptLine2.Posted:=true;
                      ReceiptLine2."Posted By":=UserId;
                      ReceiptLine2."Date Posted":=Today;
                      ReceiptLine2."Time Posted":=Time;
                      ReceiptLine2.Modify;
                  until ReceiptLine2.Next=0;
                end;
              end;
            end;
        
            //***********************************************End Update Document************************************************************//

    end;


    procedure ReverseReceipt("Receipt Header": Record "Receipt Header";"Journal Template": Code[20];"Journal Batch": Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        ReceiptLine: Record "Receipt Line";
        ReceiptHeader: Record "Receipt Header";
        SourceCode: Code[20];
        BankLedgers: Record "Bank Account Ledger Entry";
        ReceiptLine2: Record "Receipt Line";
        ReceiptHeader2: Record "Receipt Header";
    begin
            ReceiptHeader.TransferFields("Receipt Header",true);
            SourceCode:='RECEIPTJNL';
        
            //Delete Journal Lines if Exist
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name","Journal Template");
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name","Journal Batch");
            if GenJnlLine.FindSet then begin
              GenJnlLine.DeleteAll;
            end;
            //End Delete
        
            LineNo:=1000;
            //********************************************Add to Bank(Payment Header)*******************************************************//
            ReceiptHeader.CalcFields(ReceiptHeader."Total Amount");
            GenJnlLine.Init;
            GenJnlLine."Journal Template Name":="Journal Template";
            GenJnlLine.Validate(GenJnlLine."Journal Template Name");
            GenJnlLine."Journal Batch Name":="Journal Batch";
            GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
            GenJnlLine."Line No.":=LineNo;
            GenJnlLine."Source Code":=SourceCode;
            GenJnlLine."Posting Date":=ReceiptHeader."Posting Date";
            //IF CustomerLinesExist(ReceiptHeader) THEN
              //GenJnlLine."Document Type":=GenJnlLine."Document Type"::" "
            //ELSE
              //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
            GenJnlLine."Document No.":=ReceiptHeader."No.";
            GenJnlLine."Document Type":=GenJnlLine."document type"::"7";
            GenJnlLine."External Document No.":=ReceiptHeader."Cheque No";
            GenJnlLine."Account Type":=GenJnlLine."account type"::"Bank Account";
            GenJnlLine."Account No.":=ReceiptHeader."Bank Code";
            GenJnlLine.Validate(GenJnlLine."Account No.");
            GenJnlLine."Currency Code":=ReceiptHeader."Currency Code";
            GenJnlLine.Validate(GenJnlLine."Currency Code");
            GenJnlLine."Currency Factor":=ReceiptHeader."Currency Factor";
            GenJnlLine.Validate("Currency Factor");
            GenJnlLine.Amount:=ReceiptHeader."Total Amount";  //Debit Amount
            GenJnlLine.Validate(GenJnlLine.Amount);
            GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
            GenJnlLine."Bal. Account No.":='';
            GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
            GenJnlLine."Shortcut Dimension 1 Code":=ReceiptHeader."Global Dimension 1 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
            GenJnlLine."Shortcut Dimension 2 Code":=ReceiptHeader."Global Dimension 2 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
            GenJnlLine.ValidateShortcutDimCode(3,ReceiptHeader."Shortcut Dimension 3 Code");
            GenJnlLine.ValidateShortcutDimCode(4,ReceiptHeader."Shortcut Dimension 4 Code");
            GenJnlLine.ValidateShortcutDimCode(5,ReceiptHeader."Shortcut Dimension 5 Code");
            GenJnlLine.ValidateShortcutDimCode(6,ReceiptHeader."Shortcut Dimension 6 Code");
            GenJnlLine.ValidateShortcutDimCode(7,ReceiptHeader."Shortcut Dimension 7 Code");
            GenJnlLine.ValidateShortcutDimCode(8,ReceiptHeader."Shortcut Dimension 8 Code");
            GenJnlLine.Description:=CopyStr(ReceiptHeader.Description,1,50);
            GenJnlLine.Text:=UpperCase(CopyStr("Receipt Header"."Received From",1,50));
            GenJnlLine.Validate(GenJnlLine.Description);
            if GenJnlLine.Amount<>0 then
               GenJnlLine.Insert;
            //************************************************End Add to Bank***************************************************************//
        
            //***********************************************Add Receipt Lines**************************************************************//
                   ReceiptLine.Reset;
                   ReceiptLine.SetRange(ReceiptLine."Document No",ReceiptHeader."No.");
                   ReceiptLine.SetFilter(ReceiptLine.Amount,'<>%1',0);
                   if ReceiptLine.FindSet then begin
                     repeat
                    //****************************************Add Line NetAmounts***********************************************************//
                        LineNo:=LineNo+1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name":="Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name":="Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Source Code":=SourceCode;
                        GenJnlLine."Line No.":=LineNo;
                        GenJnlLine."Posting Date":=ReceiptHeader."Posting Date";
                        GenJnlLine."Document No.":=ReceiptLine."Document No";
                        GenJnlLine."Document Type":=GenJnlLine."document type"::"7";
                        GenJnlLine."Account Type":=ReceiptLine."Account Type";
                        GenJnlLine."Account No.":=ReceiptLine."Account Code";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."External Document No.":=ReceiptHeader."Cheque No";
                        GenJnlLine."Currency Code":=ReceiptHeader."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine."Currency Factor":=ReceiptHeader."Currency Factor";
                        GenJnlLine.Validate("Currency Factor");
                        GenJnlLine.Amount:=-(ReceiptLine.Amount);  //Credit Amount
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                        GenJnlLine."Bal. Account No.":='';
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Gen. Bus. Posting Group":=ReceiptLine."Gen. Bus. Posting Group";
                        GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group":=ReceiptLine."Gen. Prod. Posting Group";
                        GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group":=ReceiptLine."VAT Bus. Posting Group";
                        GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group":=ReceiptLine."VAT Prod. Posting Group";
                        GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                        GenJnlLine."Shortcut Dimension 1 Code":=ReceiptHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code":=ReceiptHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3,ReceiptHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4,ReceiptHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5,ReceiptHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6,ReceiptHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7,ReceiptHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8,ReceiptHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description:=CopyStr(ReceiptHeader.Description,1,50);
                        GenJnlLine.Text:=UpperCase(CopyStr("Receipt Header"."Received From",1,50));
                        GenJnlLine.Validate(GenJnlLine.Description);
                        /*GenJnlLine."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Invoice;
                        GenJnlLine."Applies-to Doc. No.":=PaymentLine."Applies-to Doc. No.";
                        GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                        GenJnlLine."Applies-to ID":=PaymentLine."Applies-to ID"; */
        
                        if GenJnlLine.Amount<>0 then
                           GenJnlLine.Insert;
                   //*************************************End add Line NetAmounts**********************************************************//
        
                   //****************************************Add VAT Amounts***************************************************************//
                     if ReceiptLine."VAT Code"<>'' then begin
                       TaxCodes.Reset;
                       TaxCodes.SetRange(TaxCodes."Tax Code",ReceiptLine."VAT Code");
                       if TaxCodes.FindFirst then begin
                          TaxCodes.TestField(TaxCodes."Account No");
                          LineNo:=LineNo+1;
                          GenJnlLine.Init;
                          GenJnlLine."Journal Template Name":="Journal Template";
                          GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                          GenJnlLine."Journal Batch Name":="Journal Batch";
                          GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                          GenJnlLine."Line No.":=LineNo;
                          GenJnlLine."Source Code":=SourceCode;
                          GenJnlLine."Posting Date":=ReceiptHeader."Posting Date";
                          GenJnlLine."Document No.":=ReceiptLine."Document No";
                          GenJnlLine."Document Type":=GenJnlLine."document type"::"7";
                          GenJnlLine."External Document No.":=ReceiptHeader."Cheque No";
                          GenJnlLine."Account Type":=TaxCodes."Account Type";
                          GenJnlLine."Account No.":=TaxCodes."Account No";
                          GenJnlLine.Validate(GenJnlLine."Account No.");
                          GenJnlLine."Currency Code":=ReceiptHeader."Currency Code";
                          GenJnlLine.Validate(GenJnlLine."Currency Code");
                          GenJnlLine."Currency Factor":=ReceiptHeader."Currency Factor";
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
                          GenJnlLine.Amount:=-(ReceiptLine."VAT Amount");   //Credit Amount
                          GenJnlLine.Validate(GenJnlLine.Amount);
                          GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                          GenJnlLine."Bal. Account No.":='';
                          GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                          GenJnlLine."Shortcut Dimension 1 Code":=ReceiptHeader."Global Dimension 1 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                          GenJnlLine."Shortcut Dimension 2 Code":=ReceiptHeader."Global Dimension 2 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                          GenJnlLine.ValidateShortcutDimCode(3,ReceiptHeader."Shortcut Dimension 3 Code");
                          GenJnlLine.ValidateShortcutDimCode(4,ReceiptHeader."Shortcut Dimension 4 Code");
                          GenJnlLine.ValidateShortcutDimCode(5,ReceiptHeader."Shortcut Dimension 5 Code");
                          GenJnlLine.ValidateShortcutDimCode(6,ReceiptHeader."Shortcut Dimension 6 Code");
                          GenJnlLine.ValidateShortcutDimCode(7,ReceiptHeader."Shortcut Dimension 7 Code");
                          GenJnlLine.ValidateShortcutDimCode(8,ReceiptHeader."Shortcut Dimension 8 Code");
                          GenJnlLine.Description:=CopyStr('VAT:' + Format(ReceiptLine."Account Type") + '::' + Format(ReceiptLine."Account Name"),1,50);
                          GenJnlLine.Text:=UpperCase(CopyStr("Receipt Header"."Received From",1,50));
                          if GenJnlLine.Amount<>0 then
                            GenJnlLine.Insert;
        
                          //VAT Balancing goes to Vendor
                          LineNo:=LineNo+1;
                          GenJnlLine.Init;
                          GenJnlLine."Journal Template Name":="Journal Template";
                          GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                          GenJnlLine."Journal Batch Name":="Journal Batch";
                          GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                          GenJnlLine."Line No.":=LineNo;
                          GenJnlLine."Source Code":=SourceCode;
                          GenJnlLine."Posting Date":=ReceiptHeader."Posting Date";
                          GenJnlLine."Document No.":=ReceiptLine."Document No";
                          GenJnlLine."Document Type":=GenJnlLine."document type"::"7";
                          GenJnlLine."External Document No.":=ReceiptHeader."Cheque No";
                          GenJnlLine."Account Type":=ReceiptLine."Account Type";
                          GenJnlLine."Account No.":=ReceiptLine."Account Code";
                          GenJnlLine.Validate(GenJnlLine."Account No.");
                          GenJnlLine."Currency Code":=ReceiptHeader."Currency Code";
                          GenJnlLine.Validate(GenJnlLine."Currency Code");
                          GenJnlLine."Currency Factor":=ReceiptHeader."Currency Factor";
                          GenJnlLine.Validate("Currency Factor");
                          GenJnlLine.Amount:=ReceiptLine."VAT Amount";   //Debit Amount
                          GenJnlLine.Validate(GenJnlLine.Amount);
                          GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                          GenJnlLine."Bal. Account No.":='';
                          GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                          GenJnlLine."Shortcut Dimension 1 Code":=ReceiptHeader."Global Dimension 1 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                          GenJnlLine."Shortcut Dimension 2 Code":=ReceiptHeader."Global Dimension 2 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                          GenJnlLine.ValidateShortcutDimCode(3,ReceiptHeader."Shortcut Dimension 3 Code");
                          GenJnlLine.ValidateShortcutDimCode(4,ReceiptHeader."Shortcut Dimension 4 Code");
                          GenJnlLine.ValidateShortcutDimCode(5,ReceiptHeader."Shortcut Dimension 5 Code");
                          GenJnlLine.ValidateShortcutDimCode(6,ReceiptHeader."Shortcut Dimension 6 Code");
                          GenJnlLine.ValidateShortcutDimCode(7,ReceiptHeader."Shortcut Dimension 7 Code");
                          GenJnlLine.ValidateShortcutDimCode(8,ReceiptHeader."Shortcut Dimension 8 Code");
                          GenJnlLine.Description:=CopyStr('VAT:' + Format(ReceiptLine."Account Type") + '::' + Format(ReceiptLine."Account Name"),1,50) ;
                          GenJnlLine.Text:=UpperCase(CopyStr("Receipt Header"."Received From",1,50));
                          /*GenJnlLine."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Invoice;
                          GenJnlLine."Applies-to Doc. No.":=PaymentLine."Applies-to Doc. No.";
                          GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                          GenJnlLine."Applies-to ID":=PaymentLine."Applies-to ID";*/
                          if GenJnlLine.Amount<>0 then
                             GenJnlLine.Insert;
        
                       end;
                     end;
                   //*************************************End Add VAT Amounts**************************************************************//
        
                   //****************************************Add W/TAX Amounts*************************************************************//
                     if ReceiptLine."W/TAX Code"<>'' then begin
                       TaxCodes.Reset;
                       TaxCodes.SetRange(TaxCodes."Tax Code",ReceiptLine."W/TAX Code");
                       if TaxCodes.FindFirst then begin
                          TaxCodes.TestField(TaxCodes."Account No");
                          LineNo:=LineNo+1;
                          GenJnlLine.Init;
                          GenJnlLine."Journal Template Name":="Journal Template";
                          GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                          GenJnlLine."Journal Batch Name":="Journal Batch";
                          GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                          GenJnlLine."Line No.":=LineNo;
                          GenJnlLine."Source Code":=SourceCode;
                          GenJnlLine."Posting Date":=ReceiptHeader."Posting Date";
                          GenJnlLine."Document No.":=ReceiptLine."Document No";
                          GenJnlLine."Document Type":=GenJnlLine."document type"::"7";
                          GenJnlLine."External Document No.":=ReceiptHeader."Cheque No";
                          GenJnlLine."Account Type":=TaxCodes."Account Type";
                          GenJnlLine."Account No.":=TaxCodes."Account No";
                          GenJnlLine.Validate(GenJnlLine."Account No.");
                          GenJnlLine."Currency Code":=ReceiptHeader."Currency Code";
                          GenJnlLine.Validate(GenJnlLine."Currency Code");
                          GenJnlLine."Currency Factor":=ReceiptHeader."Currency Factor";
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
                          GenJnlLine.Amount:=-(ReceiptLine."W/TAX Amount");   //Credit Amount
                          GenJnlLine.Validate(GenJnlLine.Amount);
                          GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                          GenJnlLine."Bal. Account No.":='';
                          GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                          GenJnlLine."Shortcut Dimension 1 Code":=ReceiptHeader."Global Dimension 1 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                          GenJnlLine."Shortcut Dimension 2 Code":=ReceiptHeader."Global Dimension 2 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                          GenJnlLine.ValidateShortcutDimCode(3,ReceiptHeader."Shortcut Dimension 3 Code");
                          GenJnlLine.ValidateShortcutDimCode(4,ReceiptHeader."Shortcut Dimension 4 Code");
                          GenJnlLine.ValidateShortcutDimCode(5,ReceiptHeader."Shortcut Dimension 5 Code");
                          GenJnlLine.ValidateShortcutDimCode(6,ReceiptHeader."Shortcut Dimension 6 Code");
                          GenJnlLine.ValidateShortcutDimCode(7,ReceiptHeader."Shortcut Dimension 7 Code");
                          GenJnlLine.ValidateShortcutDimCode(8,ReceiptHeader."Shortcut Dimension 8 Code");
                          GenJnlLine.Description:=CopyStr('W/TAX:' + Format(ReceiptLine."Account Type") + '::' + Format(ReceiptLine."Account Name"),1,50);
                          if GenJnlLine.Amount<>0 then
                            GenJnlLine.Insert;
        
                          //W/TAX Balancing goes to Vendor
                          LineNo:=LineNo+1;
                          GenJnlLine.Init;
                          GenJnlLine."Journal Template Name":="Journal Template";
                          GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                          GenJnlLine."Journal Batch Name":="Journal Batch";
                          GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                          GenJnlLine."Line No.":=LineNo;
                          GenJnlLine."Source Code":=SourceCode;
                          GenJnlLine."Posting Date":=ReceiptHeader."Posting Date";
                          GenJnlLine."Document No.":=ReceiptLine."Document No";
                          GenJnlLine."Document Type":=GenJnlLine."document type"::"7";
                          GenJnlLine."External Document No.":=ReceiptHeader."Cheque No";
                          GenJnlLine."Account Type":=ReceiptLine."Account Type";
                          GenJnlLine."Account No.":=ReceiptLine."Account Code";
                          GenJnlLine.Validate(GenJnlLine."Account No.");
                          GenJnlLine."Currency Code":=ReceiptHeader."Currency Code";
                          GenJnlLine.Validate(GenJnlLine."Currency Code");
                          GenJnlLine."Currency Factor":=ReceiptHeader."Currency Factor";
                          GenJnlLine.Validate("Currency Factor");
                          GenJnlLine.Amount:=ReceiptLine."W/TAX Amount";   //Debit Amount
                          GenJnlLine.Validate(GenJnlLine.Amount);
                          GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                          GenJnlLine."Bal. Account No.":='';
                          GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                          GenJnlLine."Shortcut Dimension 1 Code":=ReceiptHeader."Global Dimension 1 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                          GenJnlLine."Shortcut Dimension 2 Code":=ReceiptHeader."Global Dimension 2 Code";
                          GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                          GenJnlLine.ValidateShortcutDimCode(3,ReceiptHeader."Shortcut Dimension 3 Code");
                          GenJnlLine.ValidateShortcutDimCode(4,ReceiptHeader."Shortcut Dimension 4 Code");
                          GenJnlLine.ValidateShortcutDimCode(5,ReceiptHeader."Shortcut Dimension 5 Code");
                          GenJnlLine.ValidateShortcutDimCode(6,ReceiptHeader."Shortcut Dimension 6 Code");
                          GenJnlLine.ValidateShortcutDimCode(7,ReceiptHeader."Shortcut Dimension 7 Code");
                          GenJnlLine.ValidateShortcutDimCode(8,ReceiptHeader."Shortcut Dimension 8 Code");
                          GenJnlLine.Description:=CopyStr('W/TAX:' + Format(ReceiptLine."Account Type") + '::' + Format(ReceiptLine."Account Name"),1,50);
        
                          /*GenJnlLine."Applies-to Doc. Type":=GenJnlLine."Applies-to Doc. Type"::Invoice;
                          GenJnlLine."Applies-to Doc. No.":=PaymentLine."Applies-to Doc. No.";
                          GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                          GenJnlLine."Applies-to ID":=PaymentLine."Applies-to ID";*/
                          if GenJnlLine.Amount<>0 then
                             GenJnlLine.Insert;
        
                       end;
                     end;
        
                   //*************************************End Add W/TAX Amounts************************************************************//
        
                   //*************************************Add Retention Amounts************************************************************//
                   //***********************************End Add Retention Amounts**********************************************************//
        
        
                      until ReceiptLine.Next=0;
                   end;
        
            //*********************************************End Add Payment Lines************************************************************//
            Commit;
            //********************************************Post the Journal Lines************************************************************//
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name","Journal Template");
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name","Journal Batch");
            //Adjust GenJnlLine Exchange Rate Rounding Balances
               AdjustGenJnl.Run(GenJnlLine);
            //End Adjust GenJnlLine Exchange Rate Rounding Balances
        
            //Now Post the Journal Lines
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post",GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            BankLedgers.Reset;
            BankLedgers.SetRange(BankLedgers."Document No.",ReceiptHeader."No.");
            if BankLedgers.FindFirst then begin
              ReceiptHeader2.Reset;
              ReceiptHeader2.SetRange(ReceiptHeader2."No.",ReceiptHeader."No.");
              if ReceiptHeader2.FindFirst then begin
                ReceiptHeader2.Status:=ReceiptHeader2.Status::Posted;
                ReceiptHeader2.Posted:=true;
                ReceiptHeader2."Posted By":=UserId;
                ReceiptHeader2."Date Posted":=Today;
                ReceiptHeader2."Time Posted":=Time;
                ReceiptHeader2.Modify;
                ReceiptLine2.Reset;
                ReceiptLine2.SetRange(ReceiptLine2."Document No",ReceiptHeader2."No.");
                if ReceiptLine2.FindSet then begin
                  repeat
                      ReceiptLine2.Status:=ReceiptLine2.Status::Posted;
                      ReceiptLine2.Posted:=true;
                      ReceiptLine2."Posted By":=UserId;
                      ReceiptLine2."Date Posted":=Today;
                      ReceiptLine2."Time Posted":=Time;
                      ReceiptLine2.Modify;
                  until ReceiptLine2.Next=0;
                end;
              end;
            end;
        
            //***********************************************End Update Document************************************************************//

    end;


    procedure PostMemberReceipt("Receipt Header": Record "Receipt Header";"Journal Template": Code[20];"Journal Batch": Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        ReceiptLine: Record "Receipt Line";
        ReceiptHeader: Record "Receipt Header";
        SourceCode: Code[20];
        BankLedgers: Record "Bank Account Ledger Entry";
        ReceiptLine2: Record "Receipt Line";
        ReceiptHeader2: Record "Receipt Header";
        BankAccount: Record "Bank Account";
        BankAmount: Decimal;
    begin
        ReceiptHeader.TransferFields("Receipt Header",true);
        SourceCode:='RECEIPTJNL';
        //Delete Journal Lines if Exist
        GenJnlLine.Reset;
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name","Journal Template");
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name","Journal Batch");
        if GenJnlLine.FindSet then begin
           GenJnlLine.DeleteAll;
        end;
        //End Delete

        LineNo:=1000;
        ReceiptLine.Reset;
        ReceiptLine.SetRange(ReceiptLine."Document No",ReceiptHeader."No.");
        ReceiptLine.SetFilter(ReceiptLine.Amount,'<>%1',0);
        if ReceiptLine.FindSet then begin
          repeat
             LineNo:=LineNo+1;
             GenJnlLine.Init;
             GenJnlLine."Journal Template Name":="Journal Template";
             GenJnlLine.Validate(GenJnlLine."Journal Template Name");
             GenJnlLine."Journal Batch Name":="Journal Batch";
             GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
             GenJnlLine."Line No.":=LineNo;
             GenJnlLine."Source Code":=SourceCode;
             GenJnlLine."Posting Date":=ReceiptHeader."Posting Date";
             //IF CustomerLinesExist(PaymentHeader) THEN
               //GenJnlLine."Document Type":=GenJnlLine."Document Type"::" "
             //ELSE
                //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Payment;
             //GenJnlLine."Document Type":=GenJnlLine."Document Type"::Receipt;
             GenJnlLine."Document No.":=ReceiptHeader."No.";
             GenJnlLine."External Document No.":=ReceiptLine."Cheque No";
             GenJnlLine."Account Type":=GenJnlLine."account type"::"Bank Account";
             GenJnlLine."Account No.":=ReceiptLine."Bank Code";
             GenJnlLine.Validate(GenJnlLine."Account No.");
             GenJnlLine."Currency Code":=ReceiptHeader."Currency Code";
             GenJnlLine.Validate(GenJnlLine."Currency Code");
             GenJnlLine."Currency Factor":=ReceiptHeader."Currency Factor";
             GenJnlLine.Validate("Currency Factor");
             GenJnlLine.Amount:=ReceiptLine.Amount;  //Debit Amount
             GenJnlLine.Validate(GenJnlLine.Amount);
             GenJnlLine."Bal. Account Type":=ReceiptLine."Account Type";
             GenJnlLine."Bal. Account No.":=ReceiptLine."Account Code";
             GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
             GenJnlLine."Shortcut Dimension 1 Code":=ReceiptLine."Global Dimension 1 Code";
             GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
             GenJnlLine."Shortcut Dimension 2 Code":=ReceiptLine."Global Dimension 2 Code";
             GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
             GenJnlLine.ValidateShortcutDimCode(3,ReceiptLine."Shortcut Dimension 3 Code");
             GenJnlLine.ValidateShortcutDimCode(4,ReceiptLine."Shortcut Dimension 4 Code");
             GenJnlLine.ValidateShortcutDimCode(5,ReceiptLine."Shortcut Dimension 5 Code");
             GenJnlLine.ValidateShortcutDimCode(6,ReceiptLine."Shortcut Dimension 6 Code");
             GenJnlLine.ValidateShortcutDimCode(7,ReceiptLine."Shortcut Dimension 7 Code");
             GenJnlLine.ValidateShortcutDimCode(8,ReceiptLine."Shortcut Dimension 8 Code");
             GenJnlLine.Description:=CopyStr(ReceiptLine.Description,1,50);
             GenJnlLine.Text:=UpperCase(CopyStr("Receipt Header"."Received From",1,50));
             GenJnlLine.Validate(GenJnlLine.Description);
             if GenJnlLine.Amount<>0 then
                 GenJnlLine.Insert;

          until ReceiptLine.Next=0;
            //Now Post the Journal Lines
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post",GenJnlLine);
            //***************************************************End Posting****************************************************************//
            Commit;
            //*************************************************Update Document**************************************************************//
            BankLedgers.Reset;
            BankLedgers.SetRange(BankLedgers."Document No.",ReceiptHeader."No.");
            if BankLedgers.FindFirst then begin
              ReceiptHeader2.Reset;
              ReceiptHeader2.SetRange(ReceiptHeader2."No.",ReceiptHeader."No.");
              if ReceiptHeader2.FindFirst then begin
                ReceiptHeader2.Status:=ReceiptHeader2.Status::Posted;
                ReceiptHeader2.Posted:=true;
                ReceiptHeader2."Posted By":=UserId;
                ReceiptHeader2."Date Posted":=Today;
                ReceiptHeader2."Time Posted":=Time;
                ReceiptHeader2.Modify;

                ReceiptLine2.Reset;
                ReceiptLine2.SetRange(ReceiptLine2."Document No",ReceiptHeader2."No.");
                if ReceiptLine2.FindSet then begin
                  repeat
                      ReceiptLine2.Status:=ReceiptLine2.Status::Posted;
                      ReceiptLine2.Posted:=true;
                      ReceiptLine2."Posted By":=UserId;
                      ReceiptLine2."Date Posted":=Today;
                      ReceiptLine2."Time Posted":=Time;
                      ReceiptLine2.Modify;
                      UpdateBankStmt(ReceiptLine2."Cheque No",ReceiptHeader2."Posting Date",ReceiptHeader2."No.");
                      if ReceiptHeader2."Receipt Category"=ReceiptHeader2."receipt category"::"1" then
                        UpdateApplicant(ReceiptLine2."Applicant No",ReceiptHeader2."No.");

                      if (ReceiptHeader2."Receipt Category"=ReceiptHeader2."receipt category"::"2") or (ReceiptHeader2."Receipt Category"=ReceiptHeader2."receipt category"::"3")  then
                        UpdateMemberYears(ReceiptLine2."Account Code",ReceiptLine2."Fee Type",ReceiptLine2."Fee SubType",
                        ReceiptLine2."Fee Description",ReceiptLine2."From Year",ReceiptLine2.ToYear,ReceiptHeader2.Date);
                  until ReceiptLine2.Next=0;
                end;
              end;
            end;

            //***********************************************End Update Document************************************************************//

        end;
    end;


    procedure ReverseMemberReceipt("Receipt Header": Record "Receipt Header";"Journal Template": Code[20];"Journal Batch": Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        ReceiptLine: Record "Receipt Line";
        ReceiptHeader: Record "Receipt Header";
        SourceCode: Code[20];
        BankLedgers: Record "Bank Account Ledger Entry";
        ReceiptLine2: Record "Receipt Line";
        ReceiptHeader2: Record "Receipt Header";
        BankAccount: Record "Bank Account";
        BankAmount: Decimal;
    begin
        ReceiptHeader.TransferFields("Receipt Header",true);
        ReceiptHeader2.Reset;
        ReceiptHeader2.SetRange(ReceiptHeader2."No.",ReceiptHeader."No.");
        if ReceiptHeader2.FindFirst then begin
            ReceiptHeader2.TestField(ReceiptHeader2.Posted,true);
            ReceiptHeader2.TestField(ReceiptHeader2.Reversed,false);
            //Start Reverse
            GLEntry.Reset;
            GLEntry.SetRange(GLEntry."Document No.",ReceiptHeader2."No.");
            if GLEntry.FindFirst then begin
              Clear(ReversalEntry);
              if GLEntry.Reversed then
                ReversalEntry.AlreadyReversedEntry(GLEntry.TableCaption,GLEntry."Entry No.");
              if GLEntry."Journal Batch Name" = '' then
                ReversalEntry.TestFieldError;
              GLEntry.TestField(GLEntry."Transaction No.");
              ReversalEntry.SetHideDialog(true);
              ReversalEntry.ReverseTransaction(GLEntry."Transaction No.");
            end else begin
              exit;
            end;
            //End Reverse
            if ReceiptHeader."Receipt Category"=ReceiptHeader."receipt category"::"1" then
                ReverseApplicantUpdate(ReceiptHeader."Account No",ReceiptHeader."No.");
            //Update Header as Reversed
            ReceiptHeader2.Reversed:=true;
            ReceiptHeader2."Reversed By":=UserId;
            ReceiptHeader2."Reversal Date":=Today;
            ReceiptHeader2."Reversal Time":=Time;
            ReceiptHeader2.Modify;

            ReceiptLine.Reset;
            ReceiptLine.SetRange(ReceiptLine."Document No",ReceiptHeader."No.");
            if ReceiptLine.FindSet then begin
             repeat
               ReceiptLine.Reversed:=true;
               ReceiptLine."Reversed By":=UserId;
               ReceiptLine."Reversal Date":=Today;
               ReceiptLine."Reversal Time":=Time;
               ReceiptLine.Modify;
               ReverseBankStmtUpdate(ReceiptLine."Cheque No",ReceiptHeader2."Posting Date",ReceiptHeader2."No.");
               if ReceiptHeader2."Receipt Category"=ReceiptHeader2."receipt category"::"2" then
                  ReverseMemberYears(ReceiptHeader2."Account No",ReceiptLine."Fee Type",ReceiptLine."Fee SubType",
                                     ReceiptLine."Fee Description",ReceiptLine."From Year",ReceiptLine.ToYear);
              until ReceiptLine.Next=0;
            end;
        end;
        //***********************************************End Update Document************************************************************//
    end;


    procedure UpdateMemberYears(MemberNo: Code[20];"Fee Type": Code[50];"Fee SubType": Code[50];Description: Code[50];"From Year": Integer;"To Year": Integer;DatePaid: Date)
    begin
          /*MemberFees.RESET;
          MemberFees.SETRANGE(MemberFees."Member No.",MemberNo);
          MemberFees.SETRANGE(MemberFees."Fee Type","Fee Type");
          MemberFees.SETRANGE(MemberFees."Fee Subtype","Fee SubType");
          MemberFees.SETRANGE(MemberFees.Description, Description);
          IF MemberFees.FINDFIRST THEN BEGIN
            MemberFees."Year Last Paid":="To Year";
            MemberFees."Date Paid":=DatePaid;
            MemberFees.MODIFY;
          END;
          */

    end;

    local procedure ReverseMemberYears(MemberNo: Code[20];"Fee Type": Code[50];"Fee SubType": Code[50];Description: Code[50];"From Year": Integer;"To Year": Integer)
    begin
          /*MemberFees.RESET;
          MemberFees.SETRANGE(MemberFees."Member No.",MemberNo);
          MemberFees.SETRANGE(MemberFees."Fee Type","Fee Type");
          MemberFees.SETRANGE(MemberFees."Fee Subtype","Fee SubType");
          MemberFees.SETRANGE(MemberFees.Description, Description);
          IF MemberFees.FINDFIRST THEN BEGIN
           IF MemberFees."Year Last Paid"<="To Year" THEN BEGIN
              MemberFees."Year Last Paid":="From Year";
              MemberFees.MODIFY;
              MESSAGE('Member Fees Reversed Successfully');
           END;
          END;
          */

    end;

    local procedure UpdateBankStmt(RefNo: Code[20];"Posting Date": Date;ReceiptNo: Code[20])
    var
        ImportedStmt: Record "Imported Bank Statement";
    begin
          ImportedStmt.Reset;
          ImportedStmt.SetRange(ImportedStmt."Reference No",RefNo);
          if ImportedStmt.FindFirst then begin
             ImportedStmt.Receipted:=true;
             ImportedStmt.ReceiptNo:=ReceiptNo;
             ImportedStmt."Receipting Date":="Posting Date";
             ImportedStmt.Modify;
          end;
    end;

    local procedure ReverseBankStmtUpdate(RefNo: Code[20];"Posting Date": Date;ReceiptNo: Code[20])
    var
        ImportedStmt: Record "Imported Bank Statement";
    begin
          ImportedStmt.Reset;
          ImportedStmt.SetRange(ImportedStmt."Reference No",RefNo);
          if ImportedStmt.FindFirst then begin
             ImportedStmt.Receipted:=false;
             ImportedStmt.ReceiptNo:='';
             ImportedStmt."Receipting Date":=0D;
             ImportedStmt.Modify;
          end;
    end;

    local procedure UpdateApplicant("Applicant No": Code[20];ReceiptNo: Code[20])
    begin
         /* MemberApplication.RESET;
          MemberApplication.SETRANGE(MemberApplication."No.","Applicant No");
          IF MemberApplication.FINDFIRST THEN BEGIN
            IF NOT MemberApplication.Receipted THEN BEGIN
              MemberApplication.Receipted:=TRUE;
              MemberApplication."Receipt No":=ReceiptNo;
              MemberApplication.MODIFY;
            END;
          END;
          */

    end;

    local procedure ReverseApplicantUpdate("Applicant No": Code[20];ReceiptNo: Code[20])
    begin
          /*MemberApplication.RESET;
          MemberApplication.SETRANGE(MemberApplication."No.","Applicant No");
          IF MemberApplication.FINDFIRST THEN BEGIN
            MemberApplication.Receipted:=FALSE;
            MemberApplication."Receipt No":='';
            MemberApplication.MODIFY;
          END;
          */

    end;


    procedure PostFundsTransfer("Funds Transfer Header": Record "Funds Transfer Header";"Journal Template": Code[20];"Journal Batch": Code[20])
    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        FundsLine: Record "Funds Transfer Line";
        FundsHeader: Record "Funds Transfer Header";
        SourceCode: Code[20];
        BankLedgers: Record "Bank Account Ledger Entry";
        FundsLine2: Record "Funds Transfer Line";
        FundsHeader2: Record "Funds Transfer Header";
    begin
            FundsHeader.TransferFields("Funds Transfer Header",true);
            SourceCode:='TRANSJNL';

            //Delete Journal Lines if Exist
            GenJnlLine.Reset;
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name","Journal Template");
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name","Journal Batch");
            if GenJnlLine.FindSet then begin
              GenJnlLine.DeleteAll;
            end;
            //End Delete

            LineNo:=1000;
            //********************************************Add to Bank(Payment Header)*******************************************************//
            FundsHeader.CalcFields(FundsHeader."Total Line Amount");
            GenJnlLine.Init;
            GenJnlLine."Journal Template Name":="Journal Template";
            GenJnlLine.Validate(GenJnlLine."Journal Template Name");
            GenJnlLine."Journal Batch Name":="Journal Batch";
            GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
            GenJnlLine."Line No.":=LineNo;
            GenJnlLine."Source Code":=SourceCode;
            GenJnlLine."Posting Date":=FundsHeader."Posting Date";
            GenJnlLine."Document No.":=FundsHeader."No.";
            GenJnlLine."External Document No.":=FundsHeader."Cheque/Doc. No";
            GenJnlLine."Account Type":=GenJnlLine."account type"::"Bank Account";
            GenJnlLine."Account No.":=FundsHeader."Paying Bank Account";
            GenJnlLine.Validate(GenJnlLine."Account No.");
            GenJnlLine."Currency Code":=FundsHeader."Currency Code";
            GenJnlLine.Validate(GenJnlLine."Currency Code");
            GenJnlLine."Currency Factor":=FundsHeader."Currency Factor";
            GenJnlLine.Validate("Currency Factor");
            GenJnlLine.Amount:=-(FundsHeader."Total Line Amount");  //Credit Amount
            GenJnlLine.Validate(GenJnlLine.Amount);
            GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
            GenJnlLine."Bal. Account No.":='';
            GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
            GenJnlLine."Shortcut Dimension 1 Code":=FundsHeader."Global Dimension 1 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
            GenJnlLine."Shortcut Dimension 2 Code":=FundsHeader."Global Dimension 2 Code";
            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
            GenJnlLine.ValidateShortcutDimCode(3,FundsHeader."Shortcut Dimension 3 Code");
            GenJnlLine.ValidateShortcutDimCode(4,FundsHeader."Shortcut Dimension 4 Code");
            GenJnlLine.ValidateShortcutDimCode(5,FundsHeader."Shortcut Dimension 5 Code");
            GenJnlLine.ValidateShortcutDimCode(6,FundsHeader."Shortcut Dimension 6 Code");
            GenJnlLine.ValidateShortcutDimCode(7,FundsHeader."Shortcut Dimension 7 Code");
            GenJnlLine.ValidateShortcutDimCode(8,FundsHeader."Shortcut Dimension 8 Code");
            GenJnlLine.Description:=UpperCase(CopyStr(FundsHeader.Description,1,50));
            GenJnlLine.Text:=UpperCase(CopyStr(FundsHeader."Transfer To",1,50));
            GenJnlLine.Validate(GenJnlLine.Description);
            if GenJnlLine.Amount<>0 then
               GenJnlLine.Insert;
            //************************************************End Add to Bank***************************************************************//

            //***********************************************Add Bank Lines**************************************************************//
                   FundsLine.Reset;
                   FundsLine.SetRange(FundsLine."Document No",FundsHeader."No.");
                   FundsLine.SetFilter(FundsLine."Amount to Receive",'<>%1',0);
                   if FundsLine.FindSet then begin
                     repeat
                    //****************************************Add Line NetAmounts***********************************************************//
                        LineNo:=LineNo+1;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name":="Journal Template";
                        GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name":="Journal Batch";
                        GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Source Code":=SourceCode;
                        GenJnlLine."Line No.":=LineNo;
                        GenJnlLine."Posting Date":=FundsHeader."Posting Date";
                        GenJnlLine."Document No.":=FundsLine."Document No";
                        GenJnlLine."Account Type":=GenJnlLine."account type"::"Bank Account";
                        GenJnlLine."Account No.":=FundsLine."Receiving Bank Account";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."External Document No.":=FundsHeader."Cheque/Doc. No";
                        GenJnlLine."Currency Code":=FundsHeader."Currency Code";
                        GenJnlLine.Validate("Currency Code");
                        GenJnlLine."Currency Factor":=FundsHeader."Currency Factor";
                        GenJnlLine.Validate("Currency Factor");
                        GenJnlLine.Amount:=FundsLine."Amount to Receive";
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine."Bal. Account Type":=GenJnlLine."bal. account type"::"G/L Account";
                        GenJnlLine."Bal. Account No.":='';
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine."Gen. Bus. Posting Group":='';
                        GenJnlLine.Validate(GenJnlLine."Gen. Bus. Posting Group");
                        GenJnlLine."Gen. Prod. Posting Group":='';
                        GenJnlLine.Validate(GenJnlLine."Gen. Prod. Posting Group");
                        GenJnlLine."VAT Bus. Posting Group":='';
                        GenJnlLine.Validate(GenJnlLine."VAT Bus. Posting Group");
                        GenJnlLine."VAT Prod. Posting Group":='';
                        GenJnlLine.Validate(GenJnlLine."VAT Prod. Posting Group");
                        GenJnlLine."Shortcut Dimension 1 Code":=FundsHeader."Global Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code":=FundsHeader."Global Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine.ValidateShortcutDimCode(3,FundsHeader."Shortcut Dimension 3 Code");
                        GenJnlLine.ValidateShortcutDimCode(4,FundsHeader."Shortcut Dimension 4 Code");
                        GenJnlLine.ValidateShortcutDimCode(5,FundsHeader."Shortcut Dimension 5 Code");
                        GenJnlLine.ValidateShortcutDimCode(6,FundsHeader."Shortcut Dimension 6 Code");
                        GenJnlLine.ValidateShortcutDimCode(7,FundsHeader."Shortcut Dimension 7 Code");
                        GenJnlLine.ValidateShortcutDimCode(8,FundsHeader."Shortcut Dimension 8 Code");
                        GenJnlLine.Description:=UpperCase(CopyStr(FundsHeader.Description,1,50));
                        GenJnlLine.Text:=UpperCase(CopyStr(FundsHeader."Transfer To",1,50));
                        GenJnlLine.Validate(GenJnlLine.Description);
                        if GenJnlLine.Amount<>0 then
                           GenJnlLine.Insert;
                       until FundsLine.Next=0;
                     end;
                  //Now Post the Journal Lines
                  Codeunit.Run(Codeunit::"Gen. Jnl.-Post",GenJnlLine);
                  //***************************************************End Posting****************************************************************//
                  Commit;
                  //*************************************************Update Document**************************************************************//
                  BankLedgers.Reset;
                  BankLedgers.SetRange(BankLedgers."Document No.",FundsHeader."No.");
                  if BankLedgers.FindFirst then begin
                    FundsHeader2.Reset;
                    FundsHeader2.SetRange(FundsHeader2."No.",FundsHeader."No.");
                    if FundsHeader2.FindFirst then begin
                      FundsHeader2.Status:=FundsHeader2.Status::Posted;
                      FundsHeader2.Posted:=true;
                      FundsHeader2."Posted By":=UserId;
                      FundsHeader2."Date Posted":=Today;
                      FundsHeader2."Time Posted":=Time;
                      FundsHeader2.Modify;

                      FundsLine2.Reset;
                      FundsLine2.SetRange(FundsLine2."Document No",FundsHeader2."No.");
                      if FundsLine2.FindSet then begin
                        repeat
                            FundsLine2.Status:=FundsLine2.Status::Posted;
                            FundsLine2.Posted:=true;
                            FundsLine2."Posted By":=UserId;
                            FundsLine2."Date Posted":=Today;
                            FundsLine2."Time Posted":=Time;
                            FundsLine2.Modify;
                        until FundsLine2.Next=0;
                      end;
                    end;
                  end;

                   //*************************************End add Line NetAmounts**********************************************************//
    end;


    procedure PostImprest()
    begin
    end;


    procedure PostImprestAccounting()
    begin
    end;


    procedure PostFundsClaim()
    begin
    end;

    local procedure CustomerLinesExist("Payment Header": Record "Payment Header."): Boolean
    var
        "Payment Line": Record "Payment Line.";
        "Payment Line2": Record "Payment Line.";
    begin
           "Payment Line".Reset;
           "Payment Line".SetRange("Payment Line".No,"Payment Header"."No.");
           if "Payment Line".FindFirst then begin
              if "Payment Line"."Account Type"="Payment Line"."account type"::Customer then begin
                exit(true);
              end else begin
                "Payment Line2".Reset;
                "Payment Line2".SetRange("Payment Line2".No,"Payment Header"."No.");
                "Payment Line2".SetFilter("Payment Line2"."Net Amount",'<%1',0);
                if "Payment Line2".FindFirst then
                  exit(true)
                else
                  exit(false)
              end;
           end;
    end;
}

