#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516568 "Cheque Receipt List-Family"
{
    ApplicationArea = Basic;
    CardPageID = "Cheque Receipt Header-Family";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Cheque Receipts-Family";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Refference Document";"Refference Document")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Time";"Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field("Created By";"Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By";"Posted By")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                field("No. Series";"No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Unpaid By";"Unpaid By")
                {
                    ApplicationArea = Basic;
                }
                field(Unpaid;Unpaid)
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

