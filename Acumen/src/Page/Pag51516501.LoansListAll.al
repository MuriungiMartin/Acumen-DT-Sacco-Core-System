#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516501 "Loans  List All"
{
    Editable = false;
    PageType = List;
    SourceTable = "Loans Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan  No.";"Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date";"Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Product Type";"Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Client Code";"Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member  No';
                    Editable = false;
                }
                field("Client Name";"Client Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Staff No";"Staff No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No.';
                }
                field("ID NO";"ID NO")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'FOSA Account No.';
                }
                field("Approved Amount";"Approved Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Status";"Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Issued Date";"Issued Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Date of Completion";"Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Balance";"Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Oustanding Interest";"Oustanding Interest")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Deductible;Deductible)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000001;"Member Statistics FactBox")
            {
                SubPageLink = "No."=field("Client Code");
            }
        }
    }

    actions
    {
    }
}

