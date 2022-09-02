#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516952 "ATM Card Receipt SubPage"
{
    PageType = ListPart;
    SourceTable = "ATM Card Receipt Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ATM Application No";"ATM Application No")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Account No";"ATM Card Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Application Date";"ATM Card Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card No";"ATM Card No")
                {
                    ApplicationArea = Basic;
                }
                field(Received;Received)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Received By";"Received By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Received On";"Received On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

