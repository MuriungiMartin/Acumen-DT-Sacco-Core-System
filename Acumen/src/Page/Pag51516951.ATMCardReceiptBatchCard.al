#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516951 "ATM Card Receipt Batch Card"
{
    PageType = Card;
    SourceTable = "ATM Card Receipt Batch";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Batch No.";"Batch No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Description/Remarks";"Description/Remarks")
                {
                    ApplicationArea = Basic;
                }
                field(Requested;Requested)
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Date Created";"Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Date Requested";"Date Requested")
                {
                    ApplicationArea = Basic;
                }
                field("Requested By";"Requested By")
                {
                    ApplicationArea = Basic;
                }
                field("Prepared By";"Prepared By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control11;"ATM Card Receipt SubPage")
            {
                SubPageLink = "Batch No."=field("Batch No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(LoadATMApplications)
            {
                ApplicationArea = Basic;
                Caption = 'Load Applied and Not Received ATM Cards';
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ObjCardsApplied.Reset;
                    ObjCardsApplied.SetRange(ObjCardsApplied."Order ATM Card",true);
                    ObjCardsApplied.SetRange(ObjCardsApplied."Card Received",false);
                    if ObjCardsApplied.FindSet then begin
                      repeat
                      ObjCardsReceipts.Init;
                      ObjCardsReceipts."Batch No.":="Batch No.";
                      ObjCardsReceipts."ATM Application No":=ObjCardsApplied."No.";
                      ObjCardsReceipts."ATM Card Account No":=ObjCardsApplied."Account No";
                      ObjCardsReceipts."Account Name":=ObjCardsApplied."Account Name";
                      ObjCardsReceipts."ATM Card Application Date":=ObjCardsApplied."Application Date";
                      ObjCardsReceipts.Insert;
                      until ObjCardsApplied.Next=0;
                      end;
                end;
            }
        }
    }

    var
        ObjCardsReceipts: Record "ATM Card Receipt Lines";
        ObjCardsApplied: Record "ATM Card Applications";
}

