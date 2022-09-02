#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516939 "Package Retrieval Request List"
{
    CardPageID = "Package Retrieval Request Card";
    Editable = false;
    PageType = List;
    SourceTable = "Package Retrieval Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No";"Request No")
                {
                    ApplicationArea = Basic;
                }
                field("Package ID";"Package ID")
                {
                    ApplicationArea = Basic;
                }
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Package Description";"Package Description")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieval Requested By";"Retrieval Requested By")
                {
                    ApplicationArea = Basic;
                }
                field("Requesting Agent Name";"Requesting Agent Name")
                {
                    ApplicationArea = Basic;
                }
                field("Requesting Agent ID/Passport";"Requesting Agent ID/Passport")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieval Request Date";"Retrieval Request Date")
                {
                    ApplicationArea = Basic;
                }
                field("Reason for Retrieval";"Reason for Retrieval")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved By(Custodian 1)";"Retrieved By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved By(Custodian 2)";"Retrieved By(Custodian 2)")
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

