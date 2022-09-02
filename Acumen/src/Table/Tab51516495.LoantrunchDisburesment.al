#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516495 "Loan trunch Disburesment"
{

    fields
    {
        field(1;"Document No";Code[20])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                  SalesSetup.Get;
                  NoSeriesMgt.TestManual(SalesSetup."Trunch Disbursment Nos");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Member No";Code[20])
        {
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.","Member No");
                if Cust.Find('-') then begin
                "Member Name":=Cust.Name;
                end;
            end;
        }
        field(3;"Member Name";Text[50])
        {
        }
        field(4;"Loan No";Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where ("Client Code"=field("Member No"));

            trigger OnValidate()
            begin
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Loan  No.","Loan No");
                if LoansRec.Find('-') then begin
                "Issue Date":=LoansRec."Issued Date";
                "Balance Outstanding":=(LoansRec."Approved Amount"-LoansRec."Tranch Amount Disbursed");
                "Disbursed Amount":=LoansRec."Tranch Amount Disbursed";
                "Approved Amount":=LoansRec."Approved Amount";
                "Mode of Disbursement":=LoansRec."Mode of Disbursement";
                "FOSA Account":=LoansRec."Account No";
                end;
            end;
        }
        field(5;"Issue Date";Date)
        {
        }
        field(6;"Approved Amount";Decimal)
        {
        }
        field(7;"Disbursed Amount";Decimal)
        {
        }
        field(8;"Balance Outstanding";Decimal)
        {
        }
        field(9;"Requested Amount";Decimal)
        {
        }
        field(10;"Amount to Disburse";Decimal)
        {
        }
        field(11;Status;Option)
        {
            OptionCaption = 'Open,Pending,Approved';
            OptionMembers = Open,Pending,Approved;
        }
        field(12;"User ID";Code[20])
        {
        }
        field(13;"FOSA Account";Code[20])
        {
            TableRelation = Vendor."No." where ("BOSA Account No"=field("Member No"));
        }
        field(14;"Mode of Disbursement";Option)
        {
            OptionCaption = ' ,Cheque,Bank Transfer,EFT,RTGS,Cheque NonMember';
            OptionMembers = " ",Cheque,"Bank Transfer",EFT,RTGS,"Cheque NonMember";
        }
        field(15;"Cheque No/Reference No";Code[20])
        {
        }
        field(16;Posted;Boolean)
        {
        }
        field(17;"Posting Date";Date)
        {
        }
        field(18;"No. Series";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Document No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
          SalesSetup.Get;
          SalesSetup.TestField(SalesSetup."Trunch Disbursment Nos");
          NoSeriesMgt.InitSeries(SalesSetup."Trunch Disbursment Nos",xRec."No. Series",0D,"Document No","No. Series");
        end;

        "User ID":=UserId;
    end;

    var
        Cust: Record "Member Register";
        LoansRec: Record "Loans Register";
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

