#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516193 "HR Activity Participants"
{
    Caption = 'HR Activity Participants';

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Company Activity';
            OptionMembers = "Company Activity";
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
        }
        field(4; "Sequence No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Sequence No.';
        }
        field(5; "Approval Code"; Code[20])
        {
            Caption = 'Approval Code';
        }
        field(6; "Sender ID"; Code[50])
        {
            Caption = 'Sender ID';
            Editable = false;
        }
        field(7; Contribution; Decimal)
        {
            Caption = 'Contribution';
        }
        field(8; "Approver ID"; Code[50])
        {
            Caption = 'Participant User ID';
            Editable = false;
        }
        field(9; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Created,Open,Canceled,Rejected,Approved';
            OptionMembers = Created,Open,Canceled,Rejected,Approved;
        }
        field(10; "Date-Time Sent for Approval"; DateTime)
        {
            Caption = 'Date-Time Sent for Approval';
        }
        field(11; "Last Date-Time Modified"; DateTime)
        {
            Caption = 'Last Date-Time Modified';
        }
        field(12; "Last Modified By ID"; Code[50])
        {
            Caption = 'Last Modified By ID';
        }
        field(13; Comment; Boolean)
        {
            CalcFormula = exist("Approval Comment Line" where("Table ID" = field("Table ID"),
                                                               "Document Type" = field("Document Type"),
                                                               "Document No." = field("Document No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Event Date"; DateTime)
        {
            Caption = 'Event Date';
            Editable = false;
        }
        field(15; "Event Code"; Code[10])
        {
            AutoFormatType = 1;
            Caption = 'Event Code';
            Editable = false;
        }
        field(16; "Event Description"; Text[30])
        {
            AutoFormatType = 1;
            Caption = 'Event Description';
            Editable = false;
        }
        field(17; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(18; "Approval Type"; Option)
        {
            Caption = 'Approval Type';
            OptionCaption = ' ,Sales Pers./Purchaser,Approver';
            OptionMembers = " ","Sales Pers./Purchaser",Approver;
        }
        field(19; "Limit Type"; Option)
        {
            Caption = 'Limit Type';
            OptionCaption = 'Approval Limits,Credit Limits,Request Limits,No Limits';
            OptionMembers = "Approval Limits","Credit Limits","Request Limits","No Limits";
        }
        field(20; "Event Venue"; Text[30])
        {
            Caption = 'Event Venue';
            Editable = false;
        }
        field(21; "Email Message"; Text[250])
        {
            Caption = 'Email Message';
        }
        field(22; Participant; Code[20])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                if HREmp.Get(Participant) then
                    "Approver ID" := HREmp."User ID";
                HRCompanyActivities.Get("Document No.");
                "Table ID" := 53946;
                "Event Date" := HRCompanyActivities.Date;
                "Event Venue" := HRCompanyActivities.Venue;
                "Email Message" := HRCompanyActivities."Email Message";
                "Event Code" := HRCompanyActivities.Code;
                "Event Description" := HRCompanyActivities.Description;
                "Sender ID" := UserId;
                Status := Status::Created;
            end;
        }
        field(23; Notified; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Approver ID", "Document No.")
        {
            Clustered = true;
        }
        key(Key2; "Table ID", "Document Type", "Document No.", "Sequence No.")
        {
            //  Clustered = true;
            Enabled = false;
        }
        key(Key3; "Approver ID", Status)
        {
            Enabled = false;
        }
        key(Key4; "Sender ID")
        {
            Enabled = false;
        }
        // key(Key5;'')
        // {
        //     Enabled = false;
        // }
    }

    fieldgroups
    {
    }

    var
        HRCompanyActivities: Record "HR Company Activities";
        HREmp: Record "HR Employees";


    procedure ShowDocument()
    var
        SalesHeader: Record "Sales Header";
        PurchHeader: Record "Purchase Header";
    begin
        case "Table ID" of
            Database::"Sales Header":
                begin
                    if not SalesHeader.Get("Document Type", "Document No.") then
                        exit;
                    // case "Document Type" of
                    //   "document type"::"Company Activity":
                    //     Page.Run(Page::"Sales Quote",SalesHeader);
                    //   "document type"::
                    //     Page.Run(Page::"Sales Order",SalesHeader);
                    //   "document type"::"2":
                    //     Page.Run(Page::"Sales Invoice",SalesHeader);
                    //   "document type"::"3":
                    //     Page.Run(Page::"Sales Credit Memo",SalesHeader);
                    //   "document type"::"4":
                    //     Page.Run(Page::"Blanket Sales Order",SalesHeader);
                    //   "document type"::"5":
                    //     Page.Run(Page::"Sales Return Order",SalesHeader);
                    // end;
                end;
            Database::"Purchase Header":
                begin
                    if not PurchHeader.Get("Document Type", "Document No.") then
                        exit;
                    // case "Document Type" of
                    //   "document type"::"Company Activity":
                    //     Page.Run(Page::"Purchase Quote",PurchHeader);
                    //   "document type"::"1":
                    //     Page.Run(Page::"Purchase Order",PurchHeader);
                    //   "document type"::"2":
                    //     Page.Run(Page::"Purchase Invoice",PurchHeader);
                    //   "document type"::"3":
                    //     Page.Run(Page::"Purchase Credit Memo",PurchHeader);
                    //   "document type"::"4":
                    //     Page.Run(Page::"Blanket Purchase Order",PurchHeader);
                    //   "document type"::"5":
                    //     Page.Run(Page::"Purchase Return Order",PurchHeader);
                    // end;
                end;
        end;
    end;
}

