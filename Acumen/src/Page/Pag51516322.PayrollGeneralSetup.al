#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516322 "Payroll General Setup."
{
    PageType = Card;
    SourceTable = "Payroll General Setup.";

    layout
    {
        area(content)
        {
            group(Relief)
            {
                field("Tax Relief";"Tax Relief")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Relief";"Insurance Relief")
                {
                    ApplicationArea = Basic;
                }
                field("Max Relief";"Max Relief")
                {
                    ApplicationArea = Basic;
                }
                field("Mortgage Relief";"Mortgage Relief")
                {
                    ApplicationArea = Basic;
                }
            }
            group(NHIF)
            {
                field("NHIF Based on";"NHIF Based on")
                {
                    ApplicationArea = Basic;
                }
            }
            group(NSSF)
            {
                field("NSSF Employee";"NSSF Employee")
                {
                    ApplicationArea = Basic;
                }
                field("NSSF Employer Factor";"NSSF Employer Factor")
                {
                    ApplicationArea = Basic;
                }
                field("NSSF Based on";"NSSF Based on")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Pension)
            {
                field("Max Pension Contribution";"Max Pension Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Tax On Excess Pension";"Tax On Excess Pension")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Staff Loan")
            {
                field("Loan Market Rate";"Loan Market Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Corporate Rate";"Loan Corporate Rate")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Mortgage)
            {
            }
            group("Owner Occupier Interest")
            {
                field("OOI Deduction";"OOI Deduction")
                {
                    ApplicationArea = Basic;
                }
                field("OOI December";"OOI December")
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

