#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 51516935 "Reschedule Loan Repayment Date"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ObjLoanRepaymentSchedule.Reset;
                ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.","Loan  No.");
                if ObjLoanRepaymentSchedule.FindSet then
                  begin
                    if ObjLoanRepaymentSchedule."Repayment Date">=Today then
                      begin
                        repeat
                          VarRepayDate:=Date2dmy(ObjLoanRepaymentSchedule."Repayment Date",1);
                          VarRepayMonth:=Date2dmy(ObjLoanRepaymentSchedule."Repayment Date",2);
                          VarRepayYear:=Date2dmy(ObjLoanRepaymentSchedule."Repayment Date",3);
                          ObjLoanRepaymentSchedule."Repayment Date":=Dmy2date(VarPreferedRepayDate,VarRepayMonth,VarRepayYear);
                          ObjLoanRepaymentSchedule.Modify;
                          until ObjLoanRepaymentSchedule.Next=0;
                        end;
                    end;
            end;

            trigger OnPreDataItem()
            begin
                if VarPreferedRepayDate=0 then
                  Error('Specify Member Prefered Repayment date');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(VarPreferedRepayDate;VarPreferedRepayDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Member Prefered Repayment Date';
                        ToolTip = 'Specify Member Prefered Loan Repayment Date';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ObjLoanRepaymentSchedule: Record "Loan Repayment Schedule";
        VarPreferedRepayDate: Integer;
        VarRepayDate: Integer;
        VarRepayMonth: Integer;
        VarRepayYear: Integer;
}

