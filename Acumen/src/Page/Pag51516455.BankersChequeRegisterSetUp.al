#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516455 "Bankers Cheque Register SetUp"
{
    ApplicationArea = Basic;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Banker Cheque Register";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control6)
            {
                field("Banker Cheque No.";"Banker Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(Issued;Issued)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Cancelled;Cancelled)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
            field(BankerCh;BankerCh)
            {
                ApplicationArea = Basic;
            }
            field(NoOfLeaves;NoOfLeaves)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Generate)
            {
                ApplicationArea = Basic;
                Caption = 'Generate';
                Image = Grid;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to generate bankers cheque No.?',false) = false then
                    exit;

                    i :=0;

                    repeat
                    i := i + 1;

                    BankerR.Init;
                    BankerR."Banker Cheque No.":=BankerCh;
                    BankerR.Insert;

                    BankerCh:=IncStr(BankerCh);
                    until i = NoOfLeaves;
                end;
            }
        }
    }

    var
        BankerCh: Code[20];
        NoOfLeaves: Integer;
        i: Integer;
        BankerR: Record "Banker Cheque Register";
}

