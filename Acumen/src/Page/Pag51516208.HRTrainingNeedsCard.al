#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516208 "HR Training Needs Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions';
    SourceTable = "HR Training Needs";

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
                field("Start Date";"Start Date")
                {
                    ApplicationArea = Basic;
                }
                field(Duration;Duration)
                {
                    ApplicationArea = Basic;
                }
                field("Duration Units";"Duration Units")
                {
                    ApplicationArea = Basic;
                }
                field("Cost Of Training";"Cost Of Training")
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
                field("Provider Name";"Provider Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("End Date";"End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code";"Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Closed;Closed)
                {
                    ApplicationArea = Basic;
                }
                field("Job id";"Job id")
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
                action("&Mark as Closed/Open")
                {
                    ApplicationArea = Basic;
                    Caption = '&Mark as Closed/Open';
                    Image = CloseDocument;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Closed then
                        begin
                            Closed:=false;
                            Message('Training need :: %1 :: has been Re-Opened',Description);
                        end
                        else begin
                            Closed:=true;
                            Message('Training need :: %1 :: has been closed',Description);
                            Modify;
                        end;
                    end;
                }
            }
        }
    }

    var
        D: Date;
}

