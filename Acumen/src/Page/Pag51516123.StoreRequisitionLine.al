#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516123 "Store Requisition Line"
{
    PageType = ListPart;
    SourceTable = "Store Requistion Lines";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Description 2";"Description 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Remark';
                    Visible = false;
                }
                field("Unit of Measure";"Unit of Measure")
                {
                    ApplicationArea = Basic;
                }
                field("Qty in store";"Qty in store")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Quantity Requested";"Quantity Requested")
                {
                    ApplicationArea = Basic;
                }
                field("Unit Cost";"Unit Cost")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Line Amount";"Line Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Quantity;Quantity)
                {
                    ApplicationArea = Basic;
                    Caption = 'Quantity To Issue';
                }
                field("Issuing Store";"Issuing Store")
                {
                    ApplicationArea = Basic;
                }
                field("Bin Code";"Bin Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Gen. Bus. Posting Group";"Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Gen. Prod. Posting Group";"Gen. Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Item Status";"Item Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Lot No.";"Lot No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                }
                action("Item Tracking Lines")
                {
                    ApplicationArea = Basic;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        OpenItemTrackingLines;
                    end;
                }
            }
        }
    }
}

