#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516063 "Voucher Payment Lines"
{
    PageType = ListPart;
    SourceTable = "Payment Line.";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                    Editable = FieldEditable;
                }
                field("Account No.";"Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = FieldEditable;
                    Enabled = FieldEditable;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    Editable = FieldEditable;
                    Enabled = FieldEditable;
                }
                field("Global Dimension 1 Code";"Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = FieldEditable;
                    Enabled = FieldEditable;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = FieldEditable;
                    Enabled = FieldEditable;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                    Editable = FieldEditable;
                    Enabled = FieldEditable;

                    trigger OnValidate()
                    begin
                        //check if the payment reference is for farmer purchase
                        if "Payment Reference"="payment reference"::"Farmer Purchase" then
                          begin
                            if Amount<>xRec.Amount then
                              begin
                                Error('Amount cannot be modified');
                              end;
                          end;

                        "Amount With VAT":=Amount;
                        if "Account Type" in ["account type"::Customer,"account type"::Vendor,
                        "account type"::"G/L Account","account type"::"Bank Account","account type"::"Fixed Asset"] then

                        case "Account Type" of
                          "account type"::"G/L Account":
                            begin

                        TestField(Amount);
                        RecPayTypes.Reset;
                        RecPayTypes.SetRange(RecPayTypes.Code,Type);
                        RecPayTypes.SetRange(RecPayTypes.Type,RecPayTypes.Type::Payment);
                        if RecPayTypes.Find('-') then begin
                        if RecPayTypes."VAT Chargeable"=RecPayTypes."vat chargeable"::Yes then
                          begin
                            RecPayTypes.TestField(RecPayTypes."VAT Code");
                            TarriffCodes.Reset;
                            TarriffCodes.SetRange(TarriffCodes.Code,RecPayTypes."VAT Code");
                            if TarriffCodes.Find('-') then
                              begin
                                "VAT Amount":=(TarriffCodes.Percentage/100)*Amount;
                                "VAT Amount":=(Amount/((TarriffCodes.Percentage+100))*TarriffCodes.Percentage);
                              end;
                          end
                        else
                          begin
                            "VAT Amount":=0;
                          end;

                        if RecPayTypes."Withholding Tax Chargeable"=RecPayTypes."withholding tax chargeable"::Yes then
                          begin
                            RecPayTypes.TestField(RecPayTypes."Withholding Tax Code");
                            TarriffCodes.Reset;
                            TarriffCodes.SetRange(TarriffCodes.Code,RecPayTypes."Withholding Tax Code");
                            if TarriffCodes.Find('-') then
                              begin
                                "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*Amount;
                                "Withholding Tax Amount":=(Amount-"VAT Amount")*(TarriffCodes.Percentage/100);
                              end;
                          end
                        else
                          begin
                            "Withholding Tax Amount":=0;
                          end;
                        end;
                        end;
                          "account type"::Customer:
                            begin

                        TestField(Amount);
                        RecPayTypes.Reset;
                        RecPayTypes.SetRange(RecPayTypes.Code,Type);
                        RecPayTypes.SetRange(RecPayTypes.Type,RecPayTypes.Type::Payment);
                        if RecPayTypes.Find('-') then begin
                        if RecPayTypes."VAT Chargeable"=RecPayTypes."vat chargeable"::Yes then begin
                        TestField("VAT Code");
                        TarriffCodes.Reset;
                        TarriffCodes.SetRange(TarriffCodes.Code,"VAT Code");
                        if TarriffCodes.Find('-') then begin
                        //"VAT Amount":=(TarriffCodes.Percentage/100)*Amount;
                        "VAT Amount":=(Amount/((TarriffCodes.Percentage+100))*TarriffCodes.Percentage);
                        //
                        end;
                        end
                        else begin
                        "VAT Amount":=0;
                        end;

                        if RecPayTypes."Withholding Tax Chargeable"=RecPayTypes."withholding tax chargeable"::Yes then begin
                        TestField("Withholding Tax Code");
                        TarriffCodes.Reset;
                        TarriffCodes.SetRange(TarriffCodes.Code,"Withholding Tax Code");
                        if TarriffCodes.Find('-') then begin
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*Amount;

                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*(Amount-"VAT Amount");

                        end;
                        end
                        else begin
                        "Withholding Tax Amount":=0;
                        end;
                        end;



                            end;
                          "account type"::Vendor:
                            begin

                        TestField(Amount);
                        RecPayTypes.Reset;
                        RecPayTypes.SetRange(RecPayTypes.Code,Type);
                        RecPayTypes.SetRange(RecPayTypes.Type,RecPayTypes.Type::Payment);
                        if RecPayTypes.Find('-') then begin
                        if RecPayTypes."VAT Chargeable"=RecPayTypes."vat chargeable"::Yes then begin
                        TestField("VAT Code");
                        TarriffCodes.Reset;
                        TarriffCodes.SetRange(TarriffCodes.Code,"VAT Code");
                        if TarriffCodes.Find('-') then begin
                        "VAT Amount":=(TarriffCodes.Percentage/100)*Amount;
                        //
                        "VAT Amount":=(Amount/((TarriffCodes.Percentage+100))*TarriffCodes.Percentage);
                        //
                        end;
                        end
                        else begin
                        "VAT Amount":=0;
                        end;

                        if RecPayTypes."Withholding Tax Chargeable"=RecPayTypes."withholding tax chargeable"::Yes then begin
                        TestField("Withholding Tax Code");
                        TarriffCodes.Reset;
                        TarriffCodes.SetRange(TarriffCodes.Code,"Withholding Tax Code");
                        if TarriffCodes.Find('-') then begin
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*Amount;
                        //
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*(Amount-"VAT Amount");
                        //
                        end;
                        end
                        else begin
                        "Withholding Tax Amount":=0;
                        end;
                        end;


                            end;
                          "account type"::"Bank Account":
                            begin

                        TestField(Amount);
                        RecPayTypes.Reset;
                        RecPayTypes.SetRange(RecPayTypes.Code,Type);
                        RecPayTypes.SetRange(RecPayTypes.Type,RecPayTypes.Type::Payment);
                        if RecPayTypes.Find('-') then begin
                        if RecPayTypes."VAT Chargeable"=RecPayTypes."vat chargeable"::Yes then begin
                        RecPayTypes.TestField(RecPayTypes."VAT Code");
                        TarriffCodes.Reset;
                        TarriffCodes.SetRange(TarriffCodes.Code,RecPayTypes."VAT Code");
                        if TarriffCodes.Find('-') then begin
                        //
                        "VAT Amount":=(TarriffCodes.Percentage/100)*Amount;
                        "VAT Amount":=(Amount/((TarriffCodes.Percentage+100))*TarriffCodes.Percentage);
                        //
                        end;
                        end
                        else begin
                        "VAT Amount":=0;
                        end;

                        if RecPayTypes."Withholding Tax Chargeable"=RecPayTypes."withholding tax chargeable"::Yes then begin
                        RecPayTypes.TestField(RecPayTypes."Withholding Tax Code");
                        TarriffCodes.Reset;
                        TarriffCodes.SetRange(TarriffCodes.Code,RecPayTypes."Withholding Tax Code");
                        if TarriffCodes.Find('-') then begin
                        //
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*Amount;
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*(Amount-"VAT Amount");
                        //
                        end;
                        end
                        else begin
                        "Withholding Tax Amount":=0;
                        end;
                        end;


                            end;
                          "account type"::"Fixed Asset":
                            begin

                        TestField(Amount);
                        RecPayTypes.Reset;
                        RecPayTypes.SetRange(RecPayTypes.Code,Type);
                        RecPayTypes.SetRange(RecPayTypes.Type,RecPayTypes.Type::Payment);
                        if RecPayTypes.Find('-') then begin
                        if RecPayTypes."VAT Chargeable"=RecPayTypes."vat chargeable"::Yes then begin
                        RecPayTypes.TestField(RecPayTypes."VAT Code");
                        TarriffCodes.Reset;
                        TarriffCodes.SetRange(TarriffCodes.Code,RecPayTypes."VAT Code");
                        if TarriffCodes.Find('-') then begin
                        //"VAT Amount":=(TarriffCodes.Percentage/100)*Amount;
                        "VAT Amount":=(Amount/((TarriffCodes.Percentage+100))*TarriffCodes.Percentage);
                        end;
                        end
                        else begin
                        "VAT Amount":=0;
                        end;

                        if RecPayTypes."Withholding Tax Chargeable"=RecPayTypes."withholding tax chargeable"::Yes then begin
                        RecPayTypes.TestField(RecPayTypes."Withholding Tax Code");
                        TarriffCodes.Reset;
                        TarriffCodes.SetRange(TarriffCodes.Code,RecPayTypes."Withholding Tax Code");
                        if TarriffCodes.Find('-') then begin
                        //
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*Amount;
                        "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*(Amount-"VAT Amount");
                        //
                        end;
                        end
                        else begin
                        "Withholding Tax Amount":=0;
                        end;
                        end;


                            end;
                        end;


                        "Net Amount":=Amount-"Withholding Tax Amount";
                        Validate("Net Amount");
                    end;
                }
                field(Remarks;Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = FieldEditable;
                    Enabled = FieldEditable;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No.";"Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Prod. Posting Group";"VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Vendor Bank Account";"Vendor Bank Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("VAT Rate";"VAT Rate")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Retention Code";"Retention Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Withholding Tax Code";"Withholding Tax Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        TarriffCodes.Reset;
                        TarriffCodes.SetRange(TarriffCodes.Code,"Withholding Tax Code");
                        if TarriffCodes.FindFirst then
                          begin
                        //    "Withholding Tax Amount":=(TarriffCodes.Percentage/100)*Amount;
                            "Withholding Tax Amount":=("Amount With VAT"-"VAT Amount")*(TarriffCodes.Percentage/100);
                          end
                        else
                          begin
                            "Withholding Tax Amount":=0;
                          end;
                            "Net Amount":=Amount-"Withholding Tax Amount";
                    end;
                }
                field("VAT Amount";"VAT Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Withholding Tax Amount";"Withholding Tax Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Retention  Amount";"Retention  Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Net Amount";"Net Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Apply to ID";"Apply to ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Lookup = true;
                    Visible = false;
                }
                field("Applies-to Doc. Type";"Applies-to Doc. Type")
                {
                    ApplicationArea = Basic;
                }
                field("Applies-to Doc. No.";"Applies-to Doc. No.")
                {
                    ApplicationArea = Basic;
                }
                field("Applies-to ID";"Applies-to ID")
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
          FieldEditable:=true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
           PHeader.Reset;
           PHeader.SetRange(PHeader."No.",No);
           if PHeader.FindFirst then begin
            if (PHeader.Status=PHeader.Status::Approved) or (PHeader.Status=PHeader.Status::"Pending Approval") then begin
              FieldEditable:=false;
            end else begin
              FieldEditable:=true;
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
        FieldEditable: Boolean;
        PHeader: Record "Payment Header.";
}

