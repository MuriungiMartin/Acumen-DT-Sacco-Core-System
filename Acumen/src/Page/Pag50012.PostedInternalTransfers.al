#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50012 "Posted Internal Transfers"
{
    ApplicationArea = Basic;
    CardPageID = "Posted Sacco Transfer Card";
    PageType = List;
    SourceTable = "Sacco Transfers";
    SourceTableView = where(Posted=filter(true));
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No;No)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Schedule Total";"Schedule Total")
                {
                    ApplicationArea = Basic;
                }
                field(Approved;Approved)
                {
                    ApplicationArea = Basic;
                }
                field("Approved By";"Approved By")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account No";"Source Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Source Transaction Type";"Source Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Source Account Name";"Source Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
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

