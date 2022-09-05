#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516526 "Customer Care Log"
{
    PageType = Card;
    SourceTable = "Customer Care Logs";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Calling As"; "Calling As")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin


                        if "Calling As" = "calling as"::"As Member" then
                            Page.Run(39004305, Rec);
                    end;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Contact Mode"; "Contact Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Calling For"; "Calling For")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Balance"; "Loan Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Current Deposits"; "Current Deposits")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No"; "ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No"; "Phone No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No';
                }
                field("Passport No"; "Passport No")
                {
                    ApplicationArea = Basic;
                }
                field(Email; Email)
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                }
                field("Query Code"; "Query Code")
                {
                    ApplicationArea = Basic;
                }
                field("Share Capital"; "Share Capital")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Source; Source)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("No. Series"; "No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Application User"; "Application User")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Time"; "Application Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Receive User"; "Receive User")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Receive date"; "Receive date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Receive Time"; "Receive Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Resolved User"; "Resolved User")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Resolved Date"; "Resolved Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Resolved Time"; "Resolved Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Received From"; "Received From")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Caller Reffered To"; "Caller Reffered To")
                {
                    ApplicationArea = Basic;
                }
                field("Date Sent"; "Date Sent")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Time Sent"; "Time Sent")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sent By"; "Sent By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Detailed Member Page")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Member Account Card";
                RunPageLink = "No." = field("Member No");
            }
            action("Send To")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    TestField("Caller Reffered To");
                    "Date Sent" := WorkDate;
                    "Time Sent" := Time;
                    "Sent By" := UserId;
                    Modify;
                end;
            }
            action(Receive)
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    "Receive User" := UserId;
                    "Receive date" := WorkDate;
                    "Receive Time" := Time;
                    Modify;
                end;
            }
            action(Resolved)
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                begin

                    if Status = Status::Resolved then begin
                        Error('Customer query has already been %1', Status);
                    end;



                    //TO ENABLE RESOLUTION OF CUSTOMER QUERIES LOGGED INTO THE SYSTEM
                    CustCare.SetRange(CustCare.No, No);
                    if CustCare.Find('-') then begin
                        CustCare.Status := CustCare.Status::Resolved;
                        CustCare."Resolved User" := UserId;
                        CustCare."Resolved Date" := WorkDate;
                        CustCare."Resolved Time" := Time;
                        CustCare.Modify;
                    end;

                    CurrPage.Editable := false;
                    /*
                    CQuery.RESET;
                    CQuery.SETRANGE(CQuery.No,No);
                    IF CQuery.FIND('-') THEN BEGIN
                    REPORT.RUN(39004018,TRUE,FALSE,CQuery);
                    END;
                         */

                end;
            }
            action(Delegate)
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    TestField("Caller Reffered To");
                    "Date Sent" := WorkDate;
                    "Time Sent" := Time;
                    "Sent By" := UserId;
                    Modify;
                end;
            }
        }
    }

    var
        Cust: Record Customer;
        PvApp: Record "Responsibility Center BR";
        CustCare: Record "Customer Care Logs";
        CQuery: Record "Customer Care Logs";
}

