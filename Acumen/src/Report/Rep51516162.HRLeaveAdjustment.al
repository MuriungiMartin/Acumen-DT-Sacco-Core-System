#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 51516162 "HR Leave Adjustment"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("HR Employees";"HR Employees")
        {
            DataItemTableView = where(Status=const(Active));
            RequestFilterFields = "No.",Position,"Global Dimension 2 Code",Gender,"Leave Type Filter";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TestField(Gender);

                //Get current leave period
                HRLeavePeriods.Reset;
                HRLeavePeriods.SetRange(HRLeavePeriods."New Fiscal Year",true);
                HRLeavePeriods.SetRange(HRLeavePeriods.Closed,false);
                HRLeavePeriods.SetRange(HRLeavePeriods."Date Locked",false);
                if HRLeavePeriods.Find('-') then
                begin
                      HRLeaveTypes.Reset;
                      if LeaveTypeFilter <> '' then
                      begin
                          HRLeaveTypes.SetRange(HRLeaveTypes.Code,LeaveTypeFilter);
                      end;

                      if HRLeaveTypes.Find('-') then
                      begin
                          repeat
                                HRLeaveLedger.SetRange(HRLeaveLedger."Staff No.","No.");
                                HRLeaveLedger.SetRange(HRLeaveLedger."Leave Type",HRLeaveTypes.Code);
                                HRLeaveLedger.SetRange(HRLeaveLedger."Leave Entry Type",LeaveEntryType);
                                HRLeaveLedger.SetRange(HRLeaveLedger."Leave Period",HRLeavePeriods."Period Code");
                                if not HRLeaveLedger.Find('-') then
                                begin
                                    OK:=CheckGender("HR Employees",HRLeaveTypes);
                                    if OK then
                                    begin
                                          with HRJournalLine do
                                          begin
                                               Init;
                                              "Journal Template Name":=Text0001;
                                              Validate("Journal Template Name");

                                              "Journal Batch Name":=Format(BatchName);
                                              //VALIDATE("Journal Batch Name");

                                              "Line No.":="Line No."+1000;

                                              "Leave Period":=HRLeavePeriods."Period Code";
                                              Validate("Leave Period");

                                              "Leave Period Start Date":=HRLeavePeriods."Starting Date";
                                              Validate("Leave Period Start Date");

                                              "Staff No.":="No.";
                                               Validate("Staff No.");

                                              "Posting Date":=Today;
                                               Description:=PostingDescription;
                                              "Leave Entry Type":=LeaveEntryType;
                                              "Leave Type":=HRLeaveTypes.Code;
                                              Grade:=Grade;
                                              "Document No.":=HRLeavePeriods."Period Code";
                                              "Global Dimension 1 Code":="Global Dimension 1 Code";
                                              "Global Dimension 2 Code":="Global Dimension 2 Code";
                                              "No. of Days":=HRLeaveTypes.Days;

                                              Insert;

                                          end;
                                     end;
                               end else
                               begin
                                  Error('Allocation has already been done');
                               end;
                            until HRLeaveTypes.Next=0;
                     end else
                     begin
                          Error('No Leave Type found within the applied filters [%1]',"Leave Type Filter");
                     end;
                end;
            end;
        }
        dataitem("HR Leave Types";"HR Leave Types")
        {
            RequestFilterFields = "Code";
            column(ReportForNavId_2; 2)
            {
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(LeaveEntryType;LeaveEntryType)
                {
                    ApplicationArea = Basic;
                    Caption = 'Leave Entry Type';
                }
                field(PostingDescription;PostingDescription)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Description';
                }
                field(BatchName;BatchName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Batch Name';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        Message('Process complete');
    end;

    trigger OnPreReport()
    begin

        //IF PostingDescription = '' THEN ERROR('Posting description must have value');

        with HRJournalLine do
        begin
            if not IsEmpty then
            begin
                if Confirm(Text0002 + Text0003,false,Count,UpperCase(TableCaption),Text0001,BatchName) = true then
                begin
                    DeleteAll;
                end else
                begin
                     Error('Process aborted');
                end;
            end;
        end;

        //Get Leave type filter
        LeaveTypeFilter:="HR Leave Types".GetFilter("HR Leave Types".Code);
    end;

    var
        HRLeavePeriods: Record "HR Leave Periods";
        AllocationDone: Boolean;
        HRLeaveTypes: Record "HR Leave Types";
        HRLeaveLedger: Record "HR Leave Ledger Entries";
        LeaveEntryType: Option Postive,Negative,Reimbursement;
        OK: Boolean;
        HRJournalLine: Record "HR Journal Line";
        PostingDescription: Text;
        BatchName: Option POSITIVE,NEGATIVE;
        JournalTemplate: Code[20];
        Text0001: label 'LEAVE';
        Text0002: label 'There are [%1] entries in [%2  TABLE], Journal Template Name - [%3], Journal Batch Name [%4]';
        Text0003: label '\\Do you want to proceed and overwite these entries?';
        LeaveTypeFilter: Text;
        i: Integer;


    procedure CheckGender(Emp: Record "HR Employees";LeaveType: Record "HR Leave Types") Allocate: Boolean
    begin
        if Emp.Gender = Emp.Gender::Male then
        begin
         if LeaveType.Gender=LeaveType.Gender::Male then   Allocate:=true;
        end;

        if Emp.Gender=Emp.Gender::Female then
        begin
         if LeaveType.Gender=LeaveType.Gender::Female then  Allocate:=true;
        end;

        if LeaveType.Gender=LeaveType.Gender::Both then Allocate:=true;
        exit(Allocate);

        if Emp.Gender<>LeaveType.Gender then Allocate:=false;

        exit(Allocate);
    end;
}

