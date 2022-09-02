#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516128 "Bid Analysis SubForm"
{
    PageType = ListPart;
    SourceTable = "Bid Analysis";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Quote No.";"Quote No.")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor No.";"Vendor No.")
                {
                    ApplicationArea = Basic;
                }
                field("Item No.";"Item No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Quantity;Quantity)
                {
                    ApplicationArea = Basic;
                }
                field("Unit Of Measure";"Unit Of Measure")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Line Amount";"Line Amount")
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

