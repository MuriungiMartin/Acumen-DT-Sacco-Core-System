#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516452 "Status Change Permision"
{

    fields
    {
        field(1;"User ID";Code[50])
        {
            Caption = 'User ID';
            NotBlank = true;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                //UserMgt.LookupUserID("Account No");
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit "User Management";
            begin
                //UserMgt.ValidateUserID("Account No");
            end;
        }
        field(2;"Function";Option)
        {
            NotBlank = false;
            OptionCaption = 'Account Status,Standing Order,Discounting Cheque,Inter Teller Approval,Discounting Loan,Fosa Loan Appraisal,Discounting Shares,Discounting Dividends,Loan External EFT,Overide Defaulters,BOSA Account Status,Fosa Loan Approval,PV Approval,PV Verify,PV Cancel,ATM Approval,Petty Cash Approval,Bosa Loan Approval,Bosa Loan Appraisal,Atm card ready,Audit Approval,Finance Approval,Replace Guarantors,Account Opening,Mpesa Change,Edit,NameEdit,Loan Reschedule,Substitute Gurantor,Smobile,SmobileApp';
            OptionMembers = "Account Status","Standing Order","Discounting Cheque","Inter Teller Approval","Discounting Loan","Fosa Loan Appraisal","Discounting Shares","Discounting Dividends","Loan External EFT","Overide Defaulters","BOSA Account Status","Fosa Loan Approval","PV Approval","PV Verify","PV Cancel","ATM Approval","Petty Cash Approval","Bosa Loan Approval","Bosa Loan Appraisal","Atm card ready","Audit Approval","Finance Approval","Replace Guarantors","Account Opening","Mpesa Change",Edit,NameEdit,"Loan Reschedule","Substitute Gurantor",Smobile,SmobileApp;
        }
    }

    keys
    {
        key(Key1;"Function","User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        UserMgt: Codeunit "User Setup Management";
}

