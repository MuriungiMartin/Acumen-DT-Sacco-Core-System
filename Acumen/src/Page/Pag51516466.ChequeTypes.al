#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516466 "Cheque Types"
{
    ApplicationArea = Basic;
    PageType = Card;
    SourceTable = "Cheque Types";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control14)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field("Clearing Days";"Clearing Days")
                {
                    ApplicationArea = Basic;
                }
                field("Clearing  Days";"Clearing  Days")
                {
                    ApplicationArea = Basic;
                }
                field("Use %";"Use %")
                {
                    ApplicationArea = Basic;
                }
                field("% Of Amount";"% Of Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Clearing Charges";"Clearing Charges")
                {
                    ApplicationArea = Basic;
                }
                field("Bounced Charges";"Bounced Charges")
                {
                    ApplicationArea = Basic;
                }
                field("Clearing Bank Account";"Clearing Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name";"Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bounced Charges GL Account";"Bounced Charges GL Account")
                {
                    ApplicationArea = Basic;
                }
                field("Clearing Charges GL Account";"Clearing Charges GL Account")
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

