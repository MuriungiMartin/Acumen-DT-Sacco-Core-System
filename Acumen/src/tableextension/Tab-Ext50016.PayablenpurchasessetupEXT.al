tableextension 50016 "PayablenpurchasessetupEXT" extends "Purchases & Payables Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Requisition No"; Code[10])
        {
            Caption = 'Requisition No';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50002; "Quotation Request No"; Code[10])
        {
            Caption = 'Quatation Request No';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50003; "Stores Requisition No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50004; "Max. Purchase Requisition"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Tender Request No"; Code[10])
        {
            Caption = 'Tender Request No';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50006; "Stores Issue No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50007; "Requisition Default Vendor"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                /* Vendor.RESET;
                 IF Vendor.GET(xRec."Requisition Default Vendor") THEN BEGIN
                   Vendor."Requisition Default Vendor":=FALSE;
                   Vendor.MODIFY;
                 END;

                  Vendor.RESET;
                  IF Vendor.GET("Requisition Default Vendor") THEN BEGIN
                   Vendor."Requisition Default Vendor":=TRUE;
                   Vendor.MODIFY;
                 END;*/

            end;
        }
        field(50008; "Use Procurement Limits"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Inspection Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54249; "No. Of Order Copies"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(54250; "Copies Print Text"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'Text to show on print out';
        }
        field(54252; "LPO Expiry Period"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(54253; "Allow Posting to Main Sub"; Boolean)
        {
            Caption = 'Allow Posting to Main Sub';
            DataClassification = ToBeClassified;
        }
        field(54254; "Implementing Partner"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54255; "Study Form Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54256; "Vendor Category Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54257; "Vendor Contact Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(54258; "Vendor Category Entries Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54259; "Proposal Code Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54260; "Start Order from Requisition"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

    var
        myInt: Integer;
}