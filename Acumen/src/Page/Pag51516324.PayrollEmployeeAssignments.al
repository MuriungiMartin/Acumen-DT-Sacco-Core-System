#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516324 "Payroll Employee Assignments."
{
    DeleteAllowed = false;
    InsertAllowed = false;
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
                }
                field(Surname;Surname)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Firstname;Firstname)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Lastname;Lastname)
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
                field(Secondary;Secondary)
                {
                    ApplicationArea = Basic;
                }
            }
            group(Numbers)
            {
                field("National ID No";"National ID No")
                {
                    ApplicationArea = Basic;
                }
                field("PIN No";"PIN No")
                {
                    ApplicationArea = Basic;
                }
                field("NHIF No";"NHIF No")
                {
                    ApplicationArea = Basic;
                }
                field("NSSF No";"NSSF No")
                {
                    ApplicationArea = Basic;
                }
            }
            group("PAYE Relief and Benefit")
            {
                field(GetsPayeRelief;GetsPayeRelief)
                {
                    ApplicationArea = Basic;
                }
                field(GetsPayeBenefit;GetsPayeBenefit)
                {
                    ApplicationArea = Basic;
                }
                field(PayeBenefitPercent;PayeBenefitPercent)
                {
                    ApplicationArea = Basic;
                }
            }
            group("Employee Company")
            {
                field(Company;Company)
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

