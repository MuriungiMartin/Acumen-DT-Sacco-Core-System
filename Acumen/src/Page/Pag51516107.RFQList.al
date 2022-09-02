#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516107 "RFQ List"
{
    ApplicationArea = Basic;
    CardPageID = "RFQ Header";
    PageType = List;
    SourceTable = "Purchase Quote Header";
    SourceTableView = where(Status=filter(Open|Released));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Description";"Posting Description")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Code";"Ship-to Code")
                {
                    ApplicationArea = Basic;
                }
                field("Ship-to Name";"Ship-to Name")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Closing Date";"Expected Closing Date")
                {
                    ApplicationArea = Basic;
                }
                field("Location Code";"Location Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code";"Currency Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }


    procedure GetSelectionFilter(): Text
    var
        RFQ: Record "Purchase Quote Header";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SetSelectionFilter(RFQ);
        //EXIT(SelectionFilterManagement.GetSelectionFilterForItem(Item));
        exit(RFQ."No.");
    end;


    procedure SetSelection(var RFQ: Record "Purchase Quote Header")
    begin
        CurrPage.SetSelectionFilter(RFQ);
    end;
}

