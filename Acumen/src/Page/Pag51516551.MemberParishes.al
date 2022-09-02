#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516551 "Member Parishes"
{
    PageType = Card;
    SourceTable = "Member's Parishes";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Share Class";"Share Class")
                {
                    ApplicationArea = Basic;
                }
                field("No of Members";"No of Members")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Male Members";"Male Members")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Female Members";"Female Members")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

