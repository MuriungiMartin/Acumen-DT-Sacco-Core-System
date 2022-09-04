#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516250 "HR Notice Board"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            Description = 'Number';
            Editable = false;
        }
        field(2; "Notice Date"; Date)
        {
            Description = 'Record Date';
            Editable = false;
        }
        field(3; Title; Code[30])
        {
            Description = 'Title of Info';
            TableRelation = "HR Notice Board Info Setup"."Notice Type";

            trigger OnValidate()
            begin
                if NoticeInfoSetup.Get(NoticeInfoSetup."Notice Type") then begin
                    "Recipient Email" := NoticeInfoSetup."Group Email"
                end
            end;
        }
        field(4; Description; Text[250])
        {
            Description = 'Info Details';
            Width = 10;
        }
        field(5; "Event Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Event Date" < "Notice Date" then
                    Error('Event Date Cannot be earlier than Notice Date')
            end;
        }
        field(6; "Event Time"; Time)
        {
        }
        field(7; Venue; Text[50])
        {
            Description = 'Venue if for event';
        }
        field(8; "Recipient Email"; Text[30])
        {
            Description = 'Store User ID';
            ExtendedDatatype = EMail;
        }
        field(10; Status; Option)
        {
            InitValue = Planning;
            OptionCaption = 'Planning,Published,Completed';
            OptionMembers = Planning,Published,Completed;
        }
        field(11; Organiser; Code[70])
        {
            // TableRelation = User.Field3671336;
        }
        field(12; Closed; Boolean)
        {
        }
        field(13; "Any Attachement?"; Option)
        {
            OptionMembers = No,Yes;
        }
        field(14; "No. Series"; Code[20])
        {
        }
        field(15; Participant; Code[20])
        {
            TableRelation = "HR Notice Board Info Setup"."Group Name";
        }
        field(16; "Last Date Modified"; Date)
        {
            Editable = false;
        }
        field(17; "Modified By"; Code[70])
        {
            Editable = false;
        }
        field(18; "Organiser Job Title"; Code[20])
        {
            //  TableRelation = "HR Jobs"."Job ID";
        }
    }


    keys
    {
        key(Key1; "No.")
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
            HRSetup.Get;
            HRSetup.TestField(HRSetup."Notice Board Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Notice Board Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Notice Date" := Today;
    end;

    var
        HRSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoticeInfoSetup: Record "HR Notice Board Info Setup";


    procedure OnModify(xRec: Record "HR Notice Board")
    begin
    end;
}

