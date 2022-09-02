#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516558 "Loan Collateral Register List"
{
    CardPageID = "Loan Collateral Register Card";
    Editable = false;
    PageType = List;
    SourceTable = "Loan Collateral Register";

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
                field("Registered Owner";"Registered Owner")
                {
                    ApplicationArea = Basic;
                }
                field("Member No.";"Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Type";"Collateral Type")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Description";"Collateral Description")
                {
                    ApplicationArea = Basic;
                }
                field("Date Received";"Date Received")
                {
                    ApplicationArea = Basic;
                }
                field("Received By";"Received By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Released";"Date Released")
                {
                    ApplicationArea = Basic;
                }
                field("Released By";"Released By")
                {
                    ApplicationArea = Basic;
                }
                field(Picture;Picture)
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

