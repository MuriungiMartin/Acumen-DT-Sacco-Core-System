// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
// Codeunit 55581 "LeaveJnlManagementoldd"
// {
//     Permissions = TableData "Insurance Journal Template"=imd,
//                   TableData "Insurance Journal Batch"=imd;

//     trigger OnRun()
//     begin
//     end;

//     var
//         Text000: label 'Leave';
//         Text001: label 'Leave Journal';
//         Text002: label 'DEFAULT';
//         Text003: label 'Default Journal';
//         OldInsuranceNo: Code[20];
//         OldFANo: Code[20];
//         OpenFromBatch: Boolean;


//     procedure TemplateSelection(FormID: Integer;var InsuranceJnlLine: Record "Loan Product Cycles";var JnlSelected: Boolean)
//     var
//         InsuranceJnlTempl: Record "prPayroll Periods.";
//     begin
//         JnlSelected := true;

//         InsuranceJnlTempl.Reset;
//         InsuranceJnlTempl.SetRange(Closed,FormID);

//         case InsuranceJnlTempl.Count of

//            0:

//           begin
//               InsuranceJnlTempl.Reset;
//               InsuranceJnlTempl.SetRange(InsuranceJnlTempl."Period Month",Text000);
//               if InsuranceJnlTempl.Find('-') then
//                InsuranceJnlTempl.DeleteAll;

//               InsuranceJnlTempl.Init;
//               InsuranceJnlTempl."Period Month" := Text000;
//               InsuranceJnlTempl."Period Year" := Text001;
//               InsuranceJnlTempl.Validate(Closed);
//               InsuranceJnlTempl.Insert;
//               Commit;
//             end;

//           1:
//             InsuranceJnlTempl.Find('-');
//           else
//             JnlSelected := Page.RunModal(0,InsuranceJnlTempl) = Action::LookupOK;
//         end;
//         if JnlSelected then begin
//           InsuranceJnlLine.FilterGroup := 2;
//           InsuranceJnlLine.SetRange("Product Code",InsuranceJnlTempl."Period Month");
//           InsuranceJnlLine.FilterGroup := 0;
//           if OpenFromBatch then begin
//             InsuranceJnlLine."Product Code" := '';
//             Page.Run(InsuranceJnlTempl.Closed,InsuranceJnlLine);
//           end;
//         end;
//     end;


//     procedure TemplateSelectionFromBatch(var InsuranceJnlBatch: Record "Inspection Header")
//     var
//         InsuranceJnlLine: Record "Loan Product Cycles";
//         InsuranceJnlTempl: Record "prPayroll Periods.";
//         JnlSelected: Boolean;
//     begin
//         OpenFromBatch := true;
//         InsuranceJnlTempl.Get(InsuranceJnlBatch."No.");
//         InsuranceJnlTempl.TestField(Closed);
//         InsuranceJnlBatch.TestField("Purchase Order No.");

//         InsuranceJnlLine.FilterGroup := 2;
//         InsuranceJnlLine.SetRange("Product Code",InsuranceJnlTempl."Period Month");
//         InsuranceJnlLine.FilterGroup := 0;

//         InsuranceJnlLine."Product Code" := '';
//         InsuranceJnlLine.Cycle := InsuranceJnlBatch."Purchase Order No.";
//         Page.Run(InsuranceJnlTempl.Closed,InsuranceJnlLine);
//     end;


//     procedure OpenJournal(var CurrentJnlBatchName: Code[10];var InsuranceJnlLine: Record "Loan Product Cycles")
//     begin
//         CheckTemplateName(InsuranceJnlLine.GetRangemax("Product Code"),CurrentJnlBatchName);
//         InsuranceJnlLine.FilterGroup := 2;
//         InsuranceJnlLine.SetRange(Cycle,CurrentJnlBatchName);
//         InsuranceJnlLine.FilterGroup := 0;
//     end;


//     procedure OpenJnlBatch(var InsuranceJnlBatch: Record "Inspection Header")
//     var
//         InsuranceJnlTemplate: Record "prPayroll Periods.";
//         InsuranceJnlLine: Record "Loan Product Cycles";
//         JnlSelected: Boolean;
//     begin
//         if InsuranceJnlBatch.GetFilter("No.") <> '' then
//           exit;
//         InsuranceJnlBatch.FilterGroup(2);
//         if InsuranceJnlBatch.GetFilter("No.") <> '' then begin
//           InsuranceJnlBatch.FilterGroup(0);
//           exit;
//         end;
//         InsuranceJnlBatch.FilterGroup(0);

//         if not InsuranceJnlBatch.Find('-') then begin
//           if not InsuranceJnlTemplate.Find('-') then
//             TemplateSelection(0,InsuranceJnlLine,JnlSelected);
//           if InsuranceJnlTemplate.Find('-') then
//             CheckTemplateName(InsuranceJnlTemplate."Period Month",InsuranceJnlBatch."Purchase Order No.");
//         end;
//         InsuranceJnlBatch.Find('-');
//         JnlSelected := true;
//         if InsuranceJnlBatch.GetFilter("No.") <> '' then
//            InsuranceJnlTemplate.SetRange("Period Month",InsuranceJnlBatch.GetFilter("No."));
//         case InsuranceJnlTemplate.Count of
//           1:
//             InsuranceJnlTemplate.Find('-');
//           else
//             JnlSelected := Page.RunModal(0,InsuranceJnlTemplate) = Action::LookupOK;
//         end;
//         if not JnlSelected then
//           Error('');

//         InsuranceJnlBatch.FilterGroup(2);
//         InsuranceJnlBatch.SetRange("No.",InsuranceJnlTemplate."Period Month");
//         InsuranceJnlBatch.FilterGroup(0);
//     end;


//     procedure CheckName(CurrentJnlBatchName: Code[10];var InsuranceJnlLine: Record "Loan Product Cycles")
//     var
//         InsuranceJnlBatch: Record "Inspection Header";
//     begin
//         InsuranceJnlBatch.Get(InsuranceJnlLine.GetRangemax("Product Code"),CurrentJnlBatchName);
//     end;


//     procedure SetName(CurrentJnlBatchName: Code[10];var InsuranceJnlLine: Record "Loan Product Cycles")
//     begin
//         InsuranceJnlLine.FilterGroup := 2;
//         InsuranceJnlLine.SetRange(Cycle,CurrentJnlBatchName);
//         InsuranceJnlLine.FilterGroup := 0;
//         if InsuranceJnlLine.Find('-') then;
//     end;


//     procedure LookupName(var CurrentJnlBatchName: Code[10];var InsuranceJnlLine: Record "Loan Product Cycles"): Boolean
//     var
//         InsuranceJnlBatch: Record "Inspection Header";
//     begin
//         Commit;

//         InsuranceJnlBatch."No." := InsuranceJnlLine.GetRangemax("Product Code");
//         InsuranceJnlBatch."Purchase Order No." := InsuranceJnlLine.GetRangemax(Cycle);
//         InsuranceJnlBatch.FilterGroup(2);
//         InsuranceJnlBatch.SetRange("No.",InsuranceJnlBatch."No.");
//         InsuranceJnlBatch.FilterGroup(0);
//         if Page.RunModal(0,InsuranceJnlBatch) = Action::LookupOK then begin
//           CurrentJnlBatchName := InsuranceJnlBatch."Purchase Order No.";
//           SetName(CurrentJnlBatchName,InsuranceJnlLine);
//         end;
//     end;


//     procedure CheckTemplateName(CurrentJnlTemplateName: Code[10];var CurrentJnlBatchName: Code[10])
//     var
//         InsuranceJnlBatch: Record "Inspection Header";
//     begin
//         if not InsuranceJnlBatch.Get(CurrentJnlTemplateName,CurrentJnlBatchName) then begin
//           InsuranceJnlBatch.SetRange("No.",CurrentJnlTemplateName);
//           if not InsuranceJnlBatch.Find('-') then begin
//             InsuranceJnlBatch.Init;
//             InsuranceJnlBatch."No." := CurrentJnlTemplateName;
//             InsuranceJnlBatch.SetupNewBatch;
//             InsuranceJnlBatch."Purchase Order No." := Text002;
//             InsuranceJnlBatch."Supplier No." := Text003;
//             InsuranceJnlBatch.Insert(true);
//             Commit;
//           end;
//           CurrentJnlBatchName := InsuranceJnlBatch."Purchase Order No.";
//         end;
//     end;


//     procedure GetDescriptions(InsuranceJnlLine: Record "Loan Product Cycles";var InsuranceDescription: Text[30];var FADescription: Text[30])
//     var
//         Insurance: Record "prEmployee P9 Info";
//         FA: Record "Salary Processing Header";
//     begin
//         if InsuranceJnlLine."Document No." <> OldInsuranceNo then begin
//           InsuranceDescription := '';
//           if InsuranceJnlLine."Document No." <> '' then
//             if Insurance.Get(InsuranceJnlLine."Document No.") then
//               InsuranceDescription := Insurance.Description;
//           OldInsuranceNo := InsuranceJnlLine."Document No.";
//         end;
//         if InsuranceJnlLine."Staff No." <> OldFANo then begin
//           FADescription := '';
//           if InsuranceJnlLine."Staff No." <> '' then
//             if FA.Get(InsuranceJnlLine."Staff No.") then
//               FADescription := FA."No. Series";
//           OldFANo := FA.No;
//         end;
//     end;
// }

