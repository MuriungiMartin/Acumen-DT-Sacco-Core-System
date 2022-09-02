#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516478 "Treasury List"
{
    ApplicationArea = Basic;
    CardPageID = "Treasury Card";
    Editable = false;
    PageType = List;
    SourceTable = "Bank Account";
    SourceTableView = where("Account Type"=filter(Treasury));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field(Contact;Contact)
                {
                    ApplicationArea = Basic;
                }
                field("Phone No.";"Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No.";"Bank Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Acc. Posting Group";"Bank Acc. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field(Balance;Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Balance (LCY)";"Balance (LCY)")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Cashier Activity Report")
            {
                ApplicationArea = Basic;
                Caption = 'Activity Report(Detailed)';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    TillNo.Reset;
                    TillNo.SetRange(TillNo."No.","No.");
                    if TillNo.Find('-') then
                    Report.Run(1404,true,false,TillNo)
                end;
            }
            action("Cashier Activity Report 2")
            {
                ApplicationArea = Basic;
                Caption = 'Activity Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    TillNo.Reset;
                    TillNo.SetRange(TillNo."No.","No.");
                    if TillNo.Find('-') then
                    Report.Run(51516019,true,false,TillNo)
                end;
            }
        }
    }

    var
        TillNo: Record "Bank Account";
}

