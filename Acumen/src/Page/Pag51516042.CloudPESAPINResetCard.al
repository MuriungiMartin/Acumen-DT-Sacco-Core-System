#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516042 "CloudPESA PIN Reset Card"
{
    Editable = true;
    PageType = Card;
    SourceTable = "CloudPESA Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
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
                field(Telephone; Telephone)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No"; "ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Applied"; "Date Applied")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Applied"; "Time Applied")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Last Pin Reset"; "Last Pin Reset")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SentToServer; SentToServer)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Reset Pin")
            {
                ApplicationArea = Basic;
                Image = Answers;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F5';

                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                begin
                    UserSetup.Get(UserId);
                    //UserSetup.TESTFIELD("Reset Pin");

                    if SentToServer = false then begin
                        // ERROR('Pin reset has already been Requested');
                    end else begin

                        "Last Pin Reset" := Today;
                        "Created By" := UserId;
                        SentToServer := false;
                        "PIN Requested" := true;
                        pinResetLogs.Insert(true);

                        pinResetLogs.Reset;
                        pinResetLogs.Init;
                        pinResetLogs."Account Name" := "Account Name";
                        pinResetLogs.No := "No.";
                        pinResetLogs."ID No" := "ID No";
                        pinResetLogs."Account No" := "Account No";
                        pinResetLogs.Telephone := Telephone;
                        pinResetLogs.Date := CurrentDatetime;
                        pinResetLogs."Last PIN Reset" := CurrentDatetime;
                        pinResetLogs."Reset By" := UserId;
                        pinResetLogs.Insert(true);
                        if pinResetLogs.Insert = true then
                            Message('Pin reset has been successfully been sent');

                    end;
                end;
            }
            action("PIN Reset Entries")
            {
                ApplicationArea = Basic;
                Image = CampaignEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Pin Reset List";
                RunPageLink = No = field("No.");
                RunPageOnRec = false;
                RunPageView = sorting("Entry No")
                              order(descending);
            }
        }
    }

    trigger OnOpenPage()
    begin
        //ERROR('under maintenance');
    end;

    var
        cloudpesaapp: Record "CloudPESA Applications";
        pinResetLogs: Record "CloudPESA Pin Reset Logs";
}

