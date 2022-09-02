#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516934 "M_Withdrawal Share Cap Sell"
{
    PageType = ListPart;
    SourceTable = "M_Withdrawal Share Cap Sell";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Buyer Member No";"Buyer Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Buyer Name";"Buyer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount;Amount)
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

