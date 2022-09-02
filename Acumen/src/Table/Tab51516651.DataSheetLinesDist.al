#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516651 "Data Sheet Lines-Dist"
{

    fields
    {
        field(1;"Payroll No";Code[30])
        {
        }
        field(2;"Member No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"ID Number";Code[15])
        {
        }
        field(6;Amount;Decimal)
        {
        }
        field(7;Employer;Text[50])
        {
            TableRelation = "Sacco Employers".Code;
        }
        field(8;Date;Date)
        {

            trigger OnValidate()
            begin
                 // Month:=CALCDATE('CM',Date);
                Month:= Date2dmy(Date,2);
                //MESSAGE('the current month is %1',Month);
                if Month=1 then
                "Payroll Month":='January'
                else if Month=2 then
                "Payroll Month":='FEBRUARY'
                else if Month=3 then
                "Payroll Month":='MARCH'
                else if Month=4 then
                "Payroll Month":='APRIL'
                else if Month=5 then
                "Payroll Month":='MAY'
                else if Month=6 then
                "Payroll Month":='JUNE'
                else if Month=7 then
                "Payroll Month":='JULY'
                else if Month=8 then
                "Payroll Month":='AUGUST'
                else if Month=9 then
                "Payroll Month":='SEPTEMBER'
                else if Month=10 then
                "Payroll Month":='OCTOBER'
                else if Month=11 then
                "Payroll Month":='NOVEMBER'
                else if Month=12 then
                "Payroll Month":='DECEMBER';
            end;
        }
        field(9;"Payroll Month";Code[30])
        {

            trigger OnValidate()
            begin
                 // Month:=CALCDATE('CM',Date);
                  //MESSAGE('the current month is %1',Month);
            end;
        }
        field(10;"Interest Amount";Decimal)
        {
        }
        field(11;"Approved Amount";Decimal)
        {
        }
        field(12;"Outstanding Balance";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Outstanding Interest";Decimal)
        {
        }
        field(14;"Principal Amount";Decimal)
        {
        }
        field(15;Period;Integer)
        {
        }
        field(16;Posted;Boolean)
        {
        }
        field(34;Name;Code[90])
        {
        }
        field(35;"Data Sheet Header";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(36;"Data Sheet Line";Integer)
        {
            AutoIncrement = false;
            DataClassification = ToBeClassified;
        }
        field(37;"Deposit Contribution";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(38;"Benevolent Contribution";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39;"Capital Reserve";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40;"Expected Principal Balance";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(41;"FOSA Contribution";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(42;"Transaction Type";Option)
        {
            OptionCaption = ' ,Registration Fee,Share Capital,Interest Paid,Loan Repayment,Deposit Contribution,Insurance Contribution,Benevolent Fund,Loan,Unallocated Funds,Dividend,FOSA Account,Loan Insurance Charged,Loan Insurance Paid,Recovery Account,FOSA Shares,Additional Shares,Interest Due,Capital Reserve';
            OptionMembers = " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Capital Reserve";
        }
        field(43;"Loan Product Type";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Products Setup".Code;
        }
        field(44;"Entry No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(45;"Special Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(46;Installments;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(47;"Interest Due";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(48;"Deduction type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Deduction,Update';
            OptionMembers = Deduction,Balance;
        }
        field(49;"Transaction Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50;"Advice Id";Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Payroll No","Special Code","Entry No","Data Sheet Header")
        {
            Clustered = true;
        }
        key(Key2;"Loan Product Type","Transaction Type")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Month: Integer;
        StatusPermissions: Record "Status Change Permision";
        Cust: Record "Member Register";
        PTEN: Code[20];
        Date2: Date;
}

