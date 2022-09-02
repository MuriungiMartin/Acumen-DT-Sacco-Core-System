#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516518 "Bulk SMS Lines Part"
{
    PageType = ListPart;
    SourceTable = "Bulk SMS Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No;No)
                {
                    ApplicationArea = Basic;
                }
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                    Caption = 'Telephone No';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                           /*
                        BulkSMSHeader.RESET;
                        BulkSMSHeader.SETRANGE(BulkSMSHeader.No,No);
                        IF BulkSMSHeader.FIND('-') THEN BEGIN
                        //DIMENSION
                        IF BulkSMSHeader."SMS Type"=BulkSMSHeader."SMS Type"::Dimension THEN BEGIN
                        DimensionValue.RESET;
                        DimensionValue.SETRANGE(DimensionValue."Global Dimension No.",2);
                        IF PAGE.RUNMODAL(560,DimensionValue) = ACTION::LookupOK THEN BEGIN
                        Code:=DimensionValue.Code;
                        Description:=DimensionValue.Name;
                        END;
                        
                        END;
                        
                        END;
                           */

                    end;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        BulkSMSHeader: Record "Bulk SMS Header";
        DimensionValue: Record "Dimension Value";
}

