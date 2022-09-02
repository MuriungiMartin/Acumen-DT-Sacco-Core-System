#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516964 "Member Deposit Saving History"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "Member Deposits Saving History";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No";"Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description";"Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Out";"Amount Out")
                {
                    ApplicationArea = Basic;
                }
                field("Amount In";"Amount In")
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

