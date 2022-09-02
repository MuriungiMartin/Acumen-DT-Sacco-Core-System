#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516187 "HR Leave Types Card"
{
    PageType = Card;
    SourceTable = "HR Leave Types";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Days;Days)
                {
                    ApplicationArea = Basic;
                }
                field("Acrue Days";"Acrue Days")
                {
                    ApplicationArea = Basic;
                }
                field("Unlimited Days";"Unlimited Days")
                {
                    ApplicationArea = Basic;
                }
                field(Gender;Gender)
                {
                    ApplicationArea = Basic;
                }
                field(Balance;Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Max Carry Forward Days";"Max Carry Forward Days")
                {
                    ApplicationArea = Basic;
                }
                field("Carry Forward Allowed";"Carry Forward Allowed")
                {
                    ApplicationArea = Basic;
                }
                field("Inclusive of Non Working Days";"Inclusive of Non Working Days")
                {
                    ApplicationArea = Basic;
                }
                field("Inclusive of Saturday";"Inclusive of Saturday")
                {
                    ApplicationArea = Basic;
                }
                field("Inclusive of Sunday";"Inclusive of Sunday")
                {
                    ApplicationArea = Basic;
                }
                field("Inclusive of Holidays";"Inclusive of Holidays")
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

