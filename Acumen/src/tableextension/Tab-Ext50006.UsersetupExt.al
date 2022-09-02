tableextension 50006 "UsersetupExt" extends "User Setup"
{
    fields
    {
        // Add changes to table fields here
                field(50000;Leave;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008;"Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50009;tetst;Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(50010;"Code 2";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011;"Code 3";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50027;"Cash Advance Staff Account";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where ("Account Type"=const("Staff Advance"));
        }
        field(50030;"ReOpen/Release";Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",ReOpen,Release;
        }
        field(50031;"Location Code";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(50100;"Edit Posted Dimensions";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50110;"Journal Template Name";Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template";
        }
        field(50111;"Journal Batch Name";Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name"=field("Journal Template Name"));
        }
        field(53900;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(53901;"Responsibility Center";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Online Access Group Priveleges".Dashboard;
        }
        field(53902;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));
        }
        field(53903;"Unlimited PV Amount Approval";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53904;"PV Amount Approval Limit";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53905;"Unlimited PettyAmount Approval";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53906;"Petty C Amount Approval Limit";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53907;"Unlimited Imprest Amt Approval";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53908;"Imprest Amount Approval Limit";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53909;"Unlimited Store RqAmt Approval";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53910;"Store Req. Amt Approval Limit";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53911;"Shortcut Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference of the second global dimension in the database';
            NotBlank = false;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(53912;"Shortcut Dimension 3 Code";Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(3));
        }
        field(53913;"Shortcut Dimension 4 Code";Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            Description = 'Stores the reference of the Third global dimension in the database';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(4));
        }
        field(53914;"Unlimited ImprestSurr Amt Appr";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53915;"ImprestSurr Amt Approval Limit";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53916;"Unlimited Interbank Amt Appr";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53917;"Interbank Amt Approval Limit";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53918;"Staff Travel Account";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where ("Account Type"=const("Travel Advance"));
        }
        field(53919;"Post JVs";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53920;"Post Bank Rec";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53921;"Unlimited Receipt Amt Approval";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53922;"Receipt Amt Approval Limit";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53923;"Unlimited Claim Amt Approval";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53924;"Claim Amt Approval Limit";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53925;"Unlimited Advance Amt Approval";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53926;"Advance Amt Approval Limit";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53927;"Unlimited AdvSurr Amt Approval";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53928;"AdvSurr Amt Approval Limit";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53929;"Other Advance Staff Account";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No." where ("Account Type"=const("Staff Advance"));
        }
        field(53930;"Unlimited Grant Amt Approval";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53931;"Grant Amt Approval Limit";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53932;"Unlimited GrantSurr Approval";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53933;"GrantSurr Amt Approval Limit";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53934;"User Signature";Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(53935;"Post Staff Grants";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54278;"ReValidate LPOs";Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'Can ReOpen Expired LPOs';
        }
        field(54279;"Procurement Officer";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54280;"Compliance/Grants";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54281;"Payroll Code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "prPayroll Type";
        }
        field(54282;test;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(54283;"Archiving User";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(54284;"Member Registration";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54285;"Member Verification";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54286;"CPD User";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54287;"Indexing User";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54288;"Post CPD Adjst";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516000;"Employee no";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Employees"."No.";
        }
        field(51516001;"View Payroll";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516002;"Create Vote";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516003;"Cancel Requisition";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516004;"Create Item";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516005;"Reversal Right";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516006;"Change GL";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516007;"Post Stores Requisition";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516008;"Re-Open Batch";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516009;"View Special Accounts";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516010;"Allow Back-Dating Transactions";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516011;"Allow Process Payroll";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516012;"Unblock Loan Application";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516013;"Is Manager";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516014;"Is Internal Auditor";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51516015;"Post Pv";Boolean)
        {
            DataClassification = ToBeClassified;
        }

        
    }
    
    var
        myInt: Integer;
}