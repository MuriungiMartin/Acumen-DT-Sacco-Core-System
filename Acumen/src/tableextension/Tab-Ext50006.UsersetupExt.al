tableextension 50006 "UsersetupExt" extends "User Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; Leave; Boolean)
        {
        }
        field(50008; "Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50009; tetst; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50010; "Code 2"; Code[20])
        {
        }
        field(50011; "Code 3"; Code[20])
        {
        }
        field(50027; "Cash Advance Staff Account"; Code[20])
        {
            //  TableRelation = Customer."No." where("Account Type" = const("Staff Advance"));
        }
        field(50030; "ReOpen/Release"; Option)
        {
            OptionMembers = " ",ReOpen,Release;
        }
        field(50031; "Location Code"; Code[10])
        {
            TableRelation = Location.Code;
        }
        field(50100; "Edit Posted Dimensions"; Boolean)
        {
        }
        field(50110; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
        }
        field(50111; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(53900; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(53901; "Responsibility Center"; Code[10])
        {
            TableRelation = "Online Access Group Priveleges".Dashboard;
        }
        field(53902; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(53903; "Unlimited PV Amount Approval"; Boolean)
        {
        }
        field(53904; "PV Amount Approval Limit"; Decimal)
        {
        }
        field(53905; "Unlimited PettyAmount Approval"; Boolean)
        {
        }
        field(53906; "Petty C Amount Approval Limit"; Decimal)
        {
        }
        field(53907; "Unlimited Imprest Amt Approval"; Boolean)
        {
        }
        field(53908; "Imprest Amount Approval Limit"; Decimal)
        {
        }
        field(53909; "Unlimited Store RqAmt Approval"; Boolean)
        {
        }
        field(53910; "Store Req. Amt Approval Limit"; Decimal)
        {
        }
        field(53911; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(53912; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(53913; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(53914; "Unlimited ImprestSurr Amt Appr"; Boolean)
        {
        }
        field(53915; "ImprestSurr Amt Approval Limit"; Decimal)
        {
        }
        field(53916; "Unlimited Interbank Amt Appr"; Boolean)
        {
        }
        field(53917; "Interbank Amt Approval Limit"; Decimal)
        {
        }
        field(53918; "Staff Travel Account"; Code[20])
        {
            //     TableRelation = Customer."No." where("Account Type" = const("Travel Advance"));
        }
        field(53919; "Post JVs"; Boolean)
        {
        }
        field(53920; "Post Bank Rec"; Boolean)
        {
        }
        field(53921; "Unlimited Receipt Amt Approval"; Boolean)
        {
        }
        field(53922; "Receipt Amt Approval Limit"; Decimal)
        {
        }
        field(53923; "Unlimited Claim Amt Approval"; Boolean)
        {
        }
        field(53924; "Claim Amt Approval Limit"; Decimal)
        {
        }
        field(53925; "Unlimited Advance Amt Approval"; Boolean)
        {
        }
        field(53926; "Advance Amt Approval Limit"; Decimal)
        {
        }
        field(53927; "Unlimited AdvSurr Amt Approval"; Boolean)
        {
        }
        field(53928; "AdvSurr Amt Approval Limit"; Decimal)
        {
        }
        field(53929; "Other Advance Staff Account"; Code[20])
        {
            //  TableRelation = Customer."No." where("Account Type" = const("Staff Advance"));
        }
        field(53930; "Unlimited Grant Amt Approval"; Boolean)
        {
        }
        field(53931; "Grant Amt Approval Limit"; Decimal)
        {
        }
        field(53932; "Unlimited GrantSurr Approval"; Boolean)
        {
        }
        field(53933; "GrantSurr Amt Approval Limit"; Decimal)
        {
        }
        field(53934; "User Signature"; Blob)
        {
        }
        field(53935; "Post Staff Grants"; Boolean)
        {
        }
        field(54278; "ReValidate LPOs"; Boolean)
        {
            Description = 'Can ReOpen Expired LPOs';
        }
        field(54279; "Procurement Officer"; Boolean)
        {
        }
        field(54280; "Compliance/Grants"; Boolean)
        {
        }
        field(54281; "Payroll Code"; Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(54282; test; Text[30])
        {
        }
        field(54283; "Archiving User"; Code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(54284; "Member Registration"; Boolean)
        {
        }
        field(54285; "Member Verification"; Boolean)
        {
        }
        field(54286; "CPD User"; Boolean)
        {
        }
        field(54287; "Indexing User"; Boolean)
        {
        }
        field(54288; "Post CPD Adjst"; Boolean)
        {
        }
        field(51516000; "Employee no"; Code[20])
        {
            TableRelation = "HR Employees"."No.";
        }
        field(51516001; "View Payroll"; Boolean)
        {
        }
        field(51516002; "Create Vote"; Boolean)
        {
        }
        field(51516003; "Cancel Requisition"; Boolean)
        {
        }
        field(51516004; "Create Item"; Boolean)
        {
        }
        field(51516005; "Reversal Right"; Boolean)
        {
        }
        field(51516006; "Change GL"; Boolean)
        {
        }
        field(51516007; "Post Stores Requisition"; Boolean)
        {
        }
        field(51516008; "Re-Open Batch"; Boolean)
        {
        }
        field(51516009; "View Special Accounts"; Boolean)
        {
        }
        field(51516010; "Allow Back-Dating Transactions"; Boolean)
        {
        }
        field(51516011; "Release Loans"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516012; "Post Loans"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516013; "Issue Trunch"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516014; "Update Automatically"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516015; "Post PV"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516016; "Portal Creator"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516017; "Backdate Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516018; "Cashier Authorization"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516019; "Re-Join"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516020; "Branch Code"; code[50])
        {
            DataClassification = ToBeClassified;
        }



    }

    var
        myInt: Integer;
}