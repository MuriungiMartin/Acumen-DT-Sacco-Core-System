#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516882 "Member Signature-Change Req"
{
    Caption = 'Item Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Change Request";

    layout
    {
        area(content)
        {
            field(signinature;signinature)
            {
                ApplicationArea = Basic;
                Visible = true;
            }
            field(signatures2;signatures2)
            {
                ApplicationArea = Basic;
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
                Visible = HideActions = false;

                trigger OnAction()
                var
                    DummyPictureEntity: Record "Picture Entity";
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin
                    TestField(No);
                    //TESTFIELD(Description);

                    ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);
                    ExportPath := TemporaryPath + No + Format(Picture.MediaId);
                    Picture.ExportFile(ExportPath + '.' + DummyPictureEntity.GetDefaultExtension);

                    FileManagement.ExportImage(ExportPath,ToFile);
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

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions;
    end;

    trigger OnOpenPage()
    begin
        CameraAvailable := CameraProvider.IsAvailable;
        if CameraAvailable then
          CameraProvider := CameraProvider.Create;
    end;

    var
        [RunOnClient]
        [WithEvents]
        CameraProvider: dotnet CameraProvider;
        CameraAvailable: Boolean;
        OverrideImageQst: label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;
        HideActions: Boolean;

    procedure TakeNewPicture()
    var
        CameraOptions: dotnet CameraOptions;
    begin
        Find;
        TestField(No);
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
        TestField(No);
        //TESTFIELD(Description);

        if signinature.Count > 0 then

          if not Confirm(OverrideImageQst) then
            Error('');

        ClientFileName := '';
        FileName := FileManagement.UploadFile(SelectPictureTxt,ClientFileName);
        if FileName = '' then
          Error('');

        Clear(signinature);
        signinature.ImportFile(FileName,ClientFileName);
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
        TestField(No);

        if not Confirm(DeleteImageQst) then
          exit;

        Clear(signinature);
        Modify(true);
    end;

    trigger Cameraprovider::PictureAvailable(PictureName: Text;PictureFilePath: Text)
    var
        File: File;
        Instream: InStream;
    begin
        if (PictureName = '') or (PictureFilePath = '') then
          exit;

        if signinature.Count > 0 then
          if not Confirm(OverrideImageQst) then begin
            if Erase(PictureFilePath) then;
            exit;
          end;

        File.Open(PictureFilePath);
        File.CreateInstream(Instream);

        Clear(Picture);
        signinature.ImportStream(Instream,PictureName);
        if not Modify(true) then
          Insert(true);

        File.Close;
        if Erase(PictureFilePath) then;
    end;
}

