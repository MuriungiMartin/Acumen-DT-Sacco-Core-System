#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516564 "Guarantorship Substitution L"
{
    DrillDownPageID = "Loan Offset Detail List";
    LookupPageID = "Loan Offset Detail List";

    fields
    {
        field(1; "Document No"; Code[20])
        {
            Editable = false;
            TableRelation = "Guarantorship Substitution H"."Document No";
        }
        field(2; "Loan No."; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if Loans.Get("Loan No.") then begin
                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Oustanding Interest");
                    "Loan Type" := Loans."Loan Product Type";
                    "Approved Loan Amount" := Loans."Approved Amount";
                    "Loan Instalments" := Loans.Installments;
                    "Monthly Repayment" := Loans.Repayment;
                    "Outstanding Balance" := Loans."Outstanding Balance";
                    "Outstanding Interest" := Loans."Oustanding Interest";
                end;

                ObjLoanGuar.Reset;
                ObjLoanGuar.SetRange(ObjLoanGuar."Loan No", "Loan No.");

                if ObjLoanGuar.FindSet then begin
                    TGrAmount := 0;
                    GrAmount := 0;
                    FGrAmount := 0;
                    repeat
                        GrAmount := ObjLoanGuar."Amont Guaranteed";
                        TGrAmount := TGrAmount + GrAmount;
                        FGrAmount := TGrAmount + ObjLoanGuar."Amont Guaranteed";
                    until ObjLoanGuar.Next = 0;
                end;
                perorginal := 0;
                firtamont := 0;
                //ObjLoanGuar.("Total Loans Guaranteed","Outstanding Balance");
                ObjLoanGuar.Reset;
                ObjLoanGuar.SetRange(ObjLoanGuar."Loan No", "Loan No.");
                ObjLoanGuar.SetRange(ObjLoanGuar."Member No", "Member No");
                if ObjLoanGuar.FindSet then begin
                    ObjLoanGuar.CalcFields(ObjLoanGuar."Total Loans Guaranteed", ObjLoanGuar."Outstanding Balance");
                    perorginal := ((ObjLoanGuar."Amont Guaranteed" / ObjLoanGuar."Total Loans Guaranteed"));
                    firtamont := ((ObjLoanGuar."Total Loans Guaranteed" - ObjLoanGuar."Outstanding Balance"));
                    ObjLoanGuar."Committed Shares" := perorginal * firtamont;
                    // MESSAGE(FORMAT(perorginal));
                    "Amount Guaranteed" := ObjLoanGuar."Amont Guaranteed";
                    "Current Commitment" := ObjLoanGuar."Amont Guaranteed" - ObjLoanGuar."Committed Shares";
                end;
            end;
        }
        field(3; "Member No"; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if Cust.Get("Member No") then begin
                    "Member Name" := Cust.Name;
                    "ID. NO" := Cust."ID No.";
                    "Staff No" := Cust."Personal No";
                end;
            end;
        }
        field(4; "Loan Type"; Code[20])
        {
            Editable = false;
        }
        field(5; "Approved Loan Amount"; Decimal)
        {
        }
        field(6; "Loan Instalments"; Decimal)
        {
        }
        field(7; "Monthly Repayment"; Decimal)
        {
        }
        field(8; "Outstanding Balance"; Decimal)
        {
        }
        field(9; "Outstanding Interest"; Decimal)
        {
        }
        field(10; "Interest Rate"; Decimal)
        {
        }
        field(11; "ID. NO"; Code[20])
        {
        }
        field(12; "Staff No"; Code[20])
        {
        }
        field(13; Posted; Boolean)
        {
        }
        field(14; "Posting Date"; Date)
        {
        }
        field(15; "Amount Guaranteed"; Decimal)
        {
            Editable = false;
        }
        field(16; "Member Name"; Code[60])
        {
            Editable = false;
        }
        field(17; Substituted; Boolean)
        {
            Editable = false;
        }
        field(18; "Current Commitment"; Decimal)
        {
            Editable = false;
        }
        field(19; "Substitute Member"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Substitute Member") then begin
                    "Substitute Member Name" := Cust.Name;
                end;
            end;
        }
        field(20; "Substitute Member Name"; Code[60])
        {
        }
        field(21; "Sub Amount Guaranteed"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Document No", "Member No", "Loan No.", "Substitute Member")
        {
            Clustered = true;
            SumIndexFields = "Monthly Repayment", "Approved Loan Amount";
        }
        key(Key2; "Approved Loan Amount")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Member No", "Loan Type", "Approved Loan Amount", "Loan Instalments", "Monthly Repayment", "Outstanding Balance", "Outstanding Interest", "Interest Rate", "ID. NO", Posted)
        {
        }
    }

    var
        Loans: Record "Loans Register";
        Loantypes: Record "Loan Products Setup";
        Interest: Decimal;
        Cust: Record Customer;
        LoansTop: Record "Loans Register";
        GenSetUp: Record "Sacco General Set-Up";
        ObjLoanGuar: Record "Loans Guarantee Details";
        TGrAmount: Decimal;
        GrAmount: Decimal;
        FGrAmount: Decimal;
        perorginal: Decimal;
        firtamont: Decimal;
}

