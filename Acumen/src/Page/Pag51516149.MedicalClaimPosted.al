#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516149 "Medical Claim Posted"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "HR Medical Claims";
    SourceTableView = where(Posted=filter(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Type";"Claim Type")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Date";"Claim Date")
                {
                    ApplicationArea = Basic;
                }
                field("Patient Name";"Patient Name")
                {
                    ApplicationArea = Basic;
                }
                field("Document Ref";"Document Ref")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Service";"Date of Service")
                {
                    ApplicationArea = Basic;
                }
                field("Attended By";"Attended By")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Charged";"Amount Charged")
                {
                    ApplicationArea = Basic;
                }
                field(Comments;Comments)
                {
                    ApplicationArea = Basic;
                }
                field("Claim No";"Claim No")
                {
                    ApplicationArea = Basic;
                }
                field(Dependants;Dependants)
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("No. Series";"No. Series")
                {
                    ApplicationArea = Basic;
                }
                field("Amount Claimed";"Amount Claimed")
                {
                    ApplicationArea = Basic;
                }
                field("Hospital/Medical Centre";"Hospital/Medical Centre")
                {
                    ApplicationArea = Basic;
                }
                field("Claim Limit";"Claim Limit")
                {
                    ApplicationArea = Basic;
                }
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                }
                field(Balance;Balance)
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted";"Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By";"Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Time Posted";"Time Posted")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Other)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action(PrintNew)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reprint Claim Voucher';
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
                        PHeader2.SetRange(PHeader2."Member No","Member No");
                        if PHeader2.FindFirst then
                           Report.Run(51516199,true,true,PHeader2);
                        
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
    }

    var
        PHeader2: Record "HR Medical Claims";
}

