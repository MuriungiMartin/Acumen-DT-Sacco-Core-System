#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516290 "File Movement Header"
{
    DrillDownPageID = "SMS Charges";
    LookupPageID = "SMS Charges";

    fields
    {
        field(1;"No.";Code[20])
        {
            Editable = false;
        }
        field(2;"File Number";Code[40])
        {
        }
        field(3;"File Name";Text[100])
        {
        }
        field(4;"Account No.";Code[40])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                Vendor.Reset;
                Vendor.SetRange(Vendor."No.","Account No.");
                if Vendor.Find('-') then
                  "Account Name":=Vendor.Name;
            end;
        }
        field(5;"Account Name";Text[50])
        {
            Editable = false;
        }
        field(6;"Date Requested";Date)
        {
            Editable = false;
        }
        field(7;"Requested By";Code[50])
        {
            Editable = false;
        }
        field(8;"Date Retrieved";Date)
        {
        }
        field(9;"Responsiblity Center";Code[50])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(10;"Expected Return Date";Date)
        {
            Editable = false;
        }
        field(11;"Duration Requested";DateFormula)
        {

            trigger OnValidate()
            begin
                "Expected Return Date":=CalcDate("Duration Requested",Today);
            end;
        }
        field(12;"Date Returned";Date)
        {
        }
        field(13;"File Location";Code[40])
        {
            TableRelation = "File Locations Setup".Location;
        }
        field(14;"Current File Location";Code[40])
        {
            Editable = false;
            TableRelation = "File Locations Setup".Location;
        }
        field(15;"Retrieved By";Code[40])
        {
        }
        field(16;"Returned By";Code[40])
        {
        }
        field(17;"Global Dimension 1 Code";Code[40])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=filter(1));
        }
        field(18;"Global Dimension 2 Code";Code[40])
        {
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=filter(2));
        }
        field(19;Status;Option)
        {
            Editable = false;
            InitValue = Open;
            OptionCaption = ',Open,Pending Approval,Approved,Issued,Returned,Transferred';
            OptionMembers = ,Open,"Pending Approval",Approved,Issued,Returned,Transferred;
        }
        field(20;"User ID";Code[40])
        {
            Editable = false;
        }
        field(21;"Issuing File Location";Code[40])
        {
            Editable = true;
            InitValue = 'REGISTRY';
            TableRelation = "File Locations Setup".Location;
        }
        field(22;"No. Series";Code[20])
        {
        }
        field(23;"File Movement Status";Option)
        {
            Editable = false;
            InitValue = Open;
            OptionCaption = 'Open,Issued,Returned,Transferred';
            OptionMembers = Open,Issued,Returned,Transferred;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Error('You do not have permissions to delete this record, Please contact the system administrator');
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
           GenLedgerSetup.Get;
            GenLedgerSetup.TestField(GenLedgerSetup."File Movement Nos");
          NoSeriesMgt.InitSeries(GenLedgerSetup."File Movement Nos",xRec."No. Series",0D,"No.","No. Series");
        end;
        //Set To Defaut On Insert A New Rec-Kimoo
        "Date Requested":=Today;
        "User ID":=UserId;
        "Requested By":=UserId;
        "Issuing File Location":='REGISTRY';
    end;

    trigger OnModify()
    begin
        //ERROR('You do not have permissions to modify this record, Please contact the system administrator');
    end;

    trigger OnRename()
    begin
        //ERROR('You do not have permissions to rename this record, Please contact the system administrator');
    end;

    var
        GenLedgerSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Vendor: Record Vendor;
}

