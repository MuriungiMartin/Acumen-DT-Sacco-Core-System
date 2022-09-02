#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516758 "File Movement SetUp"
{
    CardPageID = "File Location SetUp Card";
    PageType = List;
    SourceTable = "File Locations Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Location;Location)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Custodian Code";"Custodian Code")
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

