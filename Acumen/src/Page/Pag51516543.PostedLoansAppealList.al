#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516543 "Posted Loans Appeal  List"
{
    CardPageID = "Posted Loan Appeal Card";
    DeleteAllowed = true;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Loans Register";
    SourceTableView = where("Loan to Appeal"=filter(<>''),
                            Posted=filter(true));

    layout
    {
        area(content)
        {
            repeater(Control1000000010)
            {
                field("Loan  No.";"Loan  No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type";"Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Client Code";"Client Code")
                {
                    ApplicationArea = Basic;
                }
                field("Client Name";"Client Name")
                {
                    ApplicationArea = Basic;
                }
                field("ID NO";"ID NO")
                {
                    ApplicationArea = Basic;
                }
                field("Staff No";"Staff No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No';
                }
                field(Source;Source)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status";"Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
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

