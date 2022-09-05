#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516417 "Data Sheet Main"
{

    fields
    {
        field(1; "PF/Staff No"; Code[30])
        {
        }
        field(2; Name; Code[90])
        {
        }
        field(3; "ID NO."; Code[15])
        {
        }
        field(4; "Type of Deduction"; Code[30])
        {
        }
        field(5; "Amount ON"; Decimal)
        {

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetCurrentkey(Cust."Personal No");
                Cust.SetRange(Cust."Personal No", "PF/Staff No");
                Cust.SetRange(Cust."ID No.", "ID NO.");
                if Cust.Find('-') then begin
                    Name := Cust.Name;
                    "ID NO." := Cust."ID No.";
                    "REF." := '2026';
                    Employer := Cust."Employer Code";
                    Date2 := Today + 30;
                    Date := Today;
                    "Repayment Method" := Cust."Repayment Method";
                    "Payroll Month" := Format(Date2dmy(Date2, 2)) + '/' + Format(Date2dmy(Date2, 3));
                end;

                PTEN := '';

                if StrLen("PF/Staff No") = 10 then begin
                    PTEN := CopyStr("PF/Staff No", 10);
                end else
                    if StrLen("PF/Staff No") = 9 then begin
                        PTEN := CopyStr("PF/Staff No", 9);
                    end else
                        if StrLen("PF/Staff No") = 8 then begin
                            PTEN := CopyStr("PF/Staff No", 8);
                        end else
                            if StrLen("PF/Staff No") = 7 then begin
                                PTEN := CopyStr("PF/Staff No", 7);
                            end else
                                if StrLen("PF/Staff No") = 6 then begin
                                    PTEN := CopyStr("PF/Staff No", 6);
                                end else
                                    if StrLen("PF/Staff No") = 5 then begin
                                        PTEN := CopyStr("PF/Staff No", 5);
                                    end else
                                        if StrLen("PF/Staff No") = 4 then begin
                                            PTEN := CopyStr("PF/Staff No", 4);
                                        end else
                                            if StrLen("PF/Staff No") = 3 then begin
                                                PTEN := CopyStr("PF/Staff No", 3);
                                            end else
                                                if StrLen("PF/Staff No") = 2 then begin
                                                    PTEN := CopyStr("PF/Staff No", 2);
                                                end else
                                                    if StrLen("PF/Staff No") = 1 then begin
                                                        PTEN := CopyStr("PF/Staff No", 1);
                                                    end;

                "Sort Code" := PTEN;


                /*IF LoanTypes.GET(LoanTopUp."Loan Type") THEN BEGIN
                IF customer.GET(LoanTopUp."Client Code") THEN BEGIN
                //Loans."Staff No":=customer."Payroll/Staff No";
                DataSheet.INIT;
                DataSheet."PF/Staff No":=LoanTopUp."Staff No";
                DataSheet."Type of Deduction":=LoanTypes."Product Description";
                DataSheet."Remark/LoanNO":=LoanTopUp."Loan Top Up";
                DataSheet.Name:=LoanApps."Client Name";
                DataSheet."ID NO.":=LoanApps."ID NO";
                DataSheet."Amount ON":=0;
                DataSheet."Amount OFF":=LoanTopUp."Total Top Up";
                DataSheet."REF.":='2026';
                DataSheet."New Balance":=0;
                DataSheet.Date:=Loans."Issued Date";
                DataSheet.Employer:=customer."Employer Code";
                DataSheet."Transaction Type":=DataSheet."Transaction Type"::ADJUSTMENT;
                DataSheet."Sort Code":=PTEN;
                DataSheet.INSERT;
                END;
                END; */

            end;
        }
        field(6; "Amount OFF"; Decimal)
        {

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetCurrentkey(Cust."Personal No");
                Cust.SetRange(Cust."Personal No", "PF/Staff No");
                Cust.SetRange(Cust."ID No.", "ID NO.");
                if Cust.Find('-') then begin
                    Name := Cust.Name;
                    "ID NO." := Cust."ID No.";
                    "REF." := '2026';
                    Employer := Cust."Employer Code";
                    Date2 := Today + 30;
                    Date := Today;
                    "Payroll Month" := Format(Date2dmy(Date2, 2)) + '/' + Format(Date2dmy(Date2, 3));
                end;

                PTEN := '';

                if StrLen("PF/Staff No") = 10 then begin
                    PTEN := CopyStr("PF/Staff No", 10);
                end else
                    if StrLen("PF/Staff No") = 9 then begin
                        PTEN := CopyStr("PF/Staff No", 9);
                    end else
                        if StrLen("PF/Staff No") = 8 then begin
                            PTEN := CopyStr("PF/Staff No", 8);
                        end else
                            if StrLen("PF/Staff No") = 7 then begin
                                PTEN := CopyStr("PF/Staff No", 7);
                            end else
                                if StrLen("PF/Staff No") = 6 then begin
                                    PTEN := CopyStr("PF/Staff No", 6);
                                end else
                                    if StrLen("PF/Staff No") = 5 then begin
                                        PTEN := CopyStr("PF/Staff No", 5);
                                    end else
                                        if StrLen("PF/Staff No") = 4 then begin
                                            PTEN := CopyStr("PF/Staff No", 4);
                                        end else
                                            if StrLen("PF/Staff No") = 3 then begin
                                                PTEN := CopyStr("PF/Staff No", 3);
                                            end else
                                                if StrLen("PF/Staff No") = 2 then begin
                                                    PTEN := CopyStr("PF/Staff No", 2);
                                                end else
                                                    if StrLen("PF/Staff No") = 1 then begin
                                                        PTEN := CopyStr("PF/Staff No", 1);
                                                    end;

                "Sort Code" := PTEN;
            end;
        }
        field(7; "New Balance"; Decimal)
        {
        }
        field(8; "REF."; Code[10])
        {
        }
        field(9; "Remark/LoanNO"; Text[30])
        {
            // TableRelation = test.No where(Field68093 = field("ID NO."));
            // ValidateTableRelation = false;
        }
        field(10; "Sort Code"; Code[2])
        {
        }
        field(11; Employer; Text[50])
        {
            TableRelation = "Sacco Employers".Code;
        }
        field(12; "Transaction Type"; Option)
        {
            OptionCaption = 'FRESH FEED,ADJUSTMENT,ADJUSTMENT LOAN';
            OptionMembers = "FRESH FEED",ADJUSTMENT,"ADJUSTMENT LOAN";

            trigger OnValidate()
            begin
                if "Transaction Type" = "transaction type"::ADJUSTMENT then begin
                    Source := Source::BOSA;
                end;
            end;
        }
        field(13; Date; Date)
        {

            trigger OnValidate()
            begin
                // Month:=CALCDATE('CM',Date);
                Month := Date2dmy(Date, 2);
                //MESSAGE('the current month is %1',Month);
                if Month = 1 then
                    "Payroll Month" := 'January'
                else
                    if Month = 2 then
                        "Payroll Month" := 'FEBRUARY'
                    else
                        if Month = 3 then
                            "Payroll Month" := 'MARCH'
                        else
                            if Month = 4 then
                                "Payroll Month" := 'APRIL'
                            else
                                if Month = 5 then
                                    "Payroll Month" := 'MAY'
                                else
                                    if Month = 6 then
                                        "Payroll Month" := 'JUNE'
                                    else
                                        if Month = 7 then
                                            "Payroll Month" := 'JULY'
                                        else
                                            if Month = 8 then
                                                "Payroll Month" := 'AUGUST'
                                            else
                                                if Month = 9 then
                                                    "Payroll Month" := 'SEPTEMBER'
                                                else
                                                    if Month = 10 then
                                                        "Payroll Month" := 'OCTOBER'
                                                    else
                                                        if Month = 11 then
                                                            "Payroll Month" := 'NOVEMBER'
                                                        else
                                                            if Month = 12 then
                                                                "Payroll Month" := 'DECEMBER';
            end;
        }
        field(14; "Payroll Month"; Code[30])
        {

            trigger OnValidate()
            begin
                // Month:=CALCDATE('CM',Date);
                //MESSAGE('the current month is %1',Month);
            end;
        }
        field(15; "Interest Amount"; Decimal)
        {
        }
        field(16; "Approved Amount"; Decimal)
        {
        }
        field(17; "Uploaded Interest"; Decimal)
        {
        }
        field(18; "Batch No."; Code[30])
        {
        }
        field(19; "Principal Amount"; Decimal)
        {
        }
        field(20; UploadInt; Decimal)
        {
            CalcFormula = sum("Loan Interest Variance Schedu"."Monthly Interest" where("Loan No." = field("Remark/LoanNO")));
            FieldClass = FlowField;
        }
        field(21; Source; Option)
        {
            OptionCaption = 'BOSA,FOSA';
            OptionMembers = BOSA,FOSA;
        }
        field(22; "Code"; Code[30])
        {
        }
        field(23; "Shares OFF"; Decimal)
        {
        }
        field(24; "Adjustment Type"; Option)
        {
            OptionCaption = ' ,Additional Loan,BELA Loan,Benevolent Fund,Defaulters Loan,Emergency Loan,Entrance Fee,Jitegemee Loan,Normal Loan,School Fee Loan,Shares,Lariba loan,Chipukizi Loan';
            OptionMembers = " ","Additional Loan","BELA Loan","Benevolent Fund","Defaulters Loan","Emergency Loan","Entrance Fee","Jitegemee Loan","Normal Loan","School Fee Loan",Shares,"Lariba loan","Chipukizi Loan";

            trigger OnValidate()
            begin

                if "Adjustment Type" = "adjustment type"::" " then begin

                end else
                    if "Adjustment Type" = "adjustment type"::"Additional Loan" then begin
                        "Type of Deduction" := 'ADDITIONAL LOAN';
                    end else
                        if "Adjustment Type" = "adjustment type"::"BELA Loan" then begin
                            "Type of Deduction" := 'BELA LOAN';
                        end else
                            if "Adjustment Type" = "adjustment type"::"Benevolent Fund" then begin
                                "Type of Deduction" := 'Benevolent Fund';
                            end else
                                if "Adjustment Type" = "adjustment type"::"Defaulters Loan" then begin
                                    "Type of Deduction" := 'Defaulters Loan';
                                end else
                                    if "Adjustment Type" = "adjustment type"::"Emergency Loan" then begin
                                        "Type of Deduction" := 'Emergency Loan';
                                    end else
                                        if "Adjustment Type" = "adjustment type"::"Entrance Fee" then begin
                                            "Type of Deduction" := 'Entrance Fee';
                                        end else
                                            if "Adjustment Type" = "adjustment type"::"Jitegemee Loan" then begin
                                                "Type of Deduction" := 'Jitegemee Loan';
                                            end else
                                                if "Adjustment Type" = "adjustment type"::"Normal Loan" then begin
                                                    "Type of Deduction" := 'Normal Loan';
                                                end else
                                                    if "Adjustment Type" = "adjustment type"::"School Fee Loan" then begin
                                                        "Type of Deduction" := 'School Fee Loan';
                                                    end else
                                                        if "Adjustment Type" = "adjustment type"::Shares then begin
                                                            "Type of Deduction" := 'shares';
                                                        end else
                                                            if "Adjustment Type" = "adjustment type"::"Lariba loan" then begin
                                                                "Type of Deduction" := 'Lariba Loan';
                                                            end else
                                                                if "Adjustment Type" = "adjustment type"::"Chipukizi Loan" then begin
                                                                    "Type of Deduction" := 'Chipukizi Loan';


                                                                end;
            end;
        }
        field(25; Period; Integer)
        {
        }
        field(26; "aMOUNT ON 1"; Decimal)
        {
        }
        field(27; "Vote Code"; Code[10])
        {
        }
        field(28; EDCode; Code[10])
        {
        }
        field(29; "Current Balance"; Decimal)
        {
        }
        field(30; TranType; Decimal)
        {
        }
        field(31; TranName; Text[30])
        {
        }
        field(32; "Action"; Option)
        {
            OptionCaption = 'Existing Loan,New Loan';
            OptionMembers = "Existing Loan","New Loan";
        }
        field(33; "Interest Fee"; Option)
        {
            OptionCaption = 'Interest,Interest Free';
            OptionMembers = Interest,"Interest Free";
        }
        field(34; Recoveries; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry".Amount where("Loan No" = field("Remark/LoanNO"),
                                                                  "Transaction Type" = filter("Interest Paid"),
                                                                  "Posting Date" = field(Date)));
            FieldClass = FlowField;
        }
        field(35; "Date Filter"; Date)
        {
        }
        field(36; "Interest Off"; Decimal)
        {
        }
        field(69023; "Repayment Method"; Option)
        {
            OptionMembers = " ",Amortised,"Reducing Balance","Straight Line",Constants,"Ukulima Flat";
        }
    }

    keys
    {
        key(Key1; "PF/Staff No", "Type of Deduction", "Remark/LoanNO")
        {
            Clustered = true;
            SumIndexFields = "Amount ON";
        }
        key(Key2; "Sort Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Month: Integer;
        StatusPermissions: Record "Status Change Permision";
        Cust: Record Customer;
        PTEN: Code[20];
        Date2: Date;
}

