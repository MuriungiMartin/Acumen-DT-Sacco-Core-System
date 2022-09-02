#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 55476 "Register Management"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        RegisterNo: Integer;
        FromEntryNo: Integer;
        ToEntryNo: Integer;


    procedure ResetValues()
    begin
        RegisterNo:=0;FromEntryNo:=0;ToEntryNo:=0;
    end;


    procedure SetRegisterNumber(var "No.": Integer)
    begin
        RegisterNo:="No.";
    end;


    procedure SetFromEntryNumber(var "No.": Integer)
    begin
        FromEntryNo:="No.";
    end;


    procedure SetToEntryNumber(var "No.": Integer)
    begin
        ToEntryNo:="No.";
    end;


    procedure GetRegisterNumber() RegisterNumber: Integer
    begin
        RegisterNumber:=RegisterNo;
        exit(RegisterNumber);
    end;


    procedure GetFromEntryNo() EntryNo: Integer
    begin
        EntryNo:=FromEntryNo;
        exit(EntryNo);
    end;


    procedure GetToEntryNo() EntryNo: Integer
    begin
        EntryNo:=ToEntryNo;
        exit(EntryNo);
    end;
}

