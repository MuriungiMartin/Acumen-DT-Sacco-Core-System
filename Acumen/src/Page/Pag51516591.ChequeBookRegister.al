#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516591 "Cheque Book Register"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Cheque Book Register";

    layout
    {
        area(content)
        {
            repeater(Control5)
            {
                field("Cheque No.";"Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(Issued;Issued)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
            }
            field(BankerCh;BankerCh)
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field(NoOfLeaves;NoOfLeaves)
            {
                ApplicationArea = Basic;
                Visible = false;
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
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to generate bankers cheque No.?',false) = false then
                    exit;

                    i :=0;

                    repeat
                    i := i + 1;

                    BankerR.Init;
                    BankerR."Cheque No.":=BankerCh;
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
        BankerR: Record "Cheque Book Register";
}

