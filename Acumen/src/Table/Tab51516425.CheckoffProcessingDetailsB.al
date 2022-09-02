#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516425 "Checkoff Processing Details(B)"
{

    fields
    {
        field(1;"Check Off No";Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Data Sheet Checkoff".Code;
        }
        field(2;"Check Off Advice No";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Check Off Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Member No";Code[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                ObjMembers.Reset;
                ObjMembers.SetRange("No.","Member No");
                if ObjMembers.Find('-') then
                  begin
                    ObjMembers.CalcFields("Current Shares");
                    if "Transaction Type"="transaction type"::"Deposit Contribution" then
                    "Outstanding Balance":=ObjMembers."Current Shares";
                  end
            end;
        }
        field(5;"Transaction Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Interest Paid,Loan Repayment,Deposit Contribution,Benevolent Fund,Share Capital,Capital Reserve,FOSA Savings,Unallocated Funds';
            OptionMembers = " ","Interest Paid","Loan Repayment","Deposit Contribution","Benevolent Fund","Share Capital","Capital Reserve","FOSA Savings","Unallocated Funds";
        }
        field(6;"Loan Product";Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Products Setup".Code;
        }
        field(7;"Loan No";Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ObjLoans.Get("Loan No") then begin
                  ObjLoans.SetFilter("Date filter",'..'+Format("Check Off Date"));
                  ObjLoans.CalcFields("Outstanding Balance","Oustanding Interest");
                  "Loan Product":=ObjLoans."Loan Product Type";
                  if "Transaction Type"="transaction type"::"Loan Repayment" then
                  "Outstanding Balance":=ObjLoans."Outstanding Balance";
                end;
            end;
        }
        field(8;Amount;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Outstanding Balance";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Outstanding Interest";Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Check Off No","Member No","Transaction Type","Loan No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ObjLoans: Record "Loans Register";
        ObjMembers: Record "Member Register";
}

