// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
// Codeunit 59000 "Test Report-PrintAUT"
// {

//     trigger OnRun()
//     begin
//     end;

//     var
//         SalesHeader: Record "Sales Header";
//         PurchHeader: Record "Purchase Header";
//         ReportSelection: Record "Report Selections";
//         GenJnlTemplate: Record "Gen. Journal Template";
//         VATStmtTmpl: Record "VAT Statement Template";
//         ItemJnlTemplate: Record "Item Journal Template";
//         IntraJnlTemplate: Record "Intrastat Jnl. Template";
//         GenJnlLine: Record "Gen. Journal Line";
//         VATStmtLine: Record "VAT Statement Line";
//         ItemJnlLine: Record "Item Journal Line";
//         IntrastatJnlLine: Record "Intrastat Jnl. Line";
//         ResJnlTemplate: Record "Res. Journal Template";
//         ResJnlLine: Record "Res. Journal Line";
//         JobJnlTemplate: Record "Job Journal Template";
//         JobJnlLine: Record "Job Journal Line";
//         BankAccRecon: Record "Bank Acc. ReconciliationAUT";
//         FAJnlLine: Record "FA Journal Line";
//         FAJnlTemplate: Record "FA Journal Template";
//         InsuranceJnlLine: Record "Insurance Journal Line";
//         InsuranceJnlTempl: Record "Insurance Journal Template";
//         SalesSetup: Record "Sales & Receivables Setup";
//         PurchSetup: Record "Purchases & Payables Setup";
//         SalesLine: Record "Sales Line";
//         PurchLine: Record "Purchase Line";
//         ServiceHeader: Record "Service Header";
//         ServLine: Record "Service Line";
//         WhseJnlTemplate: Record "Warehouse Journal Template";
//         WhseJnlLine: Record "Warehouse Journal Line";
//         BankRecHdr: Record UnknownRecord10120;
//         InvtPeriod: Record "Inventory Period";
//         SalesCalcDisc: Codeunit "Sales-Calc. Discount";
//         PurchCalcDisc: Codeunit "Purch.-Calc.Discount";
//         ServCalcDisc: Codeunit "Service-Calc. Discount";

//     local procedure PrintReport(ReportUsage: Integer)
//     begin
//         ReportSelection.Reset;
//         ReportSelection.SetRange(Usage,ReportUsage);
//         ReportSelection.Find('-');
//         repeat
//           ReportSelection.TestField("Report ID");
//           case ReportUsage of
//             ReportSelection.Usage::"S.Test Prepmt.",
//             ReportSelection.Usage::"S.Test":
//               Report.Run(ReportSelection."Report ID",true,false,SalesHeader);
//             ReportSelection.Usage::"P.Test Prepmt.",
//             ReportSelection.Usage::"P.Test":
//               Report.Run(ReportSelection."Report ID",true,false,PurchHeader);
//             ReportSelection.Usage::"B.Recon.Test":
//               Report.Run(ReportSelection."Report ID",true,false,BankAccRecon);
//             ReportSelection.Usage::"SM.Test":
//               Report.Run(ReportSelection."Report ID",true,false,ServiceHeader);
//             ReportSelection.Usage::"Invt. Period Test":
//               Report.Run(ReportSelection."Report ID",true,false,InvtPeriod);
//           end;
//         until ReportSelection.Next = 0;
//     end;


//     procedure PrintGenJnlBatch(GenJnlBatch: Record "Gen. Journal Batch")
//     begin
//         GenJnlBatch.SetRecfilter;
//         GenJnlTemplate.Get(GenJnlBatch."Journal Template Name");
//         GenJnlTemplate.TestField("Test Report ID");
//         Report.Run(GenJnlTemplate."Test Report ID",true,false,GenJnlBatch);
//     end;


//     procedure PrintGenJnlLine(var NewGenJnlLine: Record "Gen. Journal Line")
//     begin
//         GenJnlLine.Copy(NewGenJnlLine);
//         GenJnlLine.SetRange("Journal Template Name",GenJnlLine."Journal Template Name");
//         GenJnlLine.SetRange("Journal Batch Name",GenJnlLine."Journal Batch Name");
//         GenJnlTemplate.Get(GenJnlLine."Journal Template Name");
//         GenJnlTemplate.TestField("Test Report ID");
//         Report.Run(GenJnlTemplate."Test Report ID",true,false,GenJnlLine);
//     end;


//     procedure PrintVATStmtName(VATStmtName: Record "VAT Statement Name")
//     begin
//         VATStmtName.SetRecfilter;
//         VATStmtTmpl.Get(VATStmtName."Statement Template Name");
//         VATStmtTmpl.TestField("VAT Statement Report ID");
//         Report.Run(VATStmtTmpl."VAT Statement Report ID",true,false,VATStmtName);
//     end;


//     procedure PrintVATStmtLine(var NewVATStatementLine: Record "VAT Statement Line")
//     begin
//         VATStmtLine.Copy(NewVATStatementLine);
//         VATStmtLine.SetRange("Statement Template Name",VATStmtLine."Statement Template Name");
//         VATStmtLine.SetRange("Statement Name",VATStmtLine."Statement Name");
//         VATStmtTmpl.Get(VATStmtLine."Statement Template Name");
//         VATStmtTmpl.TestField("VAT Statement Report ID");
//         Report.Run(VATStmtTmpl."VAT Statement Report ID",true,false,VATStmtLine);
//     end;


//     procedure PrintItemJnlBatch(ItemJnlBatch: Record "Item Journal Batch")
//     begin
//         ItemJnlBatch.SetRecfilter;
//         ItemJnlTemplate.Get(ItemJnlBatch."Journal Template Name");
//         ItemJnlTemplate.TestField("Test Report ID");
//         Report.Run(ItemJnlTemplate."Test Report ID",true,false,ItemJnlBatch);
//     end;


//     procedure PrintItemJnlLine(var NewItemJnlLine: Record "Item Journal Line")
//     begin
//         ItemJnlLine.Copy(NewItemJnlLine);
//         ItemJnlLine.SetRange("Journal Template Name",ItemJnlLine."Journal Template Name");
//         ItemJnlLine.SetRange("Journal Batch Name",ItemJnlLine."Journal Batch Name");
//         ItemJnlTemplate.Get(ItemJnlLine."Journal Template Name");
//         ItemJnlTemplate.TestField("Test Report ID");
//         Report.Run(ItemJnlTemplate."Test Report ID",true,false,ItemJnlLine);
//     end;


//     procedure PrintIntrastatJnlLine(var NewIntrastatJnlLine: Record "Intrastat Jnl. Line")
//     begin
//         IntrastatJnlLine.Copy(NewIntrastatJnlLine);
//         IntrastatJnlLine.SetCurrentkey(Type,"Country/Region Code","Tariff No.","Transaction Type","Transport Method");
//         IntrastatJnlLine.SetRange("Journal Template Name",IntrastatJnlLine."Journal Template Name");
//         IntrastatJnlLine.SetRange("Journal Batch Name",IntrastatJnlLine."Journal Batch Name");
//         IntraJnlTemplate.Get(IntrastatJnlLine."Journal Template Name");
//         IntraJnlTemplate.TestField("Checklist Report ID");
//         Report.Run(IntraJnlTemplate."Checklist Report ID",true,false,IntrastatJnlLine);
//     end;


//     procedure PrintResJnlBatch(ResJnlBatch: Record "Res. Journal Batch")
//     begin
//         ResJnlBatch.SetRecfilter;
//         ResJnlTemplate.Get(ResJnlBatch."Journal Template Name");
//         ResJnlTemplate.TestField("Test Report ID");
//         Report.Run(ResJnlTemplate."Test Report ID",true,false,ResJnlBatch);
//     end;


//     procedure PrintResJnlLine(var NewResJnlLine: Record "Res. Journal Line")
//     begin
//         ResJnlLine.Copy(NewResJnlLine);
//         ResJnlLine.SetRange("Journal Template Name",ResJnlLine."Journal Template Name");
//         ResJnlLine.SetRange("Journal Batch Name",ResJnlLine."Journal Batch Name");
//         ResJnlTemplate.Get(ResJnlLine."Journal Template Name");
//         ResJnlTemplate.TestField("Test Report ID");
//         Report.Run(ResJnlTemplate."Test Report ID",true,false,ResJnlLine);
//     end;


//     procedure PrintSalesHeader(NewSalesHeader: Record "Sales Header")
//     begin
//         SalesHeader := NewSalesHeader;
//         SalesHeader.SetRecfilter;
//         SalesSetup.Get;
//         if SalesSetup."Calc. Inv. Discount" then begin
//           SalesLine.Reset;
//           SalesLine.SetRange("Document Type",SalesHeader."Document Type");
//           SalesLine.SetRange("Document No.",SalesHeader."No.");
//           SalesLine.FindFirst;
//           SalesCalcDisc.Run(SalesLine);
//           SalesHeader.Get(SalesHeader."Document Type",SalesHeader."No.");
//           Commit;
//         end;
//         PrintReport(ReportSelection.Usage::"S.Test");
//     end;


//     procedure PrintSalesHeaderPrepmt(NewSalesHeader: Record "Sales Header")
//     begin
//         SalesHeader := NewSalesHeader;
//         SalesHeader.SetRecfilter;
//         PrintReport(ReportSelection.Usage::"S.Test Prepmt.");
//     end;


//     procedure PrintPurchHeader(NewPurchHeader: Record "Purchase Header")
//     begin
//         PurchHeader := NewPurchHeader;
//         PurchHeader.SetRecfilter;
//         PurchSetup.Get;
//         if PurchSetup."Calc. Inv. Discount" then begin
//           PurchLine.Reset;
//           PurchLine.SetRange("Document Type",PurchHeader."Document Type");
//           PurchLine.SetRange("Document No.",PurchHeader."No.");
//           PurchLine.FindFirst;
//           PurchCalcDisc.Run(PurchLine);
//           PurchHeader.Get(PurchHeader."Document Type",PurchHeader."No.");
//           Commit;
//         end;
//         PrintReport(ReportSelection.Usage::"P.Test");
//     end;


//     procedure PrintPurchHeaderPrepmt(NewPurchHeader: Record "Purchase Header")
//     begin
//         PurchHeader := NewPurchHeader;
//         PurchHeader.SetRecfilter;
//         PrintReport(ReportSelection.Usage::"P.Test Prepmt.");
//     end;


//     procedure PrintBankAccRecon(NewBankAccRecon: Record "Bank Acc. ReconciliationAUT")
//     begin
//         BankAccRecon := NewBankAccRecon;
//         BankAccRecon.SetRecfilter;
//         PrintReport(ReportSelection.Usage::"B.Recon.Test");
//     end;


//     procedure PrintFAJnlBatch(FAJnlBatch: Record "FA Journal Batch")
//     begin
//         FAJnlBatch.SetRecfilter;
//         FAJnlTemplate.Get(FAJnlBatch."Journal Template Name");
//         FAJnlTemplate.TestField("Test Report ID");
//         Report.Run(FAJnlTemplate."Test Report ID",true,false,FAJnlBatch);
//     end;


//     procedure PrintFAJnlLine(var NewFAJnlLine: Record "FA Journal Line")
//     begin
//         FAJnlLine.Copy(NewFAJnlLine);
//         FAJnlLine.SetRange("Journal Template Name",FAJnlLine."Journal Template Name");
//         FAJnlLine.SetRange("Journal Batch Name",FAJnlLine."Journal Batch Name");
//         FAJnlTemplate.Get(FAJnlLine."Journal Template Name");
//         FAJnlTemplate.TestField("Test Report ID");
//         Report.Run(FAJnlTemplate."Test Report ID",true,false,FAJnlLine);
//     end;


//     procedure PrintInsuranceJnlBatch(InsuranceJnlBatch: Record "Insurance Journal Batch")
//     begin
//         InsuranceJnlBatch.SetRecfilter;
//         InsuranceJnlTempl.Get(InsuranceJnlBatch."Journal Template Name");
//         InsuranceJnlTempl.TestField("Test Report ID");
//         Report.Run(InsuranceJnlTempl."Test Report ID",true,false,InsuranceJnlBatch);
//     end;


//     procedure PrintInsuranceJnlLine(var NewInsuranceJnlLine: Record "Insurance Journal Line")
//     begin
//         InsuranceJnlLine.Copy(NewInsuranceJnlLine);
//         InsuranceJnlLine.SetRange("Journal Template Name",InsuranceJnlLine."Journal Template Name");
//         InsuranceJnlLine.SetRange("Journal Batch Name",InsuranceJnlLine."Journal Batch Name");
//         InsuranceJnlTempl.Get(InsuranceJnlLine."Journal Template Name");
//         InsuranceJnlTempl.TestField("Test Report ID");
//         Report.Run(InsuranceJnlTempl."Test Report ID",true,false,InsuranceJnlLine);
//     end;


//     procedure PrintServiceHeader(NewServiceHeader: Record "Service Header")
//     begin
//         ServiceHeader := NewServiceHeader;
//         ServiceHeader.SetRecfilter;
//         SalesSetup.Get;
//         if SalesSetup."Calc. Inv. Discount" then begin
//           ServLine.Reset;
//           ServLine.SetRange("Document Type",ServiceHeader."Document Type");
//           ServLine.SetRange("Document No.",ServiceHeader."No.");
//           ServLine.FindFirst;
//           ServCalcDisc.Run(ServLine);
//           ServiceHeader.Get(ServiceHeader."Document Type",ServiceHeader."No.");
//           Commit;
//         end;
//         PrintReport(ReportSelection.Usage::"SM.Test");
//     end;


//     procedure PrintWhseJnlBatch(WhseJnlBatch: Record "Warehouse Journal Batch")
//     begin
//         WhseJnlBatch.SetRecfilter;
//         WhseJnlTemplate.Get(WhseJnlBatch."Journal Template Name");
//         WhseJnlTemplate.TestField("Test Report ID");
//         Report.Run(WhseJnlTemplate."Test Report ID",true,false,WhseJnlBatch);
//     end;


//     procedure PrintWhseJnlLine(var NewWhseJnlLine: Record "Warehouse Journal Line")
//     begin
//         WhseJnlLine.Copy(NewWhseJnlLine);
//         WhseJnlLine.SetRange("Journal Template Name",WhseJnlLine."Journal Template Name");
//         WhseJnlLine.SetRange("Journal Batch Name",WhseJnlLine."Journal Batch Name");
//         WhseJnlTemplate.Get(WhseJnlLine."Journal Template Name");
//         WhseJnlTemplate.TestField("Test Report ID");
//         Report.Run(WhseJnlTemplate."Test Report ID",true,false,WhseJnlLine);
//     end;


//     procedure PrintInvtPeriod(NewInvtPeriod: Record "Inventory Period")
//     begin
//         InvtPeriod := NewInvtPeriod;
//         InvtPeriod.SetRecfilter;
//         PrintReport(ReportSelection.Usage::"Invt. Period Test");
//     end;


//     procedure PrintJobJnlBatch(JobJnlBatch: Record "Job Journal Batch")
//     begin
//         JobJnlBatch.SetRecfilter;
//         JobJnlTemplate.Get(JobJnlBatch."Journal Template Name");
//         JobJnlTemplate.TestField("Test Report ID");
//         Report.Run(JobJnlTemplate."Test Report ID",true,false,JobJnlBatch);
//     end;


//     procedure PrintJobJnlLine(var NewJobJnlLine: Record "Job Journal Line")
//     begin
//         JobJnlLine.Copy(NewJobJnlLine);
//         JobJnlLine.SetRange("Journal Template Name",JobJnlLine."Journal Template Name");
//         JobJnlLine.SetRange("Journal Batch Name",JobJnlLine."Journal Batch Name");
//         JobJnlTemplate.Get(JobJnlLine."Journal Template Name");
//         JobJnlTemplate.TestField("Test Report ID");
//         Report.Run(JobJnlTemplate."Test Report ID",true,false,JobJnlLine);
//     end;


//     procedure PrintBankRec(NewBankRecHdr: Record UnknownRecord10120)
//     begin
//         BankRecHdr := NewBankRecHdr;
//         BankRecHdr.SetRecfilter;
//         ReportSelection.Reset;
//         ReportSelection.SetRange(Usage,ReportSelection.Usage::"B.Recon.Test");
//         ReportSelection.Find('-');
//         Report.Run(ReportSelection."Report ID",true,false,BankRecHdr);
//     end;
// }

