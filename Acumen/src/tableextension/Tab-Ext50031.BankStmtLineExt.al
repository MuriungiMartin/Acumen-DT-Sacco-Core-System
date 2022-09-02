tableextension 50031 "BankStmtLineExt" extends "Bank Account Statement Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; Reconciled; Boolean)
        {
        }
        field(50001; "Document Date"; Date)
        {
        }
        field(50002; Debit; Decimal)
        {
            CalcFormula = sum("Bank Account Statement Line"."Statement Amount" where("Statement Amount" = filter(> 0),
                                                                                      "Bank Account No." = field("Bank Account No."),
                                                                                      "Statement Line No." = field("Statement Line No.")));
            FieldClass = FlowField;
        }
        field(50003; Credit; Decimal)
        {
            CalcFormula = sum("Bank Account Statement Line"."Statement Amount" where("Statement Amount" = filter(< 0),
                                                                                      "Bank Account No." = field("Bank Account No."),
                                                                                      "Statement Line No." = field("Statement Line No.")));
            FieldClass = FlowField;
        }
        field(50004; "Open Type"; Option)
        {
            OptionCaption = ' ,Unpresented Cheques List,Uncredited Cheques List';
            OptionMembers = " ",Unpresented,Uncredited;
        }
    }

    var
        myInt: Integer;
}