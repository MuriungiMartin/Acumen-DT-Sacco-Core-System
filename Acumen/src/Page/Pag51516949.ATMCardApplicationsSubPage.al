#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516949 "ATM Card Applications SubPage"
{
    PageType = ListPart;
    SourceTable = "ATM Card Applications";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Order ATM Card";"Order ATM Card")
                {
                    ApplicationArea = Basic;
                }
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code";"Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Request Type";"Request Type")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";"Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Card No";"Card No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Issued";"Date Issued")
                {
                    ApplicationArea = Basic;
                }
                field("Card Status";"Card Status")
                {
                    ApplicationArea = Basic;
                }
                field("Ordered By";"Ordered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Ordered On";"Ordered On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

