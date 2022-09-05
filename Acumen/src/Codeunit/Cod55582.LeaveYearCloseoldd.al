// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
// Codeunit 55582 "Leave Year-Closeoldd"
// {
//     TableNo = UnknownTable55578;

//     trigger OnRun()
//     begin
//         HRLeavePeriods.Copy(Rec);
//         Code;
//         Rec := HRLeavePeriods;
//     end;

//     var
//         Text001: label 'You must create a new fiscal year before you can close the old year.';
//         Text002: label 'This function closes the fiscal year from %1 to %2. ';
//         Text003: label 'Once the fiscal year is closed it cannot be opened again, and the periods in the fiscal year cannot be changed.\\';
//         Text004: label 'Do you want to close the fiscal year?';
//         HRLeavePeriods: Record UnknownRecord55578;
//         HRLeavePeriods2: Record UnknownRecord55578;
//         HRLeavePeriods3: Record UnknownRecord55578;
//         FiscalYearStartDate: Date;
//         FiscalYearEndDate: Date;

//     local procedure "Code"()
//     begin
//         with HRLeavePeriods do begin
//           HRLeavePeriods2.SetRange(Closed,false);
//           HRLeavePeriods2.Find('-');

//           FiscalYearStartDate := HRLeavePeriods2."Starting Date";
//           HRLeavePeriods := HRLeavePeriods2;
//           TestField("New Fiscal Year",true);

//           HRLeavePeriods2.SetRange("New Fiscal Year",true);
//           if HRLeavePeriods2.Find('>') then begin
//             FiscalYearEndDate := CalcDate('<-1D>',HRLeavePeriods2."Starting Date");

//             HRLeavePeriods3 := HRLeavePeriods2;
//             HRLeavePeriods2.SetRange("New Fiscal Year");
//             HRLeavePeriods2.Find('<');
//           end else
//             Error(Text001);

//           if not
//              Confirm(
//                Text002 +
//                Text003 +
//                Text004,false,
//                FiscalYearStartDate,FiscalYearEndDate)
//           then
//             exit;

//           Reset;

//           SetRange("Starting Date",FiscalYearStartDate,HRLeavePeriods2."Starting Date");
//           ModifyAll(Closed,true);

//           SetRange("Starting Date",FiscalYearStartDate,HRLeavePeriods3."Starting Date");
//           ModifyAll("Date Locked",true);

//           Reset;
//         end;
//     end;


//     procedure fnLeavebalance(lvApplicationcode: Code[10];lvLeavetype: Code[10];lvStaffno: Code[10];lvBalance: Decimal)
//     var
//         lvLeavebalance: Record UnknownRecord55543;
//         HRLeaveTypes: Record UnknownRecord55570;
//     begin
//         /*IF Balance = 0 THEN EXIT;
//         WITH fnLeavebalance DO BEGIN
//             INIT;
//             "No.":= Staffno;
//             "Transaction Code" := TCode;
//             "Group Text" := TGroup;
//             "Transaction Name" := Description;
//             INSERT;
//            //Update the prEmployee Transactions  with the Amount
//            fnLeavebalance( "No.","Transaction Code",Amount,"Period Month","Period Year","Payroll Period");
//         END;
//          */

//         lvLeavebalance.Reset;
//          lvLeavebalance.SetRange(lvLeavebalance."No.",lvStaffno);
//          lvLeavebalance.SetRange(lvLeavebalance."Leave Type Filter",lvLeavetype);
//          if lvLeavebalance.Find('-') then begin
//         if lvLeavebalance."Leave Balance" >=  HRLeaveTypes."Max Carry Forward Days" then begin
//         lvLeavebalance."Reimbursed Leave Days":=HRLeaveTypes."Max Carry Forward Days";
//         end else if
//         lvLeavebalance."Leave Balance" < HRLeaveTypes."Max Carry Forward Days" then
//         lvLeavebalance."Reimbursed Leave Days":=lvLeavebalance."Leave Balance";
//         lvLeavebalance.Modify;


//         /*SETFILTER("Leave Type Filter","HR Employees".GETFILTER("HR Employees"."Leave Type Filter"));

//         HRLeaveTypes.GET("HR Employees".GETFILTER("Leave Type Filter"));

//         VALIDATE("Allocated Leave Days");

//         IF "HR Employees"."Leave Balance" >=  HRLeaveTypes."Max Carry Forward Days" THEN BEGIN
//         "HR Employees"."Reimbursed Leave Days":=HRLeaveTypes."Max Carry Forward Days";
//         END ELSE IF
//         "HR Employees"."Leave Balance" < HRLeaveTypes."Max Carry Forward Days" THEN
//         "HR Employees"."Reimbursed Leave Days":="HR Employees"."Leave Balance";
//         "HR Employees".MODIFY;
//           */
//         end;

//     end;
// }

