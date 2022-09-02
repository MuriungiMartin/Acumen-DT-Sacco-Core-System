#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516106 "RFQ Subform"
{
    PageType = ListPart;
    SourceTable = "Purchase Quote Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field("Expense Code";"Expense Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Description 2";"Description 2")
                {
                    ApplicationArea = Basic;
                }
                field("Unit of Measure";"Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field(Quantity;Quantity)
                {
                    ApplicationArea = Basic;
                }
                field("Direct Unit Cost";"Direct Unit Cost")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("PRF No";"PRF No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Set Specification")
            {
                ApplicationArea = Basic;
                Caption = 'Set Specification';

                trigger OnAction()
                var
                    PParams: Record "Purchase Quote Params";
                begin
                    PParams.Reset;
                    PParams.SetRange(PParams."Document Type","Document Type");
                    PParams.SetRange(PParams."Document No.","Document No.");
                    PParams.SetRange(PParams."Line No.","Line No.");
                    Page.Run(51516780,PParams);
                end;
            }
        }
    }
}

