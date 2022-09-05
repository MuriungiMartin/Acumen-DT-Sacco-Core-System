#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516002 "Payment Lines."
{
    PageType = ListPart;
    SourceTable = "Payment Line.";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Type; Type)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    Editable = true;
                }
                field("Applies-to Doc. Type"; "Applies-to Doc. Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Applies-to Doc. No."; "Applies-to Doc. No.")
                {
                    ApplicationArea = Basic;
                }
                field("Applies-to ID"; "Applies-to ID")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        //check if the payment reference is for farmer purchase
                        if "Payment Reference" = "payment reference"::"Farmer Purchase" then begin
                            if Amount <> xRec.Amount then begin
                                Error('Amount cannot be modified');
                            end;
                        end;

                        "Amount With VAT" := Amount;
                        /*IF "Account Type" IN ["Account Type"::Customer,"Account Type"::Vendor,
                        "Account Type"::"G/L Account","Account Type"::"Bank Account","Account Type"::"Fixed Asset"] THEN
                        
                        CASE "Account Type" OF
                          "Account Type"::"G/L Account":
                            BEGIN
                        
                        TESTFIELD(Amount);
                        RecPayTypes.RESET;
                        RecPayTypes.SETRANGE(RecPayTypes.Code,Type);
                        RecPayTypes.SETRANGE(RecPayTypes.Type,RecPayTypes.Type::Payment);
                        IF RecPayTypes.FIND('-') THEN BEGIN
                        IF RecPayTypes."VAT Chargeable"=RecPayTypes."VAT Chargeable"::Yes THEN
                          BEGIN
                            RecPayTypes.TESTFIELD(RecPayTypes."VAT Code");
                            TarriffCodes.RESET;
                            TarriffCodes.SETRANGE(TarriffCodes.Code,RecPayTypes."VAT Code");
                            IF TarriffCodes.FIND('-') THEN
                              BEGIN
                                "VAT Amount":=(TarriffCodes.Percentage/100)*Amount;
                                "VAT Amount":=(Amount/((TarriffCodes.Percentage+100))*TarriffCodes.Percentage);
                              END;
                          END
                        ELSE
                          BEGIN
                            "VAT Amount":=0;
                          END;
                        
                        IF RecPayTypes."Withholding Tax Chargeable"=RecPayTypes."Withholding Tax Chargeable"::Yes THEN
                          BEGIN
                            RecPayTypes.TESTFIELD(RecPayTypes."Withholding Tax Code");
                            TarriffCodes.RESET;
                            TarriffCodes.SETRANGE(TarriffCodes.Code,RecPayTypes."Withholding Tax Code");
                            IF TarriffCodes.FIND('-') THEN
                              BEGIN
                                "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*Amount;
                                "Withholding Tax Amount":=(Amount-"VAT Amount")*(TarriffCodes.Percentage/100);
                              END;
                          END
                        ELSE
                          BEGIN
                            "Withholding Tax Amount":=0;
                          END;
                        END;
                        END;
                          "Account Type"::Customer:
                            BEGIN
                        
                        TESTFIELD(Amount);
                        RecPayTypes.RESET;
                        RecPayTypes.SETRANGE(RecPayTypes.Code,Type);
                        RecPayTypes.SETRANGE(RecPayTypes.Type,RecPayTypes.Type::Payment);
                        IF RecPayTypes.FIND('-') THEN BEGIN
                        IF RecPayTypes."VAT Chargeable"=RecPayTypes."VAT Chargeable"::Yes THEN BEGIN
                        TESTFIELD("VAT Code");
                        TarriffCodes.RESET;
                        TarriffCodes.SETRANGE(TarriffCodes.Code,"VAT Code");
                        IF TarriffCodes.FIND('-') THEN BEGIN
                        //"VAT Amount":=(TarriffCodes.Percentage/100)*Amount;
                        "VAT Amount":=(Amount/((TarriffCodes.Percentage+100))*TarriffCodes.Percentage);
                        //
                        END;
                        END
                        ELSE BEGIN
                        "VAT Amount":=0;
                        END;
                        
                        IF RecPayTypes."Withholding Tax Chargeable"=RecPayTypes."Withholding Tax Chargeable"::Yes THEN BEGIN
                        TESTFIELD("Withholding Tax Code");
                        TarriffCodes.RESET;
                        TarriffCodes.SETRANGE(TarriffCodes.Code,"Withholding Tax Code");
                        IF TarriffCodes.FIND('-') THEN BEGIN
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*Amount;
                        
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*(Amount-"VAT Amount");
                        
                        END;
                        END
                        ELSE BEGIN
                        "Withholding Tax Amount":=0;
                        END;
                        END;
                        
                        
                        
                            END;
                          "Account Type"::Vendor:
                            BEGIN
                        
                        TESTFIELD(Amount);
                        RecPayTypes.RESET;
                        RecPayTypes.SETRANGE(RecPayTypes.Code,Type);
                        RecPayTypes.SETRANGE(RecPayTypes.Type,RecPayTypes.Type::Payment);
                        IF RecPayTypes.FIND('-') THEN BEGIN
                        IF RecPayTypes."VAT Chargeable"=RecPayTypes."VAT Chargeable"::Yes THEN BEGIN
                        TESTFIELD("VAT Code");
                        TarriffCodes.RESET;
                        TarriffCodes.SETRANGE(TarriffCodes.Code,"VAT Code");
                        IF TarriffCodes.FIND('-') THEN BEGIN
                        "VAT Amount":=(TarriffCodes.Percentage/100)*Amount;
                        //
                        "VAT Amount":=(Amount/((TarriffCodes.Percentage+100))*TarriffCodes.Percentage);
                        //
                        END;
                        END
                        ELSE BEGIN
                        "VAT Amount":=0;
                        END;
                        
                        IF RecPayTypes."Withholding Tax Chargeable"=RecPayTypes."Withholding Tax Chargeable"::Yes THEN BEGIN
                        TESTFIELD("Withholding Tax Code");
                        TarriffCodes.RESET;
                        TarriffCodes.SETRANGE(TarriffCodes.Code,"Withholding Tax Code");
                        IF TarriffCodes.FIND('-') THEN BEGIN
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*Amount;
                        //
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*(Amount-"VAT Amount");
                        //
                        END;
                        END
                        ELSE BEGIN
                        "Withholding Tax Amount":=0;
                        END;
                        END;
                        
                        
                            END;
                          "Account Type"::"Bank Account":
                            BEGIN
                        
                        TESTFIELD(Amount);
                        RecPayTypes.RESET;
                        RecPayTypes.SETRANGE(RecPayTypes.Code,Type);
                        RecPayTypes.SETRANGE(RecPayTypes.Type,RecPayTypes.Type::Payment);
                        IF RecPayTypes.FIND('-') THEN BEGIN
                        IF RecPayTypes."VAT Chargeable"=RecPayTypes."VAT Chargeable"::Yes THEN BEGIN
                        RecPayTypes.TESTFIELD(RecPayTypes."VAT Code");
                        TarriffCodes.RESET;
                        TarriffCodes.SETRANGE(TarriffCodes.Code,RecPayTypes."VAT Code");
                        IF TarriffCodes.FIND('-') THEN BEGIN
                        //
                        "VAT Amount":=(TarriffCodes.Percentage/100)*Amount;
                        "VAT Amount":=(Amount/((TarriffCodes.Percentage+100))*TarriffCodes.Percentage);
                        //
                        END;
                        END
                        ELSE BEGIN
                        "VAT Amount":=0;
                        END;
                        
                        IF RecPayTypes."Withholding Tax Chargeable"=RecPayTypes."Withholding Tax Chargeable"::Yes THEN BEGIN
                        RecPayTypes.TESTFIELD(RecPayTypes."Withholding Tax Code");
                        TarriffCodes.RESET;
                        TarriffCodes.SETRANGE(TarriffCodes.Code,RecPayTypes."Withholding Tax Code");
                        IF TarriffCodes.FIND('-') THEN BEGIN
                        //
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*Amount;
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*(Amount-"VAT Amount");
                        //
                        END;
                        END
                        ELSE BEGIN
                        "Withholding Tax Amount":=0;
                        END;
                        END;
                        
                        
                            END;
                          "Account Type"::"Fixed Asset":
                            BEGIN
                        
                        TESTFIELD(Amount);
                        RecPayTypes.RESET;
                        RecPayTypes.SETRANGE(RecPayTypes.Code,Type);
                        RecPayTypes.SETRANGE(RecPayTypes.Type,RecPayTypes.Type::Payment);
                        IF RecPayTypes.FIND('-') THEN BEGIN
                        IF RecPayTypes."VAT Chargeable"=RecPayTypes."VAT Chargeable"::Yes THEN BEGIN
                        RecPayTypes.TESTFIELD(RecPayTypes."VAT Code");
                        TarriffCodes.RESET;
                        TarriffCodes.SETRANGE(TarriffCodes.Code,RecPayTypes."VAT Code");
                        IF TarriffCodes.FIND('-') THEN BEGIN
                        //"VAT Amount":=(TarriffCodes.Percentage/100)*Amount;
                        "VAT Amount":=(Amount/((TarriffCodes.Percentage+100))*TarriffCodes.Percentage);
                        END;
                        END
                        ELSE BEGIN
                        "VAT Amount":=0;
                        END;
                        
                        IF RecPayTypes."Withholding Tax Chargeable"=RecPayTypes."Withholding Tax Chargeable"::Yes THEN BEGIN
                        RecPayTypes.TESTFIELD(RecPayTypes."Withholding Tax Code");
                        TarriffCodes.RESET;
                        TarriffCodes.SETRANGE(TarriffCodes.Code,RecPayTypes."Withholding Tax Code");
                        IF TarriffCodes.FIND('-') THEN BEGIN
                        //
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*Amount;
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*(Amount-"VAT Amount");
                        //
                        END;
                        END
                        ELSE BEGIN
                        "Withholding Tax Amount":=0;
                        END;
                        END;
                        
                        
                            END;
                        END;
                        
                        
                        "Net Amount":=Amount-"Withholding Tax Amount";
                        VALIDATE("Net Amount");
                        */

                    end;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax Code"; "Withholding Tax Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        TarriffCodes.Reset;
                        TarriffCodes.SetRange(TarriffCodes.Code, "Withholding Tax Code");
                        if TarriffCodes.FindFirst then begin
                            //    "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*Amount;
                            "Withholding Tax Amount" := ("Amount With VAT" - "VAT Amount") * (TarriffCodes.Percentage / 100);
                        end
                        else begin
                            "Withholding Tax Amount" := 0;
                        end;
                        "Net Amount" := Amount - "Withholding Tax Amount";
                    end;
                }
                field("Withholding Tax Amount"; "Withholding Tax Amount")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Withhelding Amount"; "VAT Withhelding Amount")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Withheld Code"; "VAT Withheld Code")
                {
                    ApplicationArea = Basic;
                }
                field("VAT 6% Rate"; "VAT 6% Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount"; "Net Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        FieldEditable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        PHeader.Reset;
        PHeader.SetRange(PHeader."No.", No);
        if PHeader.FindFirst then begin
            if (PHeader.Status = PHeader.Status::Approved) or (PHeader.Status = PHeader.Status::"Pending Approval") then begin
                FieldEditable := false;
            end else begin
                FieldEditable := true;
            end;
        end;
    end;

    var
        RecPayTypes: Record "Receipts and Payment Types";
        TarriffCodes: Record "Tariff Codes";
        GenJnlLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        CashierLinks: Record "Cashier Link";
        LineNo: Integer;
        CustLedger: Record "Vendor Ledger Entry";
        CustLedger1: Record "Vendor Ledger Entry";
        Amt: Decimal;
        TotAmt: Decimal;
        ApplyInvoice: Codeunit "Purchase Header Apply";
        AppliedEntries: Record "CshMgt Application";
        VendEntries: Record "Vendor Ledger Entry";
        PInv: Record "Purch. Inv. Header";
        VATPaid: Decimal;
        VATToPay: Decimal;
        PInvLine: Record "Purch. Inv. Line";
        VATBase: Decimal;
        PHeader: Record "Payment Header.";
        FieldEditable: Boolean;
}

