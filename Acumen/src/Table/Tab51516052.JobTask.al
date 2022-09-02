#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516052 "Job-Task"
{
    Caption = 'Job Task';

    fields
    {
        field(1;"Grant No.";Code[50])
        {
            Caption = 'Job No.';
            Editable = true;
            NotBlank = true;
            TableRelation = Jobs;
        }
        field(2;"Grant Task No.";Code[50])
        {
        }
        field(3;Description;Text[250])
        {
            Caption = 'Description';
        }
        field(4;"Grant Task Type";Option)
        {
            Caption = 'Job Task Type';
            OptionCaption = 'Posting,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Posting,Heading,Total,"Begin-Total","End-Total";

            trigger OnValidate()
            begin
                if (xRec."Grant Task Type" = "grant task type"::Posting) and
                   ("Grant Task Type" <> "grant task type"::Posting)
                then
                  if JobLedgEntriesExist or JobPlanningLinesExist then
                    Error(Text001,FieldCaption("Grant Task Type"),TableCaption);

                if "Grant Task Type" <> "grant task type"::Posting then
                  "Grant Posting Group" := '';

                Totaling := '';
            end;
        }
        field(6;"WIP-Total";Option)
        {
            Caption = 'WIP-Total';
            OptionCaption = ' ,Total,Closed';
            OptionMembers = " ",Total,Closed;
        }
        field(7;"Grant Posting Group";Code[10])
        {
            Caption = 'Job Posting Group';
            TableRelation = "Job-Posting Group";

            trigger OnValidate()
            begin
                if "Grant Posting Group" <> '' then
                  TestField("Grant Task Type","grant task type"::Posting);
            end;
        }
        field(8;"WIP Method Used";Option)
        {
            Caption = 'WIP Method Used';
            Editable = false;
            OptionCaption = ' ,Cost Value,Sales Value,Cost of Sales,Percentage of Completion,Completed Contract';
            OptionMembers = " ","Cost Value","Sales Value","Cost of Sales","Percentage of Completion","Completed Contract";
        }
        field(10;"Schedule (Total Cost)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Job-Planning Line"."Total Cost (LCY)" where ("Grant No."=field("Grant No."),"Grant Task No."=field("Grant Task No."),"Grant Task No."=field(filter(Totaling)),"Schedule Line"=const(true),"Planning Date"=field("Planning Date Filter")));
            Caption = 'Schedule (Total Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11;"Schedule (Total Price)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Job-Planning Line"."Line Amount (LCY)" where ("Grant No."=field("Grant No."),"Grant Task No."=field("Grant Task No."),"Grant Task No."=field(filter(Totaling)),"Schedule Line"=const(true),"Planning Date"=field("Planning Date Filter")));
            Caption = 'Schedule (Total Price)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12;"Usage (Total Cost)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Job-Ledger Entry"."Total Cost (LCY)" where ("Job No."=field("Grant No."),"Job Task No."=field("Grant Task No."),"Job Task No."=field(filter(Totaling)),"Entry Type"=const(Usage),"Posting Date"=field("Posting Date Filter")));
            Caption = 'Usage (Total Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13;"Usage (Total Price)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Job-Ledger Entry"."Line Amount (LCY)" where ("Job No."=field("Grant No."),"Job Task No."=field("Grant Task No."),"Job Task No."=field(filter(Totaling)),"Entry Type"=const(Usage),"Posting Date"=field("Posting Date Filter")));
            Caption = 'Usage (Total Price)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14;"Contract (Total Cost)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Job-Planning Line"."Total Cost (LCY)" where ("Grant No."=field("Grant No."),"Grant Task No."=field("Grant Task No."),"Grant Task No."=field(filter(Totaling)),"Contract Line"=const(true),"Planning Date"=field("Planning Date Filter")));
            Caption = 'Contract (Total Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15;"Contract (Total Price)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("Job-Planning Line"."Line Amount (LCY)" where ("Grant No."=field("Grant No."),"Grant Task No."=field("Grant Task No."),"Grant Task No."=field(filter(Totaling)),"Contract Line"=const(true),"Planning Date"=field("Planning Date Filter")));
            Caption = 'Contract (Total Price)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16;"Contract (Invoiced Price)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = -sum("Job-Ledger Entry"."Line Amount (LCY)" where ("Job No."=field("Grant No."),"Job Task No."=field("Grant Task No."),"Job Task No."=field(filter(Totaling)),"Entry Type"=const(Sale),"Posting Date"=field("Posting Date Filter")));
            Caption = 'Contract (Invoiced Price)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17;"Contract (Invoiced Cost)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = -sum("Job-Ledger Entry"."Total Cost (LCY)" where ("Job No."=field("Grant No."),"Job Task No."=field("Grant Task No."),"Job Task No."=field(filter(Totaling)),"Entry Type"=const(Sale),"Posting Date"=field("Posting Date Filter")));
            Caption = 'Contract (Invoiced Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19;"Posting Date Filter";Date)
        {
            Caption = 'Posting Date Filter';
            FieldClass = FlowFilter;
        }
        field(20;"Planning Date Filter";Date)
        {
            Caption = 'Planning Date Filter';
            FieldClass = FlowFilter;
        }
        field(21;Totaling;Text[250])
        {
            Caption = 'Totaling';
            TableRelation = "Job-Task"."Grant Task No." where ("Grant No."=field("Grant No."));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if not ("Grant Task Type" in ["grant task type"::Total,"grant task type"::"End-Total"]) then
                  FieldError("Grant Task Type");
                CalcFields(
                  "Schedule (Total Cost)",
                  "Schedule (Total Price)",
                  "Usage (Total Cost)",
                  "Usage (Total Price)",
                  "Contract (Total Cost)",
                  "Contract (Total Price)",
                  "Contract (Invoiced Price)",
                  "Contract (Invoiced Cost)");
            end;
        }
        field(22;"New Page";Boolean)
        {
            Caption = 'New Page';
        }
        field(23;"No. of Blank Lines";Integer)
        {
            BlankZero = true;
            Caption = 'No. of Blank Lines';
            MinValue = 0;
        }
        field(24;Indentation;Integer)
        {
            Caption = 'Indentation';
            MinValue = 0;
        }
        field(25;"WIP Posting Date";Date)
        {
            Caption = 'WIP Posting Date';
            Editable = false;
        }
        field(26;"WIP %";Decimal)
        {
            AutoFormatType = 2;
            BlankZero = true;
            Caption = 'WIP %';
            Editable = false;
        }
        field(27;"WIP Account";Code[20])
        {
            Caption = 'WIP Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(28;"WIP Balance Account";Code[20])
        {
            Caption = 'WIP Balance Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(29;"WIP Amount";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'WIP Amount';
            Editable = false;
        }
        field(31;"Invoiced Sales Amount";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Invoiced Sales Amount';
            Editable = false;
        }
        field(32;"Invoiced Sales Account";Code[20])
        {
            Caption = 'Invoiced Sales Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(33;"Invoiced Sales Bal. Account";Code[20])
        {
            Caption = 'Invoiced Sales Bal. Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(34;"Recognized Sales Amount";Decimal)
        {
            BlankZero = true;
            Caption = 'Recognized Sales Amount';
            Editable = false;
        }
        field(35;"Recognized Sales Account";Code[20])
        {
            Caption = 'Recognized Sales Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(36;"Recognized Sales Bal. Account";Code[20])
        {
            Caption = 'Recognized Sales Bal. Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(37;"Recognized Costs Amount";Decimal)
        {
            BlankZero = true;
            Caption = 'Recognized Costs Amount';
            Editable = false;
        }
        field(38;"Recognized Costs Account";Code[20])
        {
            Caption = 'Recognized Costs Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(39;"Recognized Costs Bal. Account";Code[20])
        {
            Caption = 'Recognized Costs Bal. Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(40;"WIP Schedule (Total Cost)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'WIP Schedule (Total Cost)';
            Editable = false;
        }
        field(41;"WIP Schedule (Total Price)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'WIP Schedule (Total Price)';
            Editable = false;
        }
        field(42;"WIP Usage (Total Cost)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'WIP Usage (Total Cost)';
            Editable = false;
        }
        field(43;"WIP Usage (Total Price)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'WIP Usage (Total Price)';
            Editable = false;
        }
        field(44;"WIP Contract (Total Cost)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'WIP Contract (Total Cost)';
            Editable = false;
        }
        field(45;"WIP Contract (Total Price)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'WIP Contract (Total Price)';
            Editable = false;
        }
        field(46;"WIP (Invoiced Price)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'WIP (Invoiced Price)';
            Editable = false;
        }
        field(47;"WIP (Invoiced Cost)";Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'WIP (Invoiced Cost)';
            Editable = false;
        }
        field(48;"WIP Posting Date Filter";Text[250])
        {
            Caption = 'WIP Posting Date Filter';
            Editable = false;
        }
        field(49;"WIP Planning Date Filter";Text[250])
        {
            Caption = 'WIP Planning Date Filter';
            Editable = false;
        }
        field(50;"WIP Sales Account";Code[20])
        {
            Caption = 'WIP Sales Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(51;"WIP Sales Balance Account";Code[20])
        {
            Caption = 'WIP Sales Balance Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(52;"WIP Costs Account";Code[20])
        {
            Caption = 'WIP Costs Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(53;"WIP Costs Balance Account";Code[20])
        {
            Caption = 'WIP Costs Balance Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(54;"Cost Completion %";Decimal)
        {
            AutoFormatType = 2;
            BlankZero = true;
            Caption = 'Cost Completion %';
            Editable = false;
        }
        field(55;"Invoiced %";Decimal)
        {
            AutoFormatType = 2;
            BlankZero = true;
            Caption = 'Invoiced %';
            Editable = false;
        }
        field(60;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(61;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(62;"Outstanding Orders";Decimal)
        {
            CalcFormula = sum("Purchase Line"."Outstanding Amount (LCY)" where ("Document Type"=const(Order),"Job No."=field("Grant No."),"Job Task No."=field("Grant Task No."),"Job Task No."=field(filter(Totaling))));
            Caption = 'Outstanding Orders';
            FieldClass = FlowField;
        }
        field(63;"Amt. Rcd. Not Invoiced";Decimal)
        {
            CalcFormula = sum("Purchase Line"."Amt. Rcd. Not Invoiced (LCY)" where ("Document Type"=const(Order),"Job No."=field("Grant No."),"Job Task No."=field("Grant Task No."),"Job Task No."=field(filter(Totaling))));
            Caption = 'Amt. Rcd. Not Invoiced';
            FieldClass = FlowField;
        }
        field(50000;"Grant Phase";Code[10])
        {
            TableRelation = "Grant Phases".Code;
        }
        field(50003;"No Series";Code[20])
        {
        }
        field(50004;"Approval Status";Option)
        {
            Editable = false;
            OptionMembers = New,"Pending Approval",Approved;
        }
        field(50005;Amount;Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Grant No.","Grant Task No.")
        {
            Clustered = true;
        }
        key(Key2;"Grant Task No.")
        {
        }
        key(Key3;"Grant No.","Grant Phase")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        JobPlanningLine: Record "HR Journal Line";
        JobTaskDim: Record "HR Leave Ledger Entries";
        Job: Record "Loan Sub-Sector";
    begin
        if JobLedgEntriesExist then
          Error(Text000,TableCaption);

        JobPlanningLine.SetCurrentkey("Grant No.","Grant Task No.");
        JobPlanningLine.SetRange("Grant No.","Grant No.");
        JobPlanningLine.SetRange("Grant Task No.","Grant Task No.");
        JobPlanningLine.DeleteAll(true);

        JobTaskDim.SetRange("Job No.","Grant No.");
        JobTaskDim.SetRange("Job Task No.","Grant Task No.");
        if not JobTaskDim.IsEmpty then
          JobTaskDim.DeleteAll;


        Job.Get("Grant No.");
        if Job."Approval Status"<>Job."approval status"::Open then
        Error('Grant %1 can not be deleted as its status is %2',Job."No.",Job."Approval Status");
    end;

    trigger OnInsert()
    var
        Job: Record "Loan Sub-Sector";
        Cust: Record Customer;
    begin
        
        if "Grant Task No." = '' then begin
          JobSetup.Get;
          JobSetup.TestField("Grant Task Nos");
          NoSeriesMgt.InitSeries(JobSetup."Grant Task Nos",xRec."No Series",0D,"Grant Task No.","No Series");
        end;
        
        
        LockTable;
        Job.Get("Grant No.");
        if Job.Blocked = Job.Blocked::All then
          Job.TestBlocked;
        //Job.TESTFIELD("Bill-to Partner No.");
        //Cust.GET(Job."Bill-to Partner No.");
        
        InitWIPFields;
        "Schedule (Total Cost)" := 0;
        "Schedule (Total Price)" := 0;
        "Usage (Total Cost)" := 0;
        "Usage (Total Price)" := 0;
        "Contract (Total Cost)" := 0;
        "Contract (Total Price)" := 0;
        "Contract (Invoiced Price)" := 0;
        "Contract (Invoiced Cost)" := 0;
        
        DimMgt.InsertJobTaskDim("Grant No.","Grant Task No.","Global Dimension 1 Code","Global Dimension 2 Code");
        
        /*
        Job.GET("Grant No.");
        IF Job."Approval Status"<>Job."Approval Status"::Open THEN
        ERROR('Grant %1 can not be modified as its status is %2',Job."No.",Job."Approval Status");
         */

    end;

    trigger OnModify()
    var
        Job: Record "Loan Sub-Sector";
    begin

        Job.Get("Grant No.");
        //IF Job."Approval Status"<>Job."Approval Status"::Open THEN
        //ERROR('Grant %1 can not be modified as its status is %2',Job."No.",Job."Approval Status");
    end;

    trigger OnRename()
    var
        Job: Record "Loan Sub-Sector";
    begin
    end;

    var
        Text000: label 'You cannot delete %1 because one or more entries are associated.';
        Text001: label 'You cannot change %1 because one or more entries are associated with this %2.';
        DimMgt: Codeunit DimensionManagement;
        JobSetup: Record "HR Setup1";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    local procedure JobLedgEntriesExist(): Boolean
    var
        JobLedgEntry: Record "Loan Specific-Secto";
    begin
        JobLedgEntry.SetCurrentkey("Job No.","Job Task No.");
        JobLedgEntry.SetRange("Job No.","Grant No.");
        JobLedgEntry.SetRange("Job Task No.","Grant Task No.");
        exit(JobLedgEntry.Find('-'))
    end;


    procedure JobPlanningLinesExist(): Boolean
    var
        JobPlanningLine: Record "HR Journal Line";
    begin
        JobPlanningLine.SetCurrentkey("Grant No.","Grant Task No.");
        JobPlanningLine.SetRange("Grant No.","Grant No.");
        JobPlanningLine.SetRange("Grant Task No.","Grant Task No.");
        exit(JobPlanningLine.Find('-'))
    end;


    procedure Caption(): Text[250]
    var
        Job: Record "Loan Sub-Sector";
    begin
        if not Job.Get("Grant No.") then
          exit('');
        exit(StrSubstNo('%1 %2 %3 %4',
            Job."No.",
            Job.Description,
            "Grant Task No.",
            Description));
    end;


    procedure Caption2(): Text[250]
    var
        Job: Record "Loan Sub-Sector";
    begin
        if not Job.Get("Grant No.") then
          exit('');
        exit(StrSubstNo('%1 %2',
            Job."No.",
            Job.Description))
    end;


    procedure InitWIPFields()
    begin
        "WIP Posting Date" := 0D;
        "WIP %" := 0;
        "WIP Account" := '';
        "WIP Balance Account" := '';
        "Invoiced Sales Account" := '';
        "Invoiced Sales Bal. Account" := '';
        "WIP Amount" := 0;
        "Invoiced Sales Amount" := 0;
        "WIP Method Used" := 0;
        "WIP Schedule (Total Cost)" := 0;
        "WIP Schedule (Total Price)" := 0;
        "WIP Usage (Total Cost)" := 0;
        "WIP Usage (Total Price)" := 0;
        "WIP Contract (Total Cost)" := 0;
        "WIP Contract (Total Price)" := 0;
        "WIP (Invoiced Price)" := 0;
        "WIP (Invoiced Cost)" := 0;
        "WIP Posting Date Filter" := '';
        "WIP Planning Date Filter" := '';
        "Recognized Sales Amount" := 0;
        "Recognized Sales Account" := '';
        "Recognized Sales Bal. Account" := '';
        "Recognized Costs Amount" := 0;
        "Recognized Costs Account" := '';
        "Recognized Costs Bal. Account" := '';
        "WIP Sales Account" := '';
        "WIP Sales Balance Account" := '';
        "WIP Costs Account" := '';
        "WIP Costs Balance Account" := '';
        "Cost Completion %" := 0;
        "Invoiced %" := 0;
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer;ShortcutDimCode: Code[20])
    var
        JobTask2: Record "HR Transport Requisition";
    begin
        DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        if JobTask2.Get("Grant No.","Grant Task No.") then begin
          DimMgt.SaveJobTaskDim("Grant No.","Grant Task No.",FieldNumber,ShortcutDimCode);
          Modify;
        end else
          DimMgt.SaveJobTaskTempDim(FieldNumber,ShortcutDimCode);
    end;


    procedure ClearTempDim()
    begin
        DimMgt.DeleteJobTaskTempDim;
    end;
}

