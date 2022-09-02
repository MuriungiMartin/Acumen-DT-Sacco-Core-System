#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516910 "ATM Card Order Batch"
{
    DrillDownPageID = "ATM Card Request Batch List";
    LookupPageID = "ATM Card Request Batch List";

    fields
    {
        field(1;"Batch No.";Code[20])
        {
            NotBlank = false;

            trigger OnValidate()
            begin
                if "Batch No." <> xRec."Batch No." then begin
                  SalesSetup.Get;
                  NoSeriesMgt.TestManual(SalesSetup."ATM Card Batch Nos");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Description/Remarks";Text[30])
        {
        }
        field(3;Requested;Boolean)
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
        field(6;"Date Requested";Date)
        {
        }
        field(7;"Requested By";Code[20])
        {
        }
        field(8;"Prepared By";Code[20])
        {
        }
        field(9;Date;Date)
        {
        }
        field(13;"No. Series";Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
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

    trigger OnInsert()
    begin
        if "Batch No." = '' then begin
          SalesSetup.Get();
          SalesSetup.TestField(SalesSetup."ATM Card Batch Nos");
          NoSeriesMgt.InitSeries(SalesSetup."ATM Card Batch Nos",xRec."No. Series",0D,"Batch No.","No. Series");
        end;

        "Date Requested":=Today;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EntryNo: Integer;
}

