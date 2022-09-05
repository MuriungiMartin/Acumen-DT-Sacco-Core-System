// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516996 "S-Mobile"
{

    trigger OnRun()
    begin
        //MESSAGE(FORMAT(AdvanceEligibility('01151007758')));
        // Post
        //MESSAGE(FORMAT(Balance('0103249400065')));
    end;
}

//     var
//         Vendor: Record Vendor;
//         GenJournalLine: Record "Gen. Journal Line";
//         SmobileTrans: Record "Mobile Transactions";
//         LineNo: Integer;
//         SmobileCharges: Decimal;
//         BankCharges: Decimal;
//         ExciseFee: Decimal;
//         GenBatches: Record "Gen. Journal Batch";
//         GLPosting: Codeunit "Gen. Jnl.-Post Line";
//         GLAccount: Code[20];
//         Reversals: Record "Mobile Transactions";
//         iEntryNo: Integer;
//         Sms: Record "SMS Messages";
//         Gensetup: Record "Sacco General Set-Up";
//         Setup: Record "CloudPESA Transactions";
//         Charges: Record "S-Mobile Charges";
//         Tarrifs: Record "S-Mobile Tarrifs";
//         Cust: Record Customer;
//         Loans: Record "Loans Register";
//         STO: Record "Standing Orders";
//         Loantype: Record "Loan Products Setup";
//         Reversed: Boolean;
//         Accounttype: Record "Account Types-Saving Products";
//         AmountPaid: Decimal;
//         Totalcharges: Decimal;
//         productcharges: Record "Loan Product Charges";


//     procedure Balance(Acc: Code[30]) Bal: Decimal
//     begin
//         if Vendor.Get(Acc) then
//           begin

//             Vendor.CalcFields(Vendor."Balance (LCY)",Vendor."ATM Transactions",Vendor."Mobile Transactions");
//             Bal := Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Mobile Transactions");
//             if  Accounttype.Get(Vendor."Account Type") then
//               Bal := Bal - Accounttype."Minimum Balance";
//             end
//     end;


//     procedure GetErrorCode(errorcode: Integer) errorDesc: Text[100]
//     var
//         Codes: Record "Error Codes";
//     begin
//         if Codes.Get(errorcode) then
//           errorDesc := Codes."Error Description";
//     end;


//     procedure Post()
//     begin
//         PostTrans();
//     end;


//     procedure SendSms(Source: Text[30];Telephone: Text[200];Textsms: Text[200];DocumentNo: Text[100])
//     begin

//         Sms.Reset;
//         if Sms.Find('+') then begin
//         Sms.Init;
//         Sms."Entry No":= Sms."Entry No"+1;
//         end
//         else
//         begin
//         Sms.Init;
//         Sms."Entry No":=1;
//         end;
//         Sms.Source:=Source;
//         Sms."Telephone No":=Replacestring(Telephone,'-','');
//         Sms."Date Entered":=Today;
//         Sms."Time Entered":=Time;
//         Sms."Entered By":=UserId;
//         Sms."SMS Message":=Textsms;
//         Sms."Document No":=DocumentNo;
//         Sms."Sent To Server":=Sms."sent to server"::No;
//         Sms.Insert;
//     end;


//     procedure Replacestring(string: Text[200];findwhat: Text[30];replacewith: Text[200]) Newstring: Text[200]
//     begin
//         string := DelStr(string,StrPos(string,findwhat)) + replacewith + CopyStr(string,StrPos(string,findwhat) + StrLen(findwhat));
//         Newstring := string;
//     end;


//     procedure Charge("Transaction Type": Option " ",Withdrawal,Deposit,Balance,Ministatement,Airtime,"Loan balance","Loan Status","Share Deposit Balance","Transfer to Fosa","Transfer to Bosa","Utility Payment","Loan Application","Standing orders",Reversal,"Loan Repayment";Amount: Decimal) C: Decimal
//     begin
//           if Charges.Get("Transaction Type") then
//                 C:= Charges."Total Amount" + ((10/100) * Charges."Total Amount");

//           if Charges.Tiered = true then
//           begin
//           Tarrifs.Reset;
//             Tarrifs.SetRange(Tarrifs.Code,Format( Charges."Transaction Type"));
//             Tarrifs.SetFilter (Tarrifs.Minimum,'%>=1',SmobileTrans.Amount);
//             Tarrifs.SetFilter (Tarrifs.Maximum,'%<=1',SmobileTrans.Amount);
//             if Tarrifs.FindFirst then
//               begin
//                 C := Tarrifs."Charge Amount"+ ((10/100) * Tarrifs."Charge Amount");
//               end
//           end;
//     end;


//     procedure AdvanceEligibility(Account: Code[30]) Qualification: Decimal
//     var
//         StoDedAmount: Decimal;
//         LoanRepayAmount: Decimal;
//         ESalaryBuffer: Record "E-Loan Salary Buffer";
//         ESalaryLastSalaryDate: Date;
//         CummulativeNet: Decimal;
//         AvarageNetPay: Decimal;
//         ESalaryFirstSalaryDate: Date;
//         EQualificationAmount: Decimal;
//     begin
//         if Vendor.Get(Account) then begin
//         if (Vendor."Salary Processing"=false) then
//           Error('16');
//         Setup.Reset;
//         Setup.Get(1);
//         Setup.TestField(Setup."E-Loan");
//         Loantype.Get(Setup."E-Loan");
//         //*****Get Member Default Status
//         Loans.Reset;
//         Loans.SetRange(Loans."BOSA No",Vendor."BOSA Account No");
//         Loans.SetRange(Loans.Posted,true);

//         if Loans.Find('-') then begin
//         repeat
//           Loans.CalcFields(Loans."Outstanding Balance");
//         if (Loans."Outstanding Balance">0) then begin
//         if (Loans."Loan Product Type" = Loantype.Code) then
//           Error('18');

//           if (Loans."Loans Category"<>Loans."loans category"::Perfoming) then
//             if (Loans."Loans Category"<>Loans."loans category"::Watch)  then begin
//               Error('17');
//             end;
//             end;
//         until Loans.Next=0;
//         end;
//          if  Cust.Get(Vendor."BOSA Account No") then begin
//         Cust.CalcFields(Cust."Current Shares");
//         end;
//         if Cust."Current Shares"<10000 then
//          Error('20');
//         //******Get Salary Deductable Amount
//         //******Get Standing Order Amount
//         StoDedAmount:=0;

//         STO.Reset;
//         STO.SetRange(STO."Source Account No.",Vendor."No.");
//         STO.SetRange(STO."None Salary",false);
//         if STO.Find('-') then begin
//         repeat
//         StoDedAmount:=StoDedAmount+STO.Amount;
//         until STO.Next=0;
//         end;

//         //***Get FOSA Loan Deductions
//         LoanRepayAmount:=0;
//         Loans.Reset;
//         Loans.SetRange(Loans."Account No",Vendor."No.");
//         Loans.SetRange(Loans.Source,Loans.Source::FOSA);
//         Loans.SetRange(Loans.Posted,true);
//         Loans.CalcFields(Loans."Outstanding Balance");
//         if Loans.Find('-') then begin
//         repeat
//         if Loans."Outstanding Balance">0 then begin
//         LoanRepayAmount:=LoanRepayAmount+(Loans."Loan Principle Repayment"+Loans."Loan Interest Repayment");
//         end;
//         until Loans.Next=0;
//         end;


//         //***Get Avarege Net Pay
//         //CummulativeNet:=0;
//         ESalaryBuffer.Reset;
//         ESalaryBuffer.SetCurrentkey(ESalaryBuffer."Salary Processing Date");
//         ESalaryBuffer.SetRange(ESalaryBuffer."Account No",Vendor."No.");
//         if ESalaryBuffer.FindLast then begin
//         ESalaryLastSalaryDate:=ESalaryBuffer."Salary Processing Date";
//         ESalaryFirstSalaryDate:=CalcDate('-91D',ESalaryBuffer."Salary Processing Date");
//         if ESalaryBuffer.Find('-') then begin
//         repeat
//         if (ESalaryBuffer."Salary Processing Date">=ESalaryFirstSalaryDate) and (ESalaryBuffer."Salary Processing Date"<=ESalaryLastSalaryDate) then begin
//         CummulativeNet:=CummulativeNet+ESalaryBuffer.Amount;
//         AvarageNetPay:=CummulativeNet/3;
//         end;
//         until ESalaryBuffer.Next=0;
//         end;
//         end;


//         //***IF Member Meets the Above Parameters the Check for Qualification Amount

//         EQualificationAmount:=AvarageNetPay*(Setup."E-Loan Qualification (%)"/100);
//         Vendor."E-Loan Qualification Amount":=EQualificationAmount;

//         if EQualificationAmount > Loantype."Max. Loan Amount" then
//           EQualificationAmount := Loantype."Max. Loan Amount";


//         Vendor.Modify;
//         Qualification:= EQualificationAmount;
//         end;
//     end;

//     local procedure PostTrans()
//     begin
//         //delete journal line
//         GenJournalLine.Reset;
//         GenJournalLine.SetRange("Journal Template Name",'GENERAL');
//         GenJournalLine.SetRange("Journal Batch Name",'SMOBILE');
//         GenJournalLine.DeleteAll;
//         //end of deletion

//         GenBatches.Reset;
//         GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
//         GenBatches.SetRange(GenBatches.Name,'SMOBILE');
//         if GenBatches.Find('-') = false then begin
//           GenBatches.Init;
//           GenBatches."Journal Template Name":='GENERAL';
//           GenBatches.Name:='SMOBILE';
//           GenBatches.Description:='S-Mobile Transactions';
//           GenBatches.Validate(GenBatches."Journal Template Name");
//           GenBatches.Validate(GenBatches.Name);
//           GenBatches.Insert;
//         end;

//         SmobileTrans.Reset;
//         SmobileTrans.SetRange(SmobileTrans.Posted,false);
//         SmobileTrans.SetRange(SmobileTrans.Status, SmobileTrans.Status::Pending);
//         if SmobileTrans.FindFirst then begin
//         repeat
//           Setup.Get(1);
//           Setup.TestField(Setup."Settlement Account");
//           Setup.TestField(Setup."Commission Account");
//           SmobileCharges:=0;
//           BankCharges:=0;
//           ExciseFee:=0;
//           Reversed :=false;
//          //get  charges
//          if SmobileTrans."Transaction Type"=SmobileTrans."transaction type"::Reversal then
//            begin
//            Reversals.Reset;
//            Reversals.SetRange(Reversals."Document No",SmobileTrans."Document No");
//            Reversals.SetFilter(Reversals."Transaction Type",'<>%1',Reversals."transaction type"::Reversal);
//            if (Reversals.FindFirst) then begin
//               if Charges.Get(Reversals."Transaction Type") then begin
//                 SmobileCharges:= Charges."Total Amount";
//               end;
//            end;
//            end

//            else
//               if Charges.Get(SmobileTrans."Transaction Type") then
//                 SmobileCharges:= Charges."Total Amount";

//           if Charges.Tiered = true then
//           begin
//           Tarrifs.Reset;
//             Tarrifs.SetRange(Tarrifs.Code,Format( Charges."Transaction Type"));
//             Tarrifs.SetFilter (Tarrifs.Minimum,'%>=1',SmobileTrans.Amount);
//             Tarrifs.SetFilter (Tarrifs.Maximum,'%<=1',SmobileTrans.Amount);
//             if Tarrifs.FindFirst then
//               begin
//                 SmobileCharges := Tarrifs."Charge Amount";
//               end
//           end;

//           //
//           if SmobileCharges>0 then
//             ExciseFee := (10/100) * SmobileCharges;

//           if SmobileTrans.Description ='' then
//             SmobileTrans.Description := Format(SmobileTrans."Transaction Type");

//           if SmobileTrans."Transaction Type"=SmobileTrans."transaction type"::Reversal then
//             begin
//               Reversals.Reset;
//               Reversals.SetRange(Reversals."Document No",SmobileTrans."Document No");
//               Reversals.SetFilter(Reversals."Transaction Type",'<>%1',Reversals."transaction type"::Reversal);
//               if (Reversals.FindFirst) then begin
//                  Reversed :=true;
//                 SmobileTrans."Transaction Type":=Reversals."Transaction Type";
//              SmobileTrans.Amount := SmobileTrans.Amount *-1;
//              SmobileTrans.Charge := SmobileTrans.Charge *-1;
//              SmobileCharges := SmobileCharges *-1;
//              ExciseFee := ExciseFee *-1;
//              end;
//             end;
//           //SmobileCharges := SmobileCharges - ExciseFee;
//           if Vendor.Get(SmobileTrans."Account No") then begin
//           case SmobileTrans."Transaction Type" of
//             SmobileTrans."transaction type"::Withdrawal,
//             SmobileTrans."transaction type"::Balance,
//             SmobileTrans."transaction type"::Ministatement,
//             SmobileTrans."transaction type"::"Loan balance",
//             SmobileTrans."transaction type"::"Share Deposit Balance",
//             SmobileTrans."transaction type"::Airtime,
//             SmobileTrans."transaction type"::Deposit:

//               begin
//                     if SmobileTrans."Transaction Type"= SmobileTrans."transaction type"::Deposit then
//                       SmobileTrans.Amount := SmobileTrans.Amount*-1;
//                     LineNo:=LineNo+10000;
//                     GenJournalLine.Init;
//                     GenJournalLine."Journal Template Name":='GENERAL';
//                     GenJournalLine."Journal Batch Name":='SMOBILE';
//                     GenJournalLine."Line No.":=LineNo;
//                     GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                     GenJournalLine."Account No.":=SmobileTrans."Account No";
//                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                     GenJournalLine."Document No.":=SmobileTrans."Document No";
//                     GenJournalLine."Posting Date":=SmobileTrans."Document Date";
//                     GenJournalLine.Description:='Spotcash '+ SmobileTrans.Description + ' ' + SmobileTrans."Telephone Number";
//                     //GenJournalLine.Description:='Spotcash'+'-'+'W/D'+SmobileTrans."Telephone Number";
//                     GenJournalLine.Amount:=SmobileTrans.Amount;
//                     GenJournalLine.Validate(GenJournalLine.Amount);
//                     GenJournalLine."ATM SMS" := true;
//                     if GenJournalLine.Amount<>0 then
//                     GenJournalLine.Insert;

//                     LineNo:=LineNo+10000;

//                     GenJournalLine.Init;
//                     GenJournalLine."Journal Template Name":='GENERAL';
//                     GenJournalLine."Journal Batch Name":='SMOBILE';
//                     GenJournalLine."Line No.":=LineNo;
//                     GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
//                     GenJournalLine."Account No.":=Setup."Settlement Account";
//                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                     GenJournalLine."Document No.":=SmobileTrans."Document No";
//                     GenJournalLine."External Document No.":=SmobileTrans."Account No";
//                     GenJournalLine."Posting Date":=SmobileTrans."Document Date";
//                     GenJournalLine.Description:=Vendor.Name + ' ' + SmobileTrans.Description;
//                     GenJournalLine.Amount:=SmobileTrans.Amount*-1;
//                     GenJournalLine.Validate(GenJournalLine.Amount);
//                     GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
//                     GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
//                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                     if GenJournalLine.Amount<>0 then GenJournalLine.Insert;

//               end;

//                SmobileTrans."transaction type"::"Loan Repayment":
//                  begin
//                      SmobileTrans.Amount := SmobileTrans.Amount*-1;
//                       LineNo:=LineNo+10000;
//                       GenJournalLine.Init;
//                       GenJournalLine."Journal Template Name":='GENERAL';
//                       GenJournalLine."Journal Batch Name":='SMOBILE';
//                       GenJournalLine."Line No.":=LineNo;
//                       GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                       GenJournalLine."Account No.":=SmobileTrans."Account No";
//                       GenJournalLine.Amount:=SmobileTrans.Amount;
//                       Loantype.Reset;
//                       Loantype.SetFilter(Loantype.Code,'%1','*'+ SmobileTrans."Loan No");
//                       if Loantype.FindFirst =false then
//                         begin
//                         SmobileTrans.Comments:= 'Loan type not found '+ SmobileTrans."Loan No";

//                         end else  begin
//                         Loans.Reset;
//                         Loans.SetRange(Loans."BOSA No" , Vendor."BOSA Account No");
//                         Loans.SetRange(Loans."Loan Product Type", Loantype.Code);
//                         Loans.SetRange(Loans.Posted, true);
//                         Loans.SetFilter(Loans."Outstanding Balance",'>0');
//                         if Loans.FindFirst = false then
//                           begin
//                               SmobileTrans.Comments:= 'Loan not found '+ SmobileTrans."Loan No";
//                             end
//                             else

//                            begin
//                           Loans.CalcFields(Loans."Outstanding Balance");
//                             // MESSAGE(FORMAT(Loans."Loan  No."));
//                           if (Loans."Outstanding Balance">0) then
//                             begin
//                               GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
//                               GenJournalLine."Account No.":=Loans."Client Code";
//                               GenJournalLine."Transaction Type":= GenJournalLine."transaction type"::"Interest Paid";
//                               GenJournalLine."Loan No" := Loans."Loan  No.";
//                                if Loans."Outstanding Balance"< (SmobileTrans.Amount*-1) then
//                                  begin
//                                  if (Reversed = true) then
//                                    Loans."Outstanding Balance" := Loans."Outstanding Balance" *-1;
//                                 GenJournalLine.Amount:=Loans."Outstanding Balance";
//                                  end
//                                else
//                                 GenJournalLine.Amount:=SmobileTrans.Amount;
//                             end ;
//                         end;
//                       end;
//                       AmountPaid := GenJournalLine.Amount;
//                       GenJournalLine.Validate(GenJournalLine."Account No.");
//                       GenJournalLine."Document No.":=SmobileTrans."Document No";
//                       GenJournalLine."Posting Date":=SmobileTrans."Document Date";
//                       GenJournalLine.Description:='Spotcash '+ SmobileTrans.Description + ' ' + SmobileTrans."Telephone Number";
//                       //GenJournalLine.Description:='Spotcash'+'-'+'W/D'+SmobileTrans."Telephone Number";

//                       GenJournalLine.Validate(GenJournalLine.Amount);
//                       GenJournalLine."ATM SMS" := true;
//                       if GenJournalLine.Amount<>0 then
//                       GenJournalLine.Insert;

//                       if AmountPaid*-1<> SmobileTrans.Amount then begin
//                         LineNo:=LineNo+10000;
//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='GENERAL';
//                         GenJournalLine."Journal Batch Name":='SMOBILE';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                         GenJournalLine."Account No.":=SmobileTrans."Account No";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Document No.":=SmobileTrans."Document No";
//                         GenJournalLine."Posting Date":=SmobileTrans."Document Date";
//                         GenJournalLine.Description:='Spotcash '+ SmobileTrans.Description + ' balance ' + SmobileTrans."Telephone Number";
//                         GenJournalLine.Amount:=SmobileTrans.Amount - AmountPaid;
//                         GenJournalLine.Validate(GenJournalLine.Amount);

//                         if GenJournalLine.Amount<>0 then
//                         GenJournalLine.Insert;
//                         end;
//                       LineNo:=LineNo+10000;
//                       GenJournalLine.Init;
//                       GenJournalLine."Journal Template Name":='GENERAL';
//                       GenJournalLine."Journal Batch Name":='SMOBILE';
//                       GenJournalLine."Line No.":=LineNo;
//                       GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
//                       GenJournalLine."Account No.":=Setup."Settlement Account";
//                       GenJournalLine.Validate(GenJournalLine."Account No.");
//                       GenJournalLine."Document No.":=SmobileTrans."Document No";
//                       GenJournalLine."External Document No.":=SmobileTrans."Account No";
//                       GenJournalLine."Posting Date":=SmobileTrans."Document Date";
//                       GenJournalLine.Description:=Vendor.Name + ' ' + SmobileTrans.Description;
//                       GenJournalLine.Amount:=SmobileTrans.Amount *-1;
//                       GenJournalLine.Validate(GenJournalLine.Amount);
//                       GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
//                       GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
//                       GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                       GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                       if GenJournalLine.Amount<>0 then GenJournalLine.Insert;
//                  end;
//                       SmobileTrans."transaction type"::"Loan Application":
//                         begin
//                         if AdvanceEligibilitylocal(Vendor."No.")< SmobileTrans.Amount  then begin
//                           SmobileTrans.Posted:= true;
//                           SmobileTrans.Status:= SmobileTrans.Status::Failed;
//                           SmobileTrans.Comments:='Not qualified';
//                           SmobileTrans.Modify;
//                          exit;
//                         end;
//                        Setup.TestField(Setup."E-Loan");
//                         Loantype.Get(Setup."E-Loan");
//                         //MESSAGE(Loantype.Code);
//                         Loans.Reset;
//                         Loans.Init;
//                         Loans."Loan  No." :='';
//                         Loans."Loan Product Type":= Loantype.Code;
//                         Loans."Account No":=Vendor."No.";
//                         Loans."Client Code" := Vendor."No.";
//                         Loans."Application Date":= SmobileTrans."Document Date";
//                         Loans."Approved Amount" := SmobileTrans.Amount;
//                         Loans."Requested Amount" := SmobileTrans.Amount;
//                         Loans.Source :=Loans.Source::FOSA;
//                         Loans."BOSA No":= Vendor."BOSA Account No";
//                         Loans."Issued Date":=SmobileTrans."Document Date";
//                         Loans.Repayment := SmobileTrans.Amount + (Loantype."Interest rate"/100)* SmobileTrans.Amount;
//                         Loans."ID NO":= Vendor."ID No.";
//                         Loans."Client Name":= Vendor.Name;
//                         Loans."Repayment Method":=Loantype."Repayment Method";
//                         Loans.Interest := Loantype."Interest rate";

//                         Loans.Insert(true);
//                         if Cust.Get(Vendor."No.")= false then begin
//                         Cust.Init;
//                         Cust."No.":=Vendor."No.";
//                         Cust.Name:=Vendor.Name;
//                         Cust."Global Dimension 1 Code":=Vendor."Global Dimension 1 Code";
//                         Cust."Global Dimension 2 Code":=Vendor."Global Dimension 2 Code";
//                         Cust.Status:=Cust.Status::Applicant;
//                         Cust."Customer Type":=Cust."customer type"::FOSA;
//                         Cust."Customer Posting Group":='MEMBER';
//                         Cust."FOSA Account No.":=Vendor."No.";
//                         if Cust."Personal No" <> '' then
//                         Cust."Personal No":=Vendor."Personal No.";
//                         Cust."ID No." :=Vendor."ID No.";
//                         Cust.Insert;
//                         end;
//                         LineNo:=LineNo+10000;
//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='GENERAL';
//                         GenJournalLine."Journal Batch Name":='SMOBILE';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
//                         GenJournalLine."Account No.":=Loans."Client Code";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Transaction Type":= GenJournalLine."transaction type"::"Share Capital";
//                         GenJournalLine."Loan No" := Loans."Loan  No.";
//                         GenJournalLine."Document No.":=SmobileTrans."Document No";
//                         GenJournalLine."External Document No.":=SmobileTrans."Account No";
//                         GenJournalLine."Posting Date":=SmobileTrans."Document Date";
//                         GenJournalLine.Description:=Vendor.Name + ' ' + SmobileTrans.Description;
//                         GenJournalLine.Amount:=SmobileTrans.Amount;
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
//                         GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                         if GenJournalLine.Amount<>0 then GenJournalLine.Insert;

//                        Totalcharges:=0;
//                        productcharges.Reset;
//                        productcharges.SetRange(productcharges."Product Code", Loantype.Code);
//                        if productcharges.FindFirst then
//                         repeat
//                         LineNo:=LineNo+10000;
//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='GENERAL';
//                         GenJournalLine."Journal Batch Name":='SMOBILE';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                         GenJournalLine."Account No.":=Loans."Client Code";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Document No.":=SmobileTrans."Document No";
//                         GenJournalLine."External Document No.":=SmobileTrans."Account No";
//                         GenJournalLine."Posting Date":=SmobileTrans."Document Date";
//                         GenJournalLine.Description:=productcharges.Description;
//                         GenJournalLine.Amount:=productcharges.Amount + SmobileTrans.Charge ;
//                         GenJournalLine.Validate(GenJournalLine.Amount );
//                         GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
//                         GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
//                         //GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
//                        // GenJournalLine."Bal. Account No.":= productcharges."G/L Account";
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                         if GenJournalLine.Amount<>0 then GenJournalLine.Insert;

//                           LineNo:=LineNo+10000;
//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='GENERAL';
//                         GenJournalLine."Journal Batch Name":='SMOBILE';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
//                         GenJournalLine."Account No.":= productcharges."G/L Account";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Document No.":=SmobileTrans."Document No";
//                         GenJournalLine."External Document No.":=SmobileTrans."Account No";
//                         GenJournalLine."Posting Date":=SmobileTrans."Document Date";
//                         GenJournalLine.Description:=productcharges.Description;
//                         GenJournalLine.Amount:=-productcharges.Amount  ;
//                         GenJournalLine.Validate(GenJournalLine.Amount );
//                         GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
//                         GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";

//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                         if GenJournalLine.Amount<>0 then GenJournalLine.Insert;

//                         LineNo:=LineNo+10000;
//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='GENERAL';
//                         GenJournalLine."Journal Batch Name":='SMOBILE';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
//                         GenJournalLine."Account No.":=Setup."Settlement Account";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Document No.":=SmobileTrans."Document No";
//                         GenJournalLine."Posting Date":=SmobileTrans."Document Date";
//                         GenJournalLine.Description:=SmobileTrans.Description+' Charges';
//                         GenJournalLine.Amount:=-SmobileTrans.Charge;
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                        if GenJournalLine.Amount<>0 then
//                         GenJournalLine.Insert;
//                         SmobileTrans.Charge := 0;

//                         Totalcharges:=Totalcharges + GenJournalLine.Amount;
//                         until productcharges.Next =0;
//                          LineNo:=LineNo+10000;
//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='GENERAL';
//                         GenJournalLine."Journal Batch Name":='SMOBILE';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                         GenJournalLine."Account No.":=Loans."Client Code";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Document No.":=SmobileTrans."Document No";
//                         GenJournalLine."External Document No.":=SmobileTrans."Account No";
//                         GenJournalLine."Posting Date":=SmobileTrans."Document Date";
//                         GenJournalLine.Description:='Interest payment';
//                         GenJournalLine.Amount:=(Loantype."Interest rate"/100)* SmobileTrans.Amount  ;
//                         GenJournalLine.Validate(GenJournalLine.Amount );
//                         GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
//                         GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
//                         GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
//                         GenJournalLine."Bal. Account No.":= Loantype."Loan Interest Account";
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                         if GenJournalLine.Amount<>0 then GenJournalLine.Insert;
//                          Totalcharges:=Totalcharges + GenJournalLine.Amount;
//                          LineNo:=LineNo+10000;
//                         GenJournalLine.Init;
//                         GenJournalLine."Journal Template Name":='GENERAL';
//                         GenJournalLine."Journal Batch Name":='SMOBILE';
//                         GenJournalLine."Line No.":=LineNo;
//                         GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//                         GenJournalLine."Account No.":=Loans."Client Code";
//                         GenJournalLine.Validate(GenJournalLine."Account No.");
//                         GenJournalLine."Document No.":=SmobileTrans."Document No";
//                         GenJournalLine."External Document No.":=SmobileTrans."Account No";
//                         GenJournalLine."Posting Date":=SmobileTrans."Document Date";
//                         GenJournalLine.Description:=Vendor.Name + ' ' + SmobileTrans.Description;
//                         GenJournalLine.Amount:=(SmobileTrans.Amount ) *-1  ;
//                         GenJournalLine.Validate(GenJournalLine.Amount);
//                         GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
//                         GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                         GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                         if GenJournalLine.Amount<>0 then GenJournalLine.Insert;

//                         Loans."Loan Status" :=Loans."loan status"::Issued;
//                         Loans.Posted := true;
//                         Loans."Loan Disbursed Amount" := SmobileTrans.Amount - Totalcharges;
//                         Loans.Modify;
//                       end;

//                   SmobileTrans."transaction type"::"Share Contribution":

//                     begin
//                       SmobileTrans.Amount :=SmobileTrans.Amount *-1;
//                     LineNo:=LineNo+10000;
//                     GenJournalLine.Init;
//                     GenJournalLine."Journal Template Name":='GENERAL';
//                     GenJournalLine."Journal Batch Name":='SMOBILE';
//                     GenJournalLine."Line No.":=LineNo;
//                     GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
//                     GenJournalLine."Account No.":=Vendor."BOSA Account No";
//                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                     GenJournalLine."Document No.":=SmobileTrans."Document No";
//                     GenJournalLine."Posting Date":=SmobileTrans."Document Date";
//                     GenJournalLine.Description:='Spotcash '+ SmobileTrans.Description + ' ' + SmobileTrans."Telephone Number";
//                     //GenJournalLine.Description:='Spotcash'+'-'+'W/D'+SmobileTrans."Telephone Number";
//                     GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
//                     GenJournalLine.Amount:=SmobileTrans.Amount ;
//                     GenJournalLine.Validate(GenJournalLine.Amount);
//                     GenJournalLine."ATM SMS" := true;
//                     if GenJournalLine.Amount<>0 then
//                     GenJournalLine.Insert;

//                     LineNo:=LineNo+10000;

//                     GenJournalLine.Init;
//                     GenJournalLine."Journal Template Name":='GENERAL';
//                     GenJournalLine."Journal Batch Name":='SMOBILE';
//                     GenJournalLine."Line No.":=LineNo;
//                     GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
//                     GenJournalLine."Account No.":=Setup."Settlement Account";
//                     GenJournalLine.Validate(GenJournalLine."Account No.");
//                     GenJournalLine."Document No.":=SmobileTrans."Document No";
//                     GenJournalLine."External Document No.":=SmobileTrans."Account No";
//                     GenJournalLine."Posting Date":=SmobileTrans."Document Date";
//                     GenJournalLine.Description:=Vendor.Name + ' ' + SmobileTrans.Description;
//                     GenJournalLine.Amount:=SmobileTrans.Amount*-1;
//                     GenJournalLine.Validate(GenJournalLine.Amount);
//                     GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
//                     GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
//                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                     GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
//                     if GenJournalLine.Amount<>0 then GenJournalLine.Insert;
//                       end;//share contribution

//                       end;
//               //charges
//               LineNo:= LineNo+10000;
//               GenJournalLine.Init;
//               GenJournalLine."Journal Template Name":='GENERAL';
//               GenJournalLine."Journal Batch Name":='SMOBILE';
//               GenJournalLine."Line No.":=LineNo;
//               GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
//               GenJournalLine."Account No.":=SmobileTrans."Account No";
//               GenJournalLine.Validate(GenJournalLine."Account No.");
//               GenJournalLine."Document No.":=SmobileTrans."Document No";
//               GenJournalLine."Posting Date":=SmobileTrans."Document Date";
//               GenJournalLine.Description:=SmobileTrans.Description +' Charges';
//               if Setup."Show excise on statement" then
//                 GenJournalLine.Amount:=SmobileCharges + SmobileTrans.Charge
//               else
//                 GenJournalLine.Amount:=SmobileCharges + SmobileTrans.Charge + ExciseFee;

//               GenJournalLine.Validate(GenJournalLine.Amount);
//               if GenJournalLine.Amount<>0 then
//               GenJournalLine.Insert;

//               LineNo:=LineNo+10000;
//               GenJournalLine.Init;
//               GenJournalLine."Journal Template Name":='GENERAL';
//               GenJournalLine."Journal Batch Name":='SMOBILE';
//               GenJournalLine."Line No.":=LineNo;
//               GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
//               GenJournalLine."Account No.":=Setup."Commission Account";
//               GenJournalLine.Validate(GenJournalLine."Account No.");
//               GenJournalLine."Document No.":=SmobileTrans."Document No";
//               GenJournalLine."Posting Date":=SmobileTrans."Document Date";
//               GenJournalLine.Description:=SmobileTrans.Description+' Charges';
//               GenJournalLine.Amount:=(SmobileCharges)*-1;
//               GenJournalLine.Validate(GenJournalLine.Amount);
//               if GenJournalLine.Amount<>0 then
//               GenJournalLine.Insert;

//               LineNo:=LineNo+10000;

//               GenJournalLine.Init;
//               GenJournalLine."Journal Template Name":='GENERAL';
//               GenJournalLine."Journal Batch Name":='SMOBILE';
//               GenJournalLine."Line No.":=LineNo;
//               GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
//               GenJournalLine."Account No.":=Setup."Settlement Account";
//               GenJournalLine.Validate(GenJournalLine."Account No.");
//               GenJournalLine."Document No.":=SmobileTrans."Document No";
//               GenJournalLine."Posting Date":=SmobileTrans."Document Date";
//               GenJournalLine.Description:=SmobileTrans.Description+' Charges';
//               GenJournalLine.Amount:=-SmobileTrans.Charge;
//               GenJournalLine.Validate(GenJournalLine.Amount);

//               if GenJournalLine.Amount<>0 then
//               GenJournalLine.Insert;

//               //EXCISE PASSED TO VENDOR
//               LineNo:=LineNo+10000;

//               GenJournalLine.Init;
//               GenJournalLine."Journal Template Name":='GENERAL';
//               GenJournalLine."Journal Batch Name":='SMOBILE';
//               GenJournalLine."Line No.":=LineNo;
//               GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
//               GenJournalLine."Account No.":=Setup."Excise Duty Account";
//               GenJournalLine.Validate(GenJournalLine."Account No.");
//               GenJournalLine."Document No.":=SmobileTrans."Document No";
//               GenJournalLine."Posting Date":=SmobileTrans."Document Date";
//               GenJournalLine.Description:=SmobileTrans.Description+ ' '+' Excise Duty Charges';
//               GenJournalLine.Amount:=ExciseFee*-1;
//               if Setup."Show excise on statement" then
//               begin
//                 GenJournalLine."Bal. Account No." := SmobileTrans."Account No";
//                 GenJournalLine."Bal. Account Type" := GenJournalLine."account type"::Vendor;
//               end;
//               GenJournalLine.Validate(GenJournalLine.Amount);
//               if GenJournalLine.Amount<>0 then
//               GenJournalLine.Insert;

//               SmobileTrans.Posted:=true;
//               SmobileTrans.Status := SmobileTrans.Status::Completed;
//               SmobileTrans."Posting Date":= Today;

//           end else begin
//             SmobileTrans.Posted:=false;
//             SmobileTrans.Status := SmobileTrans.Status::Failed;
//             SmobileTrans.Comments:= 'Account No. '+SmobileTrans."Account No"+' not found.'  ;
//           end;
//           if Reversed = true then
//             SmobileTrans."Transaction Type" := SmobileTrans."transaction type"::Reversal;
//          SmobileTrans.Modify;

//         until SmobileTrans.Next = 0;

//         //Post

//         GenJournalLine.Reset;
//         GenJournalLine.SetRange("Journal Template Name",'GENERAL');
//         GenJournalLine.SetRange("Journal Batch Name",'SMOBILE');
//         if GenJournalLine.Find('-') then begin
//         repeat
//         GLPosting.Run(GenJournalLine);
//         until GenJournalLine.Next = 0;
//         end;

//         GenJournalLine.Reset;
//         GenJournalLine.SetRange("Journal Template Name",'GENERAL');
//         GenJournalLine.SetRange("Journal Batch Name",'SMOBILE');
//         GenJournalLine.DeleteAll;
//         //Post
//         end;
//     end;

//     local procedure AdvanceEligibilitylocal(Account: Code[30]) Qualification: Decimal
//     var
//         StoDedAmount: Decimal;
//         LoanRepayAmount: Decimal;
//         ESalaryBuffer: Record "E-Loan Salary Buffer";
//         ESalaryLastSalaryDate: Date;
//         CummulativeNet: Decimal;
//         AvarageNetPay: Decimal;
//         ESalaryFirstSalaryDate: Date;
//         EQualificationAmount: Decimal;
//     begin
//         if Vendor.Get(Account) then begin
//         if (Vendor."Salary Processing"=false) then
//            begin
//            Qualification :=0;
//            exit;
//            end;
//         Setup.Reset;
//         Setup.Get(1);
//         Setup.TestField(Setup."E-Loan");
//         Loantype.Get(Setup."E-Loan");
//         //*****Get Member Default Status
//         Loans.Reset;
//         Loans.SetRange(Loans."BOSA No",Vendor."BOSA Account No");
//         Loans.SetRange(Loans.Posted,true);

//         if Loans.Find('-') then begin
//         repeat
//           Loans.CalcFields(Loans."Outstanding Balance");
//           if (Loans."Outstanding Balance">0) then begin
//         if  (Loans."Loan Product Type" = Loantype.Code) then
//            begin
//            Qualification :=0;
//            exit;
//            end;
//           if (Loans."Loans Category"<>Loans."loans category"::Perfoming) then
//             if (Loans."Loans Category"<>Loans."loans category"::Watch)  then begin
//                begin
//            Qualification :=0;
//            exit;
//            end;
//            end;
//             end;
//         until Loans.Next=0;
//         end;
//          if  Cust.Get(Vendor."BOSA Account No") then begin
//         Cust.CalcFields(Cust."Current Shares");
//         end;
//         if Cust."Current Shares"<10000 then
//          begin
//            Qualification :=0;
//            exit;
//            end;
//         //******Get Salary Deductable Amount
//         //******Get Standing Order Amount
//         StoDedAmount:=0;

//         STO.Reset;
//         STO.SetRange(STO."Source Account No.",Vendor."No.");
//         STO.SetRange(STO."None Salary",false);
//         if STO.Find('-') then begin
//         repeat
//         StoDedAmount:=StoDedAmount+STO.Amount;
//         until STO.Next=0;
//         end;

//         //***Get FOSA Loan Deductions
//         LoanRepayAmount:=0;
//         Loans.Reset;
//         Loans.SetRange(Loans."Account No",Vendor."No.");
//         Loans.SetRange(Loans.Source,Loans.Source::FOSA);
//         Loans.SetRange(Loans.Posted,true);
//         Loans.CalcFields(Loans."Outstanding Balance");
//         if Loans.Find('-') then begin
//         repeat
//         if Loans."Outstanding Balance">0 then begin
//         LoanRepayAmount:=LoanRepayAmount+(Loans."Loan Principle Repayment"+Loans."Loan Interest Repayment");
//         end;
//         until Loans.Next=0;
//         end;


//         //***Get Avarege Net Pay
//         //CummulativeNet:=0;
//         ESalaryBuffer.Reset;
//         ESalaryBuffer.SetCurrentkey(ESalaryBuffer."Salary Processing Date");
//         ESalaryBuffer.SetRange(ESalaryBuffer."Account No",Vendor."No.");
//         if ESalaryBuffer.FindLast then begin
//         ESalaryLastSalaryDate:=ESalaryBuffer."Salary Processing Date";
//         ESalaryFirstSalaryDate:=CalcDate('-91D',ESalaryBuffer."Salary Processing Date");
//         if ESalaryBuffer.Find('-') then begin
//         repeat
//         if (ESalaryBuffer."Salary Processing Date">=ESalaryFirstSalaryDate) and (ESalaryBuffer."Salary Processing Date"<=ESalaryLastSalaryDate) then begin
//         CummulativeNet:=CummulativeNet+ESalaryBuffer.Amount;
//         AvarageNetPay:=CummulativeNet/3;
//         end;
//         until ESalaryBuffer.Next=0;
//         end;
//         end;


//         //***IF Member Meets the Above Parameters the Check for Qualification Amount

//         EQualificationAmount:=AvarageNetPay*(Setup."E-Loan Qualification (%)"/100);
//         Vendor."E-Loan Qualification Amount":=EQualificationAmount;

//         if EQualificationAmount > Loantype."Max. Loan Amount" then
//           EQualificationAmount := Loantype."Max. Loan Amount";


//         Vendor.Modify;
//         Qualification:= EQualificationAmount;
//         end;
//     end;
// }

