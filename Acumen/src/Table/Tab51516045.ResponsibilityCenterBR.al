#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516045 "Responsibility Center BR"
{
    Caption = 'Responsibility Center BR';
    DrillDownPageID = "Responsibility Center List";
    LookupPageID = "Responsibility Center List";

    fields
    {
        field(1;"Code";Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2;Name;Text[50])
        {
            Caption = 'Name';
        }
        field(3;Address;Text[50])
        {
            Caption = 'Address';
        }
        field(4;"Address 2";Text[50])
        {
            Caption = 'Address 2';
        }
        field(5;City;Text[30])
        {
            Caption = 'City';

            trigger OnLookup()
            begin
                //PostCode.LookUpCity(City,"Post Code",TRUE);
            end;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",true);
            end;
        }
        field(6;"Post Code";Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //PostCode.LookUpPostCode(City,"Post Code",County,"Country/Region Code",TRUE);
            end;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",true);
            end;
        }
        field(7;"Country/Region Code";Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(8;"Phone No.";Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(9;"Fax No.";Text[30])
        {
            Caption = 'Fax No.';
        }
        field(10;"Name 2";Text[50])
        {
            Caption = 'Name 2';
        }
        field(11;Contact;Text[50])
        {
            Caption = 'Contact';
        }
        field(12;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(13;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(14;"Location Code";Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where ("Use As In-Transit"=const(false));
        }
        field(15;County;Text[30])
        {
            Caption = 'County';
        }
        field(102;"E-Mail";Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(103;"Home Page";Text[90])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(5900;"Date Filter";Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5901;"Contract Gain/Loss Amount";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Contract Gain/Loss Entry".Amount where ("Responsibility Center"=field(Code),
                                                                       "Change Date"=field("Date Filter")));
            Caption = 'Contract Gain/Loss Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000;"Payment User(s) - E-Mail";Text[250])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(50001;"Notify Payment User(s)";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        DimMgt.DeleteDefaultDim(Database::"Responsibility Center",Code);

        //Prevent deletion once entries exist
        TestNoEntriesExist(FieldCaption(Code));
    end;

    var
        PostCode: Record "Post Code";
        DimMgt: Codeunit DimensionManagement;
        Text001: label 'You cannot delete %1 %2 because there is at least one %3 associated to this Responsibity Centre.';


    procedure ValidateShortcutDimCode(FieldNumber: Integer;var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::"Responsibility Center",Code,FieldNumber,ShortcutDimCode);
        Modify;
    end;


    procedure TestNoEntriesExist(CurrentFieldName: Text[100])
    var
        ItemLedgEntry: Record "Payment Header.";
    begin
         //To prevent change of field

         ItemLedgEntry.SetCurrentkey(ItemLedgEntry."Responsibility Center");
        ItemLedgEntry.SetRange("Responsibility Center",Code);
        if ItemLedgEntry.Find('-') then
          Error(
            Text001,
            CurrentFieldName);
    end;
}

