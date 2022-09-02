#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516497 "HISA Allocation"
{
    PageType = List;
    SourceTable = "HISA Allocation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Document No";"Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No.";"Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Interest Amount";"Interest Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount";"Total Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Balance";"Amount Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Balance";"Interest Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Share Mode of Payment";"Share Mode of Payment")
                {
                    ApplicationArea = Basic;
                }
                field("Total Allocation";"Total Allocation")
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

