#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516659 "County List"
{
    CardPageID = "County card";
    PageType = List;
    SourceTable = County;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field(Parish;Parish)
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

