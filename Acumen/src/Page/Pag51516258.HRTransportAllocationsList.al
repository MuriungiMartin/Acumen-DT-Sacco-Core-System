#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516258 "HR Transport Allocations List"
{
    ApplicationArea = Basic;
    CardPageID = "HR Transport Allocation";
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Transport Allocations H";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Transport Allocation No";"Transport Allocation No")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Destination(s)";"Destination(s)")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Vehicle Reg Number";"Vehicle Reg Number")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Passenger Capacity";"Passenger Capacity")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Assigned Driver";"Assigned Driver")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Driver Name";"Driver Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Date of Allocation";"Date of Allocation")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Date of Trip";"Date of Trip")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Time of Trip";"Time of Trip")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Comments;Comments)
                {
                    ApplicationArea = Basic;
                }
                field("Linked to Invoice No";"Linked to Invoice No")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("<Invoice Posting Description>";"Invoice Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Invoice Posting Description';
                    Editable = false;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755002;"HR Transport Alloc. Factbox")
            {
                Caption = 'HR Transport Allocations Factbox';
                SubPageLink = "Transport Allocation No"=field("Transport Allocation No");
            }
            systempart(Control1102755006;Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("&Print")
                {
                    ApplicationArea = Basic;
                    Caption = '&Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HRTransportAllocationsH.Reset;
                        HRTransportAllocationsH.SetRange(HRTransportAllocationsH."Transport Allocation No","Transport Allocation No");
                        if HRTransportAllocationsH.Find('-') then
                        Report.Run(53929,true,true,HRTransportAllocationsH);
                    end;
                }
                action("<Action1102755035>p")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Status:=Status::Open;
                        Modify;
                        Message('Transport Allocation No :: :: has been Re-Opened',"Transport Allocation No");
                    end;
                }
                action(Release)
                {
                    ApplicationArea = Basic;
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Question:=Text001;
                        if Confirm(Question) then
                        begin
                            Status:=Status::Released;
                            Modify;
                            Message('Transport Allocation No :: :: has been released',"Transport Allocation No");
                        end else begin
                            Message('You selected :: NO :: Release Cancelled');
                        end;
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Transport Allocations")
            {
                ApplicationArea = Basic;
                Caption = 'Transport Allocations';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report UnknownReport55596;
            }
        }
    }

    var
        HRTransportAllocationsH: Record "HR Transport Allocations H";
        Text19021002: label 'Passenger List';
        Text001: label 'Are you sure you want to Release this Document?';
        Question: Text;
}

