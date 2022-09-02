#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516387 "Loans Guarantee Details"
{
    PageType = ListPart;
    RefreshOnActivate = false;
    SourceTable = "Loans Guarantee Details";
    SourceTableView = where(Substituted=filter(false));

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Loan No";"Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account No.';
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Balance";"Loan Balance")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Shares;Shares)
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Amont Guaranteed";"Amont Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field("Free Shares";"Free Shares")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Self Guarantee";"Self Guarantee")
                {
                    ApplicationArea = Basic;
                }
                field(Substituted;Substituted)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        /*IF Substituted=TRUE THEN BEGIN
                        ERROR('You Can no Unsubstitute a Substituted Guarantor');
                        END;
                        IF Substituted=FALSE THEN BEGIN
                        Date:=TODAY;
                        TESTFIELD("Substituted Guarantor");
                        END;  */
                        /*
                        StatusPermissions.RESET;
                        StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
                        StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::);
                        IF StatusPermissions.FIND('-') = FALSE THEN
                        ERROR('You do not have permissions to Reschedule Loans.');
                           */

                    end;
                }
                field(Date;Date)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Code";"Employer Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Employer Name";"Employer Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Substituted Guarantor";"Substituted Guarantor")
                {
                    ApplicationArea = Basic;
                }
                field("Share capital";"Share capital")
                {
                    ApplicationArea = Basic;
                    Caption = 'Substitute Name';
                    Editable = false;
                }
                field("TotalLoan Guaranteed";"TotalLoan Guaranteed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Substitute Shares';
                }
                field("Loanees  No";"Loanees  No")
                {
                    ApplicationArea = Basic;
                }
                field("Loanees  Name";"Loanees  Name")
                {
                    ApplicationArea = Basic;
                }
                field("No Of Loans Guaranteed";"No Of Loans Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field(CStatus;CStatus)
                {
                    ApplicationArea = Basic;
                    Caption = 'Status';
                    Editable = false;
                }
                field("Outstanding Balance";"Outstanding Balance")
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
        /*//**Prevent modification of approved entries
        LoanApps.RESET;
        LoanApps.SETRANGE(LoanApps."Loan  No.","Loan No");
        IF LoanApps.FIND('-') THEN BEGIN
         IF LoanApps."Loan Status"=LoanApps."Loan Status"::Approved THEN BEGIN
          CurrPage.EDITABLE:=FALSE;
         END ELSE
          CurrPage.EDITABLE:=TRUE;
        END;
        */

    end;

    var
        Cust: Record "Member Register";
        EmployeeCode: Code[20];
        CStatus: Option Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawal,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member","New (Pending Confirmation)","Defaulter Recovery";
        LoanApps: Record "Loans Register";
        StatusPermissions: Record "Status Change Permision";
}

