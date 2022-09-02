#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516972 "Collateral Depr. Schedule"
{
    PageType = List;
    SourceTable = "Collateral Depr Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";"Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description";"Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Value";"Collateral Value")
                {
                    ApplicationArea = Basic;
                }
                field("Depreciation Amount";"Depreciation Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral NBV";"Collateral NBV")
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

