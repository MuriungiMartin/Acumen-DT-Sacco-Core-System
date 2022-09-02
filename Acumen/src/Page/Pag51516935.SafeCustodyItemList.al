#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516935 "Safe Custody Item List"
{
    CardPageID = "Safe Custody Item Card";
    Editable = false;
    PageType = List;
    SourceTable = "Safe Custody Item Register";

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
                field("Item ID";"Item ID")
                {
                    ApplicationArea = Basic;
                }
                field("Item Description";"Item Description")
                {
                    ApplicationArea = Basic;
                }
                field("Registered Owner";"Registered Owner")
                {
                    ApplicationArea = Basic;
                }
                field("Document Reference";"Document Reference")
                {
                    ApplicationArea = Basic;
                }
                field("Date Received";"Date Received")
                {
                    ApplicationArea = Basic;
                }
                field("Received By";"Received By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Collected";"Date Collected")
                {
                    ApplicationArea = Basic;
                }
                field("Collected By";"Collected By")
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

