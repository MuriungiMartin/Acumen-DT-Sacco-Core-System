#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516475 "HISA Allocation"
{

    fields
    {
        field(1;"Document No";Code[20])
        {
            NotBlank = true;
        }
        field(2;"Member No";Code[20])
        {
            NotBlank = true;
            TableRelation = "Member Register"."No.";
        }
        field(3;"Transaction Type";Option)
        {
            NotBlank = true;
            OptionCaption = ' ,Repayment,Deposits Contribution,Rejoining Fee,Registration Fee,Insurance Contribution,Shares Capital,Investment,Un-allocated Funds';
            OptionMembers = " ",Repayment,"Deposits Contribution","Rejoining Fee","Registration Fee","Insurance Contribution","Shares Capital",Investment,"Un-allocated Funds";

            trigger OnValidate()
            begin
                "Loan No.":='';
                Amount:=0;
                
                /*
                IF ("Transaction Type" = "Transaction Type"::Commision) OR ("Transaction Type" = "Transaction Type"::Investment) THEN BEGIN
                IF "Loan No." = '' THEN
                ERROR('You must specify loan no. for loan transactions.');
                END;
                 */
                 /*
                //bett
                IF "Transaction Type" <> "Transaction Type"::Repayment THEN BEGIN
                IF Cust.GET("Member No") THEN BEGIN
                IF Cust.Status = Cust.Status::"Defaulter Recovery" THEN
                ERROR('Only loan repayments are accepted for members whos status is Defaulter Recovery.');
                END;
                END;
                */
                
                if ("Transaction Type" <> "transaction type"::Repayment) then begin
                if Cust.Get("Member No") then begin
                if Cust."Customer Type" <> Cust."customer type"::Member then
                Error('This transaction type only applicable for BOSA Members.');
                end;
                end;

            end;
        }
        field(4;"Loan No.";Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where ("Client Code"=field("Member No"),
                                                                Source=filter(BOSA|" "));

            trigger OnValidate()
            begin
                if CopyStr("Document No",1,2) = 'ST' then begin
                if Loans.Get("Loan No.") then begin
                Loans.CalcFields(Loans."Outstanding Balance",Loans."Oustanding Interest");
                if Loans."Outstanding Balance" > 0 then begin
                Amount:=Loans."Loan Principle Repayment";
                "Interest Amount":=Loans."Loan Interest Repayment";
                end;
                end;

                end else begin
                if Loans.Get("Loan No.") then begin
                Loans.CalcFields(Loans."Outstanding Balance",Loans."Oustanding Interest");
                if (Loans."Outstanding Balance"-Loans."Loan Principle Repayment") > 0 then begin
                Amount:=Loans."Outstanding Balance"-Loans."Loan Principle Repayment";
                end;
                //IF Loans."Oustanding Interest" > 0 THEN
                //"Interest Amount":=Loans."Oustanding Interest";
                end;
                end;

                "Total Amount":=Amount+"Interest Amount";
            end;
        }
        field(5;Amount;Decimal)
        {

            trigger OnValidate()
            begin
                if ("Transaction Type" = "transaction type"::Repayment) then begin
                if "Loan No." = '' then
                Error('You must specify loan no. for loan transactions.');
                end;
                
                if ("Transaction Type" = "transaction type"::"Registration Fee") then begin
                if Cust.Get("Member No") then begin
                Cust.CalcFields(Cust."Registration Fee Paid");
                if Amount > (Cust."Registration Fee"+Cust."Registration Fee Paid") then
                Error('You can only receive the oustanding Registration fee amount of %1',(Cust."Registration Fee"+Cust."Registration Fee Paid"));
                end;
                end;
                
                /*IF ("Transaction Type" = "Transaction Type"::"Shares Capital") THEN BEGIN
                IF Cust.GET("Member No") THEN BEGIN
                Cust.CALCFIELDS(Cust."Shares Retained");
                IF Amount > (Cust."Share Capital"+Cust."Shares Retained") THEN
                ERROR('You can only receive the oustanding Share Capital amount of %1',(Cust."Share Capital"+Cust."Shares Retained"));
                END;
                END;   */
                
                
                /*
                IF Loans.GET("Loan No.") THEN BEGIN
                Loans.CALCFIELDS(Loans."Outstanding Balance");
                IF Loans.Posted = TRUE THEN BEGIN
                IF Amount > Loans."Outstanding Balance" THEN
                ERROR('Principle Repayment cannot be more than the loan oustanding balance.');
                END;
                END;
                
                {"Total Amount":=Amount+"Interest Amount";  }
                Comm:=Amount*0.05;
                "Interest Amount":=Comm; */

            end;
        }
        field(6;"Interest Amount";Decimal)
        {

            trigger OnValidate()
            begin
                if ("Transaction Type" = "transaction type"::Repayment) then begin
                if "Loan No." = '' then
                Error('You must specify loan no. for loan transactions.');
                end;
                
                /*
                IF Loans.GET("Loan No.") THEN BEGIN
                Loans.CALCFIELDS(Loans."Oustanding Interest");
                IF "Interest Amount" > Loans."Oustanding Interest" THEN
                ERROR('Interest Repayment cannot be more than the loan oustanding balance.');
                END;
                */
                
                "Total Amount":=Amount+"Interest Amount";

            end;
        }
        field(7;"Total Amount";Decimal)
        {
            Editable = false;
        }
        field(8;"Amount Balance";Decimal)
        {
        }
        field(9;"Interest Balance";Decimal)
        {
        }
        field(10;"Share Mode of Payment";Option)
        {
            OptionCaption = ' ,Cash/Fund Transfer,Cheques,Loans,Check -off,Standing Orders,Fosa Standing Order';
            OptionMembers = " ","Cash/Fund Transfer",Cheques,Loans,"Check -off","Standing Orders","Fosa Standing Order";

            trigger OnValidate()
            begin
                /*RECEIPTs.RESET;
                RECEIPTs.SETRANGE(RECEIPTs."Transaction No.","Document No");
                IF RECEIPTs.FIND('-') THEN BEGIN
                REPEAT
                {IF ("Share Mode of Payment"="Share Mode of Payment"::Loans) OR ("Share Mode of Payment"="Share Mode of Payment"::"Check -off")
                OR ("Share Mode of Payment"="Share Mode of Payment"::"Standing Orders") OR
                ("Share Mode of Payment"="Share Mode of Payment"::"Fosa Standing Order") THEN BEGIN  }
                
                IF RECEIPTs."Account Type"<>RECEIPTs."Account Type"::"Shares Drive" THEN
                ERROR ('YOU CAN ONLY SPECIFY MODE OF PAYMENT FOR SHARES DRIVE');
                UNTIL RECEIPTs.NEXT=0;
                END;  */
                //END;

            end;
        }
        field(11;"Total Allocation";Decimal)
        {
            CalcFormula = sum("HISA Allocation".Amount where ("Document No"=field("Document No")));
            FieldClass = FlowField;
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

    var
        Loans: Record "Loans Register";
        Cust: Record "Member Register";
        RECEIPTs: Record "Receipt Allocation";
        Comm: Decimal;
        bv: Integer;
}

