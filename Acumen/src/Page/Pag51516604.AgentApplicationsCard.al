#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516604 "Agent Applications Card"
{
    PageType = Card;
    SourceTable = "Agent Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Agent Code";"Agent Code")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Float Account";Account)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Date Entered";"Date Entered")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Time Entered";"Time Entered")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
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
                    ShowMandatory = true;
                }
                field("Agent ID No";"Customer ID No")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Date of Birth";"Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Mobile No";"Mobile No")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field(Comments;Comments)
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
                field("Rejection Reason";"Rejection Reason")
                {
                    ApplicationArea = Basic;
                }
                field("Sent To Server";"Sent To Server")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                    ShowMandatory = true;
                }
                field("Withdrawal Limit Amount";"Withdrawal Limit Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Name of the Proposed Agent";"Name of the Proposed Agent")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Comm Account";"Comm Account")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Type of Business";"Type of Business")
                {
                    ApplicationArea = Basic;
                }
                field("Place of Business";"Place of Business")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Business/Work Experience";"Business/Work Experience")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Registered at";"Branch Registered at")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Branch;Branch)
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

