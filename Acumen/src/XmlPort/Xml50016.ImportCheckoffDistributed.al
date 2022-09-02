#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
XmlPort 50016 "Import Checkoff Distributed"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("CheckoffLinesDistributed poly";"CheckoffLinesDistributed poly")
            {
                XmlName = 'Paybill';
                fieldelement(entry;"CheckoffLinesDistributed poly"."Entry No")
                {
                }
                fieldelement(Header_No;"CheckoffLinesDistributed poly"."Receipt Header No")
                {
                }
                fieldelement(Personal_No;"CheckoffLinesDistributed poly"."Staff/Payroll No")
                {
                }
                fieldelement(dep;"CheckoffLinesDistributed poly"."Deposit Contribution")
                {
                }
                fieldelement(share;"CheckoffLinesDistributed poly"."Share Capital")
                {
                }
                fieldelement(devp;"CheckoffLinesDistributed poly"."DEVELOPMENT LOAN Principal")
                {
                }
                fieldelement(devi;"CheckoffLinesDistributed poly"."DEVELOPMENT LOAN Int")
                {
                }
                fieldelement(carp;"CheckoffLinesDistributed poly"."Car loan Staff LOAN Principal")
                {
                }
                fieldelement(cari;"CheckoffLinesDistributed poly"."Car loan Staff LOAN Int")
                {
                }
                fieldelement(divp;"CheckoffLinesDistributed poly"."Dividend AdvanceLOAN Principal")
                {
                }
                fieldelement(divi;"CheckoffLinesDistributed poly"."Dividend Advance LOAN Int")
                {
                }
                fieldelement(mobp;"CheckoffLinesDistributed poly"."Mobile Loan Princilal")
                {
                }
                fieldelement(mobi;"CheckoffLinesDistributed poly"."Mobile Loan Int")
                {
                }
                fieldelement(inup;"CheckoffLinesDistributed poly"."Inuka Loan Principal")
                {
                }
                fieldelement(inui;"CheckoffLinesDistributed poly"."Inuka Loan Int")
                {
                }
                fieldelement(emep;"CheckoffLinesDistributed poly"."EMERGENCY LOAN Principal")
                {
                }
                fieldelement(emei;"CheckoffLinesDistributed poly"."EMERGENCY LOAN Int")
                {
                }
                fieldelement(jsp;"CheckoffLinesDistributed poly"."J-SORT LOAN Principal")
                {
                }
                fieldelement(jsi;"CheckoffLinesDistributed poly"."J-SORT LOAN Int")
                {
                }
                fieldelement(stp;"CheckoffLinesDistributed poly"."Staff Morgage Principal")
                {
                }
                fieldelement(stffi;"CheckoffLinesDistributed poly"."Staff Morgage Int")
                {
                }
                fieldelement(sal1p;"CheckoffLinesDistributed poly"."SALARY ADVANCE Principal")
                {
                }
                fieldelement(sal1i;"CheckoffLinesDistributed poly"."SALARY ADVANCE Int")
                {
                }
                fieldelement(sal2p;"CheckoffLinesDistributed poly"."Salary Advance PLUS Principal")
                {
                }
                fieldelement(sal2i;"CheckoffLinesDistributed poly"."Salary Advance PLUS Int")
                {
                }
                fieldelement(samp;"CheckoffLinesDistributed poly"."Sambaza Loan Principal")
                {
                }
                fieldelement(sami;"CheckoffLinesDistributed poly"."Sambaza Loan Int")
                {
                }
                fieldelement(schp;"CheckoffLinesDistributed poly"."School Fees Principal")
                {
                }
                fieldelement(schi;"CheckoffLinesDistributed poly"."School Fees Int")
                {
                }

                trigger OnAfterInsertRecord()
                var
                    MembershipExist: Record "Membership Exit";
                    MemberRegister: Record "Member Register";
                begin
                    MembershipExist.Reset;
                    MembershipExist.SetRange(MembershipExist."Member No.",MemberRegister."No.");
                    if MembershipExist.Find('-') then
                      currXMLport.Skip;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

