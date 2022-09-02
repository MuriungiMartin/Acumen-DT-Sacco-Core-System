#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516146 "Payment Voucher List Nafaka"
{
    CardPageID = "Payment Voucher Nafaka";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Payments Header";
    SourceTableView = where("Payment Type"=filter(Normal),Posted=filter(false),Status=filter(<>Cancelled|Posted),"Expense Type"=filter(<>Director));

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field(Cashier;Cashier)
                {
                    ApplicationArea = Basic;
                }
                field(Date;Date)
                {
                    ApplicationArea = Basic;
                }
                field("Pay Mode";"Pay Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No.";"Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center";"Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Payee;Payee)
                {
                    ApplicationArea = Basic;
                }
                field("Payment Narration";"Payment Narration")
                {
                    ApplicationArea = Basic;
                }
                field("On Behalf Of";"On Behalf Of")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code";"Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Total Payment Amount";"Total Payment Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Current Status";"Current Status")
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
            action(PrintNew)
            {
                ApplicationArea = Basic;
                Caption = 'Print/Preview';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //TESTFIELD(Status,Status::Approved);
                    /*IF (Status=Status::Pending) OR  (Status=Status::"Pending Approval") THEN
                       ERROR('You cannot Print until the document is Approved'); */
                    
                    PHeader2.Reset;
                    PHeader2.SetRange(PHeader2."No.","No.");
                    if PHeader2.FindFirst then
                       Report.Run(51516125,true,true,PHeader2);
                    
                    /*RESET;
                    SETRANGE("No.","No.");
                    IF "No." = '' THEN
                      REPORT.RUNMODAL(51516000,TRUE,TRUE,Rec)
                    ELSE
                      REPORT.RUNMODAL(51516344,TRUE,TRUE,Rec);
                    RESET;
                    */

                end;
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;

    trigger OnOpenPage()
    begin
        SetRange(Cashier,UserId);
    end;

    var
        PHeader2: Record "Payments Header";
}

