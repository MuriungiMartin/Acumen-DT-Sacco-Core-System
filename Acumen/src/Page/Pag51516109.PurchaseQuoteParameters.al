#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516109 "Purchase Quote Parameters"
{
    PageType = List;
    SourceTable = "Inward file Buffer-Family";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Field3;Field3)
                {
                    ApplicationArea = Basic;
                }
                field(Field4;Field4)
                {
                    ApplicationArea = Basic;
                }
                field(Field6;Field6)
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

