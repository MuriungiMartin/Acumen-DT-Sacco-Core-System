#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Query 50006 "ministatement"
{

    elements
    {
        dataitem(Detailed_Vendor_Ledg_Entry;"Detailed Vendor Ledg. Entry")
        {
            column(Debit_Amount;"Debit Amount")
            {
            }
            column(Credit_Amount;"Credit Amount")
            {
            }
            column(Amount;Amount)
            {
            }
            column(Vendor_No;"Vendor No.")
            {
            }
            column(Vendor_Ledger_Entry_No;"Vendor Ledger Entry No.")
            {
            }
            column(Posting_Date;"Posting Date")
            {
            }
            column(Document_No;"Document No.")
            {
            }
            dataitem(Vendor_Ledger_Entry;"Vendor Ledger Entry")
            {
                DataItemLink = "Entry No."=Detailed_Vendor_Ledg_Entry."Vendor Ledger Entry No.";
                SqlJoinType = LeftOuterJoin;
                column(Entry_No;"Entry No.")
                {
                }
                column(Description;Description)
                {
                }
                column(External_Document_No;"External Document No.")
                {
                }
            }
        }
    }
}

