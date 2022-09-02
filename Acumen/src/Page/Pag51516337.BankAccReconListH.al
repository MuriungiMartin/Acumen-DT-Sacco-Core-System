#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516337 "Bank Acc. Recon. List H"
{
    Caption = 'Bank Acc. Reconciliation List';
    CardPageID = "Payroll General Setup LIST.";
    Editable = false;
    PageType = List;
    SourceTable = "Bank Acc. Reconciliation";
    SourceTableView = where("Statement Type"=const("Bank Reconciliation"));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(BankAccountNo;"Bank Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(StatementNo;"Statement No.")
                {
                    ApplicationArea = Basic;
                }
                field(StatementDate;"Statement Date")
                {
                    ApplicationArea = Basic;
                }
                field(BalanceLastStatement;"Balance Last Statement")
                {
                    ApplicationArea = Basic;
                }
                field(StatementEndingBalance;"Statement Ending Balance")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207;Links)
            {
                Visible = false;
            }
            systempart(Control1905767507;Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Bank Acc. Recon. Post (Yes/No)";
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        if UserSetup.Get(UserId) then
                        begin
                        if UserSetup."Post Bank Rec" =false then Error ('You dont have permissions to post, Contact your system administrator! ')
                        end;
                    end;
                }
                action(PostAndPrint)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Bank Acc. Recon. Post+Print";
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        if UserSetup.Get(UserId) then
                        begin
                        if UserSetup."Post Bank Rec" =false then Error ('You dont have permissions to post, Contact your system administrator! ')
                        end;
                    end;
                }
            }
        }
    }

    var
        UserSetup: Record "User Setup";
}

