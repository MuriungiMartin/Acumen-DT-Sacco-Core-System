#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516992 "Case Details"
{
    PageType = ListPart;
    SourceTable = "Case Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Case No";"Case No")
                {
                    ApplicationArea = Basic;
                }
                field("Case Type";"Case Type")
                {
                    ApplicationArea = Basic;
                }
                field("Case Details";"Case Details")
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

