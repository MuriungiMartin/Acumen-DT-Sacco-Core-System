#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516704 "Cheque Clearing List-Posted"
{
    ApplicationArea = Basic;
    CardPageID = "Cheque Clearing Header";
    Editable = false;
    PageType = List;
    SourceTable = "Cheque Clearing Header";
    SourceTableView = where(Posted=const(true));
    UsageCategory = Lists;

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
                field("No. Series";"No. Series")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Cleared  By";"Cleared  By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Entered";"Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Entered By";"Entered By")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks;Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Date Filter";"Date Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Time Entered";"Time Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Date Of Clearing";"Expected Date Of Clearing")
                {
                    ApplicationArea = Basic;
                }
                field("Document No";"Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount";"Scheduled Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Total Count";"Total Count")
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

