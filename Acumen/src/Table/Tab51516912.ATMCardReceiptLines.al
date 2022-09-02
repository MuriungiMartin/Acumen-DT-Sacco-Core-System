#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516912 "ATM Card Receipt Lines"
{
    DrillDownPageID = "ATM Card Request Batch List";
    LookupPageID = "ATM Card Request Batch List";

    fields
    {
        field(1;"Batch No.";Code[20])
        {
            NotBlank = false;
        }
        field(2;"ATM Application No";Code[20])
        {
            TableRelation = "ATM Card Applications"."No.";

            trigger OnValidate()
            begin
                ObjATMApplications.Reset;
                ObjATMApplications.SetRange(ObjATMApplications."No.","ATM Application No");
                if ObjATMApplications.FindSet then begin
                  "ATM Card Account No":=ObjATMApplications."Account No";
                  "Account Name":=ObjATMApplications."Account Name";
                  end;
            end;
        }
        field(3;"ATM Card Account No";Code[20])
        {
        }
        field(4;"Account Name";Code[50])
        {
        }
        field(5;"ATM Card No";Code[20])
        {

            trigger OnValidate()
            begin
                if "ATM Card No"<>'' then begin
                  Received:=true;
                  "Received By":=UserId;
                  "Received On":=Today;
                  end;

                if "ATM Card No"='' then begin
                  Received:=false;
                  "Received By":='';
                  "Received On":=0D;
                  end;

                ObjATMApplications.Reset;
                ObjATMApplications.SetRange(ObjATMApplications."No.","ATM Application No");
                if ObjATMApplications.FindSet then begin
                  ObjATMApplications."Card Received":=Received;
                  ObjATMApplications."Received By":="Received By";
                  ObjATMApplications."Received On":="Received On";
                  ObjATMApplications."Card No":="ATM Card No";
                  ObjATMApplications.Modify;
                  end;
            end;
        }
        field(6;Received;Boolean)
        {
        }
        field(7;"Received By";Code[20])
        {
        }
        field(8;"Received On";Date)
        {
        }
        field(9;"ATM Card Application Date";Date)
        {
        }
    }

    keys
    {
        key(Key1;"Batch No.","ATM Application No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EntryNo: Integer;
        ObjATMApplications: Record "ATM Card Applications";
}

