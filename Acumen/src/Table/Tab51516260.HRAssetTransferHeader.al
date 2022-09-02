#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516260 "HR Asset Transfer Header"
{

    fields
    {
        field(1;"No.";Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                  fasetup.Get;
                  NoSeriesMgt.TestManual(fasetup."FA Transfer Nos");
                  "No. Seriess" := '';
                end;
            end;
        }
        field(2;"Document Date";Date)
        {
        }
        field(5;"Issuing Admin/Asst";Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin

                 hremployee.Reset;
                 if hremployee.Get("Issuing Admin/Asst") then begin
                 "Issuing Admin/Asst Name":=hremployee."First Name"+' '+hremployee."Last Name";
                  end else begin
                  "Issuing Admin/Asst Name":='';

                 end;
            end;
        }
        field(6;"Issuing Admin/Asst Name";Text[50])
        {
        }
        field(7;"Document Type";Option)
        {
            OptionCaption = 'Asset Transfer';
            OptionMembers = "Asset Transfer";
        }
        field(8;"Currency Code";Code[10])
        {
        }
        field(9;"No. Seriess";Code[10])
        {
        }
        field(10;Status;Option)
        {
            Editable = false;
            OptionMembers = Open,"Pending Approval",Approved,Canceled;
        }
        field(11;Transfered;Boolean)
        {
        }
        field(12;"Date Transfered";Date)
        {
        }
        field(13;"Transfered By";Code[20])
        {
        }
        field(14;"Time Posted";Time)
        {
        }
        field(50000;"User ID";Code[50])
        {
        }
        field(50001;"Responsibility Center";Code[50])
        {
        }
    }

    keys
    {
        key(Key1;"No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
          fasetup.Get;
          fasetup.TestField(fasetup."FA Transfer Nos");
          NoSeriesMgt.InitSeries(fasetup."FA Transfer Nos",xRec."No. Seriess",0D,"No.","No. Seriess");
        end;
    end;

    var
        fasetup: Record "FA Setup";
        hremployee: Record "HR Employees";
        fasset: Record "Fixed Asset";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimValue: Record "Dimension Value";
}

