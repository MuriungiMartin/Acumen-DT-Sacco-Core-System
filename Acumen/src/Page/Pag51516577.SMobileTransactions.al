#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516577 "S-Mobile Transactions"
{
    CardPageID = "S-Mobile Applications";
    PageType = List;
    SourceTable = "Mobile Transactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Document No";"Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date";"Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Time";"Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Telephone Number";"Telephone Number")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted";"Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Account 2";"Account 2")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No";"Loan No")
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
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Charge;Charge)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Entry;Entry)
                {
                    ApplicationArea = Basic;
                }
                field(Client;Client)
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

