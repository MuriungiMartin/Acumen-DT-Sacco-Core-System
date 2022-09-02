#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516258 "HR Employee Transfer Header"
{

    fields
    {
        field(1;"Request No";Code[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "Request No" <> xRec."Request No" then begin
                  hrsetup.Get;
                  NoSeriesMgt.TestManual(hrsetup."Employee Transfer Nos.");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Date Requested";Date)
        {
        }
        field(3;"Date Approved";Date)
        {
        }
        field(4;Status;Option)
        {
            OptionCaption = 'New,Pending Approval,Approved,Rejected,Cancelled';
            OptionMembers = New,"Pending Approval",Approved,Rejected,Cancelled;

            trigger OnValidate()
            begin
                 if Status=Status::Approved then begin
                 "Date Approved":=Today;
                end;
            end;
        }
        field(5;"No. Series";Code[10])
        {
        }
        field(6;"Responsibility Center";Code[10])
        {
            Caption = 'Responsibility Center';
        }
        field(7;"Transfer details Updated";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Request No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Request No" = '' then begin
          hrsetup.Get;
          hrsetup.TestField(hrsetup."Employee Transfer Nos.");
          NoSeriesMgt.InitSeries(hrsetup."Employee Transfer Nos.",xRec."No. Series",0D,"Request No","No. Series");
          "Date Requested":=Today;
        end;
    end;

    var
        hrsetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Employees: Record "HR Employees";
}

