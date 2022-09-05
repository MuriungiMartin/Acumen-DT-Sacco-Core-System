#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516583 "S-Mobile Member"
{
    PageType = List;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("Current Shares"; "Current Shares")
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

