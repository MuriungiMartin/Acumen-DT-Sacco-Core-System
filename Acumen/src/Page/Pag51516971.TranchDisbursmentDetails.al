#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516971 "Tranch Disbursment Details"
{
    PageType = ListPart;
    SourceTable = "Tranch Disburesment Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No";"Loan No")
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
                field("Loan Product Type";"Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.","Loan No");
        if ObjLoans.FindSet then begin
          "Client Code":=ObjLoans."Client Code";
          "Client Name":=ObjLoans."Client Name";
          "Loan Product Type":=ObjLoans."Loan Product Type";
          end;
    end;

    var
        ObjLoans: Record "Loans Register";
}

