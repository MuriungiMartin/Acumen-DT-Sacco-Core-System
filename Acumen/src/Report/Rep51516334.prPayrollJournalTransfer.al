// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
// Report 51516334 "prPayrollJournalTransfer.."
// {
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem(UnknownTable51516265;UnknownTable51516265)
//         {
//             RequestFilterFields = Field17,Field1,Field323,Field29;
//             column(ReportForNavId_6207; 6207)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 //For use when posting Pension and NSSF
//                 GLS.Get;
//                 PostingGroup.Get(GLS."Payroll Posting Group");

//                 //PKK
//                 PostingGroup.TestField("NSSF Employer Account");
//                 PostingGroup.TestField("NSSF Employee Account");
//                 PostingGroup.TestField("Pension Employer Acc");
//                 PostingGroup.TestField("Pension Employee Acc");
//                 //PKK

//                 //Get the staff details (header)
//                 objEmp.SetRange(objEmp."No.","Employee Code");
//                 if objEmp.Find('-') then
//                 begin
//                    strEmpName:='['+"Employee Code"+'] '+objEmp."Last Name"+' '+objEmp."First Name"+' '+objEmp."Middle Name";
//                    GlobalDim1:=objEmp."Department Code";
//                    GlobalDim2:=objEmp."Location/Division Code";//objEmp.Office;
//                 end;

//                 LineNumber:=LineNumber+10;


//                 PeriodTrans.Reset;
//                 PeriodTrans.SetRange(PeriodTrans."Employee Code","Employee Code");
//                 PeriodTrans.SetRange(PeriodTrans."Payroll Period",SelectedPeriod);
//                 if PeriodTrans.Find('-') then begin
//                 repeat
//                   if PeriodTrans."Journal Account Code"<>'' then begin
//                    AmountToDebit:=0;AmountToCredit:=0;
//                    if PeriodTrans."Post As" =PeriodTrans."post as"::Debit then
//                       AmountToDebit:=PeriodTrans.Amount;

//                    if PeriodTrans."Post As" =PeriodTrans."post as"::Credit then
//                       AmountToCredit:=PeriodTrans.Amount;

//                      if PeriodTrans."Journal Account Type" = 1 then
//                         IntegerPostAs:=0;
//                      if PeriodTrans."Journal Account Type" = 2 then
//                         IntegerPostAs:=1;



//                      CreateJnlEntry(IntegerPostAs,PeriodTrans."Journal Account Code",
//                      GlobalDim1,GlobalDim2,PeriodTrans."Transaction Name"+'-'+PeriodTrans."Employee Code",AmountToDebit,AmountToCredit,
//                      PeriodTrans."Post As",PeriodTrans."Loan Number",SaccoTransactionType);

//                     //Pension
//                     if PeriodTrans."coop parameters"=PeriodTrans."coop parameters"::Pension then begin
//                       //Get from Employer Deduction
//                       EmployerDed.Reset;
//                       EmployerDed.SetRange(EmployerDed."Employee Code",PeriodTrans."Employee Code");
//                       EmployerDed.SetRange(EmployerDed."Transaction Code",PeriodTrans."Transaction Code");
//                       EmployerDed.SetRange(EmployerDed."Payroll Period",PeriodTrans."Payroll Period");
//                       if EmployerDed.Find('-') then begin
//                       //Credit Payables
//                           CreateJnlEntry(0,PostingGroup."Pension Employee Acc",
//                           GlobalDim1,GlobalDim2,PeriodTrans."Transaction Name"+'-'+PeriodTrans."Employee Code",0,
//                           EmployerDed.Amount,PeriodTrans."Post As",'',SaccoTransactionType);

//                       //Debit Staff Expense
//                           CreateJnlEntry(0,PostingGroup."Pension Employer Acc",
//                           GlobalDim1,GlobalDim2,PeriodTrans."Transaction Name"+'-'+PeriodTrans."Employee Code",EmployerDed.Amount,0,1,'',
//                           SaccoTransactionType);

//                       end;
//                     end;

//                     //NSSF
//                      //PKK
//                     if PeriodTrans."coop parameters"=PeriodTrans."coop parameters"::NSSF then begin
//                        //Credit Payables
//                       //Credit Payables
//                           CreateJnlEntry(0,PostingGroup."NSSF Employee Account",
//                           GlobalDim1,GlobalDim2,PeriodTrans."Transaction Name"+'-'+PeriodTrans."Employee Code",0,PeriodTrans.Amount,
//                           PeriodTrans."Post As",'',SaccoTransactionType);

//                       //Debit Staff Expense
//                           CreateJnlEntry(0,PostingGroup."NSSF Employer Account",
//                           GlobalDim1,GlobalDim2,PeriodTrans."Transaction Name"+'-'+PeriodTrans."Employee Code",PeriodTrans.Amount,0,1,'',
//                           SaccoTransactionType);
//                     end;
//                      //PKK
//                   end;
//                 until PeriodTrans.Next=0;
//                 end;
//             end;

//             trigger OnPostDataItem()
//             begin
//                   Message('Journals Created Successfully');
//             end;

//             trigger OnPreDataItem()
//             begin

//                 LineNumber:=10000;

//                 //Create batch*****************************************************************************
//                 GenJnlBatch.Reset;
//                 GenJnlBatch.SetRange(GenJnlBatch."Journal Template Name",'GENERAL');
//                 GenJnlBatch.SetRange(GenJnlBatch.Name,'SALARIES');
//                 if GenJnlBatch.Find ('-')=false then
//                 begin
//                  GenJnlBatch.Init;
//                  GenJnlBatch."Journal Template Name":='GENERAL';
//                  GenJnlBatch.Name:='SALARIES';
//                  GenJnlBatch.Insert;
//                 end;
//                 // End Create Batch

//                 // Clear the journal Lines
//                 GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name",'SALARIES');
//                 if GeneraljnlLine.Find('-') then
//                 GeneraljnlLine.DeleteAll;

//                 "Slip/Receipt No":=UpperCase(objPeriod."Period Name");
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 field(PeriodDate;PeriodDate)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Period Date';
//                     TableRelation = "prPayroll Periods"."Date Opened";
//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnPreReport()
//     begin
//         /*
//         PeriodFilter:=PeriodDate;//"prSalary Card".GETFILTER("Period Filter");
//         IF PeriodFilter='' THEN ERROR('You must specify the period filter');
//                      */

//         if PeriodDate=0D then Error('You must specify the period filter');
//         SelectedPeriod:=PeriodDate;//"prSalary Card".GETRANGEMIN("Period Filter");
//         objPeriod.Reset;
//         if objPeriod.Get(SelectedPeriod) then PeriodName:=objPeriod."Period Name";

//         PostingDate:=CalcDate('1M-1D',SelectedPeriod);

//     end;

//     var
//         PeriodTrans: Record "prPeriod Transactions";
//         objEmp: Record "HR Employees";
//         PeriodName: Text[30];
//         PeriodFilter: Text[30];
//         SelectedPeriod: Date;
//         objPeriod: Record "prPayroll Periods";
//         ControlInfo: Record "Control-Information";
//         strEmpName: Text[150];
//         GeneraljnlLine: Record "Gen. Journal Line";
//         GenJnlBatch: Record "Gen. Journal Batch";
//         "Slip/Receipt No": Code[50];
//         LineNumber: Integer;
//         "Salary Card": Record UnknownRecord51516265;
//         TaxableAmount: Decimal;
//         PostingGroup: Record "prEmployee Posting Group";
//         GlobalDim1: Code[10];
//         GlobalDim2: Code[10];
//         TransCode: Record "Payroll Bank Branches.";
//         PostingDate: Date;
//         AmountToDebit: Decimal;
//         AmountToCredit: Decimal;
//         IntegerPostAs: Integer;
//         SaccoTransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2";
//         EmployerDed: Record "Payroll Employer Deductions.";
//         PeriodDate: Date;
//         GLS: Record "General Ledger Setup";


//     procedure CreateJnlEntry(AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";AccountNo: Code[20];GlobalDime1: Code[20];GlobalDime2: Code[20];Description: Text[50];DebitAmount: Decimal;CreditAmount: Decimal;PostAs: Option " ",Debit,Credit;LoanNo: Code[20];TransType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2")
//     begin

//          LineNumber:=LineNumber+100;
//          GeneraljnlLine.Init;
//          GeneraljnlLine."Journal Template Name":='GENERAL';
//          GeneraljnlLine."Journal Batch Name":='SALARIES';
//          GeneraljnlLine."Line No.":=LineNumber;
//          GeneraljnlLine."Document No.":="Slip/Receipt No";
//          //GeneraljnlLine."Loan No":=LoanNo;
//          //GeneraljnlLine."Transaction Type":=TransType;
//          GeneraljnlLine."Posting Date":=PostingDate;
//          GeneraljnlLine."Account Type":=AccountType;
//          GeneraljnlLine."Account No.":=AccountNo;
//          GeneraljnlLine.Validate(GeneraljnlLine."Account No.");
//          GeneraljnlLine.Description:=Description;
//          if PostAs = Postas::Debit then begin
//          GeneraljnlLine."Debit Amount":=DebitAmount;
//          GeneraljnlLine.Validate("Debit Amount");
//          end else begin
//          GeneraljnlLine."Credit Amount":=CreditAmount;
//          GeneraljnlLine.Validate("Credit Amount");
//          end;
//          GeneraljnlLine."Shortcut Dimension 1 Code":=GlobalDime1;
//          //GeneraljnlLine.VALIDATE(GeneraljnlLine."Shortcut Dimension 1 Code");
//          GeneraljnlLine."Shortcut Dimension 2 Code":=GlobalDime2;
//          //GeneraljnlLine.VALIDATE(GeneraljnlLine."Shortcut Dimension 2 Code");
//          if GeneraljnlLine.Amount<>0 then
//               GeneraljnlLine.Insert;
//     end;
// }

