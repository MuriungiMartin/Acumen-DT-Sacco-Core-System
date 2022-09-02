#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516064 "Voucher Payment List"
{
    CardPageID = "Voucher Payment Header";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Payment Header.";
    SourceTableView = where("Payment Type"=const(Normal),
                            Posted=const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field("Document Type";"Document Type")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date";"Document Date")
                {
                    ApplicationArea = Basic;
                }
                field(Payee;Payee)
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Amount(LCY)";"Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount";"Net Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Net Amount(LCY)";"Net Amount(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
         "Payment Type":="payment type"::"Cash Purchase";
         if FundsSetup.Get then begin
          FundsSetup.TestField(FundsSetup."Cash Account");
          "Bank Account":=FundsSetup."Cash Account";
          Validate("Bank Account");
         end;
    end;

    var
        FundsSetup: Record "Funds General Setup";
}

