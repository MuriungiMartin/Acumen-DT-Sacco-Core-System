#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516563 "Guarantorship Substitution H"
{
    LookupPageID = "Guarantorship Sub List";

    fields
    {
        field(1; "Document No"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Document No" <> xRec."Document No" then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Guarantor Substitution");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Application Date"; Date)
        {
        }
        field(3; "Loanee Member No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Loanee Member No") then begin
                    "Loanee Name" := Cust.Name;
                end;
            end;
        }
        field(4; "Loanee Name"; Code[60])
        {
        }
        field(5; "Loan Guaranteed"; Code[30])
        {
            TableRelation = "Loans Register"."Loan  No." where("Client Code" = field("Loanee Member No"));

            trigger OnValidate()
            begin
                GuarantorshipLine.Reset;
                GuarantorshipLine.SetRange(GuarantorshipLine."Document No", "Document No");
                if GuarantorshipLine.FindSet then begin
                    GuarantorshipLine.DeleteAll;
                end;



                LoanGuarantors.Reset;
                LoanGuarantors.SetRange(LoanGuarantors."Loan No", "Loan Guaranteed");
                if LoanGuarantors.FindSet then begin
                    repeat

                        TGrAmount := 0;
                        GrAmount := 0;
                        FGrAmount := 0;

                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", "Loan Guaranteed");
                        if LoanGuar.Find('-') then begin
                            repeat
                                GrAmount := LoanGuar."Amont Guaranteed";
                                TGrAmount := TGrAmount + GrAmount;
                                FGrAmount := TGrAmount + LoanGuar."Amont Guaranteed";
                            until LoanGuar.Next = 0;
                        end;


                        if LoansRec.Get("Loan Guaranteed") then begin
                            //Defaulter loan clear
                            LoansRec.CalcFields(LoansRec."Outstanding Balance", LoansRec."Interest Due");
                            Lbal := ROUND(LoansRec."Outstanding Balance", 1, '=');
                            if LoansRec."Oustanding Interest" > 0 then begin
                                INTBAL := ROUND(LoansRec."Oustanding Interest", 1, '=');
                                COMM := ROUND((LoansRec."Oustanding Interest" * 0.5), 1, '=');
                                LoansRec."Attached Amount" := Lbal;
                                LoansRec.PenaltyAttached := COMM;
                                LoansRec.InDueAttached := INTBAL;
                                Modify;
                            end;




                            GenSetUp.Get();
                            GenSetUp."Defaulter LN" := GenSetUp."Defaulter LN" + 10;
                            GenSetUp.Modify;
                            DLN := 'DLN_' + Format(GenSetUp."Defaulter LN");
                            TGrAmount := TGrAmount + GrAmount;
                            GrAmount := LoanGuarantors."Amont Guaranteed";



                            if loanTypes.Get(LoansRec."Loan Product Type") then begin
                            end;
                        end;
                    until LoanGuarantors.Next = 0;
                end;
            end;
        }
        field(6; "Substituting Member"; Code[30])
        {
            TableRelation = "Loans Guarantee Details"."Member No" where("Loan No" = field("Loan Guaranteed"));

            trigger OnValidate()
            begin
                if Cust.Get("Substituting Member") then begin
                    "Substituting Member Name" := Cust.Name;
                end;
            end;
        }
        field(7; "Substituting Member Name"; Code[60])
        {
        }
        field(8; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(9; "Created By"; Code[30])
        {
        }
        field(10; "Substituted By"; Code[30])
        {
        }
        field(11; "Date Substituted"; Date)
        {
        }
        field(12; "No. Series"; Code[20])
        {
        }
        field(13; Substituted; Boolean)
        {
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
    }

    trigger OnInsert()
    begin
        if "Document No" = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Guarantor Substitution");
            NoSeriesMgt.InitSeries(SalesSetup."Guarantor Substitution", xRec."No. Series", 0D, "Document No", "No. Series");
        end;

        "Application Date" := Today;
        "Created By" := UserId;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Cust: Record Customer;
        GuarantorshipLine: Record "Guarantorship Substitution L";
        LoanRec: Record "Loans Register";
        LoanGuarantors: Record "Loans Guarantee Details";
        TGrAmount: Decimal;
        GrAmount: Decimal;
        FGrAmount: Decimal;
        LoanGuar: Record "Loans Guarantee Details";
        LoansRec: Record "Loans Register";
        GenSetUp: Record "Sacco General Set-Up";
        Lbal: Decimal;
        INTBAL: Decimal;
        COMM: Decimal;
        DLN: Code[20];
        loanTypes: Record "Loan Products Setup";
}

