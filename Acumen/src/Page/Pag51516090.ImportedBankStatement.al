#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516090 "Imported Bank Statement"
{
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Imported Bank Statement..";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date;Date)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Reference No";"Reference No")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Bank;Bank)
                {
                    ApplicationArea = Basic;
                }
                field(Receipted;Receipted)
                {
                    ApplicationArea = Basic;
                }
                field(ReceiptNo;ReceiptNo)
                {
                    ApplicationArea = Basic;
                }
                field("Receipting Date";"Receipting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Reconciled;Reconciled)
                {
                    ApplicationArea = Basic;
                }
                field("Reconciliation Doc No";"Reconciliation Doc No")
                {
                    ApplicationArea = Basic;
                }
                field("Reconciliation Date";"Reconciliation Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

