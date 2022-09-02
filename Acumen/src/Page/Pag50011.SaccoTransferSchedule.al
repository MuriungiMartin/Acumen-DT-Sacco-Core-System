#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50011 "Sacco Transfer Schedule"
{
    PageType = ListPart;
    SourceTable = "Sacco Transfers Schedule";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Destination Account Type";"Destination Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account No.";"Destination Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Account Name";"Destination Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Destination Type";"Destination Type")
                {
                    ApplicationArea = Basic;
                    OptionCaption = ' ,Registration Fee,Share Capital,Interest Paid,Loan Repayment,Deposit Contribution,Insurance Contribution,Benevolent Fund,Loan,Unallocated Funds,Dividend,FOSA Account';
                }
                field("Destination Loan";"Destination Loan")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Total Payment Loan";"Cummulative Total Payment Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description";"Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Transfer Fee";"Charge Transfer Fee")
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
        SaccoHeader.Reset;
        SaccoHeader.SetRange(SaccoHeader.No,"No.");
        if SaccoHeader.FindSet then begin
          if SaccoHeader.Status=SaccoHeader.Status::Open then begin
            CurrPage.Editable:=true
            end else
            CurrPage.Editable:=false;
          end;
    end;

    trigger OnOpenPage()
    begin
        SaccoHeader.Reset;
        SaccoHeader.SetRange(SaccoHeader.No,"No.");
        if SaccoHeader.FindSet then begin
          if SaccoHeader.Status=SaccoHeader.Status::Open then begin
            CurrPage.Editable:=true
            end else
            if (SaccoHeader.Status=SaccoHeader.Status::"Pending Approval") or (SaccoHeader.Status=SaccoHeader.Status::"Pending Approval") then begin
            CurrPage.Editable:=false;
              end;
          end;
    end;

    var
        SaccoHeader: Record "Sacco Transfers";
}

