#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516464 "ATM Card Applications"
{

    fields
    {
        field(1;"No.";Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                  NoSetup.Get;
                  NoSeriesMgt.TestManual(NoSetup."ATM Applications");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Account No";Code[30])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                if Vend.Get("Account No") then begin
                //"Account Name":=PADSTR(Vend.Name,19);
                "Account Name":=Vend.Name;
                "Customer ID":=Vend."ID No.";
                "Branch Code":=Vend."Global Dimension 2 Code";
                "Phone No.":=Vend."Mobile Phone No";
                "Address 1":=Vend.Address;
                "Account Category":=Vend."Account Category";
                "ID No":=Vend."ID No.";



                end;
                "Application Date":=Today;

                "Account No C":=ConvertStr("Account No",'-',' ');

                ObjAtmcardBuffer.Reset;
                ObjAtmcardBuffer.SetRange(ObjAtmcardBuffer."Account No","Account No");
                ObjAtmcardBuffer.SetRange(ObjAtmcardBuffer."ID No","ID No");
                if ObjAtmcardBuffer.FindSet then begin
                  "Request Type":="request type"::Replacement;
                  end;
            end;
        }
        field(3;"Branch Code";Code[30])
        {
        }
        field(4;"Account Type";Option)
        {
            OptionCaption = 'Savings,Current';
            OptionMembers = Savings,Current;
        }
        field(5;"Account Name";Text[70])
        {
        }
        field(6;"Address 1";Text[70])
        {
        }
        field(7;"Address 2";Text[70])
        {
        }
        field(8;"Address 3";Text[50])
        {
        }
        field(9;"Address 4";Text[50])
        {
        }
        field(10;"Address 5";Text[50])
        {
        }
        field(11;"Customer ID";Code[50])
        {
        }
        field(12;"Relation Indicator";Option)
        {
            OptionCaption = 'Primary,Suplimentary';
            OptionMembers = Primary,Suplimentary;
        }
        field(13;"Card Type";Text[30])
        {
        }
        field(14;"Request Type";Option)
        {
            OptionCaption = 'New,Replacement,Renewal';
            OptionMembers = New,Replacement,Renewal;
        }
        field(15;"Application Date";Date)
        {

            trigger OnValidate()
            begin
                generalSetup.Get();
                "ATM Expiry Date":=CalcDate(generalSetup."ATM Expiry Duration","Application Date");
            end;
        }
        field(16;"Card No";Code[30])
        {
        }
        field(17;"Date Issued";Date)
        {
        }
        field(18;Limit;Decimal)
        {
        }
        field(19;"Terms Read and Understood";Boolean)
        {
        }
        field(20;"Card Issued";Boolean)
        {
        }
        field(21;"Form No";Code[30])
        {
        }
        field(22;"Sent To External File";Option)
        {
            OptionMembers = No,Yes;
        }
        field(23;"Card Status";Option)
        {
            OptionCaption = 'Pending,Active,Frozen';
            OptionMembers = Pending,Active,Frozen;
        }
        field(24;"Date Activated";Date)
        {
        }
        field(25;"Date Frozen";Date)
        {
        }
        field(26;"Replacement For Card No";Code[20])
        {
        }
        field(27;"Has Other Accounts";Boolean)
        {
        }
        field(28;"Account Type C";Code[20])
        {
        }
        field(29;"Relation Indicator C";Code[20])
        {
        }
        field(30;"Request Type C";Code[20])
        {
        }
        field(31;"Account No C";Code[30])
        {
        }
        field(33;"Phone No.";Code[20])
        {
        }
        field(35;"No. Series";Code[20])
        {
        }
        field(36;Collected;Boolean)
        {
        }
        field(37;"Application Approved";Boolean)
        {
        }
        field(38;"Date Collected";Date)
        {
        }
        field(39;"Card Issued By";Code[20])
        {
        }
        field(40;"Approval Date";Date)
        {
        }
        field(41;"Reason for Account blocking";Text[50])
        {
        }
        field(42;"ATM Expiry Date";Date)
        {
        }
        field(43;"Card Issued to Customer";Option)
        {
            OptionCaption = 'Owner Collected,Card Sent,Card Issued to';
            OptionMembers = "Owner Collected","Card Sent","Card Issued to";
        }
        field(44;"Issued to";Text[70])
        {
        }
        field(45;Status;Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(46;"Entry No";Integer)
        {
        }
        field(47;"Captured By";Code[20])
        {
        }
        field(48;"Time Captured";Time)
        {
        }
        field(49;"ATM Card Fee Charged";Boolean)
        {
        }
        field(50;"ATM Card Fee Charged On";Date)
        {
        }
        field(51;"ATM Card Fee Charged By";Code[20])
        {
        }
        field(52;"ATM Card Linked";Boolean)
        {
        }
        field(53;"ATM Card Linked By";Code[20])
        {
        }
        field(54;"ATM Card Linked On";Date)
        {
        }
        field(55;"Batch No";Code[20])
        {
        }
        field(56;"Order ATM Card";Boolean)
        {

            trigger OnValidate()
            begin
                if "Order ATM Card"=true then begin
                "Ordered By":=UserId;
                "Ordered On":=Today;
                end;
                if "Order ATM Card"=false then begin
                "Ordered By":='';
                "Ordered On":=0D;
                end;
            end;
        }
        field(57;"Ordered By";Code[20])
        {
        }
        field(58;"Ordered On";Date)
        {
        }
        field(59;"Card Received";Boolean)
        {
        }
        field(60;"Received By";Code[20])
        {
        }
        field(61;"Received On";Date)
        {
        }
        field(68018;"Account Category";Option)
        {
            OptionCaption = 'Single,Joint,Corporate,Group,Branch,Project';
            OptionMembers = Single,Joint,Corporate,Group,Branch,Project;
        }
        field(68019;"ID No";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"No.","Application Date","Entry No")
        {
            Clustered = true;
        }
        key(Key2;"No.","Customer ID")
        {
        }
        key(Key3;"Request Type","No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"No.","Account No","Account Name",Status)
        {
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
        NoSetup.Get();
        NoSetup.TestField(NoSetup."ATM Applications");
        NoSeriesMgt.InitSeries(NoSetup."ATM Applications",xRec."No. Series",0D,"No.","No. Series");
        end;

        "Application Date":=Today;
        "Time Captured":=Time;
        "Captured By":=UpperCase(UserId);
        Validate("Application Date");
    end;

    var
        Vend: Record Vendor;
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        generalSetup: Record "Sacco General Set-Up";
        NoSetup: Record "Sacco No. Series";
        ObjAtmcardBuffer: Record "ATM Card Nos Buffer";
}

