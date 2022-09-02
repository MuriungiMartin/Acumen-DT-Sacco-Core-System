#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516495 "Cheque Clearing Lines"
{
    Editable = true;
    PageType = ListPart;
    SourceTable = "Cheque Clearing Lines";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field("Transaction No";"Transaction No")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No";"Cheque No")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Maturity Date";"Expected Maturity Date")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Clearing Status";"Cheque Clearing Status")
                {
                    ApplicationArea = Basic;
                }
                field("Ledger Entry No";"Ledger Entry No")
                {
                    ApplicationArea = Basic;
                }
                field("Ledger Transaction No.";"Ledger Transaction No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        //SETRANGE(USER,USERID);
    end;
}

