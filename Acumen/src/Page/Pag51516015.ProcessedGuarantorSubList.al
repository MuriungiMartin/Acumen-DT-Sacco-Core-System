#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516015 "Processed Guarantor Sub List"
{
    ApplicationArea = Basic;
    CardPageID = "Processed Guarantor Sub Card";
    Editable = false;
    PageType = List;
    SourceTable = "Guarantorship Substitution H";
    UsageCategory = History;

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
                field("Application Date";"Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Loanee Member No";"Loanee Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Loanee Name";"Loanee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Guaranteed";"Loan Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field("Substituting Member";"Substituting Member")
                {
                    ApplicationArea = Basic;
                }
                field("Substituting Member Name";"Substituting Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Created By";"Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Substituted By";"Substituted By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Substituted";"Date Substituted")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series";"No. Series")
                {
                    ApplicationArea = Basic;
                }
                field(Substituted;Substituted)
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

