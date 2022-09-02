#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516731 "Cheque Nos Generation card"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Cheque Nos Generation";
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque No.";"Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(Issued;Issued)
                {
                    ApplicationArea = Basic;
                }
                field(Cancelled;Cancelled)
                {
                    ApplicationArea = Basic;
                }
                field("Bank Code";"Bank Code")
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

