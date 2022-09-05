#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516904 "Safe Custody Package Register"
{

    fields
    {
        field(1; "Package ID"; Code[20])
        {

            trigger OnValidate()
            var
                UsersRec: Record User;
            begin
                if "Package ID" <> xRec."Package ID" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Safe Custody Package Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Package Type"; Code[20])
        {
            TableRelation = "Package Types".Code;
        }
        field(3; "Package Description"; Text[50])
        {
        }
        field(4; "Custody Period"; DateFormula)
        {

            trigger OnValidate()
            begin
                "Maturity Date" := CalcDate("Custody Period", Today);
            end;
        }
        field(5; "Charge Account"; Code[20])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No"));

            trigger OnValidate()
            begin
                if ObjAccount.Get("Charge Account") then begin
                    "Charge Account Name" := ObjAccount.Name;
                end;


                ObjVendors.Reset;
                ObjVendors.SetRange(ObjVendors."No.", "Charge Account");
                if ObjVendors.Find('-') then begin
                    ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                    AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                    ObjAccTypes.Reset;
                    ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                    if ObjAccTypes.Find('-') then
                        AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                end;




                ObjPackageTypes.Reset;
                ObjPackageTypes.SetRange(ObjPackageTypes.Code, "Package Type");
                if ObjPackageTypes.FindSet then begin
                    LodgeFee := ObjPackageTypes."Package Charge";
                end;
                ObjGenSetup.Get();
                if AvailableBal < LodgeFee + (LodgeFee * ObjGenSetup."Excise Duty(%)" / 100) then
                    Error('The Member has less than %1 Lodge Fee on their Account.Account Available Balance is %2', LodgeFee + (LodgeFee * ObjGenSetup."Excise Duty(%)" / 100), AvailableBal);
            end;
        }
        field(6; "Maturity Instruction"; Option)
        {
            OptionCaption = 'Collect,Rebook';
            OptionMembers = Collect,Rebook;
        }
        field(7; "File Serial No"; Code[20])
        {
        }
        field(8; "Date Received"; Date)
        {
        }
        field(9; "Time Received"; Time)
        {
        }
        field(10; "Received By"; Code[20])
        {
        }
        field(11; "Lodged By(Custodian 1)"; Code[20])
        {
        }
        field(12; "Lodged By(Custodian 2)"; Code[20])
        {
        }
        field(13; "Date Lodged"; Date)
        {
        }
        field(14; "Time Lodged"; Time)
        {
        }
        field(15; "Released By(Custodian 1)"; Code[20])
        {
        }
        field(16; "Released By(Custodian 2)"; Code[20])
        {
        }
        field(17; "Date Released"; Date)
        {
        }
        field(18; "Time Released"; Time)
        {
        }
        field(19; "Collected By"; Code[20])
        {
        }
        field(20; "Collected On"; Date)
        {
        }
        field(21; "Collected At"; Time)
        {
        }
        field(22; "Maturity Date"; Date)
        {
        }
        field(23; "Retrieved By(Custodian 1)"; Code[20])
        {
        }
        field(24; "Retrieved By (Custodian 2)"; Code[20])
        {
        }
        field(25; "Retrieved On"; Date)
        {
        }
        field(26; "Retrieved At"; Time)
        {
        }
        field(27; "No. Series"; Code[20])
        {
        }
        field(28; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(29; "Charge Account Name"; Code[30])
        {
        }
        field(51516150; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(51516151; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(51516152; "Member No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Member No") then begin
                    "Member Name" := ObjCust.Name;
                end;
            end;
        }
        field(51516153; "Member Name"; Code[100])
        {
        }
        field(51516154; "Safe Custody Fee Charged"; Boolean)
        {
        }
        field(51516155; "Package Re_Booked On"; Date)
        {
        }
        field(51516156; "Package Rebooked By"; Code[20])
        {
        }
        field(51516157; "Package Re_Lodge Fee Charged"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Package ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Package ID", "Member No", "Member Name", "Package Type", "Package Description", "Custody Period")
        {
        }
    }

    trigger OnInsert()
    var
        UsersRec: Record "User Setup";
    begin
        if "Package ID" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Safe Custody Package Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Safe Custody Package Nos", xRec."No. Series", 0D, "Package ID", "No. Series");
        end;

        "Date Received" := Today;
        "Time Received" := Time;

        UsersRec.Reset;
        UsersRec.SetRange(UsersRec."User ID", UserId);
        if UsersRec.Find('-') then begin
            "Global Dimension 2 Code" := UsersRec."Branch Code";
        end;

        Validate("Global Dimension 2 Code");
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjAccount: Record Vendor;
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        ObjPackageTypes: Record "Package Types";
        AvailableBal: Decimal;
        LodgeFee: Decimal;
        ObjCust: Record Customer;
        ObjGenSetup: Record "Sacco General Set-Up";
}

