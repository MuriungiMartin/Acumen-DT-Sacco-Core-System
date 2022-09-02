#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516068 "CloudPESA MPESA Change"
{

    fields
    {
        field(1;idx;Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            Editable = false;
            InitValue = 1;
        }
        field(2;"Document No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "CloudPESA MPESA Trans"."Document No" where ("Needs Manual Posting"=const(true),
                                                                         Posted=const(false));

            trigger OnValidate()
            begin
                cloudpesaMpesaTrans.Reset;
                cloudpesaMpesaTrans.SetRange(  cloudpesaMpesaTrans."Document No","Document No");
                if cloudpesaMpesaTrans.Find('-') then begin
                  "Original Account No":=cloudpesaMpesaTrans."Account No";
                  "Document Date":=cloudpesaMpesaTrans."Transaction Date";
                  "Document Time":=cloudpesaMpesaTrans."Transaction Time";
                  Amount:=cloudpesaMpesaTrans.Amount;
                  "Account Name":=cloudpesaMpesaTrans."Account Name";
                  "Changed By":=UserId;

                end ;
            end;
        }
        field(3;"Document Date";Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4;"Document Time";Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5;"Original Account No";Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6;"Account No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No." where ("Account Type"=filter('100 OR 200'));

            trigger OnValidate()
            var
                vendor: Record Vendor;
            begin

                vendor.Reset;
                vendor.SetRange("No.","Account No");
                if vendor.Find('-') then begin
                  "Account Name":=vendor.Name;
                end else begin
                  "Account Name":='';
                end;
            end;
        }
        field(7;"Document Change Date";DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8;Amount;Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9;"Account Name";Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10;Telephone;Text[15])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11;"Changed By";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Change Status";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Pending,Changed,Cancelled';
            OptionMembers = Pending,Changed,Cancelled;
        }
    }

    keys
    {
        key(Key1;idx)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        cloudpesaMpesaTrans: Record "CloudPESA MPESA Trans";
}

