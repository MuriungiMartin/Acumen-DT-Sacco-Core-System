#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516955 "M_Signatory Picture-App"
{
    PageType = CardPart;
    SourceTable = "Member App Signatories";

    layout
    {
        area(content)
        {
            field(Picture; Picture)
            {
                ApplicationArea = Basic, Suite;
                ShowCaption = false;
                ToolTip = 'Specifies the picture that has been inserted for the member.';
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
                Visible = CameraAvailable and (HideActions = false);

                trigger OnAction()
                begin
                    TakeNewPicture;
                end;
            }
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';
                Visible = HideActions = false;

                trigger OnAction()
                begin
                    ImportFromDevice;
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the picture to a file.';
                Visible = (CameraAvailable = false) and (HideActions = false);

                trigger OnAction()
                var
                    NameValueBuffer: Record "Name/Value Buffer";
                    TempNameValueBuffer: Record "Name/Value Buffer" temporary;
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin
                    TestField("Account No");
                    //TESTFIELD(Description);

                    NameValueBuffer.DeleteAll;
                    ExportPath := TemporaryPath + "Account No" + Format(Picture.MediaId);
                    Picture.ExportFile(ExportPath);
                    FileManagement.GetServerDirectoryFilesList(TempNameValueBuffer, TemporaryPath);
                    TempNameValueBuffer.SetFilter(Name, StrSubstNo('%1*', ExportPath));
                    TempNameValueBuffer.FindFirst;
                    ToFile := StrSubstNo('%1 %2.jpg', "Account No", ConvertStr("Account No", '"/\', '___'));
                    Download(TempNameValueBuffer.Name, DownloadImageTxt, '', '', ToFile);
                    if FileManagement.DeleteServerFile(TempNameValueBuffer.Name) then;
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';
                Visible = HideActions = false;

                trigger OnAction()
                begin
                    DeleteItemPicture;
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
        HideActions: Boolean;

    procedure TakeNewPicture()
    var
        CameraOptions: dotnet CameraOptions;
    begin
        Find;
        TestField("Account No");
        //TESTFIELD(Description);

        if not CameraAvailable then
            exit;

        CameraOptions := CameraOptions.CameraOptions;
        CameraOptions.Quality := 50;
        CameraProvider.RequestPictureAsync(CameraOptions);
    end;

    procedure ImportFromDevice()
    var
        FileManagement: Codeunit "File Management";
        FileName: Text;
        ClientFileName: Text;
    begin
        Find;
        TestField("Account No");
        //TESTFIELD(Description);

        if Picture.Count > 0 then
            if not Confirm(OverrideImageQst) then
                Error('');

        ClientFileName := '';
        FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
        if FileName = '' then
            Error('');

        Clear(Picture);
        Picture.ImportFile(FileName, ClientFileName);
        if not Insert(true) then
            Modify(true);

        if FileManagement.DeleteServerFile(FileName) then;
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Picture.Count <> 0;
    end;

    procedure IsCameraAvailable(): Boolean
    begin
        exit(CameraProvider.IsAvailable);
    end;

    procedure SetHideActions()
    begin
        HideActions := true;
    end;


    procedure DeleteItemPicture()
    begin
        TestField("Account No");

        if not Confirm(DeleteImageQst) then
            exit;

        Clear(Picture);
        Modify(true);
    end;

    trigger CameraProvider::PictureAvailable(PictureName: Text; PictureFilePath: Text)
    begin
    end;
}

