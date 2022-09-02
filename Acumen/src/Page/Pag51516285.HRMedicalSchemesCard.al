#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516285 "HR Medical Schemes Card"
{
    PageType = Card;
    SourceTable = "HR Medical Schemes";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Scheme No";"Scheme No")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Insurer";"Medical Insurer")
                {
                    ApplicationArea = Basic;
                }
                field("Scheme Name";"Scheme Name")
                {
                    ApplicationArea = Basic;
                }
                field("In-patient limit";"In-patient limit")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Out-patient limit";"Out-patient limit")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Area Covered";"Area Covered")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Dependants Included";"Dependants Included")
                {
                    ApplicationArea = Basic;
                }
                field(Comments;Comments)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Medical Scheme Members")
                {
                    ApplicationArea = Basic;
                    Caption = 'Medical Scheme Members';
                    Image = PersonInCharge;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Medical Scheme Members List";
                }
            }
        }
    }
}

