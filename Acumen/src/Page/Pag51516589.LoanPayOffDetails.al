#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516589 "Loan PayOff Details"
{
    PageType = ListPart;
    SourceTable = "Loans PayOff Details";

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
                field(Source;Source)
                {
                    ApplicationArea = Basic;
                }
                field("Loan to PayOff";"Loan to PayOff")
                {
                    ApplicationArea = Basic;
                }
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Type";"Loan Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Outstanding";"Loan Outstanding")
                {
                    ApplicationArea = Basic;
                }
                field("Commision on PayOff";"Commision on PayOff")
                {
                    ApplicationArea = Basic;
                }
                field("Total PayOff";"Total PayOff")
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

