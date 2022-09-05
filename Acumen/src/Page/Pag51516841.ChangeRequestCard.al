#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516841 "Change Request Card"
{
    PageType = Card;
    SourceTable = "Change Request";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Type)
                {
                    ApplicationArea = Basic;
                    Editable = TypeEditable;

                    trigger OnValidate()
                    begin
                        AccountVisible := false;
                        MobileVisible := false;
                        AtmVisible := false;
                        nxkinvisible := false;

                        if Type = Type::"Mobile Change" then begin
                            MobileVisible := true;
                        end;

                        if Type = Type::"ATM Change" then begin
                            AtmVisible := true;
                        end;

                        if Type = Type::"Backoffice Change" then begin
                            AccountVisible := true;
                            nxkinvisible := true;
                        end;

                        if Type = Type::"Agile Change" then begin
                            AccountVisible := true;
                            nxkinvisible := true;
                        end;

                        if Type = Type::"Microfinance Change" then begin
                            AccountVisible := true;
                            nxkinvisible := true;
                        end;
                    end;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                    Editable = AccountNoEditable;
                }
                field("Captured by"; "Captured by")
                {
                    ApplicationArea = Basic;
                }
                field("Capture Date"; "Capture Date")
                {
                    ApplicationArea = Basic;
                }
                field("Approved by"; "Approved by")
                {
                    ApplicationArea = Basic;
                }
                field("Approval Date"; "Approval Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Reason for change"; "Reason for change")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Mobile)
            {
                Caption = 'Phone No Details';
                Visible = Mobilevisible;
                field("Mobile No"; "Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mobile No(New Value)"; "Mobile No(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No(New Value)';
                    Editable = MobileNoEditable;
                }
                field("S-Mobile No"; "S-Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("S-Mobile No(New Value)"; "S-Mobile No(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'S-Mobile No(New Value)';
                    Editable = SMobileNoEditable;
                }
            }
            group("Atm Details")
            {
                Caption = 'ATM Card Details';
                Visible = Atmvisible;
                field("ATM Approve"; "ATM Approve")
                {
                    ApplicationArea = Basic;
                    Editable = ATMApproveEditable;
                }
                field("Card Expiry Date"; "Card Expiry Date")
                {
                    ApplicationArea = Basic;
                    Editable = CardExpiryDateEditable;
                }
                field("Card Valid From"; "Card Valid From")
                {
                    ApplicationArea = Basic;
                    Editable = CardValidFromEditable;
                }
                field("Card Valid To"; "Card Valid To")
                {
                    ApplicationArea = Basic;
                    Editable = CardValidToEditable;
                }
                field("Date ATM Linked"; "Date ATM Linked")
                {
                    ApplicationArea = Basic;
                }
                field("ATM No."; "ATM No.")
                {
                    ApplicationArea = Basic;
                    Editable = ATMNOEditable;
                }
                field("ATM Issued"; "ATM Issued")
                {
                    ApplicationArea = Basic;
                    Editable = ATMIssuedEditable;
                }
                field("ATM Self Picked"; "ATM Self Picked")
                {
                    ApplicationArea = Basic;
                    Editable = ATMSelfPickedEditable;
                }
                field("ATM Collector Name"; "ATM Collector Name")
                {
                    ApplicationArea = Basic;
                    Editable = ATMCollectorNameEditable;
                }
                field("ATM Collectors ID"; "ATM Collectors ID")
                {
                    ApplicationArea = Basic;
                    Editable = ATMCollectorIDEditable;
                }
                field("Atm Collectors Moile"; "Atm Collectors Moile")
                {
                    ApplicationArea = Basic;
                    Editable = ATMCollectorMobileEditable;
                }
                field("Responsibility Centers"; "Responsibility Centers")
                {
                    ApplicationArea = Basic;
                    Editable = ResponsibilityCentreEditable;
                }
            }
            group("Account Info")
            {
                Caption = 'Account Details';
                Visible = Accountvisible;
                field(Picture; Picture)
                {
                    ApplicationArea = Basic;
                    Visible = PictureEditable;
                }
                field(signinature; signinature)
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Name(New Value)"; "Name(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name(New Value)';
                    Editable = NameEditable;
                }
                field("Member class"; "Member class")
                {
                    ApplicationArea = Basic;
                }
                field("Member class (New)"; "Member class (New)")
                {
                    ApplicationArea = Basic;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Address(New Value)"; "Address(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Address(New Value)';
                    Editable = AddressEditable;
                }
                field(City; City)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("City(New Value)"; "City(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'City(New Value)';
                    Editable = CityEditable;
                }
                field("E-mail"; "E-mail")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Email(New Value)"; "Email(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Email(New Value)';
                    Editable = EmailEditable;
                }
                field("Personal No"; "Personal No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Personal No(New Value)"; "Personal No(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Personal No(New Value)';
                    Editable = PersonalNoEditable;
                }
                field("ID No"; "ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No(New Value)"; "ID No(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No(New Value)';
                    Editable = IDNoEditable;
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Marital Status(New Value)"; "Marital Status(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status(New Value)';
                    Editable = MaritalStatusEditable;
                    ToolTip = 'Please enter your marital status';
                }
                field("Passport No."; "Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Passport No.(New Value)"; "Passport No.(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.(New Value)';
                    Editable = PassPortNoEditbale;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Type(New Value)"; "Account Type(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Type(New Value)';
                    Editable = AccountTypeEditible;
                }
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Category(New Value)"; "Account Category(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Category(New Value)';
                    Editable = AccountCategoryEditable;
                }
                field(Section; Section)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Section(New Value)"; "Section(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Section(New Value)';
                    Editable = SectionEditable;
                }
                field("Card No"; "Card No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Card No(New Value)"; "Card No(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Card No(New Value)';
                    Editable = CardNoEditable;
                }
                field("Home Address"; "Home Address")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Home Address(New Value)"; "Home Address(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Address(New Value)';
                    Editable = HomeAddressEditable;
                }
                field(Loaction; Loaction)
                {
                    ApplicationArea = Basic;
                    Caption = '<Locaction>';
                    Editable = false;
                }
                field("Loaction(New Value)"; "Loaction(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Location(New Value)';
                    Editable = LocationEditable;
                }
                field("Sub-Location"; "Sub-Location")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sub-Location(New Value)"; "Sub-Location(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sub-Location(New Value)';
                    Editable = SubLocationEditable;
                }
                field(District; District)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("District(New Value)"; "District(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'District(New Value)';
                    Editable = DistrictEditable;
                }
                field("Status."; "Status.")
                {
                    ApplicationArea = Basic;
                }
                field("Status.(New)"; "Status.(New)")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Code(New)"; "Employer Code(New)")
                {
                    ApplicationArea = Basic;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    OptionCaption = ' ,Payment,All';
                }
                field("Blocked (New)"; "Blocked (New)")
                {
                    ApplicationArea = Basic;
                    OptionCaption = ' ,Payment,All';
                }
                field("Charge Reactivation Fee"; "Charge Reactivation Fee")
                {
                    ApplicationArea = Basic;
                    Editable = ReactivationFeeEditable;
                }
                field("Signing Instructions"; "Signing Instructions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retirement Date"; "Retirement Date")
                {
                    ApplicationArea = Basic;
                    Editable = RetirementDateEditable;
                }
                field("Retirement Date(New)"; "Retirement Date(New)")
                {
                    ApplicationArea = Basic;
                }
                field("Signing Instructions(NewValue)"; "Signing Instructions(NewValue)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signing Instructions(New Value)';
                    Editable = SigningInstructionEditable;
                }
                field("Monthly Contributions"; "Monthly Contributions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Contributions(NewValu)"; "Monthly Contributions(NewValu)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Monthly Contributions(New Value)';
                    Editable = MonthlyContributionEditable;
                }
                field("Member Cell Group"; "Member Cell Group")
                {
                    ApplicationArea = Basic;
                    Editable = MemberCellEditable;
                }
                field("Group Account No"; "Group Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Group Account Name"; "Group Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No.(Old)"; "Phone No.(Old)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Phone No.(New)"; "Phone No.(New)")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                }
                field("Gender(New)"; "Gender(New)")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000082; "Member Picture-Change Reqnew")
            {
                Caption = 'Picture';
                SubPageLink = No = field(No);
            }
            part(Control1000000083; "Member Signature-Change Req")
            {
                Caption = 'Signature';
                SubPageLink = No = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Changes")
            {
                ApplicationArea = Basic;
                Caption = 'Update Changes';
                Image = UserInterface;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    /*IF (Status<>Status::Approved) THEN BEGIN
                    ERROR('Change Request Must be Approved First');
                    END;*/
                    if ((Type = Type::"Mobile Change") or (Type = Type::"ATM Change") or (Type = Type::"Agile Change") or (Type = Type::"Backoffice Change")) then begin

                        vend.Reset;
                        vend.SetRange(vend."No.", "Account No");
                        if vend.Find('-') then begin
                            if "Name(New Value)" <> '' then
                                vend.Name := "Name(New Value)";
                            vend."Global Dimension 2 Code" := Branch;
                            if "Address(New Value)" <> '' then
                                vend.Address := "Address(New Value)";

                            if "Email(New Value)" <> '' then
                                vend."E-Mail" := "Email(New Value)";
                            vend.Status := "Status (New Value)";
                            if "Mobile No(New Value)" <> '' then
                                vend."Mobile Phone No" := "Mobile No(New Value)";
                            //vend."Mobile Phone No":=Memb."Mobile Phone No";
                            if "S-Mobile No(New Value)" <> '' then
                                vend."S-Mobile No" := "S-Mobile No(New Value)";
                            if "ATM Collector Name" <> '' then
                                vend."ATM Collector Name" := "ATM Collector Name";
                            if "ID No(New Value)" <> '' then
                                vend."ID No." := "ID No(New Value)";
                            if "Personal No(New Value)" <> '' then
                                vend."Personal No." := "Personal No(New Value)";
                            if "City(New Value)" <> '' then
                                vend.City := "City(New Value)";
                            if "Section(New Value)" <> '' then
                                vend.Section := "Section(New Value)";
                            if "Card Expiry Date" <> 0D then
                                vend."Card Expiry Date" := "Card Expiry Date";
                            if "Card No(New Value)" <> '' then
                                vend."Card No." := "Card No(New Value)";
                            if "Card No(New Value)" <> '' then
                                vend."ATM No." := "Card No(New Value)";
                            if "Card Valid From" <> 0D then
                                vend."Card Valid From" := "Card Valid From";
                            if "Card Valid To" <> 0D then
                                vend."Card Valid To" := "Card Valid To";
                            if "Marital Status(New Value)" <> "marital status(new value)"::" " then
                                vend."Marital Status" := "Marital Status(New Value)";
                            if "Responsibility Centers" <> '' then
                                vend."Responsibility Center" := "Responsibility Centers";
                            if "Phone No.(New)" <> '' then
                                vend."Phone No." := "Phone No.(New)";
                            vend.Blocked := "Blocked (New)";
                            vend.Status := "Status.(New)";
                            if "Member class (New)" <> "member class (new)"::" " then
                                vend."Member class" := "Member class (New)";
                            vend.Picture := Picture;
                            vend.Modify;

                            /*
                         IF (Type=Type::"Agile Change") THEN BEGIN
                            ProductNxK.RESET;
                            ProductNxK.SETRANGE(ProductNxK."Account No","Account No");
                            IF ProductNxK.FIND('-') THEN

                             REPEAT;

                              ProductNxK.Name:= Kinchangedetails.Name;
                              ProductNxK.Relationship:=Kinchangedetails.Relationship;
                              ProductNxK.Beneficiary:=Kinchangedetails.Beneficiary;
                              ProductNxK."Date of Birth":=Kinchangedetails."Date of Birth";
                              ProductNxK.Address:=Kinchangedetails.Address;
                              ProductNxK.Telephone:=Kinchangedetails.Telephone;
                              //ProductNxK.Fax:=Kinchangedetails.Fax;
                              ProductNxK.Email:=Kinchangedetails.Email;
                              ProductNxK."ID No.":=Kinchangedetails."ID No.";
                              ProductNxK."%Allocation":=Kinchangedetails."%Allocation";
                              ProductNxK.MODIFY;

                             UNTIL ProductNxK.NEXT=0;

                             END
                       */
                        end;
                        // END;


                        //IF Type=Type::"Backoffice Change" THEN BEGIN
                        Memb.Reset;
                        Memb.SetRange(Memb."No.", "Account No");
                        if Memb.Find('-') then begin
                            if "Name(New Value)" <> '' then
                                Memb.Name := "Name(New Value)";
                            Memb."Global Dimension 2 Code" := Branch;
                            if "Address(New Value)" <> '' then
                                Memb.Address := "Address(New Value)";
                            if "Email(New Value)" <> '' then
                                Memb."E-Mail" := "Email(New Value)";
                            if "Mobile No(New Value)" <> '' then
                                Memb."Mobile Phone No" := "Mobile No(New Value)";
                            if "Retirement Date(New)" <> 0D then
                                Memb."Retirement Date" := "Retirement Date(New)";
                            if "Phone No.(New)" <> '' then
                                Memb."Mobile Phone No" := "Phone No.(New)";
                            if "Gender(New)" <> "gender(new)"::" " then
                                Memb.Gender := "Gender(New)";
                            if "ID No(New Value)" <> '' then
                                Memb."ID No." := "ID No(New Value)";
                            if "Personal No(New Value)" <> '' then begin
                                Memb."Personal No" := "Personal No(New Value)";
                                Memb.Validate("Personal No");
                            end;
                            if "City(New Value)" <> '' then
                                Memb.City := "City(New Value)";
                            Memb.Status := "Status(New Value)";
                            if "Section(New Value)" <> '' then
                                Memb.Section := "Section(New Value)";
                            Memb.Blocked := "Blocked (New)";
                            if "Marital Status(New Value)" <> "marital status(new value)"::" " then
                                Memb."Marital Status" := "Marital Status(New Value)";
                            if "Responsibility Centers" <> '' then
                                Memb."Responsibility Center" := "Responsibility Centers";
                            if "Group Account No" <> '' then
                                Memb."Group Account No" := "Group Account No";

                            //Memb."Retirement Date":=ret;
                            if "Group Account Name" <> '' then
                                Memb."Group Account Name" := "Group Account Name";

                            if "Member class (New)" <> "member class (new)"::" " then
                                Memb."Member class" := "Member class (New)";

                            if "Employer Code(New)" <> '' then
                                Memb."Employer Code" := "Employer Code(New)";
                            //IF Memb.Picture

                            // Memb.Picture:=Picture;
                            Memb.Picture := Picture;
                            Memb."Picture 2" := "Picture 2";
                            Memb.Signature := signinature;
                            Memb."Signature  2" := signatures2;
                            Memb.Status := "Status.(New)";
                            Memb.Modify;
                            vend.Reset;
                            vend.SetRange(vend."No.", "Account No");
                            if vend.Find('-') then begin
                                if "Name(New Value)" <> '' then
                                    vend.Name := "Name(New Value)";
                                vend."Global Dimension 2 Code" := Branch;
                                if "Address(New Value)" <> '' then
                                    vend.Address := "Address(New Value)";

                                if "Email(New Value)" <> '' then
                                    vend."E-Mail" := "Email(New Value)";
                                vend.Status := "Status (New Value)";
                                if "Mobile No(New Value)" <> '' then
                                    vend."Mobile Phone No" := "Mobile No(New Value)";
                                //vend."Mobile Phone No":=Memb."Mobile Phone No";
                                if "S-Mobile No(New Value)" <> '' then
                                    vend."S-Mobile No" := "S-Mobile No(New Value)";
                                if "ATM Collector Name" <> '' then
                                    vend."ATM Collector Name" := "ATM Collector Name";
                                if "ID No(New Value)" <> '' then
                                    vend."ID No." := "ID No(New Value)";
                                if "Personal No(New Value)" <> '' then
                                    vend."Personal No." := "Personal No(New Value)";
                                if "City(New Value)" <> '' then
                                    vend.City := "City(New Value)";
                                if "Section(New Value)" <> '' then
                                    vend.Section := "Section(New Value)";
                                if "Card Expiry Date" <> 0D then
                                    vend."Card Expiry Date" := "Card Expiry Date";
                                if "Card No(New Value)" <> '' then
                                    vend."Card No." := "Card No(New Value)";
                                if "Card No(New Value)" <> '' then
                                    vend."ATM No." := "Card No(New Value)";
                                if "Card Valid From" <> 0D then
                                    vend."Card Valid From" := "Card Valid From";
                                if "Card Valid To" <> 0D then
                                    vend."Card Valid To" := "Card Valid To";
                                if "Marital Status(New Value)" <> "marital status(new value)"::" " then
                                    vend."Marital Status" := "Marital Status(New Value)";
                                if "Responsibility Centers" <> '' then
                                    vend."Responsibility Center" := "Responsibility Centers";
                                if "Phone No.(New)" <> '' then
                                    vend."Phone No." := "Phone No.(New)";
                                vend.Blocked := "Blocked (New)";
                                vend.Status := "Status.(New)";
                                if "Member class (New)" <> "member class (new)"::" " then
                                    vend."Member class" := "Member class (New)";
                                vend.Picture := Picture;
                                vend."Signature  2" := signatures2;
                                vend.Modify;
                                if "Charge Reactivation Fee" = true then begin
                                    if Confirm('The System Is going to Charge Reactivation Fee', false) = true then begin
                                        GenSetUp.Get();
                                        GenJournalLine.Reset;
                                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                        if GenJournalLine.FindSet then begin
                                            GenJournalLine.DeleteAll;
                                        end;

                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Reset;
                                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                                        GenJournalLine.DeleteAll;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Employee;
                                        GenJournalLine."Account No." := "Account No";
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine."Document No." := No;
                                        GenJournalLine.Description := 'Account Reactivation Fee' + ' ' + No;
                                        GenJournalLine.Amount := GenSetUp."Rejoining Fee";
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := GenSetUp."Rejoining Fees Account";
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        GenJournalLine.Reset;
                                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                        if GenJournalLine.FindSet then begin
                                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                                        end;
                                        Message('Reactivation Fee Charged Successfuly');
                                    end;
                                end;



                            end;

                        end;

                        Changed := true;
                        Modify;
                        Message('Changes have been updated Successfully');
                    end;

                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    ApprovalsMgmt: Codeunit WorkflowIntegration;
                begin

                    if Status <> Status::Open then
                        Error(text001);
                    TestField("Reason for change");
                    if ApprovalsMgmt.CheckChangeRequestApprovalsWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendChangeRequestForApproval(Rec);

                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel A&pproval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    ApprovalMgt: Codeunit WorkflowIntegration;
                begin
                    if Status <> Status::Open then
                        Error(text001);


                end;
            }
            action(Approvals)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    DocumentType := Documenttype::ChangeRequest;

                    ApprovalEntries.Setfilters(Database::"Change Request", DocumentType, No);
                    ApprovalEntries.Run;
                end;
            }
            separator(Action1000000047)
            {
            }
            action(Populate)
            {
                ApplicationArea = Basic;
                Caption = 'Populate';
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    /*IF ("No. Series"="No. Series"::"1") OR ("No. Series"="No. Series"::"2") THEN BEGIN
                     ERROR('Only Backoffice change or Agile Change allows you to Populate Next of Kin');
                    END;
                    IF ("No. Series"="No. Series"::"3") THEN BEGIN

                    END;

                  IF ("No. Series"="No. Series"::"4") THEN BEGIN
                    ProductNxK.RESET;
                    ProductNxK.SETRANGE(ProductNxK."Account No",Posted);
                    IF ProductNxK.FIND('-') THEN
                      MESSAGE(FORMAT(Posted));
                      REPEAT;
                        Kinchangedetails.INIT;
                        Kinchangedetails."Member No":=Posted;
                        Kinchangedetails."Dividend year":=ProductNxK.Name;
                        Kinchangedetails.Amount:=ProductNxK.Relationship;
                        Kinchangedetails."Member Name":=ProductNxK.Beneficiary;
                        Kinchangedetails.Message:=ProductNxK."Date of Birth";
                        Kinchangedetails."Message Sent":=ProductNxK.Address;
                        Kinchangedetails."Account No.":=ProductNxK.Telephone;
                        Kinchangedetails.Fax:=ProductNxK.Fax;
                        Kinchangedetails.Email:=ProductNxK.Email;
                        Kinchangedetails."ID No.":=ProductNxK."ID No.";
                        Kinchangedetails."%Allocation":=ProductNxK."%Allocation";
                        Kinchangedetails.INSERT;

                      UNTIL ProductNxK.NEXT=0;
                      MESSAGE('Next of Kin Details Populated Successfully');
                    END;
                    */

                end;
            }
            separator(Action1000000055)
            {
            }
            action("Next of Kin")
            {
                ApplicationArea = Basic;
                Caption = 'Next of Kin';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Next of Kin-Change";
                RunPageLink = "Account No" = field("Account No");
            }
            action("UpLoad Picture")
            {
                ApplicationArea = Basic;
                Image = Picture;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    ApprovalsMgmt: Codeunit WorkflowIntegration;
                begin
                    Memb.Reset;
                    Memb.SetRange(Memb."No.", "Account No");
                    if Memb.Find('-') then begin
                        Message(Format(Memb."No."));
                        Message(Format(Memb.Picture));
                        //Picturen:=Memb.Picture;
                        Modify;

                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        AccountVisible := false;
        MobileVisible := false;
        AtmVisible := false;
        nxkinvisible := false;

        if Type = Type::"Mobile Change" then begin
            MobileVisible := true;
        end;

        if Type = Type::"ATM Change" then begin
            AtmVisible := true;
        end;

        if Type = Type::"Backoffice Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;

        if Type = Type::"Agile Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;

        if Type = Type::"Microfinance Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;

        UpdateControl();
    end;

    trigger OnOpenPage()
    begin
        AccountVisible := false;
        MobileVisible := false;
        AtmVisible := false;
        nxkinvisible := false;

        if Type = Type::"Mobile Change" then begin
            MobileVisible := true;
        end;

        if Type = Type::"ATM Change" then begin
            AtmVisible := true;
        end;

        if Type = Type::"Backoffice Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;

        if Type = Type::"Agile Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;
        if Type = Type::"Microfinance Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;

        UpdateControl();
    end;

    var
        vend: Record Vendor;
        Memb: Record Customer;
        MobileVisible: Boolean;
        AtmVisible: Boolean;
        AccountVisible: Boolean;
        ProductNxK: Record "FOSA Account NOK Details";
        MembNxK: Record "Members Nominee";
        cloudRequest: Record "Change Request";
        nxkinvisible: Boolean;
        Kinchangedetails: Record "Members Nominee";
        DocumentType: Option " ",Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Withdrawal","Membership Reg","Loan Batches","Payment Voucher","Petty Cash",Loan,Interbank,Checkoff,"Savings Product Opening","Standing Order",ChangeRequest;
        MemberNxK: Record "Members Nominee";
        GenSetUp: Record "Sacco General Set-Up";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        NameEditable: Boolean;
        PictureEditable: Boolean;
        SignatureEditable: Boolean;
        AddressEditable: Boolean;
        CityEditable: Boolean;
        EmailEditable: Boolean;
        PersonalNoEditable: Boolean;
        IDNoEditable: Boolean;
        MaritalStatusEditable: Boolean;
        PassPortNoEditbale: Boolean;
        AccountTypeEditible: Boolean;
        SectionEditable: Boolean;
        CardNoEditable: Boolean;
        HomeAddressEditable: Boolean;
        LocationEditable: Boolean;
        SubLocationEditable: Boolean;
        DistrictEditable: Boolean;
        MemberStatusEditable: Boolean;
        ReasonForChangeEditable: Boolean;
        SigningInstructionEditable: Boolean;
        MonthlyContributionEditable: Boolean;
        MemberCellEditable: Boolean;
        ATMApproveEditable: Boolean;
        CardExpiryDateEditable: Boolean;
        CardValidFromEditable: Boolean;
        CardValidToEditable: Boolean;
        ATMNOEditable: Boolean;
        ATMIssuedEditable: Boolean;
        ATMSelfPickedEditable: Boolean;
        ATMCollectorNameEditable: Boolean;
        ATMCollectorIDEditable: Boolean;
        ATMCollectorMobileEditable: Boolean;
        ResponsibilityCentreEditable: Boolean;
        MobileNoEditable: Boolean;
        SMobileNoEditable: Boolean;
        TypeEditable: Boolean;
        AccountNoEditable: Boolean;
        AccountCategoryEditable: Boolean;
        ReactivationFeeEditable: Boolean;
        RetirementDateEditable: Boolean;

    local procedure UpdateControl()
    begin
        if Status = Status::Open then begin
            NameEditable := true;
            PictureEditable := true;
            SignatureEditable := true;
            AddressEditable := true;
            CityEditable := true;
            EmailEditable := true;
            PersonalNoEditable := true;
            IDNoEditable := true;
            MaritalStatusEditable := true;
            PassPortNoEditbale := true;
            AccountTypeEditible := true;
            EmailEditable := true;
            SectionEditable := true;
            CardNoEditable := true;
            HomeAddressEditable := true;
            LocationEditable := true;
            SubLocationEditable := true;
            DistrictEditable := true;
            MemberStatusEditable := true;
            ReasonForChangeEditable := true;
            SigningInstructionEditable := true;
            MonthlyContributionEditable := true;
            MemberCellEditable := true;
            ATMApproveEditable := true;
            CardExpiryDateEditable := true;
            CardValidFromEditable := true;
            CardValidToEditable := true;
            ATMNOEditable := true;
            ATMIssuedEditable := true;
            ATMSelfPickedEditable := true;
            ATMCollectorNameEditable := true;
            ATMCollectorIDEditable := true;
            ATMCollectorMobileEditable := true;
            ResponsibilityCentreEditable := true;
            MobileNoEditable := true;
            SMobileNoEditable := true;
            AccountNoEditable := true;
            ReactivationFeeEditable := true;
            TypeEditable := true;
            AccountCategoryEditable := true
        end else
            if Status = Status::Pending then begin
                NameEditable := false;
                PictureEditable := false;
                SignatureEditable := false;
                AddressEditable := false;
                CityEditable := false;
                EmailEditable := false;
                PersonalNoEditable := false;
                IDNoEditable := false;
                MaritalStatusEditable := false;
                PassPortNoEditbale := false;
                AccountTypeEditible := false;
                EmailEditable := false;
                SectionEditable := false;
                CardNoEditable := false;
                HomeAddressEditable := false;
                LocationEditable := false;
                SubLocationEditable := false;
                DistrictEditable := false;
                MemberStatusEditable := false;
                ReasonForChangeEditable := false;
                SigningInstructionEditable := false;
                MonthlyContributionEditable := false;
                MemberCellEditable := false;
                ATMApproveEditable := false;
                CardExpiryDateEditable := false;
                CardValidFromEditable := false;
                CardValidToEditable := false;
                ATMNOEditable := false;
                ATMIssuedEditable := false;
                ATMSelfPickedEditable := false;
                ATMCollectorNameEditable := false;
                ATMCollectorIDEditable := false;
                ATMCollectorMobileEditable := false;
                ResponsibilityCentreEditable := false;
                MobileNoEditable := false;
                SMobileNoEditable := false;
                AccountNoEditable := false;
                TypeEditable := false;
                ReactivationFeeEditable := false;
                AccountCategoryEditable := false
            end else
                if Status = Status::Approved then begin
                    NameEditable := false;
                    PictureEditable := false;
                    SignatureEditable := false;
                    AddressEditable := false;
                    CityEditable := false;
                    EmailEditable := false;
                    PersonalNoEditable := false;
                    IDNoEditable := false;
                    MaritalStatusEditable := false;
                    PassPortNoEditbale := false;
                    AccountTypeEditible := false;
                    EmailEditable := false;
                    SectionEditable := false;
                    CardNoEditable := false;
                    HomeAddressEditable := false;
                    LocationEditable := false;
                    SubLocationEditable := false;
                    DistrictEditable := false;
                    MemberStatusEditable := false;
                    ReasonForChangeEditable := false;
                    SigningInstructionEditable := false;
                    MonthlyContributionEditable := false;
                    MemberCellEditable := false;
                    ATMApproveEditable := false;
                    CardExpiryDateEditable := false;
                    CardValidFromEditable := false;
                    CardValidToEditable := false;
                    ATMNOEditable := false;
                    ATMIssuedEditable := false;
                    ATMSelfPickedEditable := false;
                    ATMCollectorNameEditable := false;
                    ATMCollectorIDEditable := false;
                    ATMCollectorMobileEditable := false;
                    ResponsibilityCentreEditable := false;
                    MobileNoEditable := false;
                    SMobileNoEditable := false;
                    AccountNoEditable := false;
                    ReactivationFeeEditable := false;
                    TypeEditable := false;
                    AccountCategoryEditable := false
                end;
    end;
}

