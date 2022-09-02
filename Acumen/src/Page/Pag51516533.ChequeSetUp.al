#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516533 "Cheque Set-Up"
{
    Editable = false;
    PageType = List;
    SourceTable = "Cheque Set Up";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque Code";"Cheque Code")
                {
                    ApplicationArea = Basic;
                }
                field("Number Of Leaf";"Number Of Leaf")
                {
                    ApplicationArea = Basic;
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

