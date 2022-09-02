#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516221 "HR E-Mail Parameters"
{
    PageType = Card;
    SourceTable = "HR E-Mail Parameters";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Associate With";"Associate With")
                {
                    ApplicationArea = Basic;
                }
                field("Sender Name";"Sender Name")
                {
                    ApplicationArea = Basic;
                }
                field("Sender Address";"Sender Address")
                {
                    ApplicationArea = Basic;
                }
                field(Recipients;Recipients)
                {
                    ApplicationArea = Basic;
                }
                field(Subject;Subject)
                {
                    ApplicationArea = Basic;
                }
                field(Body;Body)
                {
                    ApplicationArea = Basic;
                }
                field("Body 2";"Body 2")
                {
                    ApplicationArea = Basic;
                }
                field("Body 3";"Body 3")
                {
                    ApplicationArea = Basic;
                }
                field(HTMLFormatted;HTMLFormatted)
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

