#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516905 "SCustody Agent List"
{
    CardPageID = "SCustody Agent Card";
    Editable = false;
    PageType = List;
    SourceTable = "Safe Custody Agents Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Package ID";"Package ID")
                {
                    ApplicationArea = Basic;
                }
                field("Agent ID";"Agent ID")
                {
                    ApplicationArea = Basic;
                }
                field("Agent Member No";"Agent Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Agent Name";"Agent Name")
                {
                    ApplicationArea = Basic;
                }
                field("Is Owner";"Is Owner")
                {
                    ApplicationArea = Basic;
                }
                field("Created By";"Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Appointed";"Date Appointed")
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

