#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516310 "Payroll Employee Card."
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    SourceTable = "Payroll Employee.";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff No';
                }
                field("Payroll No";"Payroll No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sacco Member No.';
                }
                field(Surname;Surname)
                {
                    ApplicationArea = Basic;
                }
                field(Firstname;Firstname)
                {
                    ApplicationArea = Basic;
                }
                field(Lastname;Lastname)
                {
                    ApplicationArea = Basic;
                }
                field("Employee Email";"Employee Email")
                {
                    ApplicationArea = Basic;
                }
                field("Joining Date";"Joining Date")
                {
                    ApplicationArea = Basic;
                }
                field("Currency Code";"Currency Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Morgage Relief";"Morgage Relief")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1";"Global Dimension 1")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2";"Global Dimension 2")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Membership No.";"Sacco Membership No.")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Group";"Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("National ID No";"National ID No")
                {
                    ApplicationArea = Basic;
                }
                field("NSSF No";"NSSF No")
                {
                    ApplicationArea = Basic;
                }
                field("NHIF No";"NHIF No")
                {
                    ApplicationArea = Basic;
                }
                field("PIN No";"PIN No")
                {
                    ApplicationArea = Basic;
                }
                field("Job Group";"Job Group")
                {
                    ApplicationArea = Basic;
                }
                field(Category;Category)
                {
                    ApplicationArea = Basic;
                }
                field(Department;Department)
                {
                    ApplicationArea = Basic;
                }
                field("Is Management";"Is Management")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Pay Details")
            {
                field("Basic Pay";"Basic Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Paid per Hour";"Paid per Hour")
                {
                    ApplicationArea = Basic;
                }
                field("Pays PAYE";"Pays PAYE")
                {
                    ApplicationArea = Basic;
                }
                field("Pays NSSF";"Pays NSSF")
                {
                    ApplicationArea = Basic;
                }
                field("Pays NHIF";"Pays NHIF")
                {
                    ApplicationArea = Basic;
                }
                field("Payment Mode";"Payment Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Premium";"Insurance Premium")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Bank Details")
            {
                field("Bank Code";"Bank Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bank Name";"Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code";"Branch Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Branch Name";"Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No";"Bank Account No")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Other Details")
            {
                field("Payslip Message";"Payslip Message")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Cummulative Figures")
            {
                Editable = false;
                field("Cummulative Basic Pay";"Cummulative Basic Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Gross Pay";"Cummulative Gross Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Allowances";"Cummulative Allowances")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Deductions";"Cummulative Deductions")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Net Pay";"Cummulative Net Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative PAYE";"Cummulative PAYE")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative NSSF";"Cummulative NSSF")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative Pension";"Cummulative Pension")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative HELB";"Cummulative HELB")
                {
                    ApplicationArea = Basic;
                }
                field("Cummulative NHIF";"Cummulative NHIF")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Suspension of Payment")
            {
                field("Suspend Pay";"Suspend Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Suspend Date";"Suspend Date")
                {
                    ApplicationArea = Basic;
                }
                field("Suspend Reason";"Suspend Reason")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Process Payroll")
            {
                ApplicationArea = Basic;
                Image = Allocations;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    //ContrInfo.GET;

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed,false);
                    if objPeriod.Find('-') then begin
                    SelectedPeriod:=objPeriod."Date Opened";
                    varPeriodMonth:=objPeriod."Period Month";
                    SalCard.Get("No.");
                    end;

                    //For Multiple Payroll
                    if ContrInfo."Multiple Payroll" then
                      begin
                          PayrollDefined:='';
                          PayrollType.Reset;
                          PayrollType.SetCurrentkey(EntryNo);
                          if PayrollType.FindFirst then
                            begin
                                NoofRecords:=PayrollType.Count;
                                i:=0;
                                repeat
                                  i+= 1;
                                  PayrollDefined:=PayrollDefined+'&'+PayrollType."Payroll Code";
                                  if i<NoofRecords then
                                     PayrollDefined:=PayrollDefined+','
                                until PayrollType.Next=0;
                            end;
                            //Selection := STRMENU(PayrollDefined,NoofRecords);

                            PayrollType.Reset;
                            PayrollType.SetRange(PayrollType.EntryNo,Selection);
                            if PayrollType.Find('-') then
                              begin
                                PayrollCode:=PayrollType."Payroll Code";
                             end;
                      end;

                    //Delete all Records from the prPeriod Transactions for Reprocessing
                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed,false);
                    if objPeriod.FindFirst then begin

                      //IF ContrInfo."Multiple Payroll" THEN BEGIN
                        ObjPayrollTransactions.Reset;
                        ObjPayrollTransactions.SetRange(ObjPayrollTransactions."Payroll Period",objPeriod."Date Opened");
                       if ObjPayrollTransactions.Find('-') then
                         begin
                         ObjPayrollTransactions.DeleteAll;
                       end;
                    end;

                    PayrollEmployerDed.Reset;
                      PayrollEmployerDed.SetRange(PayrollEmployerDed."Payroll Period",SelectedPeriod);
                     if PayrollEmployerDed.Find('-') then
                       PayrollEmployerDed.DeleteAll;




                     if ContrInfo."Multiple Payroll" then
                        HrEmployee.Reset;
                        HrEmployee.SetRange(HrEmployee.Status,HrEmployee.Status::Active);
                        if HrEmployee.Find('-') then
                        begin
                          ProgressWindow.Open('Processing Salary for Employee No. #1#######');
                        repeat
                          Sleep(100);
                          if not SalCard."Suspend Pay" then
                            begin
                              ProgressWindow.Update(1,HrEmployee."No."+':'+HrEmployee.Firstname+' '+HrEmployee.Lastname+' '+HrEmployee.Surname);
                              if SalCard.Get(HrEmployee."No.") then
                              ProcessPayroll.fnProcesspayroll(HrEmployee."No.",HrEmployee."Joining Date",SalCard."Basic Pay",SalCard."Pays PAYE"
                              ,SalCard."Pays NSSF",SalCard."Pays NHIF",SelectedPeriod,SelectedPeriod,HrEmployee."Payroll No",'',
                              HrEmployee."Date of Leaving",true,HrEmployee."Branch Code",PayrollCode);
                            end;
                        until  HrEmployee.Next=0;
                        ProgressWindow.Close;
                     end;
                     Message('Payroll processing completed successfully.');
                end;
            }
            action("Employee Earnings")
            {
                ApplicationArea = Basic;
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Payroll Employee Earnings.";
                RunPageLink = "No."=field("No.");
                RunPageView = where("Transaction Type"=filter(Income));
            }
            action("Employee Deductions")
            {
                ApplicationArea = Basic;
                Image = EntriesList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Payroll Employee Deductions.";
                RunPageLink = "No."=field("No.");
                RunPageView = where("Transaction Type"=filter(Deduction));
            }
            action("Employee Assignments")
            {
                ApplicationArea = Basic;
                Image = Apply;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Payroll Employee Assignments.";
                RunPageLink = "No."=field("No.");
            }
            action("Employee Cummulatives")
            {
                ApplicationArea = Basic;
                Image = History;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Payroll Employee Cummulatives.";
                RunPageLink = "No."=field("No.");
            }
            action("View PaySlip")
            {
                ApplicationArea = Basic;
                Image = PaymentHistory;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                     PayrollEmp.Reset;
                     PayrollEmp.SetRange(PayrollEmp."No.","No.");
                     if PayrollEmp.FindFirst then begin
                        Report.Run(50010,true,false,PayrollEmp);
                     end;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        //TODO
        /*IF UserSetup.GET(USERID) THEN
        BEGIN
        IF UserSetup."View Payroll"=FALSE THEN ERROR ('You dont have permissions for payroll, Contact your system administrator! ')
        END;*/

    end;

    var
        PayrollEmp: Record "Payroll Employee.";
        PayrollManager: Codeunit "Payroll Management";
        "Payroll Period": Date;
        PayrollCalender: Record "Payroll Calender.";
        PayrollMonthlyTrans: Record "Payroll Monthly Transactions.";
        PayrollEmployeeDed: Record "Payroll Employee Deductions.";
        PayrollEmployerDed: Record "Payroll Employer Deductions.";
        objEmp: Record "Salary Processing Header";
        SalCard: Record "Payroll Employee.";
        objPeriod: Record "Payroll Calender.";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;
        ProcessPayroll: Codeunit "Payroll Processing";
        HrEmployee: Record "Payroll Employee.";
        ProgressWindow: Dialog;
        prPeriodTransactions: Record "prPeriod Transactions..";
        prEmployerDeductions: Record "Payroll Employer Deductions.";
        PayrollType: Record "Payroll Type.";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "Control-Information.";
        UserSetup: Record "User Setup";
        ObjPayrollTransactions: Record "prPeriod Transactions.";
        varPeriodMonth: Integer;

    local procedure RemoveTrans(EmpNo: Code[20];PayrollPeriod: Date)
    begin
    end;
}

