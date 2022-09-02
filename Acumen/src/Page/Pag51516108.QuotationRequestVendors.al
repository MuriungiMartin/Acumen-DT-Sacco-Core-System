#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516108 "Quotation Request Vendors"
{
    PageType = List;
    SourceTable = "Quotation Request Vendors";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Requisition Document No.";"Requisition Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor No.";"Vendor No.")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor Name";"Vendor Name")
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

