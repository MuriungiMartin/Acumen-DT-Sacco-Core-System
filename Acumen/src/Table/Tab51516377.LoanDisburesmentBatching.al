#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516377 "Loan Disburesment-Batching"
{
    DrillDownPageID = "Loans Disbursment Batch List";
    LookupPageID = "Loans Disbursment Batch List";

    fields
    {
        field(1;"Batch No.";Code[30])
        {
            NotBlank = false;

            trigger OnValidate()
            begin
                if "Batch No." <> xRec."Batch No." then begin
                  SalesSetup.Get;
                  NoSeriesMgt.TestManual(SalesSetup."Loans Batch Nos");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Description/Remarks";Text[30])
        {
        }
        field(3;Posted;Boolean)
        {
        }
        field(4;Status;Option)
        {
            OptionCaption = 'Open,Pending Approval,,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",,Approved,Rejected;
        }
        field(5;"Date Created";Date)
        {
        }
        field(6;"Posting Date";Date)
        {
        }
        field(7;"Posted By";Code[30])
        {
        }
        field(8;"Prepared By";Code[20])
        {
        }
        field(9;Date;Date)
        {
        }
        field(10;"Mode Of Disbursement";Option)
        {
            OptionCaption = 'Individual Cheques,Cheque,Transfer to FOSA,FOSA Loans,EFT,RTGS';
            OptionMembers = "Individual Cheques",Cheque,"Transfer to FOSA","FOSA Loans",EFT,RTGS;

            trigger OnValidate()
            begin
                /*IF "Mode Of Disbursement"<>"Mode Of Disbursement"::"Transfer to FOSA" THEN
                "Cheque No.":="Batch No.";
                MODIFY;
                */

            end;
        }
        field(11;"Document No.";Code[20])
        {
        }
        field(12;"BOSA Bank Account";Code[20])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                /* IF ("Mode Of Disbursement"="Mode Of Disbursement"::"FOSA Loans") OR  ("Mode Of Disbursement"="Mode Of Disbursement"::"Transfer to FOSA") THEN
                 ERROR('Cannot be used with this disbursemnt method %1',"Mode Of Disbursement");
                                                                                                 */

            end;
        }
        field(13;"No. Series";Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(14;"Approvals Remarks";Text[150])
        {
        }
        field(15;"Total Loan Amount";Decimal)
        {
            CalcFormula = sum("Loans Register"."Approved Amount" where ("Batch No."=field("Batch No."),
                                                                        "Loan Status"=filter(<>Rejected),
                                                                        Source=filter(BOSA|" "|FOSA),
                                                                        "Loan Product Type"=filter(<>'BRIDGING')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(16;"Current Location";Code[50])
        {
            CalcFormula = max("Movement Tracker".Station where ("Document No."=field("Batch No.")));
            Editable = true;
            FieldClass = FlowField;
        }
        field(17;"Cheque No.";Code[20])
        {
        }
        field(18;"Batch Type";Option)
        {
            OptionMembers = Loans,"Bridging Loans","Personal Loans",Refunds,"Funeral Expenses","Withdrawals - Resignation","Withdrawals - Death","Branch Loans",Journals,"File Movement","Appeal Loans";

            trigger OnValidate()
            begin
                EntryNo:=0;
                
                
                /*
                ApprovalsSetup.RESET;
                ApprovalsSetup.SETRANGE(ApprovalsSetup."Approval Type","Batch Type");
                IF ApprovalsSetup.FIND('-') THEN BEGIN
                MovementTracker.INIT;
                MovementTracker."Entry No.":=EntryNo;
                MovementTracker."Document No.":="Batch No.";
                MovementTracker."Approval Type":=ApprovalsSetup."Approval Type";
                MovementTracker.Stage:=ApprovalsSetup.Stage;
                MovementTracker."Current Location":=TRUE;
                MovementTracker.Status:=MovementTracker.Status::"Being Processed";
                MovementTracker.Description:=ApprovalsSetup.Description;
                MovementTracker.Station:=ApprovalsSetup.Station;
                MovementTracker."Date/Time In":=CREATEDATETIME(TODAY,TIME);
                MovementTracker.INSERT(TRUE);*/
                
                
                
                
                if "Batch Type" = "batch type"::"Bridging Loans" then
                "Mode Of Disbursement":="mode of disbursement"::Cheque;

            end;
        }
        field(19;"Special Advance Posted";Boolean)
        {
        }
        field(20;"FOSA Bank Account";Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(21;"No of Loans";Integer)
        {
            CalcFormula = count("Loans Register" where ("Batch No."=field("Batch No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(22;"Post to Loan Control";Boolean)
        {

            trigger OnValidate()
            begin
                if "Batch Type" <> "batch type"::"Branch Loans" then
                Error('Only applicable for branch loans');
            end;
        }
        field(23;"Total Appeal Amount";Decimal)
        {
            CalcFormula = sum("Loans Register"."Appeal Amount" where ("Batch No."=field("Batch No."),
                                                                      "Loan Status"=filter(<>Rejected),
                                                                      Source=const(" ")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(24;Source;Option)
        {
            OptionCaption = 'BOSA,FOSA,MICRO';
            OptionMembers = BOSA,FOSA,MICRO;
        }
        field(25;Location;Code[50])
        {
            CalcFormula = max("Movement Tracker".Station where ("Document No."=field("Batch No."),
                                                                "Current Location"=const(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(26;"Finance Approval";Boolean)
        {
        }
        field(27;"Audit Approval";Boolean)
        {
        }
        field(28;"Cheque Name";Text[60])
        {
        }
        field(29;"No transfer Fee";Boolean)
        {
        }
        field(30;"Global Dimension 1 Code";Code[10])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1),
                                                          "Dimension Value Type"=const(Standard));
        }
        field(31;"Global Dimension 2 Code";Code[10])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2),
                                                          "Dimension Value Type"=const(Standard));
        }
    }

    keys
    {
        key(Key1;"Batch No.")
        {
            Clustered = true;
        }
        key(Key2;"Description/Remarks")
        {
        }
        key(Key3;Date)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        /*IF Posted = TRUE THEN
        ERROR('You can not delete a posted batch.');
        */

    end;

    trigger OnInsert()
    begin
        if "Batch No." = '' then begin
          SalesSetup.Get();
          SalesSetup.TestField(SalesSetup."Loans Batch Nos");
          NoSeriesMgt.InitSeries(SalesSetup."Loans Batch Nos",xRec."No. Series",0D,"Batch No.","No. Series");
          "Document No.":="Batch No.";
        end;
        //ERROR('You dont have permission to create %1 batches',"Batch Type")
        "Mode Of Disbursement":="mode of disbursement"::"Transfer to FOSA"
    end;

    trigger OnModify()
    begin
        /*IF Posted = TRUE THEN
        ERROR('You can not modify a posted batch.');
           */

    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EntryNo: Integer;
}

