#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516457 "Bankers Cheque Schedule"
{
    ApplicationArea = Basic;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Transactions;
    SourceTableView = where(Type=const('Bankers Cheque'),
                            Posted=const(true),
                            "Banking Posted"=const(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control17)
            {
                field(No;No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Staff/Payroll No";"Staff/Payroll No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff No';
                    Editable = false;
                }
                field(Payee;Payee)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Description";"Transaction Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction';
                    Editable = false;
                }
                field("Bankers Cheque No";"Bankers Cheque No")
                {
                    ApplicationArea = Basic;
                }
                field("Other Bankers No.";"Other Bankers No.")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Date";"Cheque Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Reference No";"Reference No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks;Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("BIH No";"BIH No")
                {
                    ApplicationArea = Basic;
                }
                field(Select;Select)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Banker Cheque")
            {
                Caption = 'Banker Cheque';
                action("Bankers Cheque Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bankers Cheque Schedule';
                    Visible = false;
                }
                separator(Action1102760029)
                {
                }
                action("Process Banking")
                {
                    ApplicationArea = Basic;
                    Caption = 'Process Banking';
                    Image = PutawayLines;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Bank the selected cheques?',false) = true then begin

                        Transactions.Reset;
                        Transactions.SetRange(Type,'Bankers Cheque');
                        Transactions.SetRange(Transactions.Select,true);
                        //Transactions.SETRANGE(Transactions."Cheque Processed",Transactions."Cheque Processed"::"0");
                        if Transactions.Find('-') then begin
                        repeat

                        Transactions."Banked By":=UserId;
                        Transactions."Date Banked":=Today;
                        Transactions."Time Banked":=Time;
                        Transactions."Banking Posted":=true;
                        Transactions."Cheque Processed":=Transactions."cheque processed"::"1";
                        Transactions.Modify;
                        until Transactions.Next = 0;

                        Message('The selected bankers cheques banked successfully.');

                        end;
                        end;
                    end;
                }
                separator(Action1102760038)
                {
                }
                action("Commitement Cheque Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Commitement Cheque Schedule';
                    Visible = false;
                }
            }
        }
        area(processing)
        {
            action("Select All")
            {
                ApplicationArea = Basic;
                Caption = 'Select All';
                Image = SelectEntries;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Transactions.Reset;
                    Transactions.SetRange(Type,'Bankers Cheque');
                    Transactions.SetRange(Transactions.Select,false);
                    if Transactions.Find('-') then begin
                    repeat

                    Transactions.Select:=true;
                    Transactions.Modify;
                    until Transactions.Next = 0;

                    Message('Bankers cheques selected successfully.');

                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Filter based on branch
        /*IF UsersID.GET(USERID) THEN BEGIN
        IF UsersID.Branch <> '' THEN
        SETRANGE("Transacting Branch",UsersID.Branch);
        END;*/
        //Filter based on branch

    end;

    var
        Transactions: Record Transactions;
        SupervisorApprovals: Record "Supervisors Approval Levels";
        UsersID: Record User;
}

