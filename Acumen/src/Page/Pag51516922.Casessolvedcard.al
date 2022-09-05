#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516922 "Cases solved card"
{
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    SourceTable = "Cases Management";
    SourceTableView = where(Status = filter(Resolved));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Case Number"; "Case Number")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Complaint"; "Date of Complaint")
                {
                    ApplicationArea = Basic;
                }
                field("Type of cases"; "Type of cases")
                {
                    ApplicationArea = Basic;
                }
                field("Recommended Action"; "Recommended Action")
                {
                    ApplicationArea = Basic;
                }
                field("Case Description"; "Case Description")
                {
                    ApplicationArea = Basic;
                }
                field("Resource #2"; "Resource #2")
                {
                    ApplicationArea = Basic;
                }
                field("Action Taken"; "Action Taken")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Case Information")
            {
                field("Date To Settle Case"; "Date To Settle Case")
                {
                    ApplicationArea = Basic;
                }
                field("Document Link"; "Document Link")
                {
                    ApplicationArea = Basic;
                }
                field("Solution Remarks"; "Solution Remarks")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Comments)
                {
                    ApplicationArea = Basic;
                }
                field("Body Handling The Complaint"; "Body Handling The Complaint")
                {
                    ApplicationArea = Basic;
                }
                field(Recomendations; Recomendations)
                {
                    ApplicationArea = Basic;
                }
                field("Support Documents"; "Support Documents")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Date Resolved"; "Date Resolved")
                {
                    ApplicationArea = Basic;
                }
                field("Time Resolved"; "Time Resolved")
                {
                    ApplicationArea = Basic;
                }
                field("Resolved User"; "Resolved User")
                {
                    ApplicationArea = Basic;
                    Caption = 'Resolved By';
                }
                field("Resource Assigned"; "Resource Assigned")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; "Loan No")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control8; "Member Statistics FactBox")
            {
                Caption = 'BOSA Statistics FactBox';
                SubPageLink = "No." = field("Member No");
            }
            part(Control7; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("FOSA Account.");
            }
            part(Control6; "Loans Sub-Page List")
            {
                Caption = 'Loans Details';
                SubPageLink = "Client Code" = field("Member No");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Print Resolved Confirmation Sheet")
            {
                ApplicationArea = Basic;
                Image = PrintAcknowledgement;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Status <> Status::Resolved then
                        Error('only resolved cases can be printed');
                    casep.Reset;
                    casep.SetRange(casep."Case Number", "Case Number");
                    if casep.FindFirst then begin
                        Report.Run(Report::"Case solved  confirmation", true, false, casep);
                    end;
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
                    end else



                        //TO ENABLE RESOLUTION OF CUSTOMER QUERIES LOGGED INTO THE SYSTEM
                        CustCare.SetRange(CustCare.No, "Case Number");
                    if CustCare.Find('-') then begin
                        CustCare.Status := CustCare.Status::Resolved;
                        CustCare."Resolved User" := UserId;
                        CustCare."Resolved Date" := WorkDate;
                        CustCare."Resolved Time" := Time;
                        CustCare.Modify;
                    end;
                    caseCare.SetRange(caseCare."Case Number", "Case Number");
                    if caseCare.Find('-') then begin
                        caseCare.Status := caseCare.Status::Resolved;
                        caseCare."Resolved User" := UserId;
                        caseCare."Resolved Date" := WorkDate;
                        caseCare."Resolved Time" := Time;
                        caseCare.Modify;
                        smsResolved();
                        Message('The case has been successfully resolved');
                    end;
                    CurrPage.Editable := false;
                end;
            }
            action("Members Statistics")
            {
                ApplicationArea = Basic;
                Caption = 'Member Details';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Members Statistics";
                RunPageLink = "No." = field("Member No");
            }
        }
    }

    trigger OnInit()
    begin
        //SETRANGE("Resource Assigned",USERID);
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("Resource Assigned",USERID);
    end;

    var
        CustCare: Record "General Equiries.";
        AssignedReas: Record "Cases Management";
        caseCare: Record "Cases Management";
        casep: Record "Cases Management";

    local procedure sms()
    var
        iEntryNo: Integer;
        SMSMessages: Record "SMS Messages";
        Cust: Record Customer;
    begin

        //SMS MESSAGE
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;

        SMSMessages.Reset;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Account No" := "Member No.";
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'Cases';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        //SMSMessages."Sent To Server":=SMSMessages."Sent To Server::No;
        SMSMessages."SMS Message" := 'Your case/complain has been received and assigned to.' + "Resource #2" +
                                  ' kindly contact the resource for follow ups';
        Cust.Reset;
        if Cust.Get("Member No.") then
            SMSMessages."Telephone No" := Cust."Phone No.";
        SMSMessages.Insert;
    end;

    local procedure smsResolved()
    var
        iEntryNo: Integer;
        SMSMessages: Record "SMS Messages";
        cust: Record Customer;
    begin

        //SMS MESSAGE
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;

        SMSMessages.Reset;
        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Account No" := "Member No.";
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'Cases';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        //SMSMessages."Sent To Server":=SMSMessages."Sent To Server::No;
        SMSMessages."SMS Message" := 'Your case/complain has been resolved by.' + "Resolved User" +
                                  ' Thank you for your being our priority customer';
        cust.Reset;
        if cust.Get("Member No.") then
            SMSMessages."Telephone No" := cust."Phone No.";
        SMSMessages.Insert;
    end;
}

