#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516491 "Bulk SMS Header"
{

    fields
    {
        field(1;No;Code[20])
        {
            NotBlank = false;
        }
        field(2;"Date Entered";Date)
        {
        }
        field(3;"Time Entered";Time)
        {
        }
        field(4;"Entered By";Code[150])
        {
        }
        field(5;"SMS Type";Option)
        {
            OptionMembers = Dimension,Telephone,Everyone;
        }
        field(6;"SMS Status";Option)
        {
            OptionMembers = Pending,Sent,Cancelled;
        }
        field(7;"Status Date";Date)
        {
        }
        field(8;"Status Time";Time)
        {
        }
        field(9;"Status By";Code[150])
        {
        }
        field(10;Message;Text[160])
        {
        }
        field(11;"No. Series";Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(12;"Use Line Message";Boolean)
        {
        }
        field(13;Status;Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(14;SentToServer;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin


          if No = '' then begin
          NoSetup.Get;
          NoSetup.TestField(NoSetup."SMS Request Series");
          NoSeriesMgt.InitSeries(NoSetup."SMS Request Series",xRec."No. Series",0D,No,"No. Series");
          end;

        "Date Entered":=Today;
        "Time Entered":=Time;
        "Entered By":=UserId;
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

