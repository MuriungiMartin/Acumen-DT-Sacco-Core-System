#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516509 "S-Mobile codes"
{
    PageType = List;
    SourceTable = "Error Codes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ErrorCode;ErrorCode)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Error Description";"Error Description")
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

