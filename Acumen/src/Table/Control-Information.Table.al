#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516161 "Control-Information"
{

    fields
    {
        field(1;"Primary Key";Code[10])
        {
        }
        field(2;Name;Text[50])
        {
        }
        field(3;"Name 2";Text[50])
        {
        }
        field(4;Address;Text[50])
        {
        }
        field(5;"Address 2";Text[50])
        {
        }
        field(6;City;Text[50])
        {
        }
        field(7;"Phone No.";Text[150])
        {
        }
        field(8;"Phone No. 2";Text[20])
        {
        }
        field(9;"Telex No.";Text[20])
        {
        }
        field(10;"Fax No.";Text[20])
        {
        }
        field(11;"Giro No.";Text[20])
        {
        }
        field(12;"Bank Name";Text[30])
        {
        }
        field(13;"Bank Branch No.";Text[20])
        {
        }
        field(14;"Bank Account No.";Text[20])
        {
        }
        field(15;"Payment Routing No.";Text[20])
        {
        }
        field(17;"Customs Permit No.";Text[10])
        {
        }
        field(18;"Customs Permit Date";Date)
        {
        }
        field(19;"VAT Registration No.";Text[20])
        {
        }
        field(20;"Registration No.";Text[20])
        {
        }
        field(21;"Telex Answer Back";Text[20])
        {
        }
        field(22;"Ship-to Name";Text[30])
        {
        }
        field(23;"Ship-to Name 2";Text[30])
        {
        }
        field(24;"Ship-to Address";Text[30])
        {
        }
        field(25;"Ship-to Address 2";Text[30])
        {
        }
        field(26;"Ship-to City";Text[30])
        {
        }
        field(27;"Ship-to Contact";Text[30])
        {
        }
        field(28;"Location Code";Code[10])
        {
            TableRelation = Location;
        }
        field(29;Picture;Blob)
        {
            SubType = Bitmap;
        }
        field(30;"Post Code";Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if PostCode.Get("Post Code") then
                  City := PostCode.City;
            end;
        }
        field(31;County;Text[30])
        {
        }
        field(32;"Ship-to Post Code";Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if PostCode.Get("Ship-to Post Code") then
                  "Ship-to City" := PostCode.City;
            end;
        }
        field(33;"Ship-to County";Text[30])
        {
        }
        field(34;"E-Mail";Text[80])
        {
        }
        field(35;"Home Page";Text[80])
        {
        }
        field(50000;"Company P.I.N";Code[30])
        {
        }
        field(50001;"N.S.S.F No.";Code[30])
        {
        }
        field(50002;"Company code";Code[10])
        {
        }
        field(50003;"Working Days Per Year";Integer)
        {
        }
        field(50004;"Working Hours Per Week";Integer)
        {
        }
        field(50005;"Working Hours Per Day";Integer)
        {
        }
        field(50006;Mission;Text[250])
        {
        }
        field(50007;"Mission/Vision Link";Text[50])
        {
        }
        field(50008;Vision;Text[250])
        {
        }
        field(50009;"N.H.I.F No";Text[100])
        {
        }
        field(50010;"Payslip Message";Text[250])
        {
            Description = 'Dennis Added';
        }
        field(50011;"Multiple Payroll";Boolean)
        {
        }
        field(50012;"Picture USAID";Blob)
        {
            SubType = Bitmap;
        }
        field(50013;"Board Tax Percent";Decimal)
        {
        }
        field(50014;"Committee Tax Per";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PostCode: Record "Post Code";
}

