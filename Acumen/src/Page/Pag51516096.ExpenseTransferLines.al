#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516096 "Expense Transfer Lines"
{
    PageType = ListPart;
    SourceTable = "Funds Transfer Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type";"Document Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expense Type';
                }
                field("Receiving Bank Account";"Receiving Bank Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expense Account No.';
                    Editable = false;
                }
                field("Bank Name";"Bank Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expense Name';
                }
                field("Bank Balance";"Bank Balance")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Amount to Receive";"Amount to Receive")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Expensed';
                }
                field("External Doc No.";"External Doc No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Rcpt No.';
                }
            }
        }
    }

    actions
    {
    }
}

