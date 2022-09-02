#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516601 "Agent applications List"
{
    CardPageID = "Agent Applications Card";
    Editable = false;
    PageType = List;
    SourceTable = "Agent Applications";
    SourceTableView = where(Status=filter(Pending));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Agent Code";"Agent Code")
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
                field("Document Serial No";"Document Serial No")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date";"Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Customer ID No";"Customer ID No")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field("Mobile No";"Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field(Comments;Comments)
                {
                    ApplicationArea = Basic;
                }
                field("Rejection Reason";"Rejection Reason")
                {
                    ApplicationArea = Basic;
                }
                field("Date Approved";"Date Approved")
                {
                    ApplicationArea = Basic;
                }
                field("Time Approved";"Time Approved")
                {
                    ApplicationArea = Basic;
                }
                field("Approved By";"Approved By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Rejected";"Date Rejected")
                {
                    ApplicationArea = Basic;
                }
                field("Time Rejected";"Time Rejected")
                {
                    ApplicationArea = Basic;
                }
                field("Rejected By";"Rejected By")
                {
                    ApplicationArea = Basic;
                }
                field("Sent To Server";"Sent To Server")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series";"No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("1st Approval By";"1st Approval By")
                {
                    ApplicationArea = Basic;
                }
                field("Date 1st Approval";"Date 1st Approval")
                {
                    ApplicationArea = Basic;
                }
                field("Time First Approval";"Time First Approval")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Limit Code";"Withdrawal Limit Code")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Limit Amount";"Withdrawal Limit Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Account;Account)
                {
                    ApplicationArea = Basic;
                }
                field("Name of the Proposed Agent";"Name of the Proposed Agent")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Birth";"Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("Type of Business";"Type of Business")
                {
                    ApplicationArea = Basic;
                }
                field("Business/Work Experience";"Business/Work Experience")
                {
                    ApplicationArea = Basic;
                }
                field("Name of Banker";"Name of Banker")
                {
                    ApplicationArea = Basic;
                }
                field("PIN(KRA)";"PIN(KRA)")
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

