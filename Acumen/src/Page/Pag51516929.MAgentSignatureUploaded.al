#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516929 "M_Agent Signature-Uploaded"
{
    PageType = CardPart;
    SourceTable = "Member Agent Details";

    layout
    {
        area(content)
        {
            field(Signature; Signature)
            {
                ApplicationArea = Basic, Suite;
                ShowCaption = false;
                ToolTip = 'Specifies the picture that has been inserted for the signature.';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = All;
                Caption = 'Take';
                Image = Camera;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Activate the camera on the device.';
                Visible = CameraAvailable;

                trigger OnAction()
                var
                    CameraOptions: dotnet CameraOptions;
                begin
                    if not CameraAvailable then
                        exit;
                    CameraOptions := CameraOptions.CameraOptions;
                    CameraOptions.Quality := 100;
                    CameraProvider.RequestPictureAsync(CameraOptions);
                end;
            }
            action(ImportSignature)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Enabled = false;
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    ClientFileName: Text;
                begin
                    if Signature.Count > 0 then
                        if not Confirm(OverrideImageQst) then
                            exit;

                    FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
                    if FileName = '' then
                        exit;

                    Clear(Signature);
                    Signature.ImportFile(FileName, ClientFileName);
                    Modify(true);
                    if FileManagement.DeleteServerFile(FileName) then;
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the picture to a file.';

                trigger OnAction()
                var
                    NameValueBuffer: Record "Name/Value Buffer";
                    TempNameValueBuffer: Record "Name/Value Buffer" temporary;
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin
                    NameValueBuffer.DeleteAll;
                    ExportPath := TemporaryPath + "Account No" + Format(Signature.MediaId);
                    Signature.ExportFile(ExportPath);
                    FileManagement.GetServerDirectoryFilesList(TempNameValueBuffer, TemporaryPath);
                    TempNameValueBuffer.SetFilter(Name, StrSubstNo('%1*', ExportPath));
                    TempNameValueBuffer.FindFirst;
                    ToFile := StrSubstNo('%1 %2.jpg', "Account No", Names);
                    Download(TempNameValueBuffer.Name, DownloadImageTxt, '', '', ToFile);
                    if FileManagement.DeleteServerFile(TempNameValueBuffer.Name) then;
                end;
            }
            action(DeleteSignature)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin
                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(Signature);
                    Modify(true);
                end;
            }
        }
    }

    var
        [RunOnClient]
        [WithEvents]
        CameraProvider: dotnet CameraProvider;
        CameraAvailable: Boolean;
        DeleteExportEnabled: Boolean;
        OverrideImageQst: label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: label 'Select a picture to upload';
        DownloadImageTxt: label 'Download image';

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Signature.Count <> 0;
    end;

    trigger CameraProvider::PictureAvailable(PictureName: Text; PictureFilePath: Text)
    var
        File: File;
        Instream: InStream;
    begin
        if (PictureName = '') or (PictureFilePath = '') then
            exit;

        if Signature.Count > 0 then
            if not Confirm(OverrideImageQst) then begin
                if Erase(PictureFilePath) then;
                exit;
            end;

        File.Open(PictureFilePath);
        File.CreateInstream(Instream);

        Clear(Signature);
        Signature.ImportStream(Instream, PictureName);
        Modify(true);

        File.Close;
        if Erase(PictureFilePath) then;
    end;
}

