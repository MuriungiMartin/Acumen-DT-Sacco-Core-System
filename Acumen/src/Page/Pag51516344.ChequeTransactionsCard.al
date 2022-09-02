#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516344 "Cheque Transactions Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Cheque Truncation Buffer";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(SerialId;SerialId)
                {
                    ApplicationArea = Basic;
                }
                field(RCODE;RCODE)
                {
                    ApplicationArea = Basic;
                }
                field(VTYPE;VTYPE)
                {
                    ApplicationArea = Basic;
                }
                field(AMOUNT;AMOUNT)
                {
                    ApplicationArea = Basic;
                }
                field(ENTRYMODE;ENTRYMODE)
                {
                    ApplicationArea = Basic;
                }
                field(CURRENCYCODE;CURRENCYCODE)
                {
                    ApplicationArea = Basic;
                }
                field(DESTBANK;DESTBANK)
                {
                    ApplicationArea = Basic;
                }
                field(DESTBRANCH;DESTBRANCH)
                {
                    ApplicationArea = Basic;
                }
                field(DESTACC;DESTACC)
                {
                    ApplicationArea = Basic;
                }
                field(CHQDGT;CHQDGT)
                {
                    ApplicationArea = Basic;
                }
                field(PBANK;PBANK)
                {
                    ApplicationArea = Basic;
                }
                field(PBRANCH;PBRANCH)
                {
                    ApplicationArea = Basic;
                }
                field(COLLACC;COLLACC)
                {
                    ApplicationArea = Basic;
                }
                field(MemberNo;MemberNo)
                {
                    ApplicationArea = Basic;
                }
                field(SNO;SNO)
                {
                    ApplicationArea = Basic;
                }
                field(FrontBWImage;FrontBWImage)
                {
                    ApplicationArea = Basic;
                }
                field(FrontGrayScaleImage;FrontGrayScaleImage)
                {
                    ApplicationArea = Basic;
                }
                field(RearImage;RearImage)
                {
                    ApplicationArea = Basic;
                }
                field(IsFCY;IsFCY)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(UploadFile)
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    DestinationFile: Text[100];
                begin
                    DestinationFile := FileMgt.OpenFileDialog('Family Cheque file','*.J70',UserId+'(*.*)|(*.J70)');

                    Message(DestinationFile);
                    //UPLOADINTOSTREAM('Import','','All Files (*.*)|*.*',DestinationFile,USERID+'(*.*)|(*.J70)');
                end;
            }
        }
    }

    var
        FileMgt: Codeunit "File Management";
}

