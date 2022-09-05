#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516907 "Package Retrieval Register"
{

    fields
    {
        field(1; "Request No"; Code[20])
        {

            trigger OnValidate()
            var
                UsersRec: Record User;
            begin
                if "Request No" <> xRec."Request No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Package Retrieval Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Package ID"; Code[20])
        {
            TableRelation = "Safe Custody Package Register"."Package ID";

            trigger OnValidate()
            begin
                if ObjPackage.Get("Package ID") then begin
                    "Package Description" := ObjPackage."Package Description";
                    "Package Type" := ObjPackage."Package Type";
                    "Package Expiry Date" := ObjPackage."Maturity Date";
                    "Maturity Instructions" := ObjPackage."Maturity Instruction";
                    "Retrieval Charge Account" := ObjPackage."Charge Account";
                end;
            end;
        }
        field(3; "Package Description"; Text[50])
        {
        }
        field(4; "Retrieval Requested By"; Code[20])
        {
            TableRelation = "Safe Custody Agents Register"."Agent ID" where("Package ID" = field("Package ID"));

            trigger OnValidate()
            begin
                ObjAgents.Reset;
                ObjAgents.SetRange(ObjAgents."Agent ID", "Retrieval Requested By");
                if ObjAgents.FindSet then begin
                    "Requesting Agent Name" := ObjAgents."Agent Name";
                    "Requesting Agent ID/Passport" := ObjAgents."Agent ID/Passport No";
                    "Make Copy of Package/Item" := ObjAgents."Make Copy of Package/Item";
                    "Add Package/Item" := ObjAgents."Add Package/Item";
                    "Collect Package/Item" := ObjAgents."Collect Package/Item";
                end;
            end;
        }
        field(5; "Retrieval Request Date"; Date)
        {
        }
        field(6; "Retrieved By(Custodian 1)"; Code[20])
        {
        }
        field(7; "Retrieved By(Custodian 2)"; Code[20])
        {
        }
        field(8; "Retrieval Date"; Date)
        {
        }
        field(9; "Retrieval Charge Account"; Code[20])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No"));

            trigger OnValidate()
            begin
                if ObjAccount.Get("Retrieval Charge Account") then begin
                    "Charge Account Name" := ObjAccount.Name;
                end;


                ObjVendors.Reset;
                ObjVendors.SetRange(ObjVendors."No.", "Retrieval Charge Account");
                if ObjVendors.Find('-') then begin
                    ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                    AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                    ObjAccTypes.Reset;
                    ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                    if ObjAccTypes.Find('-') then
                        AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                end;


                ObjGenSetup.Get();

                ObjPackageTypes.Reset;
                ObjPackageTypes.SetRange(ObjPackageTypes.Code, "Package Type");
                if ObjPackageTypes.FindSet then begin
                    LodgeFee := ObjPackageTypes."Package Retrieval Fee";
                end;

                if AvailableBal < (LodgeFee + (LodgeFee * ObjGenSetup."Excise Duty(%)" / 100)) then
                    Error('The Member has less than %1 Retrieval Fee on their Account.Account Available Balance is %2', (LodgeFee + (LodgeFee * ObjGenSetup."Excise Duty(%)" / 100)), AvailableBal);
            end;
        }
        field(10; "Reason for Retrieval"; Option)
        {
            OptionCaption = 'Check Item,Add Item,Release Item,Release Package';
            OptionMembers = "Check Item","Add Item","Release Item","Release Package";
        }
        field(11; "Package Expiry Date"; Date)
        {
        }
        field(12; "No. Series"; Code[20])
        {
        }
        field(13; "Package Type"; Code[20])
        {
        }
        field(14; "Maturity Instructions"; Option)
        {
            OptionMembers = Renew;
        }
        field(15; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(16; "Requesting Agent Name"; Code[50])
        {
        }
        field(17; "Requesting Agent ID/Passport"; Code[20])
        {
        }
        field(21; "Collect Package/Item"; Boolean)
        {
        }
        field(22; "Add Package/Item"; Boolean)
        {
        }
        field(23; "Make Copy of Package/Item"; Boolean)
        {
        }
        field(24; "Charge Account Name"; Code[100])
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
        field(51516154; "Re_Lodged By(Custodian 1)"; Code[20])
        {
        }
        field(51516155; "Re_Lodged By(Custodian 2)"; Code[20])
        {
        }
        field(51516156; "Date Re_Lodged"; Date)
        {
        }
        field(51516157; "Time Re_Lodged"; Time)
        {
        }
        field(51516158; "Released By(Custodian 1)"; Code[20])
        {
        }
        field(51516159; "Released By(Custodian 2)"; Code[20])
        {
        }
        field(51516160; "Date Released"; Date)
        {
        }
        field(51516161; "Time Released"; Time)
        {
        }
    }

    keys
    {
        key(Key1; "Request No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Request No", "Package ID", "Package Description", "Retrieval Requested By")
        {
        }
    }

    trigger OnInsert()
    var
        UsersRec: Record "User Setup";
    begin
        if "Request No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Package Retrieval Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Package Retrieval Nos", xRec."No. Series", 0D, "Request No", "No. Series");
        end;
        "Retrieval Request Date" := Today;

        UsersRec.Reset;
        UsersRec.SetRange(UsersRec."User Id", UserId);
        if UsersRec.Find('-') then begin
            "Global Dimension 2 Code" := UsersRec."Branch Code";
        end;

        Validate("Global Dimension 2 Code");
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjPackage: Record "Safe Custody Package Register";
        ObjAgents: Record "Safe Custody Agents Register";
        ObjAccount: Record Vendor;
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        ObjPackageTypes: Record "Package Types";
        AvailableBal: Decimal;
        LodgeFee: Decimal;
        ObjCust: Record Customer;
        ObjGenSetup: Record "Sacco General Set-Up";
}

