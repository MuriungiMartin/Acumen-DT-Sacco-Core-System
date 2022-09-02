#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516979 "Score Card List"
{
    CardPageID = "Score Card";
    PageType = List;
    SourceTable = "Score Card Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                    TableRelation = "Score Card Header"."Member No";
                }
                field("Registration Date";"Registration Date")
                {
                    ApplicationArea = Basic;
                }
                field("Date Approved";"Date Approved")
                {
                    ApplicationArea = Basic;
                }
                field("Captured By";"Captured By")
                {
                    ApplicationArea = Basic;
                }
                field("Last Modified By";"Last Modified By")
                {
                    ApplicationArea = Basic;
                }
                field("Last Modified Date";"Last Modified Date")
                {
                    ApplicationArea = Basic;
                }
                field("Total Score";"Total Score")
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

