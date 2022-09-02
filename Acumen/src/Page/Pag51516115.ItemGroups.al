#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516115 "Item Groups"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Item Groups";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control12)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Def. Gen. Prod. Posting Group";"Def. Gen. Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Def. Inventory Posting Group";"Def. Inventory Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Def. VAT Prod. Posting Group";"Def. VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Def. Costing Method";"Def. Costing Method")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control2;Links)
            {
                Visible = false;
            }
            systempart(Control1;Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Item Category Code")
            {
                ApplicationArea = Basic;
                Caption = '&Item Category Code';
                Image = ItemGroup;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Item Categories";
                RunPageLink = Field51516000=field(Code);
            }
        }
    }
}

