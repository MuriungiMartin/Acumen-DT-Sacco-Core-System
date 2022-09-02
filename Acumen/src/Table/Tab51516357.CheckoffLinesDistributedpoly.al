#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516357 "CheckoffLinesDistributed poly"
{

    fields
    {
        field(1;"Staff/Payroll No";Code[20])
        {
        }
        field(2;Amount;Decimal)
        {
            Enabled = true;
        }
        field(3;"No Repayment";Boolean)
        {
            Enabled = false;
        }
        field(4;"Staff Not Found";Boolean)
        {
        }
        field(5;"Date Filter";Date)
        {
            FieldClass = FlowFilter;
        }
        field(6;"Transaction Date";Date)
        {
        }
        field(7;"Entry No";Integer)
        {
        }
        field(8;Generated;Boolean)
        {
        }
        field(9;"Payment No";Integer)
        {
        }
        field(10;Posted;Boolean)
        {
        }
        field(11;"Multiple Receipts";Boolean)
        {
        }
        field(12;Name;Text[200])
        {
        }
        field(13;"Early Remitances";Boolean)
        {
        }
        field(14;"Early Remitance Amount";Decimal)
        {
        }
        field(15;"Loan No.";Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where ("Client Code"=field("Member No."),
                                                                "Outstanding Balance"=filter(<>0));
        }
        field(16;"Member No.";Code[20])
        {
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.","Member No.");
                if Cust.Find('-') then begin
                Name:=Cust.Name;
                end;
            end;
        }
        field(17;Interest;Decimal)
        {
        }
        field(18;"Loan Type";Code[30])
        {
        }
        field(19;DEPT;Code[10])
        {
        }
        field(20;"Expected Amount";Decimal)
        {
        }
        field(21;"FOSA Account";Code[20])
        {
        }
        field(22;"Trans Type";Code[20])
        {
        }
        field(23;"Transaction Type";Option)
        {
            OptionCaption = ' ,Registration Fee,Share Capital,Interest Paid,Loan Repayment,Deposit Contribution,Insurance Contribution,Benevolent Fund,Loan,Unallocated Funds,Dividend,FOSA Account,Loan Insurance Charged,Loan Insurance Paid,Recovery Account,FOSA Shares,Additional Shares,Interest Due,Capital Reserve';
            OptionMembers = " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Capital Reserve";
        }
        field(24;"Special Code";Code[50])
        {
        }
        field(25;"Account type";Code[10])
        {
        }
        field(26;Variance;Decimal)
        {
        }
        field(27;"Employer Code";Code[10])
        {
        }
        field(28;GPersonalNo;Code[10])
        {
        }
        field(29;Gnames;Text[80])
        {
        }
        field(30;Gnumber;Code[10])
        {
        }
        field(31;Userid1;Code[25])
        {
        }
        field(32;"Loans Not found";Boolean)
        {
        }
        field(33;"Receipt Header No";Code[20])
        {
            TableRelation = "CheckoffHeader-Distribut poly".No;
        }
        field(34;Source;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,BOSA,FOSA,MICRO';
            OptionMembers = " ",BOSA,FOSA,MICRO;
        }
        field(35;"Advice Number";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(36;"DEVELOPMENT LOAN Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(37;"DEVELOPMENT LOAN Principal";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(38;"DEVELOPMENT LOAN Int";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39;"Car loan Staff Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40;"Car loan Staff LOAN Principal";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(41;"Car loan Staff LOAN Int";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(42;"Dividend Advance LOAN Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(43;"Dividend AdvanceLOAN Principal";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(44;"Dividend Advance LOAN Int";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(45;"Mobile Loan Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(46;"Mobile Loan Princilal";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(47;"Mobile Loan Int";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(48;"Inuka Loan Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(49;"Inuka Loan Principal";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50;"Inuka Loan Int";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51;"EMERGENCY LOAN Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52;"EMERGENCY LOAN Principal";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53;"EMERGENCY LOAN Int";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54;"J-SORT LOAN Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55;"J-SORT LOAN Principal";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(56;"J-SORT LOAN Int";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(57;"Staff Morgage Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(58;"Staff Morgage Principal";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(59;"Staff Morgage Int";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60;"SALARY ADVANCE Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(61;"SALARY ADVANCE Principal";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(62;"SALARY ADVANCE Int";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63;"Salary Advance PLUS Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(64;"Salary Advance PLUS Principal";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(65;"Salary Advance PLUS Int";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(66;"Sambaza Loan Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(67;"Sambaza Loan Principal";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(68;"Sambaza Loan Int";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(84;"Deposit Contribution";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(85;"Share Capital";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(86;"Welfare contribution";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(87;"Not Found Ln Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(88;Id;Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(89;"Header No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(90;"Utility Type";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(106;"Insurance Fee";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(107;"Benevolent Fund";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(108;"Registration Fee";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(109;"DEVELOPMENT LOAN NO.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(110;"DEVELOPMENT LOAN TOTAL";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(111;"Car loan Staff LOAN Total";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(112;"Car loan Staff LOAN No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(113;"Dividend Advance LOAN Total";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(114;"Dividend Advance LOAN No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(115;"Mobile Loan Total";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(116;"Mobile Loan No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(117;"Inuka Loan Total";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(118;"Inuka Loan No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(119;"EMERGENCY LOAN Total";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(120;"EMERGENCY LOAN No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(121;"J-SORT LOAN Total";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(122;"J-SORT LOAN No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(123;"Staff Morgage Total";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(124;"Staff Morgage No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(125;"SALARY ADVANCE Total";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(126;"SALARY ADVANCE No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(127;"Salary Advance PLUS Total";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(128;"Salary Advance PLUS No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(129;"Sambaza Loan Total";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(130;"Sambaza Loan No.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(131;"School Fees amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(132;"School Fees Principal";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(133;"School Fees Int";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(134;"School Fees Total";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(135;"School Fees No.";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(136;"Deposit Contribution Total";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(137;"Share Capital total";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(138;"Welfare contribution total";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(139;"Insurance Fee Total";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(140;"Benevolent Fund Total";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(141;"Registration Fee Total";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(142;"School Fees Loan no.";Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Receipt Header No","Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record "Member Register";
}

