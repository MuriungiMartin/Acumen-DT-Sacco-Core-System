#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516940 "Member Agent/Next Of Kin Chang"
{
    DrillDownPageID = "House Change Request";
    LookupPageID = "House Change Request";

    fields
    {
        field(1; "Document No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Member Agent/NOK Change");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[20])
        {
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Member No") then begin
                    "Member Name" := ObjCust.Name;
                end;
            end;
        }
        field(3; "Member Name"; Code[50])
        {
        }
        field(4; "Account Type"; Option)
        {
            OptionCaption = ' ,BOSA,FOSA';
            OptionMembers = " ",BOSA,FOSA;

            trigger OnValidate()
            begin
                /*IF "Account Type"="Account Type"::BOSA THEN
                  BEGIN
                    "Account No":="Member No";
                    END;*/

            end;
        }
        field(5; "Account No"; Code[30])
        {
            TableRelation = if ("Account Type" = filter(BOSA)) "Member Register"."No."
            else
            if ("Account Type" = filter(FOSA)) Vendor."No." where("BOSA Account No" = field("Member No"));
        }
        field(6; "Change Type"; Option)
        {
            OptionCaption = ' ,Account Agent Change,Account Next Of Kin Change';
            OptionMembers = " ","Account Agent Change","Account Next Of Kin Change";
        }
        field(7; "Captured By"; Code[20])
        {
        }
        field(8; "Captured On"; Date)
        {
        }
        field(9; "No. Series"; Code[20])
        {
        }
        field(15; "Change Effected"; Boolean)
        {
        }
        field(16; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Document No", "Member No", "Member Name", "Account Type")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Member Agent/NOK Change");
            NoSeriesMgt.InitSeries(SalesSetup."Member Agent/NOK Change", xRec."No. Series", 0D, "Document No", "No. Series");
        end;

        "Captured On" := Today;
        "Captured By" := UserId;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjAccount: Record Vendor;
        ObjCust: Record "Member Register";
        ObjLoans: Record "Loans Register";
        ObjSurestep: Codeunit "SURESTEP Factory.";
        VarAmountInArrears: Decimal;
        ObjHouses: Record "Member House Groups";
}

