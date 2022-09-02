#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516520 "Loans Partial Disburesments"
{
    PageType = List;
    SourceTable = "Loan Partial Disburesments";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No.";"Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product";"Loan Product")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Be Disbursed";"Amount to Be Disbursed")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Due";"Amount Due")
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

