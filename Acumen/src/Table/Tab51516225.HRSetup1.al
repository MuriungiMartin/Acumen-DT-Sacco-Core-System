#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516225 "HR Setup1"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Employee Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(3; "Training Application Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(4; "Leave Application Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(6; "Disciplinary Cases Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(7; "Base Calendar"; Code[10])
        {
        }
        field(13; "Transport Req Nos"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(14; "Employee Requisition Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(17; "Job Application Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(18; "Exit Interview Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(19; "Appraisal Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(20; "Company Activities"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(21; "Default Leave Posting Template"; Code[10])
        {
            TableRelation = "HR Leave Journal Batch"."Journal Template Name";
        }
        field(22; "Positive Leave Posting Batch"; Code[10])
        {
            TableRelation = "HR Leave Journal Batch".Name;
        }
        field(23; "Leave Template"; Code[10])
        {
            TableRelation = "HR Leave Journal Template";
        }
        field(24; "Leave Batch"; Code[10])
        {
            TableRelation = "HR Leave Journal Batch".Name;
        }
        field(25; "Job Interview Nos"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(26; "Company Documents"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(27; "HR Policies"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(28; "Notice Board Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(29; "Leave Reimbursment Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(30; "Min. Leave App. Months"; Integer)
        {
            Caption = 'Minimum Leave Application Months';
        }
        field(31; "Negative Leave Posting Batch"; Code[10])
        {
            TableRelation = "HR Leave Journal Batch".Name;
        }
        field(32; "Appraisal Method"; Option)
        {
            OptionCaption = ' ,Normal Appraisal,360 Appraisal,BSC Appraisal';
            OptionMembers = " ","Normal Appraisal","360 Appraisal","BSC Appraisal";
        }
        field(33; "Appraisal Template"; Code[10])
        {
        }
        field(34; "Appraisal Batch"; Code[10])
        {
        }
        field(35; "Appraisal Posting Period[FROM]"; Date)
        {
        }
        field(36; "Appraisal Posting Period[TO]"; Date)
        {
        }
        field(37; "Target Setting Month"; Integer)
        {
        }
        field(38; "Appraisal Interval"; DateFormula)
        {
        }
        field(39; "Job ID Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(40; "HR Loan Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(41; "Loan Batch Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(42; "Overtime Req Nos."; Code[10])
        {
            Caption = 'Overtime Requisition Nos.';
            TableRelation = "No. Series";
        }
        field(43; "Overtime Payroll Code"; Code[10])
        {
        }
        field(44; "Interns Req. Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50000; "Loan Application Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50001; "Leave Carry Over App Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50002; "Pay-change No."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50003; "Max Appraisal Rating"; Decimal)
        {
        }
        field(50004; "Medical Claims Nos"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50005; "Employee Transfer Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50006; "Leave Planner Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50007; "Employee Asset Transfer No."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50008; "Company Additional Amount"; Decimal)
        {
        }
        field(50009; "Employee Confirmation No."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50010; "Employee Promotion No."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50011; "Professional Bodies No."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50012; "Employee Grievance Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50013; "Proffessional Bodies Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50014; "Traning Needs Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50015; "Induction Nos"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50016; "Transport Allocation Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50017; "Succession Planning Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50018; "Incident Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50019; "Investigation Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50020; "Shift Nos"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50021; "Shift Schedule Nos"; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50022; "PR Deduction Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50023; "PR Allowances Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(51516000; "Tax Table"; Code[10])
        {
        }
        field(51516001; "Corporation Tax"; Decimal)
        {
        }
        field(51516002; "Housing Earned Limit"; Decimal)
        {
        }
        field(51516003; "Pension Limit Percentage"; Decimal)
        {
        }
        field(51516004; "Pension Limit Amount"; Decimal)
        {
        }
        field(51516005; "Round Down"; Boolean)
        {
        }
        field(51516006; "Working Hours"; Decimal)
        {
        }
        field(51516007; "Payroll Rounding Precision"; Decimal)
        {
        }
        field(51516008; "Payroll Rounding Type"; Option)
        {
            OptionMembers = Nearest,Up,Down;
        }
        field(51516009; "Special Duty Table"; Code[10])
        {
            // TableRelation = Table26004012;
        }
        field(51516040; "CFW Round Deduction code"; Code[20])
        {
        }
        field(51516041; "BFW Round Earning code"; Code[20])
        {
        }
        field(51516042; "Company overtime hours"; Decimal)
        {
        }
        field(51516043; "Tax Relief Amount"; Decimal)
        {
        }
        field(51516044; "Vehicle Maintenance Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(51516045; "Vehicle Servic Maintenance Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516046; "Fuel Maintenance No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516047; "Service Management No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51516048; "Posting Group"; Code[30])
        {
            TableRelation = "Payroll Posting Groups."."Posting Code";
        }
        field(51516049; "Salary Advance Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(51516050; "Back To Office Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(51516051; "Leave Posting Period[FROM]"; Date)
        {
        }
        field(51516052; "Leave Posting Period[TO]"; Date)
        {
        }
        field(51516053; "Claims G/L Acc Outpatient"; Code[15])
        {
            TableRelation = "G/L Account";
        }
        field(51516054; "Claims G/L Acc-Dental"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(51516055; "Claims G/L Acc-Optical"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(51516056; Current; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

