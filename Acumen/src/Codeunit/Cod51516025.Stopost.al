#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516025 "Stopost"
{
    // Where the workflow event subscribe to


    trigger OnRun()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostSto(var STO: Record "Standing Orders")
    begin
    end;
}

