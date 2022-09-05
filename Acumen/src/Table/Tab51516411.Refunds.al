#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516411 "Refunds"
{

    fields
    {
        field(1; "Member No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Transaction Type"; Option)
        {
            NotBlank = true;
            OptionMembers = " ","Shares Contribution",Repayment,Interest,"Unallocated Funds";

            trigger OnValidate()
            begin
                if "Transaction Type" = "transaction type"::"Unallocated Funds" then begin
                    if Cust.Get("Member No.") then begin
                        Cust.CalcFields(Cust."Un-allocated Funds");
                        Amount := Cust."Un-allocated Funds" * -1;
                    end;
                end;
            end;
        }
        field(3; Amount; Decimal)
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Transaction Type" = "transaction type"::"Unallocated Funds" then begin
                    if Cust.Get("Member No.") then begin
                        Cust.CalcFields(Cust."Un-allocated Funds");
                        if Amount > (Cust."Un-allocated Funds" * -1) then
                            Error('Amount cannot be greater than the un-allocated funds: %1', (Cust."Un-allocated Funds" * -1));
                        ;
                    end;
                end;

                if Amount <> 0 then begin

                    if "Transaction Type" = "transaction type"::"Shares Contribution" then begin
                        if Cust.Get("Member No.") then begin
                            Cust.CalcFields(Cust."Current Shares");
                            if Amount > (Cust."Current Shares" * -1) then
                                Error('Amount cannot be greater than the current shares: %1', (Cust."Current Shares" * -1));
                            ;
                        end;
                    end;


                    if "Transaction Type" = "transaction type"::Repayment then begin
                        if Loans.Get("Loan No.") then begin
                            Loans.CalcFields(Loans."Current Repayment");
                            if Amount > (Loans."Current Repayment" * -1) then
                                Error('Amount cannot be greater than the total repayments: %1', (Loans."Current Repayment" * -1));
                            ;
                        end;
                    end;

                    if "Transaction Type" = "transaction type"::Interest then begin
                        if Loans.Get("Loan No.") then begin
                            Loans.CalcFields(Loans."Interest Paid");
                            if Amount > (Loans."Interest Paid" * -1) then
                                Error('Amount cannot be greater than the interest paid: %1', (Loans."Interest Paid" * -1));
                            ;
                        end;
                    end;
                end;
            end;
        }
        field(4; "Loan No."; Code[20])
        {
            TableRelation = if ("Transaction Type" = const(Repayment)) "Loans Register"."Loan  No." where("Client Code" = field("Member No."))
            else
            if ("Transaction Type" = const(Interest)) "Loans Register"."Loan  No." where("Client Code" = field("Member No."));

            trigger OnValidate()
            begin

                if "Transaction Type" = "transaction type"::Repayment then begin
                    if Loans.Get("Loan No.") then begin
                        Loans.CalcFields(Loans."Current Repayment");
                        if Amount > (Loans."Current Repayment" * -1) then
                            Error('Amount cannot be greater than the total repayments: %1', (Loans."Current Repayment" * -1));
                        ;
                    end;
                end;


                if "Transaction Type" = "transaction type"::Interest then begin
                    if Loans.Get("Loan No.") then begin
                        Loans.CalcFields(Loans."Interest Paid");
                        if Amount > (Loans."Interest Paid" * -1) then
                            Error('Amount cannot be greater than the interest paid: %1', (Loans."Interest Paid" * -1));
                        ;
                    end;
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Member No.", "Transaction Type", "Loan No.")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record Customer;
        Loans: Record "Loans Register";
}

