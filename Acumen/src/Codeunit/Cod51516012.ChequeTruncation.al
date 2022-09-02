#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 51516012 "Cheque Truncation"
{

    trigger OnRun()
    begin
        fnGetMemberNo();
    end;

    var
        objChequeTruncationBuffer: Record "Cheque Truncation Buffer";
        FilePath: Text[1024];
        Imge: Codeunit "File Management";
        PicTable: Record TempBlob;
        InStream1: InStream;
        InputFile: File;
        OutStream1: OutStream;
        TempBlob: Record "Cheque Truncation Buffer";
        FilePath2: Text[1024];
        icduFileMgt: Codeunit "File Management";
        tmpattach: Record Attachment;
        serverfileNAme: Text[250];


    procedure fnSaveChequeData(FilePath: Text;rcode: Code[10];vtype: Code[10];amount: Decimal;entryMode: Code[10];currCode: Code[10];destBank: Code[10];destBranch: Code[10];destAccount: Code[10];cheqdgt: Code[10];pBank: Code[10];pBranch: Code[10];filler: Code[10];colAcc: Code[100];SNO: Code[10];procNo: Code[10];FImageSizeBW: Integer;FImageSignBW: Integer;FImageSize: Integer;FImageSign: Integer;BImageSize: Integer;BImageSign: Integer)
    begin
        objChequeTruncationBuffer.Init;
        objChequeTruncationBuffer.RCODE:=rcode;
        objChequeTruncationBuffer.VTYPE:=vtype;
        objChequeTruncationBuffer.AMOUNT:=amount;
        objChequeTruncationBuffer.ENTRYMODE:=entryMode;
        objChequeTruncationBuffer.CURRENCYCODE:=currCode;
        objChequeTruncationBuffer.DESTBANK:=destBank;
        objChequeTruncationBuffer.DESTBRANCH:=destBranch;
        objChequeTruncationBuffer.DESTACC:=destAccount;
        objChequeTruncationBuffer.CHQDGT:=cheqdgt;
        objChequeTruncationBuffer.PBANK:=pBank;
        objChequeTruncationBuffer.PBRANCH:=pBranch;
        objChequeTruncationBuffer.FILLER:=filler;
        objChequeTruncationBuffer.COLLACC:=colAcc;
        objChequeTruncationBuffer.SNO:=SNO;
        objChequeTruncationBuffer.PROCNO:=procNo;
        objChequeTruncationBuffer.FIMAGESIGN:=FImageSign;
        objChequeTruncationBuffer.FIMAGESIZE:=FImageSize;
        objChequeTruncationBuffer.FIMAGESIGNBW:=FImageSignBW;
        objChequeTruncationBuffer.FIMAGESIZEBW:=FImageSizeBW;
        objChequeTruncationBuffer.BIMAGESIGN:=BImageSign;
        objChequeTruncationBuffer.BIMAGESIZE:=BImageSize;
        objChequeTruncationBuffer.Insert;
    end;


    procedure FnSaveFBWImages(fileName: Text[200];SerialNo: Integer)
    begin
        objChequeTruncationBuffer.Reset;
        objChequeTruncationBuffer.SetRange(objChequeTruncationBuffer.ChequeDataId,SerialNo);
        if objChequeTruncationBuffer.Find('-') then begin
        if objChequeTruncationBuffer.FrontBWImage.Hasvalue then
        Clear(objChequeTruncationBuffer.FrontBWImage);
        if FILE.Exists(fileName) then begin
        InputFile.Open(fileName);
        InputFile.CreateInstream(InStream1);
        objChequeTruncationBuffer.FrontBWImage.CreateOutstream(OutStream1);
        CopyStream(OutStream1,InStream1);
        objChequeTruncationBuffer.Modify;
        InputFile.Close;
        end;
        end;
    end;


    procedure FnSaveGrayImages(fileName: Text[200];SerialNo: Integer)
    begin
        objChequeTruncationBuffer.Reset;
        objChequeTruncationBuffer.SetRange(objChequeTruncationBuffer.ChequeDataId,SerialNo);
        if objChequeTruncationBuffer.Find('-') then begin
        if objChequeTruncationBuffer.FrontGrayScaleImage.Hasvalue then
        Clear(objChequeTruncationBuffer.FrontGrayScaleImage);

        if FILE.Exists(fileName) then begin
        InputFile.Open(fileName);
        InputFile.CreateInstream(InStream1);
        objChequeTruncationBuffer.FrontGrayScaleImage.CreateOutstream(OutStream1);
        CopyStream(OutStream1,InStream1);
        objChequeTruncationBuffer.Modify;
        InputFile.Close;
        end;
        end;
    end;


    procedure FnSaveRearImages(fileName: Text[200];SerialNo: Integer)
    begin
        objChequeTruncationBuffer.Reset;
        objChequeTruncationBuffer.SetRange(objChequeTruncationBuffer.ChequeDataId,SerialNo);
        if objChequeTruncationBuffer.Find('-') then begin
        if objChequeTruncationBuffer.RearImage.Hasvalue then
        Clear(objChequeTruncationBuffer.RearImage);

        if FILE.Exists(fileName) then begin
        InputFile.Open(fileName);
        InputFile.CreateInstream(InStream1);
        objChequeTruncationBuffer.RearImage.CreateOutstream(OutStream1);
        CopyStream(OutStream1,InStream1);
        objChequeTruncationBuffer.Modify;
        InputFile.Close;
        end;
        end;
    end;


    procedure fnGetMemberNo()
    begin
        objChequeTruncationBuffer.Reset;
        //objChequeTruncationBuffer.SETRANGE(objChequeTruncationBuffer.MemberNo,'');
        if objChequeTruncationBuffer.Find('-') then begin
          repeat
          objChequeTruncationBuffer.MemberNo:=CopyStr(objChequeTruncationBuffer.DESTACC,1,5);
          objChequeTruncationBuffer.Modify;
          until objChequeTruncationBuffer.Next=0;
          end;
    end;
}

