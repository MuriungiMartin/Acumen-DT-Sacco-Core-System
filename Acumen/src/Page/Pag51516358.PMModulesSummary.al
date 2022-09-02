#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516358 "PM Modules Summary"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "PM Modules";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field("Module Name";"Module Name")
                {
                    ApplicationArea = Basic;
                }
                field(New;New)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(WIP;WIP)
                {
                    ApplicationArea = Basic;
                    Style = Standard;
                    StyleExpr = true;
                }
                field(Resolved;Resolved)
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field(Rejected;Rejected)
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Total Items";"Total Items")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
    }
}

