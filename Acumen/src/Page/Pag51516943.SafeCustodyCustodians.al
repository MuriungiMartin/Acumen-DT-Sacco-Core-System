#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516943 "Safe Custody Custodians"
{
    PageType = List;
    SourceTable = "Safe Custody Custodians";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Permision Type";"Permision Type")
                {
                    ApplicationArea = Basic;
                }
                field("Custodian Of";"Custodian Of")
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

