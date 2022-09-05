#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516440 "Cashier Trans Authorisations"
{
    ApplicationArea = Basic;
    CardPageID = "Cashier Transactions Card Auth";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Transactions;
    SourceTableView = where("Supervisor Checked" = const(false),
                            "Needs Approval" = const(Yes),
                            "Post Attempted" = const(true));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Description"; "Transaction Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transaction';
                    Editable = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Cashier; Cashier)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date"; "Transaction Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date';
                    Editable = false;
                }
                field("Transaction Time"; "Transaction Time")
                {
                    ApplicationArea = Basic;
                    Caption = 'Time';
                    Editable = false;
                }
                field("Authorisation Requirement"; "Authorisation Requirement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Authorisation Req.';
                    Editable = false;
                }
                field(Authorised; Authorised)
                {
                    ApplicationArea = Basic;
                }
                field(Select; Select)
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
            group(View)
            {
                Caption = 'View';
                action("Account Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Card';
                    RunObject = Page "FOSA Account Card";
                    RunPageLink = "No." = field("Account No");
                }
            }
        }
        area(processing)
        {
            action("Send Mail")
            {
                ApplicationArea = Basic;
                Caption = 'Send Mail';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    MailContent := 'Transaction of Kshs.' + ' ' + Format(Amount) + ' ' + 'for' + ' ' + "Account Name" +
                    ' ' + 'has been authorized.';


                    SENDMAIL;
                end;
            }
            action(Process)
            {
                ApplicationArea = Basic;
                Caption = 'Process';
                Image = PutawayLines;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    /*MESSAGE('Authorization process underway');
                    
                    Transactions.RESET;
                    Transactions.SETRANGE(Transactions.Select,TRUE);
                    Transactions.SETRANGE(Transactions."Supervisor Checked",FALSE);
                    Transactions.SETRANGE(Transactions."Needs Approval",Transactions."Needs Approval"::Yes);
                    IF Transactions.FIND('-') THEN
                    REPEAT
                    
                    UNTIL Transactions.NEXT = 0;
                    
                    IF Transactions."Authorisation Requirement" = 'Withdrawal Above teller Limit' THEN
                    Transactions."Withdrawal FrequencyAuthorised":=Transactions."Withdrawal FrequencyAuthorised"::Yes;
                    Transactions."Supervisor Checked":=TRUE;
                    Transactions."Status Date":=TODAY;
                    Transactions."Status Time":=TIME;
                    Transactions."Checked By":=USERID;
                    Transactions.Authorised:=Transactions.Authorised::Yes;
                    Transactions.MODIFY;
                    //END;
                    MESSAGE('The selected transactions have been processed.');
                    */





                    if Confirm('Are you sure you want to process the selected transactions?', false) = true then begin

                        Transactions.Reset;
                        Transactions.SetRange(Transactions.Select, true);
                        Transactions.SetRange(Transactions."Supervisor Checked", false);
                        Transactions.SetRange(Transactions."Needs Approval", Transactions."needs approval"::Yes);
                        if Transactions.Find('-') then
                            repeat

                                //Check authorisation limits
                                if Transactions.Authorised <> Transactions.Authorised::No then begin
                                    SupervisorApprovals.Reset;
                                    SupervisorApprovals.SetRange(SupervisorApprovals."Supervisor ID", UpperCase(UserId));
                                    if Transactions."Transaction Type" = 'Cash Deposit' then
                                        SupervisorApprovals.SetRange(SupervisorApprovals."Transaction Type", SupervisorApprovals."transaction type"::"Cash Deposits");
                                    if Transactions."Transaction Type" = 'Cheque Deposit' then
                                        SupervisorApprovals.SetRange(SupervisorApprovals."Transaction Type", SupervisorApprovals."transaction type"::"Cheque Deposits");
                                    if Transactions."Transaction Type" = 'Withdrawal' then
                                        SupervisorApprovals.SetRange(SupervisorApprovals."Transaction Type", SupervisorApprovals."transaction type"::Withdrawals);
                                    if SupervisorApprovals.Find('-') then begin
                                        if Transactions.Amount > SupervisorApprovals."Maximum Approval Amount" then
                                            Error('You cannot approve the deposit because it is above your approval limit.');
                                    end else begin
                                        Error('You are not authorised to approve the selected deposits.');
                                    end;

                                    /*IF Transactions."Authorisation Requirement" = 'Over Draft' THEN BEGIN
                                    Transactions.Overdraft:=TRUE;
                                    Transactions.MODIFY;
                                    END;*/


                                    if Transactions."Authorisation Requirement" = 'Withdrawal Freq.' then
                                        Transactions."Withdrawal FrequencyAuthorised" := Transactions."withdrawal frequencyauthorised"::Yes;
                                    Transactions."Supervisor Checked" := true;
                                    Transactions."Status Date" := Today;
                                    Transactions."Status Time" := Time;
                                    Transactions."Checked By" := UserId;
                                    Transactions.Modify;
                                end;

                            until Transactions.Next = 0;

                        SENDMAIL;
                        Message('The selected transactions have been processed.');

                    end;

                end;
            }
            action(Authorize)
            {
                ApplicationArea = Basic;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    UserSetUp.Reset;
                    if UserSetUp.Get(Cashier) then begin
                        /// MESSAGE(FORMAT(USERID));
                        if UserSetUp."Cashier Authorization" = false then
                            Error('%1,You do not have Permission to Authorize Cashier Transaction, Kindly Contact your System Administrator.', Cashier);
                    end;

                    if Confirm('Are you Sure you want to Authorization THIS TRANSACTION?', true) = false then
                        exit;

                    "Supervisor Checked" := true;
                    "Needs Approval" := "needs approval"::Yes;
                    "Post Attempted" := true;
                    Authorised := Authorised::Yes;
                    //"Above Teller Limit App Status":="Above Teller Limit App Status"::"3";
                    if Type = 'Withdrawals' then begin
                        "Authorisation Requirement" := 'Withdaral Above Cashier Limits'
                    end else
                        "Authorisation Requirement" := 'Deposit Above Cashier Limits';
                    Modify;
                    Message('Authorized Successfully, Thank you');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        /*IF UsersID.GET(USERID) THEN BEGIN
        IF UsersID.Branch <> '' THEN
        SETRANGE("Transacting Branch",UsersID.Branch);
        END; */

    end;

    var
        Transactions: Record Transactions;
        SupervisorApprovals: Record "Supervisors Approval Levels";
        UsersID: Record User;
        "Gen-Setup": Record "Sacco General Set-Up";
        SendToAddress: Text[30];
        BankAccount: Record "Bank Account";
        MailContent: Text[150];
        UserSetUp: Record "User Setup";


    procedure SENDMAIL()
    begin
        //sent mail on authorisation
        /*
        BankAccount.RESET;
        BankAccount.SETRANGE(BankAccount."Cashier ID",Cashier);
        IF BankAccount.FIND('-') THEN BEGIN
        REPEAT
        MailContent:='Transaction' + ' '+'TR. No.'+' '+No+' ' + 'of Kshs'+ ' '+ FORMAT(Amount) + ' '+ 'for'
        +' ' +"Account Name"+' '+'has been authorized';
        
        "Gen-Setup".GET();
        SMTPMAIL.NewMessage("Gen-Setup"."Sender Address",'AUTHORISED TRANSACTION'+''+'');
        SMTPMAIL.SetWorkMode();
        SMTPMAIL.ClearAttachments();
        SMTPMAIL.ClearAllRecipients();
        SMTPMAIL.SetDebugMode();
        SMTPMAIL.SetFromAdress("Gen-Setup"."Sender Address");
        SMTPMAIL.SetHost("Gen-Setup"."Outgoing Mail Server");
        SMTPMAIL.SetUserID("Gen-Setup"."Sender User ID");
        SMTPMAIL.AddLine(MailContent);
        SendToAddress:=BankAccount."E-Mail";
        SMTPMAIL.SetToAdress(SendToAddress);
        SMTPMAIL.Send;
        UNTIL BankAccount.NEXT=0;
        END;
        */

    end;
}

