#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516242 "HR Training Needs"
{
    ApplicationArea = Basic;
    CardPageID = "HR Training Needs Card";
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Training Needs";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Duration;Duration)
                {
                    ApplicationArea = Basic;
                }
                field("Duration Units";"Duration Units")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date";"Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date";"End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Re-Assessment Date";"Re-Assessment Date")
                {
                    ApplicationArea = Basic;
                }
                field(Location;Location)
                {
                    ApplicationArea = Basic;
                }
                field(Provider;Provider)
                {
                    ApplicationArea = Basic;
                }
                field("Cost Of Training";"Cost Of Training")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755003;Outlook)
            {
            }
            systempart(Control1102755005;Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Training Needs")
            {
                Caption = 'Training Needs';
                action("&Card")
                {
                    ApplicationArea = Basic;
                    Caption = '&Card';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Training Needs";
                    RunPageLink = Code=field(Code);
                }
            }
        }
        area(reporting)
        {
            action(Action1102755006)
            {
                ApplicationArea = Basic;
                Caption = 'Training Needs';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report UnknownReport55595;
            }
        }
    }
}

