#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516553 "Type of Trade"
{
    PageType = List;
    SourceTable = "Type of Trade";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Type of Trade";"Type of Trade")
                {
                    ApplicationArea = Basic;
                }
                field("Trade Description";"Trade Description")
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

