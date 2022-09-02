#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516239 "Company Documents"
{
    DrillDownPageID = UnknownPage55688;
    LookupPageID = UnknownPage55688;

    fields
    {
        field(1;"Doc No.";Code[20])
        {
        }
        field(2;"Document Description";Text[200])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                CompanyDocs.Reset;
                CompanyDocs.SetRange("Document Description","Document Description");
                if CompanyDocs.FindFirst then Error('Document already exists');
            end;
        }
        field(3;"Document Link";Text[200])
        {
        }
        field(6;"Attachment No.";Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(7;"Language Code (Default)";Code[10])
        {
            TableRelation = Language;
        }
        field(8;Attachment;Option)
        {
            Editable = false;
            OptionMembers = No,Yes;
        }
        field(9;"No. Series";Code[20])
        {
        }
        field(10;Type;Option)
        {
            OptionCaption = 'Company,Leave';
            OptionMembers = Company,Leave;
        }
    }

    keys
    {
        key(Key1;"Doc No.","Document Description")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Doc No." = '' then begin
          HRSetup.Get;
          HRSetup.TestField("Company Documents");
          NoSeriesMgt.InitSeries(HRSetup."Company Documents",xRec."No. Series",0D,"Doc No.","No. Series");
        end;
    end;

    var
        CompanyDocs: Record "Company Documents";
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

