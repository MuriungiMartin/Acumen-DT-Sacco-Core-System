#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516608 "Interest Earned Buffer"
{
    Editable = false;
    PageType = List;
    SourceTable = "Interest Buffer Savings";

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
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Date";"Interest Date")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Amount";"Interest Amount")
                {
                    ApplicationArea = Basic;
                }
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Account Matured";"Account Matured")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series";"No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Late Interest";"Late Interest")
                {
                    ApplicationArea = Basic;
                }
                field(Transferred;Transferred)
                {
                    ApplicationArea = Basic;
                }
                field("Mark For Deletion";"Mark For Deletion")
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

