// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
// Codeunit 55489 "Payment Voucher Apply"
// {
//     TableNo = UnknownTable55904;

//     trigger OnRun()
//     begin
//         PVLine.Copy(Rec);
//         with PVLine do begin
//           PayToVendorNo := "Account No." ;
//           VendLedgEntry.SetCurrentkey("Vendor No.",Open);
//           VendLedgEntry.SetRange("Vendor No.",PayToVendorNo);
//           VendLedgEntry.SetRange(Open,true);
//           if "Applies-to ID" = '' then
//             "Applies-to ID" := No;
//           if "Applies-to ID" = '' then
//             Error(
//               Text000,
//               FieldCaption(No),FieldCaption("Applies-to ID"));
//           //ApplyVendEntries."SetPVLine-Delete"(PVLine,PVLine.FIELDNO("Applies-to ID"));
//           ApplyVendEntries.SetPVLine(PVLine,VendLedgEntry,PVLine.FieldNo("Applies-to ID"));
//           ApplyVendEntries.SetRecord(VendLedgEntry);
//           ApplyVendEntries.SetTableview(VendLedgEntry);
//           ApplyVendEntries.LookupMode(true);
//           OK := ApplyVendEntries.RunModal = Action::LookupOK;
//           Clear(ApplyVendEntries);
//           if not OK then
//             exit;
//           VendLedgEntry.Reset;
//           VendLedgEntry.SetCurrentkey("Vendor No.",Open);
//           VendLedgEntry.SetRange("Vendor No.",PayToVendorNo);
//           VendLedgEntry.SetRange(Open,true);
//           VendLedgEntry.SetRange("Applies-to ID","Applies-to ID");
//           if VendLedgEntry.Find('-') then begin
//             "Applies-to Doc. Type" := 0;
//             "Applies-to Doc. No." := '';
//           end else
//             "Applies-to ID" := '';

//           Modify;
//         end;
//     end;

//     var
//         Text000: label 'You must specify %1 or %2.';
//         PVLine: Record UnknownRecord55894;
//         VendLedgEntry: Record "Vendor Ledger Entry";
//         PayToVendorNo: Code[20];
//         OK: Boolean;
//         ApplyVendEntries: Page "Apply Vendor Entries";
// }

