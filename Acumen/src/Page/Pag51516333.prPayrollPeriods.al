#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516333 "prPayroll Periods"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "prPayroll Periods";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Period Month";"Period Month")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Period Year";"Period Year")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Period Name";"Period Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Opened";"Date Opened")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Closed";"Date Closed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Closed;Closed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Payroll Code";"Payroll Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Close Period")
            {
                ApplicationArea = Basic;
                Caption = 'Close Period';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*
                    Warn user about the consequence of closure - operation is not reversible.
                    Ask if he is sure about the closure.
                    */
                    
                    fnGetOpenPeriod;
                    
                    Question := 'Once a period has been closed it can NOT be opened.\It is assumed that you have PAID out salaries.\'
                    + 'Do still want to close ['+ strPeriodName +']';
                    
                    //For Multiple Payroll
                    ContrInfo.Get();
                    if ContrInfo."Multiple Payroll" then begin
                    PayrollDefined:='';
                    PayrollType.SetCurrentkey(EntryNo);
                    if PayrollType.FindFirst then begin
                        NoofRecords:=PayrollType.Count;
                        repeat
                          i+= 1;
                          PayrollDefined:=PayrollDefined+'&'+PayrollType."Payroll Code";
                          if i<NoofRecords then
                             PayrollDefined:=PayrollDefined+','
                        until PayrollType.Next=0;
                    end;
                    
                    
                            Selection := StrMenu(PayrollDefined,3);
                            PayrollType.Reset;
                            PayrollType.SetRange(PayrollType.EntryNo,Selection);
                            if PayrollType.Find('-') then begin
                                PayrollCode:=PayrollType."Payroll Code";
                            end;
                    end;
                    //End Multiple Payroll
                    
                    
                    
                    Answer := Dialog.Confirm(Question, false);
                    if Answer=true then
                    begin
                      Clear(objOcx);
                      objOcx.fnClosePayrollPeriod(dtOpenPeriod);//,PayrollCode);
                      Message ('Process Complete');
                    end else begin
                       Message('You have selected NOT to Close the period');
                    end

                end;
            }
        }
    }

    var
        PayPeriod: Record "prPayroll Periods";
        strPeriodName: Text[30];
        Text000: label '''Leave without saving changes?''';
        Text001: label '''You selected %1.''';
        Question: Text[250];
        Answer: Boolean;
        objOcx: Codeunit prPayrollProcessingXX;
        dtOpenPeriod: Date;
        PayrollType: Record "prPayroll Type";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "Control-Information";


    procedure fnGetOpenPeriod()
    begin


        //Get the open/current period
        PayPeriod.SetRange(PayPeriod.Closed,false);
        if PayPeriod.Find('-') then begin
           strPeriodName:=PayPeriod."Period Name";
           dtOpenPeriod:=PayPeriod."Date Opened";
        end;
    end;
}

