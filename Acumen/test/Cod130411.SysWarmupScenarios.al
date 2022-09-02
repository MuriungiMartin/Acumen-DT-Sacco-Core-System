#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 130411 "Sys. Warmup Scenarios"
{
    Subtype = Test;

    trigger OnRun()
    begin
    end;

    [Test]
    procedure WarmupInvoicePosting()
    var
        Customer: Record Customer;
        Item: Record Item;
        SalesHeader: Record "Sales Header";
    begin
        if not Customer.FindFirst then
          exit;

        Item.SetFilter(Inventory,'<>%1',0);
        if not Item.FindFirst then
          exit;

        CreateSalesInvoice(SalesHeader,Customer,Item);
        PostSalesInvoice(SalesHeader);
    end;

    local procedure GetRandomString(): Text
    begin
        exit(DelChr(Format(CreateGuid),'=','{}-'));
    end;

    local procedure CreateSalesInvoice(var SalesHeader: Record "Sales Header";Customer: Record Customer;Item: Record Item)
    begin
        CreateSalesHeader(SalesHeader,Customer);
        CreateSalesLine(SalesHeader,Item);
    end;

    local procedure PostSalesInvoice(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.Ship := true;
        SalesHeader.Invoice := true;
        Codeunit.Run(Codeunit::"Sales-Post",SalesHeader);
    end;

    local procedure CreateSalesHeader(var SalesHeader: Record "Sales Header";Customer: Record Customer)
    begin
        SalesHeader.Validate("Document Type",SalesHeader."document type"::Invoice);
        SalesHeader."No." := CopyStr(GetRandomString,1,MaxStrLen(SalesHeader."No."));
        SalesHeader.Insert(true);
        SalesHeader.Validate("Sell-to Customer No.",Customer."No.");
        SalesHeader.Modify(true);
    end;

    local procedure CreateSalesLine(SalesHeader: Record "Sales Header";Item: Record Item)
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Validate("Document Type",SalesHeader."Document Type");
        SalesLine.Validate("Document No.",SalesHeader."No.");
        SalesLine.Validate("Sell-to Customer No.",SalesHeader."Sell-to Customer No.");
        SalesLine.Validate("Line No.",10000);
        SalesLine.Insert(true);
        SalesLine.Validate(Type,SalesLine.Type::Item);
        SalesLine.Validate("No.",Item."No.");
        SalesLine.Validate(Quantity,1);
        SalesLine.Modify(true);
    end;
}

