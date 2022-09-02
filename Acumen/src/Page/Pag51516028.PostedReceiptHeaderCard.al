#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516028 "Posted Receipt Header Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Receipt Header";
    SourceTableView = where(Posted=const(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field(Date;Date)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Code";"Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name";"Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Balance";"Bank Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No";"Cheque No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque No.';
                }
                field("Currency Code";"Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code";"Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code";"Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Received";"Amount Received")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Received(LCY)";"Amount Received(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount";"Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount(LCY)";"Total Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Received From";"Received From")
                {
                    ApplicationArea = Basic;
                }
                field("On Behalf of";"On Behalf of")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control23;"Posted Receipt Line")
            {
                SubPageLink = "Document No"=field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Reprint Receipt")
            {
                ApplicationArea = Basic;
                Image = PrintVoucher;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                     DocNo:="No.";
                     ReceiptHeader.Reset;
                     ReceiptHeader.SetRange(ReceiptHeader."No.",DocNo);
                     if ReceiptHeader.FindFirst then begin
                        Report.RunModal(Report::"Receipt Header",true,false,ReceiptHeader);
                     end;
                end;
            }
        }
    }

    var
        BillNoVisible: Boolean;
        AccNoVisible: Boolean;
        ok: Boolean;
        ReceiptLine: Record "Receipt Line";
        LineNo: Integer;
        FundsTransTypes: Record "Funds Transaction Types";
        Amount: Decimal;
        "Amount(LCY)": Decimal;
        ReceiptLines: Record "Receipt Line";
        FundsManager: Codeunit "Funds Management";
        JTemplate: Code[20];
        JBatch: Code[20];
        FundsUser: Record "Funds User Setup";
        PostingVisible: Boolean;
        MoveVisible: Boolean;
        PageEditable: Boolean;
        ReverseVisible: Boolean;
        DocNo: Code[20];
        ReceiptHeader: Record "Receipt Header";

    local procedure CheckReceiptRequiredFields()
    begin
         CalcFields("Total Amount");

         TestField("Total Amount");
         TestField("Amount Received");
         TestField("Bank Code");
         TestField(Date);
         TestField("Posting Date");
         TestField(Description);
         TestField("Received From");
         TestField("Global Dimension 1 Code");
         TestField("Global Dimension 2 Code");

         if "Amount Received"<>"Total Amount" then
          Error('Amount Received must be Equal to the total Amount');
    end;

    local procedure CheckLines()
    begin
        ReceiptLines.Reset;
        ReceiptLines.SetRange(ReceiptLines."Document No","No.");
        if ReceiptLines.FindSet then begin
          repeat
            ReceiptLines.TestField(ReceiptLines."Account Code");
            ReceiptLines.TestField(ReceiptLines."Account Code");
            ReceiptLines.TestField(ReceiptLines.Amount);
          until ReceiptLines.Next=0;
        end else begin
           Error('Empty Receipt Lines');
        end;
    end;
}

