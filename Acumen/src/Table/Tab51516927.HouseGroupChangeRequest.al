#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516927 "House Group Change Request"
{
    DrillDownPageID = "House Change Request";
    LookupPageID = "House Change Request";

    fields
    {
        field(1; "Document No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."House Change Request No");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No"; Code[20])
        {
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            begin
                if ObjCust.Get("Member No") then begin
                    ObjCust.CalcFields(ObjCust."Current Shares", ObjCust."Total Loans Outstanding");
                    "Member Name" := ObjCust.Name;
                    "House Group" := ObjCust."Member House Group";
                    "House Group Name" := ObjCust."Member House Group Name";
                    "Deposits on Date of Change" := ObjCust."Current Shares";
                    "Outs. Loans on Date of Change" := ObjCust."Total Loans Outstanding";
                end;
            end;
        }
        field(3; "Member Name"; Code[50])
        {
        }
        field(4; "House Group"; Code[20])
        {
            TableRelation = "Member House Groups"."Cell Group Code";

            trigger OnValidate()
            begin
                /*IF ObjLoans.GET("Loan In Default") THEN BEGIN
                  ObjLoans.CALCFIELDS(ObjLoans."Outstanding Balance");
                  "Loan Product":=ObjLoans."Loan Product Type";
                  "Loan Instalments":=ObjLoans.Installments;
                  "Loan Disbursement Date":=ObjLoans."Loan Disbursement Date";
                  "Expected Completion Date":=ObjLoans."Expected Date of Completion";
                  VarAmountInArrears:=ObjSurestep.FnGetLoanAmountinArrears("Loan In Default");
                  "Amount In Arrears":=VarAmountInArrears;
                  "Loan Outstanding Balance":=ObjLoans."Outstanding Balance";
                  "Loan Issued":=ObjLoans."Approved Amount";
                  END;*/

            end;
        }
        field(5; "House Group Name"; Code[50])
        {
        }
        field(6; "Reason For Changing Groups"; Text[80])
        {
        }
        field(7; "Date Group Changed"; Date)
        {
        }
        field(8; "Changed By"; Code[20])
        {
        }
        field(9; "Deposits on Date of Change"; Decimal)
        {
        }
        field(10; "Outs. Loans on Date of Change"; Decimal)
        {
        }
        field(11; "Entry No"; Integer)
        {
        }
        field(12; "No. Series"; Code[20])
        {
        }
        field(13; "Destination Cell"; Code[20])
        {
            TableRelation = "Member House Groups"."Cell Group Code";

            trigger OnValidate()
            begin
                if ObjHouses.Get("Destination Cell") then begin
                    "Destination Cell Group" := ObjHouses."Cell Group Name";
                end;
            end;
        }
        field(14; "Destination Cell Group"; Code[50])
        {
        }
        field(15; "Change Effected"; Boolean)
        {
        }
        field(16; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(17; "House Group Status"; Option)
        {
            OptionCaption = 'Active,Exiting the Group';
            OptionMembers = Active,"Exiting the Group";

            trigger OnValidate()
            begin
                if Confirm('Are you sure you want to Change this Member`s House Group Status', false) = true then begin
                    if ObjCust.Get("Member No") then begin
                        ObjCust."House Group Status" := "House Group Status";
                        ObjCust.Modify;
                    end;
                end;
            end;
        }
        field(18; "Change Type"; Option)
        {
            OptionCaption = 'Group Change,Remove From Group,Join Group';
            OptionMembers = "Group Change","Remove From Group","Join Group";
        }
    }

    keys
    {
        key(Key1; "Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Document No", "Member No", "Member Name", "House Group")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."House Change Request No");
            NoSeriesMgt.InitSeries(SalesSetup."House Change Request No", xRec."No. Series", 0D, "Document No", "No. Series");
        end;

        //"Demand Notice Date":=TODAY;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjAccount: Record Vendor;
        ObjCust: Record "Member Register";
        ObjLoans: Record "Loans Register";
        ObjSurestep: Codeunit "SURESTEP Factory.";
        VarAmountInArrears: Decimal;
        ObjHouses: Record "Member House Groups";
}

