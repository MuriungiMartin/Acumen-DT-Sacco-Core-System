#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516321 "Payroll Posting Group."
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "Payroll Posting Groups.";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Code";"Posting Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Salary Account";"Salary Account")
                {
                    ApplicationArea = Basic;
                }
                field("Income Tax Account";"Income Tax Account")
                {
                    ApplicationArea = Basic;
                }
                field("SSF Employer Account";"SSF Employer Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'NSSF Employer Account';
                }
                field("SSF Employee Account";"SSF Employee Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'NSSF Employee Account';
                }
                field("Net Salary Payable";"Net Salary Payable")
                {
                    ApplicationArea = Basic;
                }
                field("Operating Overtime";"Operating Overtime")
                {
                    ApplicationArea = Basic;
                }
                field("Tax Relief";"Tax Relief")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Provident Fund Acc.";"Employee Provident Fund Acc.")
                {
                    ApplicationArea = Basic;
                }
                field("Pay Period Filter";"Pay Period Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Pension Employer Acc";"Pension Employer Acc")
                {
                    ApplicationArea = Basic;
                }
                field("Pension Employee Acc";"Pension Employee Acc")
                {
                    ApplicationArea = Basic;
                }
                field("Earnings and deductions";"Earnings and deductions")
                {
                    ApplicationArea = Basic;
                }
                field("Staff Benevolent";"Staff Benevolent")
                {
                    ApplicationArea = Basic;
                }
                field(SalaryExpenseAC;SalaryExpenseAC)
                {
                    ApplicationArea = Basic;
                }
                field("Directors Fee GL";"Directors Fee GL")
                {
                    ApplicationArea = Basic;
                }
                field("Staff Gratuity";"Staff Gratuity")
                {
                    ApplicationArea = Basic;
                }
                field("NHIF Employee Account";"NHIF Employee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Code";"Payroll Code")
                {
                    ApplicationArea = Basic;
                }
                field("Upload to Payroll";"Upload to Payroll")
                {
                    ApplicationArea = Basic;
                }
                field("PAYE Benefit A/C";"PAYE Benefit A/C")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

