#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516630 "Member Agent Account Card"
{
    PageType = Card;
    SourceTable = "Member Agent Details";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Names;Names)
                {
                    ApplicationArea = Basic;
                }
                field("Agent Serial No";"Agent Serial No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Of Birth";"Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("Staff/Payroll";"Staff/Payroll")
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Designation;Designation)
                {
                    ApplicationArea = Basic;
                }
                field("Allowed Balance Enquiry";"Allowed Balance Enquiry")
                {
                    ApplicationArea = Basic;
                }
                field("Allowed  Correspondence";"Allowed  Correspondence")
                {
                    ApplicationArea = Basic;
                }
                field("Allowed FOSA Withdrawals";"Allowed FOSA Withdrawals")
                {
                    ApplicationArea = Basic;
                }
                field("Allowed Loan Processing";"Allowed Loan Processing")
                {
                    ApplicationArea = Basic;
                }
                field("Expiry Date";"Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA No.";"BOSA No.")
                {
                    ApplicationArea = Basic;
                }
                field("Email Address";"Email Address")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000006;"M_Agent Picture-Uploaded")
            {
                Caption = 'Agent Picture';
                SubPageLink = "Account No"=field("Account No");
            }
            part(Control1000000007;"M_Agent Signature-Uploaded")
            {
                Caption = 'Agent Signature';
                SubPageLink = "Account No"=field("Account No");
            }
        }
    }

    actions
    {
    }

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        //"Entry No":=10000+1;
    end;
}

