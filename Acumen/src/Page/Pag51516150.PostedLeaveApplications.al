#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516150 "Posted Leave Applications"
{
    ApplicationArea = Basic;
    CardPageID = "Posted  Leave Application Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Leave Application";
    SourceTableView = where(Status = filter(Posted));
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                field("Application Code"; "Application Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Application No';
                    StyleExpr = true;
                }
                field("Employee No"; "Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Type"; "Leave Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Days Applied"; "Days Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Return Date"; "Return Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; "End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Reliever Name"; "Reliever Name")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755006; "HR Leave Applicaitons Factbox")
            {
                SubPageLink = "No." = field("Employee No");
            }
            systempart(Control1102755004; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Re-Print")
            {
                ApplicationArea = Basic;
                Caption = 'Re-Print';
                Image = PrintForm;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                begin
                    HRLeaveApp.Reset;
                    HRLeaveApp.SetRange(HRLeaveApp."Application Code", "Application Code");
                    if HRLeaveApp.Find('-') then
                        Report.Run(51516610, true, true, HRLeaveApp);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        /*HREmp.RESET;
        HREmp.SETRANGE(HREmp."User ID",USERID);
        IF HREmp.GET THEN
        SETRANGE("User ID",HREmp."User ID")
        ELSE
        //user id may not be the creator of the doc
        SETRANGE("User ID",USERID);
        */

    end;

    var
        ApprovalMgt: Codeunit WorkflowIntegration;
        ApprovalEntries: Page "Approval Entries";
        ApprovalComments: Page "Approval Comments";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application";
        HRLeaveApp: Record "HR Leave Application";
        HREmp: Record "HR Employees";


    procedure TESTFIELDS()
    begin
        TestField("Leave Type");
        TestField("Days Applied");
        TestField("Start Date");
        TestField(Reliever);
        TestField(Supervisor);
    end;


    procedure TestLeaveFamily()
    var
        LeaveFamily: Record "HR Leave Family Groups";
        LeaveFamilyEmployees: Record "HR Leave Family Employees";
        Employees: Record "HR Employees";
    begin
        LeaveFamilyEmployees.SetRange(LeaveFamilyEmployees."Employee No", "Employee No");
        if LeaveFamilyEmployees.FindSet then //find the leave family employee is associated with
            repeat
                LeaveFamily.SetRange(LeaveFamily.Code, LeaveFamilyEmployees.Family);
                LeaveFamily.SetFilter(LeaveFamily."Max Employees On Leave", '>0');
                if LeaveFamily.FindSet then //find the status other employees on the same leave family
                  begin
                    Employees.SetRange(Employees."No.", LeaveFamilyEmployees."Employee No");
                    Employees.SetRange(Employees."Leave Status", Employees."leave status"::" ");
                    if Employees.Count > LeaveFamily."Max Employees On Leave" then
                        Error('The Maximum number of employees on leave for this family has been exceeded, Contact th HR manager for more information');
                end
            until LeaveFamilyEmployees.Next = 0;
    end;
}

