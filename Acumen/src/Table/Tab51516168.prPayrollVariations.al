#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516168 "prPayroll Variations"
{

    fields
    {
        field(1;"Employee Code";Code[30])
        {
            TableRelation = "HR Employees"."No." where (Status=filter(Normal|Pension));

            trigger OnValidate()
            begin
                "Employee Names":='';
                if "Employee Code" <> '' then begin
                if SalaryCard.Get("Employee Code") = false then
                Error('You must enter employee salary details first. Employee Code: %1',"Employee Code");

                if HREmployee.Get("Employee Code") then begin
                "Employee Names":=HREmployee."First Name" + ' ' + HREmployee."Middle Name" + ' ' + HREmployee."Last Name";

                end;
                end;
            end;
        }
        field(2;"Transaction Code";Code[30])
        {
            TableRelation = "prTransaction Codes"."Transaction Code";

            trigger OnValidate()
            begin
                /*IF Transcode.GET("Transaction Code") THEN BEGIN
                IF Transcode."Leave Allowance" = TRUE THEN BEGIN
                EmployeeTrans.RESET;
                EmployeeTrans.SETRANGE(EmployeeTrans."Employee Code","Employee Code");
                EmployeeTrans.SETRANGE(EmployeeTrans."Transaction Code","Transaction Code");
                IF EmployeeTrans.FIND('-') THEN BEGIN
                REPEAT
                IF EmployeeTrans."Period Year" = "Period Year" THEN
                MonthName:=FORMAT(EmployeeTrans."Payroll Period",0,'<Month Text>');
                //ERROR(MonthName);
                ERROR('Employee has already been paid leave allowance in the period of %1. - %2',EmployeeTrans."Payroll Period",
                       "Employee Code");
                UNTIL EmployeeTrans.NEXT = 0;
                END;
                END;
                END;
                   */
                
                if Transcode.Get("Transaction Code") then
                  "Transaction Name":=Transcode."Transaction Name";
                  Frequency:=Transcode.Frequency;
                  "Payroll Period":=SelectedPeriod;
                  "Period Month":=PeriodMonth;
                  "Period Year":=PeriodYear;
                   "Transaction Type":=Transcode."Transaction Type";

            end;
        }
        field(3;"Transaction Name";Text[100])
        {
        }
        field(4;Amount;Decimal)
        {

            trigger OnValidate()
            begin
                if (Balance > 0) and (Amount > 0) then
                "#of Repayments":=Balance/Amount;
            end;
        }
        field(5;Balance;Decimal)
        {

            trigger OnValidate()
            begin
                if (Balance > 0) and (Amount > 0) and ("#of Repayments" = 0) then
                "#of Repayments":=Balance/Amount;

                if (Balance > 0) and ("#of Repayments" > 0) then
                Amount:=Balance/"#of Repayments";
            end;
        }
        field(6;"Original Amount";Decimal)
        {
        }
        field(7;"Period Month";Integer)
        {
        }
        field(8;"Period Year";Integer)
        {
        }
        field(9;"Payroll Period";Date)
        {
            TableRelation = "prPayroll Periods"."Date Opened";
        }
        field(10;"#of Repayments";Integer)
        {

            trigger OnValidate()
            begin
                if (Balance > 0) and ("#of Repayments" > 0) then
                Amount:=Balance/"#of Repayments"
            end;
        }
        field(11;Membership;Code[10])
        {
            TableRelation = "prInstitutional Membership"."Institution No";
        }
        field(12;"Reference No";Text[100])
        {
        }
        field(13;integera;Integer)
        {
        }
        field(14;"Employer Amount";Decimal)
        {
        }
        field(15;"Employer Balance";Decimal)
        {
        }
        field(16;"Stop for Next Period";Boolean)
        {
        }
        field(17;"Amortized Loan Total Repay Amt";Decimal)
        {
        }
        field(18;"Start Date";Date)
        {
        }
        field(19;"End Date";Date)
        {
        }
        field(20;"Loan Number";Code[10])
        {
        }
        field(21;"Payroll Code";Code[20])
        {
            TableRelation = "prPayroll Type";
        }
        field(22;"No of Units";Decimal)
        {
        }
        field(23;Suspended;Boolean)
        {
        }
        field(24;"Employee Names";Text[200])
        {
        }
        field(25;"Transaction Type";Option)
        {
            Description = 'Income,Deduction';
            OptionMembers = Income,Deduction;
        }
        field(26;Frequency;Option)
        {
            Description = 'Fixed,Varied';
            OptionMembers = "Fixed",Varied;
        }
        field(27;Processed;Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Transaction Type","Employee Code","Transaction Code","Reference No","Period Month","Period Year","Payroll Period")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    var
        Transcode: Record UnknownRecord55507;
        EmployeeTrans: Record UnknownRecord55516;
        MonthName: Text[100];
        HREmployee: Record "HR Employees";
        SalaryCard: Record UnknownRecord55530;
        SalCard: Record UnknownRecord55530;
        SalaryNotches: Record "HR Salary Notch";
        SelectedPeriod: Date;
        objPeriod: Record UnknownRecord55506;
        PeriodName: Text[30];
        PeriodTrans: Record UnknownRecord55517;
        PeriodMonth: Integer;
        PeriodYear: Integer;
}

