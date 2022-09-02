#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 53918 "Job Create-PO 1"
{

    trigger OnRun()
    begin
    end;

    var
        Currency: Record Currency;
        SalesHeader: Record "Purchase Header";
        SalesHeader2: Record "Purchase Header";
        SalesLine: Record "Purchase Line";
        TempJobPlanningLine: Record UnknownRecord53928 temporary;
        Text000: label 'The lines were successfully transferred to an Order.';
        Text001: label 'The lines were not transferred to an Order.';
        Text002: label 'There were no lines to transfer.';
        Text003: label '%1 %2 = %3 " for %4 were successfully transferred to invoice %5.';
        Text004: label 'You must specify Order No. or New Order.';
        Text005: label 'You must specify Credit Memo No. or New Order.';
        Text007: label 'You must specify %1.';
        TransferExtendedText: Codeunit "Transfer Extended Text";
        JobInvCurrency: Boolean;
        UpdateExchangeRates: Boolean;
        Text008: label 'The lines were successfully transferred to a credit memo.';
        Text009: label 'The selected planning lines must have the same %1.';
        Text010: label 'The currency dates on all planning lines will be updated based on the invoice posting date because there is a difference in currency exchange rates. Recalculations will be based on the Exch. Calculation setup for the Cost and Price values for the job. Do you want to continue?';


    procedure CreateSalesInvoice(var JobPlanningLine: Record UnknownRecord53928;CrMemo: Boolean)
    var
        SalesHeader: Record "Purchase Header";
        JT: Record UnknownRecord53926;
        GetSalesInvoiceNo: Report "Job Transfer to Sales Invoice";
        GetSalesCrMemoNo: Report "Job Transfer to Credit Memo";
        Done: Boolean;
        NewInvoice: Boolean;
        PostingDate: Date;
        InvoiceNo: Code[20];
    begin
        JT.Get(JobPlanningLine."Grant No.",JobPlanningLine."Grant Task No.");
        if not CrMemo then begin
          GetSalesInvoiceNo.SetCustomer(JobPlanningLine."Grant No.");
          GetSalesInvoiceNo.RunModal;
          GetSalesInvoiceNo.GetInvoiceNo(Done,NewInvoice,PostingDate,InvoiceNo);
        end else begin
          GetSalesCrMemoNo.SetCustomer(JobPlanningLine."Grant No.");
          GetSalesCrMemoNo.RunModal;
          GetSalesCrMemoNo.GetCreditMemoNo(Done,NewInvoice,PostingDate,InvoiceNo);
        end;

        if Done then  begin
          if (PostingDate = 0D) and NewInvoice then
            Error(Text007,SalesHeader.FieldCaption("Posting Date"));
          if (InvoiceNo = '') and not NewInvoice then begin
            if CrMemo then
              Error(Text005);
            Error(Text004);
          end;
          CreateSalesInvoiceLines(
            JobPlanningLine."Grant No.",JobPlanningLine,InvoiceNo,NewInvoice,PostingDate,CrMemo);
        end;
    end;


    procedure CreateSalesInvoiceLines(JobNo: Code[20];var JobPlanningLine: Record UnknownRecord53928;InvoiceNo: Code[20];NewInvoice: Boolean;PostingDate: Date;CreditMemo: Boolean)
    var
        Cust: Record Customer;
        Job: Record UnknownRecord53913;
        LineCounter: Integer;
    begin
        ClearAll;
        Job.Get(JobNo);
        if Job.Blocked = Job.Blocked::"2" then
          Job.TestBlocked;
        if Job."Currency Code" = '' then
          JobInvCurrency := Job."Invoice Currency Code" <> '';
        Job.TestField(Job."Bill-to Partner No.");
        Cust.Get(Job."Bill-to Partner No.");
        if CreditMemo then
          SalesHeader2."Document Type" := SalesHeader2."document type"::"Credit Memo"
        else
          SalesHeader2."Document Type" := SalesHeader2."document type"::Order;

        if not NewInvoice then
          SalesHeader.Get(SalesHeader2."Document Type",InvoiceNo);

        if JobPlanningLine.Find('-') then
          repeat
            if JobPlanningLine."Contract Line" and not JobPlanningLine.Transferred then begin
              LineCounter := LineCounter + 1;
              if JobPlanningLine."Grant No." <> JobNo then
                Error(Text009,JobPlanningLine.FieldCaption("Grant No."));
              if NewInvoice then
                TestExchangeRate(JobPlanningLine,PostingDate)
              else
                TestExchangeRate(JobPlanningLine,SalesHeader."Posting Date");
            end;
          until JobPlanningLine.Next = 0;
        if LineCounter = 0 then
          Error(Text002);
        if NewInvoice then
          CreateSalesheader(Job,PostingDate)
        else
          TestSalesHeader(SalesHeader,Job);
        if JobPlanningLine.Find('-') then
          repeat
            if JobPlanningLine."Contract Line" and not JobPlanningLine.Transferred then begin
              if JobPlanningLine.Type in [JobPlanningLine.Type::"0",JobPlanningLine.Type::"1",
                JobPlanningLine.Type::"2"] then
                  JobPlanningLine.TestField("No.");
              CreateSalesLine(JobPlanningLine);
              if SalesHeader2."Document Type" = SalesHeader2."document type":: Order then begin
               // JobPlanningLine."Invoice Type" := JobPlanningLine."Invoice Type"::Order;
                JobPlanningLine."Invoice No." := SalesHeader."No.";
              end;
              if SalesHeader2."Document Type" = SalesHeader2."document type":: "Credit Memo" then begin
                JobPlanningLine."Invoice Type" := JobPlanningLine."invoice type"::"2";
                JobPlanningLine."Invoice No." := SalesHeader."No.";
              end;
              JobPlanningLine.Transferred := true;
              JobPlanningLine."Transferred Date" := PostingDate;
              JobPlanningLine.Modify;
            end;
          until JobPlanningLine.Next = 0;
        Commit;
        if CreditMemo then
          Message(Text008)
        else
          Message(Text000);
    end;


    procedure DeleteSalesInvoiceBuffer()
    begin
        ClearAll;
        TempJobPlanningLine.DeleteAll;
    end;


    procedure CreateSalesInvoiceJT(var JT2: Record UnknownRecord53926;PostingDate: Date;InvoicePerTask: Boolean;var NoOfInvoices: Integer;var OldJobNo: Code[20];var OldJTNo: Code[20];LastJobTask: Boolean)
    var
        Cust: Record Vendor;
        Job: Record UnknownRecord53913;
        JT: Record UnknownRecord53926;
        JobPlanningLine: Record UnknownRecord53928;
    begin
        ClearAll;
        if not LastJobTask then begin
          JT := JT2;
          if JT."Grant No." = '' then
            exit;
          if JT."Grant Task No." = '' then
            exit;
          JT.Find;
          if JT."Grant Task Type" <> JT."grant task type"::"0" then
            exit;
          Job.Get(JT."Grant No.");
        end;
        if LastJobTask then begin
          if not TempJobPlanningLine.Find('-') then
            exit;
          Job.Get(TempJobPlanningLine."Grant No.");
          JT.Get(TempJobPlanningLine."Grant No.",TempJobPlanningLine."Grant Task No.");
        end;
        Job.TestField(Job."Bill-to Partner No.");
        if Job.Blocked = Job.Blocked::"2" then
          Job.TestBlocked;
        if Job."Currency Code" = '' then
          JobInvCurrency := Job."Invoice Currency Code" <> '';
        Cust.Get(Job."Bill-to Partner No.");

        if CreateNewInvoice(JT,InvoicePerTask,OldJobNo,OldJTNo,LastJobTask) then begin
          Job.Get(TempJobPlanningLine."Grant No.");
          JT.Get(TempJobPlanningLine."Grant No.",TempJobPlanningLine."Grant Task No.");
          if Job."Currency Code" = '' then
            JobInvCurrency := Job."Invoice Currency Code" <> '';
          Cust.Get(Job."Bill-to Partner No.");
          NoOfInvoices := NoOfInvoices + 1;
          SalesHeader2."Document Type" := SalesHeader2."document type"::Order;
          CreateSalesheader(Job,PostingDate);
          if TempJobPlanningLine.Find('-') then
            repeat
              JobPlanningLine := TempJobPlanningLine;
              JobPlanningLine.Find;
              if JobPlanningLine.Type in [JobPlanningLine.Type::"0",JobPlanningLine.Type::"1",
                JobPlanningLine.Type::"2"] then
                  JobPlanningLine.TestField("No.");
              TestExchangeRate(JobPlanningLine,PostingDate);
              CreateSalesLine(JobPlanningLine);
              if SalesHeader2."Document Type" = SalesHeader2."document type":: Order then begin
                JobPlanningLine."Invoice Type" := JobPlanningLine."invoice type"::"1";
                JobPlanningLine."Invoice No." := SalesHeader."No.";
              end;
              if SalesHeader2."Document Type" = SalesHeader2."document type":: "Credit Memo" then begin
                JobPlanningLine."Invoice Type" := JobPlanningLine."invoice type"::"2";
                JobPlanningLine."Invoice No." := SalesHeader."No.";
              end;
              JobPlanningLine.Transferred := true;
              JobPlanningLine."Transferred Date" := PostingDate;
              JobPlanningLine.Modify;
            until TempJobPlanningLine.Next = 0;
          TempJobPlanningLine.DeleteAll;
        end;
        if LastJobTask then
          exit;
        JobPlanningLine.Reset;
        JobPlanningLine.SetCurrentkey("Grant No.","Grant Task No.");
        JobPlanningLine.SetRange("Grant No.",JT2."Grant No.");
        JobPlanningLine.SetRange("Grant Task No.",JT2."Grant Task No.");
        JobPlanningLine.SetFilter("Planning Date",JT2.GetFilter("Planning Date Filter"));

        if JobPlanningLine.Find('-') then
          repeat
            if JobPlanningLine."Contract Line" and not JobPlanningLine.Transferred then begin
              TempJobPlanningLine := JobPlanningLine;
              TempJobPlanningLine.Insert;
            end;
          until JobPlanningLine.Next = 0;
    end;

    local procedure CreateNewInvoice(var JT: Record UnknownRecord53926;InvoicePerTask: Boolean;var OldJobNo: Code[20];var OldJTNo: Code[20];LastJobTask: Boolean): Boolean
    var
        NewInvoice: Boolean;
    begin
        if LastJobTask then
          NewInvoice := true
        else begin
          if OldJobNo <> '' then begin
            if InvoicePerTask then
              if (OldJobNo <> JT."Grant No.") or (OldJTNo <> JT."Grant Task No.") then
                NewInvoice := true;
            if not InvoicePerTask then
              if OldJobNo <> JT."Grant No." then
                NewInvoice := true;
          end;
          OldJobNo := JT."Grant No.";
          OldJTNo := JT."Grant Task No.";
        end;
        if not TempJobPlanningLine.Find('-') then
          NewInvoice := false;
        exit(NewInvoice);
    end;

    local procedure CreateSalesheader(Job: Record UnknownRecord53913;PostingDate: Date)
    var
        SalesSetup: Record "Purchases & Payables Setup";
        Cust: Record Vendor;
    begin
        Clear(SalesHeader);
        SalesHeader."Document Type" := SalesHeader2."Document Type";
        SalesSetup.Get;
        if SalesHeader."Document Type" = SalesHeader."document type"::Order then
          SalesSetup.TestField("Invoice Nos.");
        if SalesHeader."Document Type" = SalesHeader."document type"::"Credit Memo" then
          SalesSetup.TestField("Credit Memo Nos.");
        SalesHeader."Posting Date" := PostingDate;
        SalesHeader."Buy-from Vendor No.":=Job."Bill-to Partner No.";
        SalesHeader.Validate("Buy-from Vendor No.");
        SalesHeader.Insert(true);
        Cust.Get(Job."Bill-to Partner No.");
        Cust.TestField(Cust."Pay-to Vendor No.",'');
        SalesHeader.Validate(SalesHeader."Pay-to Vendor No.",Job."Bill-to Partner No.");
        if Job."Currency Code" <> '' then
          SalesHeader.Validate("Currency Code",Job."Currency Code")
        else
          SalesHeader.Validate("Currency Code",Job."Invoice Currency Code");
        if PostingDate <> 0D then
          SalesHeader.Validate("Posting Date",PostingDate);
        UpdateSalesHeader(SalesHeader,Job);
        SalesHeader."Responsibility Center":=Job."Responsibility Center";
        SalesHeader.Validate("Responsibility Center" );
        SalesHeader."Posting Description":=Job.Description;
        SalesHeader."Shortcut Dimension 1 Code":=Job."Global Dimension 1 Code";
        SalesHeader.Validate("Shortcut Dimension 1 Code");
        SalesHeader."Shortcut Dimension 2 Code":=Job."Global Dimension 2 Code";
        SalesHeader.Validate("Shortcut Dimension 2 Code");
        SalesHeader.Modify(true);
    end;

    local procedure CreateSalesLine(var JobPlanningLine: Record UnknownRecord53928)
    var
        Job: Record UnknownRecord53913;
        Factor: Integer;
        JobTask: Record UnknownRecord53926;
    begin
        Factor := 1;
        if SalesHeader2."Document Type" = SalesHeader2."document type"::"Credit Memo" then
          Factor := -1;
        TestTransferred(JobPlanningLine);
        JobPlanningLine.TestField("Planning Date");
        Job.Get(JobPlanningLine."Grant No.");
        Clear(SalesLine);
        SalesLine."Document Type" := SalesHeader2."Document Type";
        SalesLine."Document No." := SalesHeader."No.";
        //Add Expense code here
        //SalesLine."Expense Code":=JobPlanningLine."Expense Code";
        if not JobInvCurrency then begin
          SalesHeader.TestField("Currency Code",JobPlanningLine."Currency Code");
          if Job."Currency Code" <> '' then
            SalesHeader.TestField("Currency Factor",JobPlanningLine."Currency Factor");
          SalesHeader.TestField("Currency Code",Job."Currency Code");
        end;
        if JobPlanningLine.Type = JobPlanningLine.Type::"3" then
          SalesLine.Validate(Type,SalesLine.Type::" ");
        if JobPlanningLine.Type = JobPlanningLine.Type::"2" then
          SalesLine.Validate(Type,SalesLine.Type::"G/L Account");
        if JobPlanningLine.Type = JobPlanningLine.Type::"1" then
          SalesLine.Validate(Type,SalesLine.Type::Item);
        //IF JobPlanningLine.Type = JobPlanningLine.Type::Resource THEN
          //SalesLine.VALIDATE(Type,SalesLine.Type::Resource);

        //Add Expense code here
        //SalesLine."Expense Code":=JobPlanningLine."Expense Code";

        if SalesLine.Type = SalesLine.Type::" " then begin
          SalesLine.Description := JobPlanningLine.Description;
          SalesLine."Description 2" := JobPlanningLine."Description 2";
        end else begin
          SalesLine.Validate("No.",JobPlanningLine."No.");
          SalesLine.Validate("Location Code",JobPlanningLine."Location Code");
          //SalesLine.VALIDATE("Work Type Code",JobPlanningLine."Work Type Code");
          SalesLine.Validate("Variant Code",JobPlanningLine."Variant Code");
          SalesLine.Validate("Unit of Measure Code",JobPlanningLine."Unit of Measure Code");
          SalesLine.Validate(Quantity,Factor * JobPlanningLine.Quantity);
          if JobInvCurrency then begin
            Currency.Get(SalesLine."Currency Code");
            SalesLine.Validate("Direct Unit Cost",
              ROUND(JobPlanningLine."Unit Price" * SalesHeader."Currency Factor",
                Currency."Unit-Amount Rounding Precision"));
          end else
            SalesLine.Validate("Direct Unit Cost",JobPlanningLine."Unit Price");
          SalesLine.Validate("Unit Cost (LCY)",JobPlanningLine."Unit Price (LCY)");
          SalesLine.Validate("Line Discount %",JobPlanningLine."Line Discount %");
          SalesLine.Description := JobPlanningLine.Description;
          SalesLine."Description 2" := JobPlanningLine."Description 2";
        end;
        if not SalesHeader."Prices Including VAT" then
          SalesLine.Validate("Job Line Type",JobPlanningLine."Grant Contract Entry No.");
        SalesLine."Job No." := JobPlanningLine."Grant No.";
        //SalesLine."Job Planning Line No." := JobPlanningLine."Grant Task No.";
        SalesLine."Line No." := GetNextLineNo(SalesLine);
        SalesLine.Insert(true);
          //Force the Dimensions here
          JobTask.Reset;
          JobTask.SetRange(JobTask."Grant No.",JobPlanningLine."Grant No.");
          JobTask.SetRange(JobTask."Grant Task No.",JobPlanningLine."Grant Task No.");
          if JobTask.Find('-') then begin
            SalesLine."Shortcut Dimension 1 Code":=JobTask."Global Dimension 1 Code";
            SalesLine.Validate("Shortcut Dimension 1 Code");
            SalesLine."Shortcut Dimension 2 Code":=JobTask."Global Dimension 2 Code";
            SalesLine.Validate("Shortcut Dimension 2 Code");
            SalesLine.Modify(true);
          end;

        if JobInvCurrency then begin
          JobPlanningLine."Invoice Currency" := true;
          JobPlanningLine."Inv. Curr. Unit Price" := SalesLine."Direct Unit Cost";
          JobPlanningLine."Inv. Curr. Line Amount" := SalesLine."Line Amount";
          JobPlanningLine."Invoice Currency Code" := Job."Invoice Currency Code";
          JobPlanningLine."Invoice Currency Factor" := SalesHeader."Currency Factor";
        end;

        if SalesHeader."Prices Including VAT" and
           (SalesLine.Type <> SalesLine.Type::" ")
        then begin
          if SalesLine."Currency Code" = '' then
            Currency.InitRoundingPrecision
          else
            Currency.Get(SalesLine."Currency Code");
          SalesLine."Direct Unit Cost" :=
            ROUND(
              SalesLine."Direct Unit Cost" * (1 + (SalesLine."VAT %" / 100)),
              Currency."Unit-Amount Rounding Precision");
          if SalesLine.Quantity <> 0 then begin
            SalesLine."Line Discount Amount" :=
              ROUND(
                SalesLine.Quantity * SalesLine."Direct Unit Cost" * SalesLine."Line Discount %" / 100,
                Currency."Amount Rounding Precision");
            SalesLine.Validate("Inv. Discount Amount",
              ROUND(
                SalesLine."Inv. Discount Amount" * (1 + (SalesLine."VAT %" / 100)),
                Currency."Amount Rounding Precision"));
          end;
        //  SalesLine.VALIDATE("Job Contract Entry No.",JobPlanningLine."Grant Contract Entry No.");
           SalesLine.Modify;
          JobPlanningLine."VAT Unit Price" := SalesLine."Direct Unit Cost";
          JobPlanningLine."VAT Line Discount Amount" := SalesLine."Line Discount Amount";
          JobPlanningLine."VAT Line Amount" := SalesLine."Line Amount";
          JobPlanningLine."VAT %" := SalesLine."VAT %";
        end;
        if TransferExtendedText.PurchCheckIfAnyExtText(SalesLine,false) then
          TransferExtendedText.InsertPurchExtText(SalesLine);
    end;

    local procedure GetNextLineNo(SalesLine: Record "Purchase Line"): Integer
    var
        NextLineNo: Integer;
    begin
        SalesLine.SetRange("Document Type",SalesLine."Document Type");
        SalesLine.SetRange("Document No.",SalesLine."Document No.");
        NextLineNo := 10000;
        if SalesLine.Find('+') then
          NextLineNo := SalesLine."Line No." + 10000;
        exit(NextLineNo);
    end;

    local procedure TestTransferred(JobPlanningLine: Record UnknownRecord53928)
    var
        SalesLine: Record "Purchase Line";
        JobTransferLine: Codeunit "Job Transfer Line";
    begin
        //SalesLine.SETCURRENTKEY("Job Contract Entry No.");
        /*SalesLine.SETRANGE("Job Contract Entry No.",JobPlanningLine."Grant Contract Entry No.");
        IF SalesLine.FIND('-') THEN
          ERROR(Text003,
            JobPlanningLine.TABLECAPTION,
            JobPlanningLine.FIELDCAPTION("Line No."),
            JobPlanningLine."Line No.",
            JobTransferLine.JTName(JobPlanningLine."Grant No.",JobPlanningLine."Grant Task No."),
            JobPlanningLine."Grant Contract Entry No.",
            SalesLine."Document No.");
        JobPlanningLine.TESTFIELD(Invoiced,FALSE);
         */

    end;


    procedure DeleteSalesLine(SalesLine: Record "Purchase Line")
    var
        JobPlanningLine: Record UnknownRecord55535;
    begin
        //JobPlanningLine.SETCURRENTKEY("Grant Contract Entry No.");
        /*JobPlanningLine.SETRANGE("Grant Contract Entry No.",SalesLine."Job Contract Entry No.");
        IF JobPlanningLine.FIND('-') THEN BEGIN
          JobPlanningLine.InitJobPlanningLine;
          JobPlanningLine.MODIFY;
        END;
         */

    end;


    procedure GetSalesInvoice(JobPlanningLine: Record UnknownRecord53928)
    var
        SalesHeader: Record "Purchase Header";
        SalesLine: Record "Purchase Line";
        SalesInvHeader: Record "Purch. Inv. Header";
        SalesInvLine: Record "Purch. Inv. Line";
        SalesCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        SalesCrMemoLine: Record "Purch. Cr. Memo Line";
    begin
        ClearAll;
        with JobPlanningLine do begin
          if "Line No." = 0 then
            exit;
        //  TESTFIELD("Grant No.");
        //  TESTFIELD("Grant Task No.");
        //  TESTFIELD(Transferred);
          if not Invoiced then begin
        //    SalesLine.SETCURRENTKEY("Job Contract Entry No.");
            SalesLine.SetRange(SalesLine."Job Planning Line No.","Grant Contract Entry No.");
            if SalesLine.Find('-') then begin
              if SalesHeader.Get(SalesLine."Document Type",SalesLine."Document No.") then;
              if SalesLine."Document Type" = SalesLine."document type"::Order then
                Page.RunModal(Page::"Purchase Order",SalesHeader)
              else
                Page.RunModal(Page::"Purchase Order",SalesHeader);
            end else
              Error(Text001);
          end;
          if Invoiced then begin
        //    SalesCrMemoLine.SETCURRENTKEY("Job Planning Line No.");
         //   SalesCrMemoLine.SETRANGE("Job Contract Entry No.","Grant Contract Entry No.");
         //   IF SalesCrMemoLine.FIND('-') THEN BEGIN;
         //     IF SalesCrMemoHeader.GET(SalesCrMemoLine."Document No.") THEN;
          //    PAGE.RUNMODAL(PAGE::"Purchase Order",SalesCrMemoHeader);
          //  END ELSE BEGIN
           //   SalesInvLine.SETCURRENTKEY("Job Contract Entry No.");
            //  SalesInvLine.SETRANGE("Job Contract Entry No.","Grant Contract Entry No.");
            //  SalesInvLine.FIND('-');
              if SalesInvHeader.Get(SalesInvLine."Document No.") then;
              Page.RunModal(Page::"Purchase Order",SalesInvHeader);
            end;
          end;
        //END;
    end;

    local procedure UpdateSalesHeader(var SalesHeader: Record "Purchase Header";Job: Record UnknownRecord53913)
    begin
        /*SalesHeader."Pay-to Contact No." := Job."Grant-to Contact No.";
        SalesHeader."Pay-to Contact No." := Job."Grant-to Contact";
        SalesHeader."Pay-to Name" := Job."Grant-to Name";
        SalesHeader."Pay-to Address" := Job."Grant-to Address";
        SalesHeader."Pay-to Address 2" := Job."Grant-to Address 2";
        SalesHeader."Pay-to City" := Job."Grant-to City";
        SalesHeader."Pay-to Post Code":= Job."Grant-to Post Code";
        
        SalesHeader."Buy-from Contact" := Job."Grant-to Contact No.";
        SalesHeader."Buy-from Contact" := Job."Grant-to Contact";
        SalesHeader."Buy-from Vendor Name" := Job."Grant-to Name";
        SalesHeader."Buy-from Address" := Job."Grant-to Address";
        SalesHeader."Buy-from Address 2" := Job."Grant-to Address 2";
        SalesHeader."Buy-from City" := Job."Grant-to City";
        SalesHeader."Pay-to Post Code" := Job."Grant-to Post Code";
        
        SalesHeader."Ship-to Contact" := Job."Grant-to Contact";
        SalesHeader."Ship-to Name" := Job."Grant-to Name";
        SalesHeader."Ship-to Address" := Job."Grant-to Address";
        SalesHeader."Ship-to Address 2" := Job."Grant-to Address 2";
        SalesHeader."Ship-to City" := Job."Grant-to City";
        SalesHeader."Ship-to Post Code" := Job."Grant-to Post Code";
         */

    end;

    local procedure TestSalesHeader(var SalesHeader: Record "Purchase Header";var Job: Record UnknownRecord53913)
    begin
        SalesHeader.TestField(SalesHeader."Pay-to Vendor No.",Job."Bill-to Partner No.");
        SalesHeader.TestField(SalesHeader."Buy-from Vendor No.",Job."Bill-to Partner No.");

        if Job."Currency Code" <> '' then
          SalesHeader.TestField("Currency Code",Job."Currency Code")
        else
          SalesHeader.TestField("Currency Code",Job."Invoice Currency Code");
    end;


    procedure TestExchangeRate(var JobPlanningLine: Record UnknownRecord53928;PostingDate: Date)
    var
        CurrencyExchangeRate: Record "Currency Exchange Rate";
    begin
        if JobPlanningLine."Currency Code" <> '' then
          if (CurrencyExchangeRate.ExchangeRate(PostingDate,JobPlanningLine."Currency Code") <> JobPlanningLine."Currency Factor")
            then begin

            if UpdateExchangeRates = false then
              UpdateExchangeRates := Confirm(Text010,true);

            if UpdateExchangeRates = true then begin
              JobPlanningLine."Currency Date" := PostingDate;
              JobPlanningLine."Document Date" := PostingDate;
              JobPlanningLine.Validate("Currency Date");
              JobPlanningLine."Last Date Modified" := Today;
              JobPlanningLine."User ID" := UserId;
              JobPlanningLine.Modify(true);
            end else begin
              Error('')
            end;
          end;
    end;
}

