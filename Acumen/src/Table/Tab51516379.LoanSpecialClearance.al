#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516379 "Loan Special Clearance"
{

    fields
    {
        field(1;"Loan No.";Code[20])
        {
            NotBlank = true;
            TableRelation = "Loans Register"."Loan  No.";
        }
        field(2;"Loan Off Set";Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                "Loan Type":='';
                "Principle Off Set":=0;
                "Interest Off Set":=0;
                "Total Off Set":=0;
                PrincipleRepayment:=0;
                
                Loans.Reset;
                Loans.SetRange(Loans."Loan  No.","Loan Off Set");
                if Loans.Find('-') then begin
                Source:=Loans.Source;
                Loans.CalcFields(Loans."Outstanding Balance",Loans."Interest Due");
                "Loan Type":=Loans."Loan Product Type";
                PrincipleRepayment:=Loans.Repayment-Loans."Interest Due";
                if PrincipleRepayment < 0 then begin
                "Interest Off Set":=PrincipleRepayment*-1;
                PrincipleRepayment:=0;
                end;
                
                if ("Loan Type" = 'ADVANCE') or ("Loan Type" = 'SAL ADV') or ("Loan Type" = 'FLEX') or ("Loan Type" = 'OMEGA ADV')  then begin
                "Principle Off Set":=Loans."Outstanding Balance";
                if Loans."Interest Due" > 0 then
                "Interest Off Set":=Loans."Interest Due";
                end else
                "Principle Off Set":=Loans."Outstanding Balance"-PrincipleRepayment;
                //Bett"Principle Off Set":=Loans."Outstanding Balance"-(Loans."Amortised Repayment"-PrincipleRepayment);
                
                //PKKIF Loans."Interest Due" > 0 THEN
                //PKK"Interest Off Set":=Loans."Interest Due";
                end;
                
                //PKK SUPER WEEKLY
                /*
                IF ("Loan Type" = 'SUPER') THEN BEGIN
                "Principle Off Set":=0;
                "Interest Off Set":=0;
                IF Loans."Outstanding Balance" > 0 THEN
                "Principle Off Set":=Loans."Outstanding Balance";
                IF Loans."Interest Due" > 0 THEN
                "Interest Off Set":=Loans."Interest Due";
                END;
                */
                //PKK SUPER WEEKLY
                
                "Monthly Repayment":=Loans.Repayment;
                
                
                if "Principle Off Set" < 0 then
                "Principle Off Set" := 0;
                
                if "Interest Off Set" < 0 then
                "Interest Off Set":=0;
                
                if ("Principle Off Set"+"Interest Off Set") > 0 then
                "Total Off Set":="Principle Off Set"+"Interest Off Set";

            end;
        }
        field(3;"Client Code";Code[20])
        {
        }
        field(4;"Loan Type";Code[20])
        {
        }
        field(5;"Principle Off Set";Decimal)
        {

            trigger OnValidate()
            begin
                Loans.Reset;
                Loans.SetRange(Loans."Loan  No.","Loan Off Set");
                if Loans.Find('-') then begin
                Loans.CalcFields(Loans."Outstanding Balance");
                if "Principle Off Set" > Loans."Outstanding Balance" then
                Error('Amount cannot be greater than the loan oustanding balance.');

                end;

                "Total Off Set":="Principle Off Set"+"Interest Off Set";
            end;
        }
        field(6;"Interest Off Set";Decimal)
        {

            trigger OnValidate()
            begin
                "Total Off Set":="Principle Off Set"+"Interest Off Set";

                if  "Interest Off Set" <> 0 then begin
                Loans.Reset;
                Loans.SetRange(Loans."Loan  No.","Loan Off Set");
                if Loans.Find('-') then begin
                Loans.CalcFields(Loans."Interest Due");
                if "Interest Off Set" > Loans."Interest Due" then
                Error('Amount cannot be greater than the interest due.');

                end;
                end;
            end;
        }
        field(7;"Total Off Set";Decimal)
        {
            Editable = false;
        }
        field(8;"Monthly Repayment";Decimal)
        {
        }
        field(9;Source;Option)
        {
            OptionCaption = 'BOSA,FOSA';
            OptionMembers = BOSA,FOSA;
        }
    }

    keys
    {
        key(Key1;"Loan No.","Client Code","Loan Off Set")
        {
            Clustered = true;
            SumIndexFields = "Total Off Set";
        }
    }

    fieldgroups
    {
    }

    var
        Loans: Record "Loans Register";
        PrincipleRepayment: Decimal;
}

