#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516479 "Loan Guarantors FOSA"
{
    PageType = ListPart;
    SourceTable = "Loan GuarantorsFOSA";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No.";"Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Names;Names)
                {
                    ApplicationArea = Basic;
                }
                field("Staff/Payroll No.";"Staff/Payroll No.")
                {
                    ApplicationArea = Basic;
                }
                field("Current Shares";"Current Shares")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount Guaranted";"Amount Guaranted")
                {
                    ApplicationArea = Basic;
                }
                field(Substituted;Substituted)
                {
                    ApplicationArea = Basic;
                }
                field("Line No";"Line No")
                {
                    ApplicationArea = Basic;
                }
                field(Date;Date)
                {
                    ApplicationArea = Basic;
                }
                field("Self Guarantee";"Self Guarantee")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No";"Loan No")
                {
                    ApplicationArea = Basic;
                }
                field(Salaried;Salaried)
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

