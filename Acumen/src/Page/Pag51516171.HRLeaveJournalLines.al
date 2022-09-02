#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516171 "HR Leave Journal Lines"
{
    ApplicationArea = Basic;
    AutoSplitKey = false;
    DelayedInsert = true;
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Worksheet;
    PromotedActionCategories = 'New,Process,Report,Functions,Approvals';
    RefreshOnActivate = true;
    SaveValues = true;
    ShowFilter = true;
    SourceTable = "HR Journal Line";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName;CurrentJnlBatchName)
            {
                ApplicationArea = Basic;
                Caption = 'Batch Name';
                Lookup = true;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SaveRecord;

                    //Rec.RESET;

                    InsuranceJnlManagement.LookupName(CurrentJnlBatchName,Rec);
                    CurrPage.Update(false);
                end;

                trigger OnValidate()
                begin
                    InsuranceJnlManagement.CheckName(CurrentJnlBatchName,Rec);
                      CurrentJnlBatchNameOnAfterVali;
                end;
            }
            repeater(Control1102755000)
            {
                field("Line No.";"Line No.")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Period";"Leave Period")
                {
                    ApplicationArea = Basic;
                }
                field("Staff No.";"Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field("Staff Name";"Staff Name")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Type";"Leave Type")
                {
                    ApplicationArea = Basic;
                }
                field("Leave Entry Type";"Leave Entry Type")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Days";"No. of Days")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Document No.";"Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
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
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Post Adjustment")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Adjustment';
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        Codeunit.Run(Codeunit::"HR Leave Jnl.-Post",Rec);

                        CurrentJnlBatchName := GetRangemax("Journal Batch Name");
                        CurrPage.Update(false);
                    end;
                }
                action("Batch Allocation")
                {
                    ApplicationArea = Basic;
                    Image = Allocate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Report UnknownReport53932;

                    trigger OnAction()
                    begin
                        
                        
                        
                        /*
                        AllocationDone:=TRUE;
                        
                        HRJournalBatch.RESET;
                        HRJournalBatch.GET("Journal Template Name","Journal Batch Name");
                        
                        
                        //GET THE CURRENT LEAVE PERIOD
                        HRLeavePeriods.RESET;
                        HRLeavePeriods.SETRANGE(HRLeavePeriods."New Fiscal Year",FALSE);
                        HRLeavePeriods.FIND('-');
                        
                        
                        //WE ARE ALLOCATING FOR ACTIVE EMPLOYEES ONLY AND GRADE SHOULD BE BETWEEN NIB 1-6
                        HREmp.RESET;
                        HREmp.SETRANGE(HREmp.Status,HREmp.Status::Normal);
                        HREmp.FINDFIRST;
                        
                        HRLeaveTypes.RESET;
                        HRLeaveTypes.FINDFIRST;
                            BEGIN
                            REPEAT
                                   REPEAT
                                      //CHECK IF ALLOCATION OF CURRENT LEAVE TYPE FOR THE CURRENT PERIOD AND FOR CURRENT EMPLOYEE HAS BEEN DONE
                                      HRLeaveLedger.SETRANGE(HRLeaveLedger."Staff No.",HREmp."No.");
                                      HRLeaveLedger.SETRANGE(HRLeaveLedger."Leave Type",HRLeaveTypes.Code);
                                      HRLeaveLedger.SETRANGE(HRLeaveLedger."Leave Entry Type",HRJournalBatch.Type);
                                      HRLeaveLedger.SETRANGE(HRLeaveLedger."Leave Period",FORMAT(HRLeavePeriods."Starting Date"));
                                      IF NOT HRLeaveLedger.FIND('-') THEN
                        
                                      OK:=CheckGender(HREmp,HRLeaveTypes);
                        
                                      IF OK THEN
                        
                                        BEGIN
                        
                                            //INSERT INTO JOURNAL
                                             INIT;
                                            IF HREmp.Gender = HREmp.Gender::" " THEN BEGIN
                                                ERROR('Please specify Gender for Employee No %1',HREmp."No.");
                                            END;
                                            IF HREmp."Grade" = '' THEN
                                            BEGIN
                                                ERROR('Please specify Job Group for Employee No %1: ',HREmp."No.");
                                            END;
                        
                        
                                            "Journal Template Name":="Journal Template Name";
                                            "Journal Batch Name":="Journal Batch Name";
                                            "Line No.":="Line No."+1000;
                                            "Leave Period Name":=HRLeavePeriods."Period Name";
                                            "Leave Period Start Date":=HRLeavePeriods."Starting Date";
                                            "Staff No.":=HREmp."No.";
                        
                                             VALIDATE("Staff No.");
                                            "Posting Date":=TODAY;
                                             Description:=HRJournalBatch."Posting Description";
                                            "Leave Entry Type":=HRJournalBatch.Type;
                                            "Leave Type":=HRLeaveTypes.Code;
                                             IF "Leave Type" = 'ANNUAL' THEN
                                             BEGIN
                                                  IF HREmp."Job Group Code" = 'NIB11'  THEN
                                                  BEGIN
                                                       "No. of Days":=26;
                                                  END ELSE
                                                  BEGIN
                                                       "No. of Days":=HRLeaveTypes.Days;
                                                  END;
                                                  IF HREmp."Job Group Code" = 'NIB12'THEN
                                                  BEGIN
                                                       "No. of Days":=26;
                                                  END ELSE
                                                  BEGIN
                                                       "No. of Days":=HRLeaveTypes.Days;
                                                  END;
                                                  IF HREmp."Job Group Code" = 'NIB13'  THEN
                                                  BEGIN
                                                       "No. of Days":=26;
                                                  END ELSE
                                                  BEGIN
                                                      "No. of Days":=HRLeaveTypes.Days;
                                                  END;
                                             END ELSE
                                             BEGIN
                                                  "No. of Days":=HRLeaveTypes.Days;
                                             END;
                        
                                            "Job Group":=HREmp."Job Group Code";
                                            "Journal Created BY":=USERID;
                                            "Document No.":='LV2014_2015';
                                            "Shortcut Dimension 1 Code":=HREmp."Scheme Code";
                                            "Shortcut Dimension 2 Code":=HREmp."Department Code";
                                                INSERT;
                        
                                            AllocationDone:=TRUE;
                        
                                       END;
                        
                                      UNTIL HRLeaveTypes.NEXT=0;
                        
                                      HRLeaveTypes.FINDFIRST;
                        
                              UNTIL HREmp.NEXT=0;
                            END;
                        HRLeaveTypes.FINDFIRST;
                        
                        
                        
                        IF NOT AllocationDone THEN
                        MESSAGE('Allocation of leave days for '+HRLeavePeriods."Period Name"+
                         ' period has already been done for all ACTIVE employees');
                              */

                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    begin
                        //IF ApprovalsMgmt.CheckSalesApprovalsWorkflowEnabled(Rec) THEN
                          //ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    begin
                        //ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
        InsuranceJnlManagement: Codeunit LeaveJnlManagementold;
    begin
        OpenedFromBatch := ("Journal Batch Name" <> '') and ("Journal Template Name" = '');
        if OpenedFromBatch then begin
          CurrentJnlBatchName := "Journal Batch Name";
          InsuranceJnlManagement.OpenJournal(CurrentJnlBatchName,Rec);
          exit;
        end;
        InsuranceJnlManagement.TemplateSelection(Page::"HR Leave Journal Lines",Rec,JnlSelected);
        if not JnlSelected then
          Error('');
        InsuranceJnlManagement.OpenJournal(CurrentJnlBatchName,Rec);
    end;

    var
        HRLeaveTypes: Record "HR Leave Types";
        HREmp: Record "HR Employees";
        HRLeaveLedger: Record "HR Leave Ledger Entries";
        InsuranceJnlManagement: Codeunit LeaveJnlManagementold;
        ReportPrint: Codeunit "Test Report-Print";
        CurrentJnlBatchName: Code[10];
        InsuranceDescription: Text[30];
        FADescription: Text[30];
        ShortcutDimCode: array [8] of Code[20];
        OpenedFromBatch: Boolean;
        HRLeavePeriods: Record "HR Leave Periods";
        AllocationDone: Boolean;
        HRJournalBatch: Record "HR Leave Journal Batch";
        OK: Boolean;
        ApprovalEntries: Record "Approval Entry";
        LLE: Record "HR Leave Ledger Entries";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;


    procedure CheckGender(Emp: Record "HR Employees";LeaveType: Record "HR Leave Types") Allocate: Boolean
    begin

        //CHECK IF LEAVE TYPE ALLOCATION APPLIES TO EMPLOYEE'S GENDER

        if Emp.Gender=Emp.Gender::Male then begin
         if LeaveType.Gender=LeaveType.Gender::Male then
         Allocate:=true;
        end;

        if Emp.Gender=Emp.Gender::Female then begin
         if LeaveType.Gender=LeaveType.Gender::Female then
         Allocate:=true;
        end;

        if LeaveType.Gender=LeaveType.Gender::Both then
        Allocate:=true;
        exit(Allocate);

        if Emp.Gender<>LeaveType.Gender then
        Allocate:=false;

        exit(Allocate);
    end;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SaveRecord;
        InsuranceJnlManagement.SetName(CurrentJnlBatchName,Rec);
        CurrPage.Update(false);
    end;


    procedure AllocateLeave1()
    begin
    end;


    procedure AllocateLeave2()
    begin
    end;
}

