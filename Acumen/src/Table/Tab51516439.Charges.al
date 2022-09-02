#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516439 "Charges"
{
    DrillDownPageID = "Front Office Charges";
    LookupPageID = "Front Office Charges";

    fields
    {
        field(1;"Code";Code[20])
        {
            NotBlank = true;
        }
        field(2;Description;Text[150])
        {
        }
        field(3;"Charge Amount";Decimal)
        {
        }
        field(5;"Percentage of Amount";Decimal)
        {

            trigger OnValidate()
            begin
                if "Percentage of Amount">100 then
                Error('You cannot exceed 100. Please enter a valid number.');
            end;
        }
        field(6;"Use Percentage";Boolean)
        {
        }
        field(7;"GL Account";Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(8;Minimum;Decimal)
        {

            trigger OnValidate()
            begin
                if Maximum<>0 then begin
                if Maximum<Minimum then
                Error('The maximum amount cannot be less than the minimum amount.');
                end;
            end;
        }
        field(9;Maximum;Decimal)
        {

            trigger OnValidate()
            begin
                if Minimum<>0 then begin
                if Minimum>Maximum then
                Error('The minimum amount cannot be more than the maximum amount.');
                end;
            end;
        }
        field(10;"Charge Type";Option)
        {
            OptionCaption = ' ,Loans,Special Advance,Discounting,Standing Order Fee,Failed Standing Order Fee,External Standing Order Fee,Cheque Book,Cheque Processing';
            OptionMembers = " ",Loans,"Special Advance",Discounting,"Standing Order Fee","Failed Standing Order Fee","External Standing Order Fee","Cheque Book","Cheque Processing";
        }
        field(11;"Sacco Amount";Decimal)
        {
        }
        field(12;"Bank Account";Code[20])
        {
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        TransactionCharges.Reset;
        TransactionCharges.SetFilter(TransactionCharges."Charge Code",Code);
        if TransactionCharges.Find('-') then begin
        TransactionCharges."Charge Code":=Code;
        TransactionCharges.Description:=Description;
        TransactionCharges."Charge Amount":="Charge Amount";
        TransactionCharges."Percentage of Amount":="Percentage of Amount";
        TransactionCharges."Use Percentage":="Use Percentage";
        TransactionCharges."G/L Account":="GL Account";
        TransactionCharges."Minimum Amount":=Minimum;
        TransactionCharges."Maximum Amount":=Maximum;
        TransactionCharges.Modify;
        end;
    end;

    var
        TransactionCharges: Record "Transaction Charges";
}

