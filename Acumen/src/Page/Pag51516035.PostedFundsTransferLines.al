#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516035 "Posted Funds Transfer Lines"
{
    PageType = List;
    SourceTable = "Funds Transfer Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receiving Bank Account";"Receiving Bank Account")
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
                field("Bank Balance(LCY)";"Bank Balance(LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No.";"Bank Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code";"Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Factor";"Currency Factor")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Receive";"Amount to Receive")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Receive (LCY)";"Amount to Receive (LCY)")
                {
                    ApplicationArea = Basic;
                }
                field("External Doc No.";"External Doc No.")
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

