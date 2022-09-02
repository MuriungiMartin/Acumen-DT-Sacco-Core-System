tableextension 50041 "BankLineExt" extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        // Add changes to table fields here
        field(50004; "Open Type"; Option)
        {
            OptionCaption = ' ,Unpresented Cheques List,Uncredited Cheques List';
            OptionMembers = " ",Unpresented,Uncredited;
        }
        field(50005; "Bank Ledger Entry Line No"; Integer)
        {
        }
        field(50006; "Bank Statement Entry Line No"; Integer)
        {
        }
        field(50007; Reversed; Boolean)
        {
        }
        field(50008; "Reconciling Date"; Date)
        {
        }
        field(5151600; Reconciled; Boolean)
        {

        }

    }

    var
        myInt: Integer;
}