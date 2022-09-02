#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516450 "Bank Transfer List"
{
    ApplicationArea = Basic;
    CardPageID = "Transfer Header Card";
    Editable = false;
    PageType = List;
    SourceTable = "Bank Transfer Header Details";
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
                field(Transferred;Transferred)
                {
                    ApplicationArea = Basic;
                }
                field("Date Transferred";"Date Transferred")
                {
                    ApplicationArea = Basic;
                }
                field("Time Transferred";"Time Transferred")
                {
                    ApplicationArea = Basic;
                }
                field("Transferred By";"Transferred By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Entered";"Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Time Entered";"Time Entered")
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
                field("Payee Bank Name";"Payee Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank  No";"Bank  No")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Processing No.";"Salary Processing No.")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Options";"Salary Options")
                {
                    ApplicationArea = Basic;
                }
                field(Total;Total)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count";"Total Count")
                {
                    ApplicationArea = Basic;
                }
                field(RTGS;RTGS)
                {
                    ApplicationArea = Basic;
                }
                field("Document No. Filter";"Document No. Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Date Filter";"Date Filter")
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

