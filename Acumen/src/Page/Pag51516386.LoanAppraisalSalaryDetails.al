#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516386 "Loan Appraisal Salary Details"
{
    PageType = ListPart;
    SourceTable = "Loan Appraisal Salary Details";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //**Prevent modification of approved entries
        LoanApps.Reset;
        LoanApps.SetRange(LoanApps."Loan  No.","Loan No");
        if LoanApps.Find('-') then begin
         if LoanApps."Approval Status"=LoanApps."approval status"::Approved then begin
          CurrPage.Editable:=false;
         end else
          CurrPage.Editable:=true;
        end;
    end;

    var
        LoanApps: Record "Loans Register";
}

