#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516576 "S-Mobile Loans"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                }
                field("Application Date";"Application Date")
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
                field("Oustanding Interest";"Oustanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance";"Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status";"Loan Status")
                {
                    ApplicationArea = Basic;
                }
                field("Issued Date";"Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount";"Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone;Telephone)
                {
                    ApplicationArea = Basic;
                    Caption = 'Telephone';
                }
                field("Loan Name";"Loan Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Name';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if Ltype.Get(Rec."Loan Product Type") then
          "Loan Name" := Ltype."Product Description";
    end;

    var
        Telephone: Code[30];
        "Loan Name": Text[30];
        Ltype: Record "Loan Products Setup";
}

