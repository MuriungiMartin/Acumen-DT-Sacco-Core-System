#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516664 "Fixed Asset Disposal Wizard"
{
    Caption = 'Fixed Asset Acquisition';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = NavigatePage;
    ShowFilter = false;
    SourceTable = "Gen. Journal Line";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(Control96)
            {
                Editable = false;
                Visible = TopBannerVisible and (Step <> Step::Done);
                field(MediaResourcesStandard;MediaResourcesStandard."Media Reference")
                {
                    ApplicationArea = FixedAssets;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(Control98)
            {
                Editable = false;
                Visible = TopBannerVisible and (Step = Step::Done);
                field(MediaResourcesDone;MediaResourcesDone."Media Reference")
                {
                    ApplicationArea = FixedAssets;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(Step1)
            {
                Caption = '';
                Visible = Step = Step::Intro;
                group("Para1.1")
                {
                    Caption = 'Welcome to Assisted Fixed Asset Acquisition';
                    group("Para1.1.1")
                    {
                        Caption = '';
                        InstructionalText = 'When you acquire a fixed asset, you can post the transaction to a G/L account, a vendor, or a bank account.';
                    }
                    group("Para1.1.2")
                    {
                        Visible = false;
                    }
                }
                group("Para1.2")
                {
                    Caption = '';
                    InstructionalText = 'Choose Next to specify how to post the acquisition.';
                }
            }
            group(Step2)
            {
                Caption = '';
                Visible = Step = Step::"FA Details";
                group("Para2.1")
                {
                    Caption = 'Provide information about the fixed asset.';
                    field(AcquisitionCost;Amount)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Disposal Cost Incl. VAT';

                        trigger OnValidate()
                        begin
                            ValidateCurrentStep(Step);
                        end;
                    }
                    field(AcquisitionDate;"Posting Date")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Disposal  Date';

                        trigger OnValidate()
                        begin
                            ValidateCurrentStep(Step);
                        end;
                    }
                }
            }
            group(Step3)
            {
                Caption = '';
                Visible = Step = Step::"Register Details";
                group("Para3.1")
                {
                    Caption = 'Which ledger do you want to post the acquisition to?';
                    field(TypeOfAcquisitions;AcquisitionOptions)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Post to';
                        OptionCaption = 'G/L Account,Vendor,Bank Account';

                        trigger OnValidate()
                        begin
                            case AcquisitionOptions of
                              Acquisitionoptions::"G/L Account":
                                Validate("Bal. Account Type","bal. account type"::"G/L Account");
                              Acquisitionoptions::Vendor:
                                "Bal. Account Type" := "bal. account type"::Vendor;
                              Acquisitionoptions::"Bank Account":
                                Validate("Bal. Account Type","bal. account type"::"Bank Account");
                            end;
                            ValidateCurrentStep(Step);
                        end;
                    }
                    group(Control34)
                    {
                        Visible = AcquisitionOptions = AcquisitionOptions::"G/L Account";
                        field(BalancingAccountNo;"Bal. Account No.")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Balancing Account No.';

                            trigger OnValidate()
                            begin
                                ValidateCurrentStep(Step);
                            end;
                        }
                    }
                    group(Control27)
                    {
                        Visible = AcquisitionOptions = AcquisitionOptions::Vendor;
                        field(VendorNo;"Bal. Account No.")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Vendor';
                        }
                        field(ExternalDocNo;"External Document No.")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'External Document No.';

                            trigger OnValidate()
                            begin
                                ValidateCurrentStep(Step);
                            end;
                        }
                    }
                    group(Control30)
                    {
                        Visible = AcquisitionOptions = AcquisitionOptions::"Bank Account";
                        field("Bank Account";"Bal. Account No.")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Bank Account';

                            trigger OnValidate()
                            begin
                                ValidateCurrentStep(Step);
                            end;
                        }
                    }
                }
            }
            group(Step4)
            {
                Caption = '';
                Visible = Step = Step::Done;
                group("Para4.1")
                {
                    Caption = 'That''s it!';
                    InstructionalText = 'The information needed to post the acquisition is  now ready in the fixed asset G/L journal.';
                }
                group("Para4.2")
                {
                    Caption = '';
                    InstructionalText = 'Choose Finish to automatically post the fixed asset G/L journal lines.';
                    field(OpenFAGLJournal;OpenFAGLJournal)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Upon Finish, open the FA G/L journal.';
                        Enabled = EnableOpenFAGLJournal;
                    }
                }
            }
            group(StepInJournal)
            {
                Caption = '';
                Visible = Step = Step::"Already In Journal";
                group("Para5.1")
                {
                    Caption = 'The fixed asset is already planned to be acquired.';
                    InstructionalText = 'Fixed asset G/L journal already contains a line for the acquisition of this fixed asset.';
                }
                group("Para5.2")
                {
                    Caption = '';
                    InstructionalText = 'Choose Finish to open the fixed asset G/L journal. Close this window to take no further action.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(PreviousPage)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Back';
                Enabled = Step <> Step::Intro;
                Image = PreviousRecord;
                InFooterBar = true;
                Visible = Step <> Step::"Already In Journal";

                trigger OnAction()
                begin
                    NextStep(true);
                end;
            }
            action(NextPage)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Next';
                Enabled = (Step <> Step::Done) and (CurrStepIsValid);
                Image = NextRecord;
                InFooterBar = true;
                Visible = Step <> Step::"Already In Journal";

                trigger OnAction()
                begin
                    NextStep(false);
                end;
            }
            action(Finish)
            {
                ApplicationArea = FixedAssets;
                Caption = 'Finish';
                Image = Approve;
                InFooterBar = true;

                trigger OnAction()
                var
                    GenJnlLine: Record "Gen. Journal Line";
                    PageGenJnlLine: Record "Gen. Journal Line";
                begin
                    if Step <> Step::"Already In Journal" then
                      CreateFADisposalLines(GenJnlLine);

                    if OpenFAGLJournal then begin
                      PageGenJnlLine.Validate("Journal Template Name","Journal Template Name");
                      PageGenJnlLine.Validate("Journal Batch Name","Journal Batch Name");
                      PageGenJnlLine.SetRange("Journal Template Name","Journal Template Name");
                      PageGenJnlLine.SetRange("Journal Batch Name","Journal Batch Name");
                      Page.Run(Page::"Fixed Asset G/L Journal",PageGenJnlLine);
                    end else
                      Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch",GenJnlLine);

                    CurrPage.Close;
                end;
            }
            action("Exit")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Exit';

                trigger OnAction()
                begin
                    CurrPage.Close
                end;
            }
        }
    }

    trigger OnInit()
    begin
        LoadTopBanners;
    end;

    trigger OnOpenPage()
    begin
        // We could check if values like FA Posting code, descirption are in the temp
        if not Get then begin
          Init;
          "Journal Template Name" := FixedAssetAcquisitionWizard.SelectFATemplate;
          "Journal Batch Name" := FixedAssetAcquisitionWizard.GetAutogenJournalBatch;
          "Document Type" := "document type"::Invoice;
          "Account Type" := "account type"::"Fixed Asset";
          "FA Posting Type" := "fa posting type"::"Acquisition Cost";
          "Posting Date" := WorkDate;
          SetAccountNoFromFilter;
          Insert;
        end;

        EnableOpenFAGLJournal := JournalBatchIsEmpty;
        OpenFAGLJournal := not EnableOpenFAGLJournal;
        VerifyFADoNotExistInGLJournalLines;
        ValidateCurrentStep(Step);
    end;

    var
        MediaRepositoryStandard: Record "Media Repository";
        MediaRepositoryDone: Record "Media Repository";
        MediaResourcesStandard: Record "Media Resources";
        MediaResourcesDone: Record "Media Resources";
        TempBalancingGenJournalLine: Record "Gen. Journal Line" temporary;
        FixedAssetAcquisitionWizard: Codeunit "Fixed Asset Acquisition Wizard";
        ClientTypeManagement: Codeunit ClientTypeManagement;
        Step: Option Intro,"FA Details","Register Details",Done,"Already In Journal";
        TopBannerVisible: Boolean;
        AcquisitionOptions: Option "G/L Account",Vendor,"Bank Account";
        OpenFAGLJournal: Boolean;
        CurrStepIsValid: Boolean;
        EnableOpenFAGLJournal: Boolean;

    local procedure NextStep(Backwards: Boolean)
    begin
        if Backwards then
          Step := Step - 1
        else
          Step := Step + 1;
        ValidateCurrentStep(Step);

        if Step = Step::Done then begin
          TempBalancingGenJournalLine.Init;
          TempBalancingGenJournalLine.TransferFields(Rec);
          TempBalancingGenJournalLine."Account No." := '';
          if not TempBalancingGenJournalLine.Insert then
            TempBalancingGenJournalLine.Modify(true);
        end;

        CurrPage.Update(true);
    end;

    local procedure LoadTopBanners()
    begin
        if MediaRepositoryStandard.Get('AssistedSetup-NoText-400px.png',Format(ClientTypeManagement.GetCurrentClientType)) and
           MediaRepositoryDone.Get('AssistedSetupDone-NoText-400px.png',Format(ClientTypeManagement.GetCurrentClientType))
        then
          if MediaResourcesStandard.Get(MediaRepositoryStandard."Media Resources Ref") and
             MediaResourcesDone.Get(MediaRepositoryDone."Media Resources Ref")
          then
            TopBannerVisible := MediaResourcesDone."Media Reference".Hasvalue;
    end;

    local procedure ValidateCurrentStep(CurrentStep: Option)
    begin
        case CurrentStep of
          Step::Intro:
            CurrStepIsValid := true;
          Step::"FA Details":
            CurrStepIsValid := (Amount >= 0.0) and ("Posting Date" <> 0D);
          Step::"Register Details":
            begin
              CurrStepIsValid := "Bal. Account No." <> '';
              if AcquisitionOptions = Acquisitionoptions::Vendor then
                CurrStepIsValid := CurrStepIsValid and ("External Document No." <> '');
            end;
          Step::Done:
            CurrStepIsValid := true;
          else
            CurrStepIsValid := true;
        end;
    end;

    local procedure JournalBatchIsEmpty(): Boolean
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.SetRange("Journal Batch Name","Journal Batch Name");
        exit(GenJournalLine.Count = 0);
    end;

    local procedure VerifyFADoNotExistInGLJournalLines()
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.SetRange("Account No.","Account No.");
        GenJournalLine.SetRange("Account Type",GenJournalLine."account type"::"Fixed Asset");
        GenJournalLine.SetRange("FA Posting Type","fa posting type"::"Acquisition Cost");
        if GenJournalLine.FindFirst then begin
          Step := Step::"Already In Journal";
          OpenFAGLJournal := true;
          Copy(GenJournalLine);
          Insert;
        end
    end;
}

