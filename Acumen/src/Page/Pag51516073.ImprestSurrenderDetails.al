#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516073 "Imprest Surrender Details"
{
    Caption = ' Travel Imprest  Surrender Details';
    PageType = ListPart;
    SourceTable = "Imprest Surrender Details";

    layout
    {
        area(content)
        {
            repeater(Control1102758000)
            {
                field("Account No:";"Account No:")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Actual Spent";"Actual Spent")
                {
                    ApplicationArea = Basic;
                }
                field("Cash Receipt No";"Cash Receipt No")
                {
                    ApplicationArea = Basic;
                }
                field("Cash Receipt Amount";"Cash Receipt Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Cash Surrender Amt";"Cash Surrender Amt")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cash Surrender Amount';
                }
                field("Bank/Petty Cash";"Bank/Petty Cash")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cash Surrender Bank';
                }
                field("Imprest Holder";"Imprest Holder")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Apply to";"Apply to")
                {
                    ApplicationArea = Basic;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        "Apply to":='';
                        "Apply to ID":='';
                        
                          //Amt:=0;
                        
                         Custledger.Reset;
                         Custledger.SetCurrentkey(Custledger."Customer No.",Open,"Document No.");
                         Custledger.SetRange(Custledger."Customer No.","Imprest Holder");
                         Custledger.SetRange(Open,true);
                         //CustLedger.SETRANGE(CustLedger."Transaction Type",CustLedger."Transaction Type"::"Down Payment");
                         Custledger.CalcFields(Custledger.Amount);
                        if Page.RunModal(25,Custledger) = Action::LookupOK then begin
                        
                        if Custledger."Applies-to ID"<>'' then begin
                         Custledger1.Reset;
                         Custledger1.SetCurrentkey(Custledger1."Customer No.",Open,"Applies-to ID");
                         Custledger1.SetRange(Custledger1."Customer No.","Imprest Holder");
                         Custledger1.SetRange(Open,true);
                         //CustLedger1.SETRANGE("Transaction Type",CustLedger1."Transaction Type"::"Down Payment");
                         Custledger1.SetRange("Applies-to ID",Custledger."Applies-to ID");
                         if Custledger1.Find('-') then begin
                           repeat
                             Custledger1.CalcFields(Custledger1.Amount);
                             Amt:=Amt+Abs(Custledger1.Amount);
                           until Custledger1.Next=0;
                          end;
                        
                        if Amt<>Amt then
                         //ERROR('Amount is not equal to the amount applied on the application form');
                         /*Amount:=Amt;
                         VALIDATE(Amount);*/
                           "Apply to":=Custledger."Document No.";
                        "Apply to ID":=Custledger."Applies-to ID";
                        end else begin
                        if Amount<>Abs(Custledger.Amount) then
                        Custledger.CalcFields(Custledger."Remaining Amount");
                        
                        /*Amount:=ABS(CustLedger."Remaining Amount");
                         VALIDATE(Amount);*/
                         //ERROR('Amount is not equal to the amount applied on the application form');
                        
                           "Apply to":=Custledger."Document No.";
                          "Apply to ID":=Custledger."Applies-to ID";
                        
                        end;
                        end;
                        
                        if "Apply to ID" <> '' then
                        "Apply to":='';
                        
                        Validate(Amount);

                    end;
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        Custledger: Record "Cust. Ledger Entry";
        Custledger1: Record "Cust. Ledger Entry";
        Amt: Decimal;
}

