tableextension 50030 "BankAccStmtExt" extends "Bank Account Statement"
{
    fields
    {
        // Add changes to table fields here

        field(50000; "Cash Book Balance"; Decimal)
        {
            Editable = false;
        }
    }

    var
        myInt: Integer;
}