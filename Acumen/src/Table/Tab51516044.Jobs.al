#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516044 "Jobs"
{
    Caption = 'Job';
    DataCaptionFields = "No.",Description;
    DrillDownPageID = UnknownPage53926;
    LookupPageID = UnknownPage53926;

    fields
    {
        field(1;"No.";Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                  JobSetup.Get;
                  NoSeriesMgt.TestManual(JobSetup."Job Nos.");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Search Description";Code[250])
        {
            Caption = 'Search Description';
        }
        field(3;Description;Text[250])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                  "Search Description" := Description;
                TestField("Approval Status","approval status"::Open);
            end;
        }
        field(4;"Description 2";Text[80])
        {
            Caption = 'Description 2';
        }
        field(5;"Bill-to Partner No.";Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer."No." where ("Account Type"=filter(Donor));

            trigger OnValidate()
            begin
                if ("Bill-to Partner No." = '') or ("Bill-to Partner No." <> xRec."Bill-to Partner No.") then
                  if JobLedgEntryExist or JobPlanningLineExist then
                    Error(Text000,FieldCaption("Bill-to Partner No."),TableCaption);
                //UpdateCust;
            end;
        }
        field(12;"Creation Date";Date)
        {
            Caption = 'Creation Date';
            Editable = false;
        }
        field(13;"Starting Date";Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                //CheckDate;
            end;
        }
        field(14;"Ending Date";Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            begin
                if "Period of Performance"="period of performance"::"Open Ended" then Error('You cannot insert and end date if status is open ended');
                //CheckDate;
            end;
        }
        field(19;Status;Option)
        {
            Caption = 'Status';
            OptionCaption = 'Concept Formulation,Proposal,Contract,Project,Completed';
            OptionMembers = "Concept Formulation",Proposal,Contract,Project,Completed;

            trigger OnValidate()
            var
                JobPlanningLine: Record "Job-Planning Line";
            begin
                if xRec.Status <> Status then begin
                  if Status = Status::Project then
                    Validate(Complete,true);
                  if xRec.Status = xRec.Status::Project then begin
                    if Dialog.Confirm(Text004) then
                      Validate(Complete,false)
                    else begin
                      Status := xRec.Status;
                    end;
                  end;
                  JobPlanningLine.SetCurrentkey("Grant No.");
                  JobPlanningLine.SetRange("Grant No.","No.");
                  JobPlanningLine.ModifyAll(Status,Status);
                  Modify;
                end;
            end;
        }
        field(20;"Person Responsible";Code[20])
        {
            Caption = 'Person Responsible';
            TableRelation = Resource;
        }
        field(21;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1,"Global Dimension 1 Code");
                Modify;
            end;
        }
        field(22;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2,"Global Dimension 2 Code");
                Modify;
            end;
        }
        field(23;"Job Posting Group";Code[10])
        {
            Caption = 'Kind of Program';
        }
        field(24;Blocked;Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Posting,All';
            OptionMembers = " ",Posting,All;
        }
        field(29;"Last Date Modified";Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(30;Comment;Boolean)
        {
            CalcFormula = exist("Comment Line" where ("Table Name"=const(16),
                                                      "No."=field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(31;"Customer Disc. Group";Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(32;"Customer Price Group";Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(41;"Language Code";Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(49;"Scheduled Res. Qty.";Decimal)
        {
            CalcFormula = sum("Job-Planning Line"."Quantity (Base)" where ("Grant No."=field("No."),
                                                                           "Schedule Line"=const(true),
                                                                           Type=const(Resource),
                                                                           "No."=field("Resource Filter"),
                                                                           "Planning Date"=field("Planning Date Filter")));
            Caption = 'Scheduled Res. Qty.';
            DecimalPlaces = 0:5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50;"Resource Filter";Code[20])
        {
            Caption = 'Resource Filter';
            FieldClass = FlowFilter;
            TableRelation = Resource;
        }
        field(51;"Posting Date Filter";Date)
        {
            Caption = 'Posting Date Filter';
            FieldClass = FlowFilter;
        }
        field(55;"Resource Gr. Filter";Code[20])
        {
            Caption = 'Resource Gr. Filter';
            FieldClass = FlowFilter;
            TableRelation = "Resource Group";
        }
        field(56;"Scheduled Res. Gr. Qty.";Decimal)
        {
            CalcFormula = sum("Job-Planning Line"."Quantity (Base)" where ("Grant No."=field("No."),
                                                                           "Schedule Line"=const(true),
                                                                           Type=const(Resource),
                                                                           "Resource Group No."=field("Resource Gr. Filter"),
                                                                           "Planning Date"=field("Planning Date Filter")));
            Caption = 'Scheduled Res. Gr. Qty.';
            DecimalPlaces = 0:5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(57;Picture;Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(58;"Bill-to Name";Text[100])
        {
            Caption = 'Bill-to Name';
        }
        field(59;"Bill-to Address";Text[50])
        {
            Caption = ' Address';
        }
        field(60;"Bill-to Address 2";Text[50])
        {
            Caption = 'Email Address';
            ExtendedDatatype = EMail;
        }
        field(61;"Bill-to City";Text[50])
        {
            Caption = 'Bill-to City';
        }
        field(63;County;Text[30])
        {
            CalcFormula = lookup(Customer.County where ("No."=field("Bill-to Partner No.")));
            Caption = 'County';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64;"Bill-to Post Code";Code[20])
        {
            Caption = 'Bill-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(66;"No. Series";Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(67;"Bill-to Country/Region Code";Code[10])
        {
            Caption = 'Bill-to Country/Region Code';
            Editable = true;
            TableRelation = "Country/Region";
        }
        field(68;"Bill-to Name 2";Text[50])
        {
            CalcFormula = lookup(Customer."Name 2" where ("No."=field("Bill-to Partner No.")));
            Caption = 'Bill-to Name 2';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1000;Contractor;Option)
        {
            Caption = 'Contractor';
            OptionCaption = ' ,Prime Contractor,Sub Contractor';
            OptionMembers = " ","Prime Contractor","Sub Contractor";
        }
        field(1001;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if "Currency Code" <> xRec."Currency Code" then
                  if not JobLedgEntryExist then
                    CurrencyUpdatePlanningLines
                  else
                    Error(Text000,FieldCaption("Currency Code"),TableCaption);

                TestField("Approval Status","approval status"::Open);
            end;
        }
        field(1002;"Bill-to Contact No.";Code[20])
        {
            Caption = 'Bill-to Contact No.';

            trigger OnLookup()
            begin
                if ("Bill-to Partner No." <> '') and Cont.Get("Bill-to Contact No.") then
                  Cont.SetRange("Company No.",Cont."Company No.")
                else
                  if Cust.Get("Bill-to Partner No.") then begin
                    ContBusinessRelation.Reset;
                    ContBusinessRelation.SetCurrentkey("Link to Table","No.");
                    ContBusinessRelation.SetRange("Link to Table",ContBusinessRelation."link to table"::Customer);
                    ContBusinessRelation.SetRange("No.","Bill-to Partner No.");
                    if ContBusinessRelation.Find('-') then
                      Cont.SetRange("Company No.",ContBusinessRelation."Contact No.");
                  end else
                    Cont.SetFilter("Company No.",'<>''''');

                if "Bill-to Contact No." <> '' then
                  if Cont.Get("Bill-to Contact No.") then ;
            end;

            trigger OnValidate()
            begin
                if Blocked >= Blocked::Posting then
                  Error(Text000,FieldCaption("Bill-to Contact No."),TableCaption);

                if ("Bill-to Contact No." <> xRec."Bill-to Contact No.") and
                   (xRec."Bill-to Contact No." <> '')
                then begin
                  if ("Bill-to Contact No." = '') and ("Bill-to Partner No." = '') then begin
                    Init;
                    "No. Series" := xRec."No. Series";
                    Validate(Description,xRec.Description);
                  end;
                end;

                if ("Bill-to Partner No." <> '') and ("Bill-to Contact No." <> '') then begin
                  Cont.Get("Bill-to Contact No.");
                  ContBusinessRelation.Reset;
                  ContBusinessRelation.SetCurrentkey("Link to Table","No.");
                  ContBusinessRelation.SetRange("Link to Table",ContBusinessRelation."link to table"::Customer);
                  ContBusinessRelation.SetRange("No.","Bill-to Partner No.");
                  if ContBusinessRelation.Find('-') then
                    if ContBusinessRelation."Contact No." <> Cont."Company No." then
                      Error(Text005,Cont."No.",Cont.Name,"Bill-to Partner No.");
                end;
                UpdateBillToCust("Bill-to Contact No.");
            end;
        }
        field(1003;"Bill-to Contact";Text[50])
        {
            Caption = 'Bill-to Contact';
        }
        field(1004;"Planning Date Filter";Date)
        {
            Caption = 'Planning Date Filter';
            FieldClass = FlowFilter;
        }
        field(1005;"Total WIP Cost Amount";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total WIP Cost Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1006;"Total WIP Cost G/L Amount";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total WIP Cost G/L Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1007;"WIP Posted To G/L";Boolean)
        {
            Caption = 'WIP Posted To G/L';
            Editable = false;
        }
        field(1008;"WIP Posting Date";Date)
        {
            Caption = 'WIP Posting Date';
            Editable = false;
        }
        field(1009;"WIP G/L Posting Date";Date)
        {
            Caption = 'WIP G/L Posting Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1010;"Posted WIP Method Used";Option)
        {
            Caption = 'Posted WIP Method Used';
            Editable = false;
            OptionCaption = ' ,Cost Value,Sales Value,Cost of Sales,Percentage of Completion,Completed Contract';
            OptionMembers = " ","Cost Value","Sales Value","Cost of Sales","Percentage of Completion","Completed Contract";
        }
        field(1011;"Invoice Currency Code";Code[10])
        {
            Caption = 'Invoice Currency Code';
            TableRelation = Currency;
        }
        field(1012;"Exch. Calculation (Cost)";Option)
        {
            Caption = 'Exch. Calculation (Cost)';
            OptionCaption = 'Fixed LCY,Fixed FCY';
            OptionMembers = "Fixed LCY","Fixed FCY";
        }
        field(1013;"Exch. Calculation (Price)";Option)
        {
            Caption = 'Exch. Calculation (Price)';
            OptionCaption = 'Fixed FCY,Fixed LCY';
            OptionMembers = "Fixed FCY","Fixed LCY";
        }
        field(1014;"Allow Schedule/Contract Lines";Boolean)
        {
            Caption = 'Allow Schedule/Contract Lines';
        }
        field(1015;Complete;Boolean)
        {
            Caption = 'Complete';

            trigger OnValidate()
            begin
                if Complete <> xRec.Complete then
                  ChangeJobCompletionStatus;
            end;
        }
        field(1016;"Calc. WIP Method Used";Option)
        {
            Caption = 'Calc. WIP Method Used';
            Editable = false;
            OptionCaption = ' ,Cost Value,Sales Value,Cost of Sales,Percentage of Completion,Completed Contract';
            OptionMembers = " ","Cost Value","Sales Value","Cost of Sales","Percentage of Completion","Completed Contract";
        }
        field(1017;"Amount Awarded";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount Awarded';
            Editable = true;
            FieldClass = Normal;
        }
        field(1018;"Recog. Sales G/L Amount";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recog. Sales G/L Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1019;"Recog. Costs Amount";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recog. Costs Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1020;"Recog. Costs G/L Amount";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Recog. Costs G/L Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1021;"Total WIP Sales Amount";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total WIP Sales Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1022;"Total WIP Sales G/L Amount";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total WIP Sales G/L Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(1023;"Completion Calculated";Boolean)
        {
            Caption = 'Completion Calculated';
            FieldClass = FlowField;
        }
        field(1024;"Next Invoice Date";Date)
        {
            CalcFormula = min("Job-Planning Line"."Planning Date" where ("Grant No."=field("No."),
                                                                         "Contract Line"=filter(=true),
                                                                         Invoiced=filter(=false)));
            Caption = 'Next Invoice Date';
            FieldClass = FlowField;
        }
        field(50000;"Grant Phases";Code[10])
        {
        }
        field(50001;"Approval Status";Option)
        {
            Editable = true;
            OptionCaption = 'Open,Pending Approval,Approved';
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(50002;"Responsibility Center";Code[10])
        {
            TableRelation = "Responsibility Center BR";
        }
        field(50003;"Total Cost";Decimal)
        {
            CalcFormula = sum("Job-Planning Line"."Total Cost" where ("Grant No."=field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004;"Total Cost(LCY)";Decimal)
        {
            CalcFormula = sum("Job-Planning Line"."Total Cost (LCY)" where ("Grant No."=field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005;"Contract Description";Text[150])
        {
        }
        field(50006;"Contract Type";Code[10])
        {
            TableRelation = "Responsibility Center";
        }
        field(50007;"Disbursed Amount";Decimal)
        {
            CalcFormula = sum("Payment Line.".Amount where ("Shortcut Dimension 2 Code"=field("No.")));
            FieldClass = FlowField;
        }
        field(50008;"Allow OverExpenditure";Boolean)
        {
        }
        field(50009;"Accounted Amount";Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010;"Received Amount";Decimal)
        {
            FieldClass = FlowField;
        }
        field(50011;"Proposal No";Code[20])
        {
            Editable = false;
            TableRelation = Jobs."No." where ("No."=field("Proposal No"),
                                              Status=const(Proposal));
        }
        field(50012;"Converted To Proposal";Boolean)
        {
            Editable = false;
        }
        field(50013;"Project No";Code[20])
        {
            Editable = true;
            TableRelation = Jobs."No." where ("No."=field("Project No"),
                                              Status=const(Contract));
        }
        field(50014;"Converted To Project";Boolean)
        {
            Editable = true;
        }
        field(50015;"Concept Number";Code[20])
        {
        }
        field(50016;Objective;Text[150])
        {
        }
        field(50017;"Contract No";Code[20])
        {
        }
        field(50018;"Reporting dates generated";Boolean)
        {
            Editable = false;
            FieldClass = FlowField;
        }
        field(50019;"Condition for budget realloca";Code[10])
        {
        }
        field(50020;"Principal Investigator";Text[100])
        {
            TableRelation = Resource;

            trigger OnValidate()
            begin
                 objReso.Reset;
                 objReso.SetRange(objReso."No.","Principal Investigator");
                if objReso.Find('-') then begin
                 "Principal Investigator name":=objReso.Name;
                 "Bill-to Address" :=objReso.Address;
                 //"Bill-to Address 2":=objReso.Email;
                 //Institution:=objReso.Institution;
                end;
            end;
        }
        field(50021;"Expected Receipt Amount";Decimal)
        {
            FieldClass = FlowField;
        }
        field(50022;Partners;Boolean)
        {
            Caption = 'Collaborative Grants';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50023;"Project Location";Text[70])
        {
        }
        field(50024;"Income Account";Code[10])
        {
        }
        field(50025;"Concept Approval Date";DateTime)
        {
            Editable = false;
        }
        field(50026;"Project Filter";Code[10])
        {
            FieldClass = Normal;
        }
        field(50027;Title;Text[30])
        {
        }
        field(50028;"Project Coordinator";Text[100])
        {
            TableRelation = Resource;
        }
        field(50029;Task;Option)
        {
            OptionCaption = ' ,Research,Service';
            OptionMembers = " ",Research,Service;
        }
        field(50030;"Project Status";Option)
        {
            OptionCaption = 'Setup,In Progress,Halted,Completed';
            OptionMembers = Setup,"In Progress",Halted,Completed;
        }
        field(50031;"Audit Indicator";Boolean)
        {
        }
        field(50032;"Approved Funding Start Date";Date)
        {
        }
        field(50033;"Approved Funding End Date";Date)
        {
        }
        field(50034;"Justification Narration";Text[200])
        {
            Description = 'Narrations defined esp. when modifying  the project/contract info';
        }
        field(50035;"Amount Invoiced";Decimal)
        {
            FieldClass = FlowField;
        }
        field(50036;"Grant Level";Option)
        {
            OptionCaption = 'Grant,Sub-Grant';
            OptionMembers = Grant,"Sub-Grant";
        }
        field(50037;"RSPO No.";Code[30])
        {
        }
        field(50038;"Alert sent";Boolean)
        {
        }
        field(50039;"Proposal Application due Date";Date)
        {
        }
        field(50040;Submission;Option)
        {
            OptionCaption = ' ,Paper Submission,Electronic Submission';
            OptionMembers = " ","Paper Submission","Electronic Submission";
        }
        field(50041;"PI Name";Text[100])
        {
            Caption = 'PI At Collaborative Institution';

            trigger OnValidate()
            begin
                /*objPImaster.RESET;
                objPImaster.SETRANGE(objPImaster."PI Code","PI Name");
                IF objPImaster.FIND('-') THEN BEGIN
                 "PI Address":=objPImaster."PI Address";
                 "PI Telephone":=objPImaster."PI Telephone";
                 "PI EMail":=objPImaster."PI EMail";
                 MODIFY;
                END;
                */

            end;
        }
        field(50042;"PI Address";Text[30])
        {
        }
        field(50043;"PI Telephone";Text[30])
        {
        }
        field(50044;"PI EMail";Text[30])
        {
            ExtendedDatatype = EMail;
        }
        field(50045;"Collaborative Grant";Boolean)
        {
        }
        field(50046;"IREC Approval";Option)
        {
            OptionCaption = 'Pending Approval,Approved,Exempt';
            OptionMembers = "Pending Approval",Approved,Exempt;
        }
        field(50047;"IREC Approval Date";Date)
        {
        }
        field(50048;"Cost Share";Boolean)
        {
        }
        field(50049;"Cost Share Details";Text[100])
        {
        }
        field(50050;Matching;Boolean)
        {
        }
        field(50051;"Matching Details";Text[150])
        {
        }
        field(50052;"Application disposition Status";Option)
        {
            OptionCaption = ' ,Signed By Institutions Authorities,Returned to PI,Forwarded to funding Agency';
            OptionMembers = " ","Signed By Institutions Authorities","Returned to PI","Forwarded to funding Agency";
        }
        field(50053;"SubAward No.";Code[20])
        {
            Description = 'Project Sub award';
        }
        field(50054;"Payment Methods";Code[20])
        {
            TableRelation = "Payment Method".Code;
        }
        field(50055;Schools;Code[10])
        {
            Caption = 'Kind of Program';
        }
        field(50056;"Application Due Date";Date)
        {
        }
        field(50057;"Funding Request";Boolean)
        {
        }
        field(50058;Budget;Boolean)
        {
        }
        field(50059;"Budget Justification";Boolean)
        {
        }
        field(50060;"Project Summary Abstract";Boolean)
        {
        }
        field(50061;"RSPO Completion List";Boolean)
        {
        }
        field(50062;Donors;Boolean)
        {
            FieldClass = FlowField;
        }
        field(50063;Workplan;Boolean)
        {
            FieldClass = FlowField;
        }
        field(50064;"Period of Performance";Option)
        {
            OptionMembers = "Multiple Years","One Year","Open Ended";

            trigger OnValidate()
            begin
                if "Period of Performance"="period of performance"::"Open Ended" then "Ending Date":=0D;
            end;
        }
        field(50065;"Principal Investigator name";Text[100])
        {
        }
        field(50066;"Response To fund Opportunity";Boolean)
        {
        }
        field(50067;"Main Donor";Code[50])
        {
            TableRelation = Customer."No." where ("Account Type"=filter(Donor));
        }
        field(50068;"Main Sub";Code[50])
        {
            TableRelation = Vendor."No." where (Tes=filter(1));
        }
        field(50069;"Special Contract Provision";Text[250])
        {
        }
        field(50070;"Funding Agency No.";Code[20])
        {
        }
        field(50071;"Type Of Funding";Option)
        {
            OptionCaption = ',Discretionary,Donations,Supplimental Funds,Others';
            OptionMembers = ,Discretionary,Donations,"Supplimental Funds",Others;
        }
        field(50072;"Responsible Officer";Code[50])
        {
        }
        field(50073;"RFA/A Receipt Date";Date)
        {
        }
        field(50074;"Project Team";Code[20])
        {
            TableRelation = "Resource Group"."No.";
        }
        field(50075;Institution;Option)
        {
            OptionCaption = ' ,MTRH,MU,OTHERS';
            OptionMembers = " ",MTRH,MU,OTHERS;
        }
        field(50076;"Moi/MTRH Collaborator";Boolean)
        {
            Caption = 'Do you have a previous Collaboration with Moi/MTRH ?';
        }
        field(50077;"AMPATH Affiliation Consortium";Boolean)
        {
        }
        field(50078;"Previous MU Consortium School?";Boolean)
        {
        }
        field(50079;"Which MU Consortium School";Text[50])
        {
        }
        field(50080;"ASANTE Collaborator?";Boolean)
        {
        }
        field(50081;"ASANTE Collaborator Details";Text[50])
        {
        }
        field(50082;"Assist identifying Collabotor?";Boolean)
        {
        }
        field(50083;"Study Type";Option)
        {
            OptionCaption = ' ,Retrospective Cohort,Propective Cohort,Clinical trial,Others';
            OptionMembers = " ","Retrospective Cohort","Propective Cohort","Clinical trial",Others;
        }
        field(50084;"Study Type Details";Text[50])
        {
        }
        field(50085;"Brief Description of Study";Text[20])
        {
        }
        field(50086;"Study Funded";Boolean)
        {
        }
        field(50087;"Funding Source/Funding Sought";Text[50])
        {
        }
        field(50088;"Application Deadline";Date)
        {
        }
        field(50089;"Lab Services";Boolean)
        {

            trigger OnValidate()
            begin
                 /*IF "Lab Services"=TRUE THEN BEGIN
                   IF CONFIRM('Are you sure you want to update the Lab Request')=TRUE THEN BEGIN
                     `objLabRequest.RESET;
                     objLabRequest.SETRANGE(objLabRequest."Proposal No.","No.");
                     IF objLabRequest.FIND('-') THEN EXIT
                     ELSE BEGIN
                      objLabRequest.INIT;
                      objLabRequest."Proposal No.":="No.";
                      objLabRequest.INSERT;
                     END;
                   END;
                 END;
                 */

            end;
        }
        field(50090;"AMPATH Data Mgt Core Required";Boolean)
        {
        }
        field(50091;"Contracted To";Text[150])
        {
            Description = 'Added:'' for capturing details of subs in commas form  -came up during data import';
        }
        field(50092;"Biostats Core Required";Boolean)
        {
        }
        field(50093;"Prime Institution";Code[50])
        {
            Description = 'Added:'' for capturing details prime institution -came up during data import';
        }
        field(50094;"Workgroup Recomendation";Option)
        {
            OptionCaption = ' ,Do not support further Development,Support further Development,Support Study and feel no further input is needed';
            OptionMembers = " ","Do not support further Development","Support further Development","Support Study and feel no further input is needed";
        }
        field(50095;"Recomendation Description";Text[50])
        {
        }
        field(50096;"Approved Budget Start Date";Date)
        {
        }
        field(50097;"Approved Budget End Date";Date)
        {
        }
        field(50098;"Financial Reporting Due Date";DateFormula)
        {
        }
        field(50099;"Technical  Reporting Due Date";DateFormula)
        {
        }
        field(50100;"Obligated Amount";Decimal)
        {
            CalcFormula = sum(Committment.Amount where ("Shortcut Dimension 2 Code"=field("No.")));
            Description = 'An alert to be provided when the grant expenditure is 95% of the project expenditure';
            FieldClass = FlowField;
        }
        field(50101;"Re:";Text[100])
        {
        }
        field(50102;"System Contract No";Code[20])
        {
        }
        field(50103;"Converted To Contract";Boolean)
        {
        }
        field(50104;"Indirect Cost";Boolean)
        {
        }
        field(50105;"Allowed Indirect Cost";Decimal)
        {
        }
        field(50106;"Consistence with inst. Objs.";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"No.")
        {
            Clustered = true;
        }
        key(Key2;"Search Description")
        {
        }
        key(Key3;"Bill-to Partner No.")
        {
        }
        key(Key4;Description)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        CommentLine: Record "Comment Line";
        JobTask: Record "Job-Task";
    begin
        /*MoveEntries.MoveJobEntries(Rec);
        
        JobTask.SETCURRENTKEY("Grant No.");
        JobTask.SETRANGE("Grant No.","No.");
        JobTask.DELETEALL(TRUE);
        
        JobResPrice.SETRANGE("Job No.","No.");
        JobResPrice.DELETEALL;
        
        JobItemPrice.SETRANGE("Job No.","No.");
        JobItemPrice.DELETEALL;
        
        JobGLAccPrice.SETRANGE("Job No.","No.");
        JobGLAccPrice.DELETEALL;
        
        CommentLine.SETRANGE("Table Name",CommentLine."Table Name"::Job);
        CommentLine.SETRANGE("No.","No.");
        CommentLine.DELETEALL;
        
        DimMgt.DeleteDefaultDim(DATABASE::Jobs,"No.");
        TESTFIELD("Approval Status","Approval Status"::Open);
        
        ProjectPartners.SETRANGE(ProjectPartners."Grant No","No.");
        ProjectPartners.DELETEALL;
        
        ProjectDonors.SETRANGE(ProjectDonors."Grant No","No.");
        ProjectDonors.DELETEALL;
        
        ProjPersonnel.SETRANGE(ProjPersonnel.Project,"No.");
        ProjPersonnel.DELETEALL;
        */

    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
          JobSetup.Get;
          JobSetup.TestField("Concept Nos");
          NoSeriesMgt.InitSeries(JobSetup."Concept Nos",xRec."No. Series",0D,"No.","No. Series");
        end;

        if GetFilter("Bill-to Partner No.") <> '' then
          if GetRangeMin("Bill-to Partner No.") = GetRangemax("Bill-to Partner No.") then
            Validate("Bill-to Partner No.",GetRangeMin("Bill-to Partner No."));

        DimMgt.UpdateDefaultDim(
          Database::Jobs,"No.",
          "Global Dimension 1 Code","Global Dimension 2 Code");
        InitWIPFields;

        "Creation Date" := Today;
        "Last Date Modified" := "Creation Date";
        //Status:=Status::Proposal;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
        TestField("Approval Status","approval status"::Open);
    end;

    var
        Text000: label 'You cannot change %1 because one or more entries are associated with this %2.';
        JobSetup: Record "Jobs-Setup";
        PostCode: Record "Post Code";
        Job: Record Jobs;
        Cust: Record Customer;
        Cont: Record Contact;
        ContBusinessRelation: Record "Contact Business Relation";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        Text003: label 'You must run the %1 and %2 functions to create and post the completion entries for this job.';
        Text004: label 'This will delete any unposted WIP entries for this job and allow you to reverse the completion postings for this job.\\Do you wish to continue?';
        Text005: label 'Contact %1 %2 is related to a different company than customer %3.';
        Text006: label 'Contact %1 %2 is not related to customer %3.';
        Text007: label 'Contact %1 %2 is not related to a customer.';
        Text008: label '%1 %2 must not be blocked with type %3.';
        Text009: label 'You must run the %1 function to reverse the completion entries that have already been posted for this job.';
        MoveEntries: Codeunit MoveEntries;
        Text010: label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        Text011: label '%1 must be equal to or earlier than %2.';
        JobTask: Record "Job-Task";
        JobTasks: Record "Job-Task";
        JobPlanningLine: Record "Job-Planning Line";
        JobPlanningLines: Record "Job-Planning Line";
        LastEntryNo: Integer;
        JobEntryNo: Record "Job Entry No.";
        ApprovalEntries: Record "Approval Entry";
        ApprovalDate: DateTime;
        DimVal: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        ProjectCode: Code[10];
        objReso: Record Resource;


    procedure AssistEdit(OldJob: Record Jobs): Boolean
    begin
        with Job do begin
          Job := Rec;
          JobSetup.Get;
          JobSetup.TestField("Job Nos.");
          if NoSeriesMgt.SelectSeries(JobSetup."Job Nos.",OldJob."No. Series","No. Series") then begin
            JobSetup.Get;
            JobSetup.TestField("Job Nos.");
            NoSeriesMgt.SetSeries("No.");
            Rec := Job;
            exit(true);
          end;
        end;
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer;ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::Jobs,"No.",FieldNumber,ShortcutDimCode);
        Modify;
    end;


    procedure UpdateBillToCont(CustomerNo: Code[20])
    var
        ContBusRel: Record "Contact Business Relation";
        Cust: Record Customer;
    begin
        if Cust.Get(CustomerNo) then begin
          if Cust."Primary Contact No." <> '' then
            "Bill-to Contact No." := Cust."Primary Contact No."
          else begin
            ContBusRel.Reset;
            ContBusRel.SetCurrentkey("Link to Table","No.");
            ContBusRel.SetRange("Link to Table",ContBusRel."link to table"::Customer);
            ContBusRel.SetRange("No.","Bill-to Partner No.");
            if ContBusRel.Find('-') then
              "Bill-to Contact No." := ContBusRel."Contact No.";
          end;
          "Bill-to Contact" := Cust.Contact;
        end;
    end;

    local procedure JobLedgEntryExist(): Boolean
    var
        JobLedgEntry: Record "Job-Ledger Entry";
    begin
        Clear(JobLedgEntry);
        JobLedgEntry.SetCurrentkey("Job No.");
        JobLedgEntry.SetRange("Job No.","No.");
        exit(JobLedgEntry.Find('-'));
    end;

    local procedure JobPlanningLineExist(): Boolean
    var
        JobPlanningLine: Record "Job-Planning Line";
    begin
        JobPlanningLine.Init;
        JobPlanningLine.SetRange("Grant No.","No.");
        exit(JobPlanningLine.Find('-'));
    end;


    procedure UpdateBillToCust(ContactNo: Code[20])
    var
        ContBusinessRelation: Record "Contact Business Relation";
        Cust: Record Customer;
        Cont: Record Contact;
    begin
        if Cont.Get(ContactNo) then begin
          "Bill-to Contact No." := Cont."No.";
          if Cont.Type = Cont.Type::Person then
            "Bill-to Contact" := Cont.Name
          else
            if Cust.Get("Bill-to Partner No.") then
              "Bill-to Contact" := Cust.Contact
            else
              "Bill-to Contact" := '';
        end else begin
          "Bill-to Contact" := '';
          exit;
        end;

        ContBusinessRelation.Reset;
        ContBusinessRelation.SetCurrentkey("Link to Table","Contact No.");
        ContBusinessRelation.SetRange("Link to Table",ContBusinessRelation."link to table"::Customer);
        ContBusinessRelation.SetRange("Contact No.",Cont."Company No.");
        if ContBusinessRelation.Find('-') then begin
          if "Bill-to Partner No." = '' then
            Validate("Bill-to Partner No.",ContBusinessRelation."No.")
          else
            if "Bill-to Partner No." <> ContBusinessRelation."No." then
              Error(Text006,Cont."No.",Cont.Name,"Bill-to Partner No.");
        end else
          Error(Text007,Cont."No.",Cont.Name);
    end;


    procedure UpdateCust()
    begin
        if "Bill-to Partner No." <> '' then begin
          Cust.Get("Bill-to Partner No.");
          Cust.TestField("Customer Posting Group");
          Cust.TestField("Bill-to Customer No.",'');
          "Bill-to Name" := Cust.Name;
          "Bill-to Name 2" := Cust."Name 2";
          "Bill-to Address" := Cust.Address;
          "Bill-to Address 2" := Cust."Address 2";
          "Bill-to City" := Cust.City;
          "Bill-to Post Code" := Cust."Post Code";
          "Bill-to Country/Region Code" := Cust."Country/Region Code";
          "Currency Code" := Cust."Currency Code";
          "Customer Disc. Group" := Cust."Customer Disc. Group";
          "Customer Price Group" := Cust."Customer Price Group";
          "Language Code" := Cust."Language Code";
          County := Cust.County;
          UpdateBillToCont("Bill-to Partner No.");
        end else begin
          "Bill-to Name" := '';
          "Bill-to Name 2" := '';
          "Bill-to Address" := '';
          "Bill-to Address 2" := '';
          "Bill-to City" := '';
          "Bill-to Post Code" := '';
          "Bill-to Country/Region Code" := '';
          "Currency Code" := '';
          "Customer Disc. Group" := '';
          "Customer Price Group" := '';
          "Language Code" := '';
          County := '';
          Validate("Bill-to Contact No.",'');
        end;
    end;


    procedure InitWIPFields()
    begin
        "WIP Posted To G/L" := false;
        "WIP Posting Date" := 0D;
        "WIP G/L Posting Date" := 0D;
        "Posted WIP Method Used" := 0;
    end;


    procedure TestBlocked()
    begin
        if Blocked = Blocked::" " then
          exit;
        Error(Text008,TableCaption,"No.",Blocked);
    end;


    procedure CurrencyUpdatePlanningLines()
    var
        PlaningLine: Record "Job-Planning Line";
    begin
        /*PlaningLine.SETRANGE("Grant No.","No.");
        IF PlaningLine.FIND('-') THEN
          REPEAT
            IF PlaningLine.Transferred THEN
              ERROR(Text000,FIELDCAPTION("Currency Code"),TABLECAPTION);
            PlaningLine.VALIDATE("Currency Code","Currency Code");
            PlaningLine.VALIDATE("Currency Date");
            PlaningLine.MODIFY;
          UNTIL PlaningLine.NEXT = 0;
          */

    end;


    procedure ChangeJobCompletionStatus()
    var
        AllObjwithCaption: Record AllObjWithCaption;
        JobCalcWIP: Codeunit "Job Calculate WIP";
        ReportCaption1: Text[250];
        ReportCaption2: Text[250];
    begin
        AllObjwithCaption.Get(AllObjwithCaption."object type"::Report,Report::"Job Calculate WIP");
        ReportCaption1 := AllObjwithCaption."Object Caption";
        AllObjwithCaption.Get(AllObjwithCaption."object type"::Report,Report::"Job Post WIP to G/L");
        ReportCaption2 := AllObjwithCaption."Object Caption";

        if Complete = true then
          Message(Text003,ReportCaption1,ReportCaption2)
        else begin
          JobCalcWIP.ReOpenJob("No.");
          "WIP Posting Date" := 0D;
          "Calc. WIP Method Used" := 0;
          Message(Text009,ReportCaption2);
        end;
    end;


    procedure DisplayMap()
    var
        MapPoint: Record "Online Map Setup";
        MapMgt: Codeunit "Online Map Management";
    begin
        if MapPoint.Find('-') then
          MapMgt.MakeSelection(Database::Jobs,GetPosition)
        else
          Message(Text010);
    end;


    procedure GetQuantityAvailable(ItemNo: Code[20];LocationCode: Code[10];VariantCode: Code[10];InEntryType: Option Usage,Sale,Both;Direction: Option Possitive,Negative,Both) QtyBase: Decimal
    var
        JobLedgEntry: Record "Job-Ledger Entry";
    begin
        Clear(JobLedgEntry);
        with JobLedgEntry do begin
          SetCurrentkey("Job No.","Entry Type",Type,"No.");
          SetRange("Job No.",Rec."No.");
          if not (InEntryType = Inentrytype::Both) then
            SetRange("Entry Type",InEntryType);
          SetRange(Type,Type::Item);
          SetRange("No.",ItemNo);
          if FindSet then
            repeat
              if ("Location Code" = LocationCode) and
                 ("Variant Code" = VariantCode) and
                 ((Direction = Direction::Both) or
                  ((Direction = Direction::Possitive) and ("Quantity (Base)" > 0)) or
                  ((Direction = Direction::Negative) and ("Quantity (Base)" < 0)))
              then
                QtyBase := QtyBase + "Quantity (Base)";
            until Next = 0;
        end;
    end;

    local procedure CheckDate()
    begin
        if ("Starting Date" > "Ending Date") and ("Ending Date" <> 0D) then
          Error(Text011,FieldCaption("Starting Date"),FieldCaption("Ending Date"));
    end;


    procedure ChangeProjectStatus()
    begin
        /*//LastEntryNo:=JobPlanningLine.GETRANGEMAX(JobPlanningLine."Grant Contract Entry No.");
        ApprovalEntries.RESET;
        ApprovalEntries.SETRANGE(ApprovalEntries."Document Type",ApprovalEntries."Document Type"::None);
        ApprovalEntries.SETRANGE(ApprovalEntries."Document No.","No.");
        IF ApprovalEntries.FIND('+') THEN
        ApprovalDate:=ApprovalEntries."Last Date-Time Modified"
        ELSE
        ApprovalDate:=0DT;
        */
        //+++++++++++++++++++++++++++++++++++++++++++++++++++
        
        if Status = Status::"Concept Formulation" then begin
        if Confirm('Convert concept to proposal?',true)=false then exit;
           if "Approval Status"<>"approval status"::Approved then Error('Status must be approved to continue');
        //+++++++++++++++++++++++++++++++++++++++++++++++++++
         if "Proposal No" ='' then
          begin
            JobSetup.Get;
            JobSetup.TestField(JobSetup."Proposal Nos");
            NoSeriesMgt.InitSeries(JobSetup."Proposal Nos",xRec."No. Series",0D,"Proposal No","No. Series");
          end;
            //+++++++++++++++++++++++++++++++++++++++++++++++++++
            Job.Init;
            Job."Concept Number":= "No.";
            Job."No.":="Proposal No";
            Job.Description:=Description;
            Job."Description 2":="Description 2";
        
            Job."Bill-to Partner No.":="Bill-to Partner No.";
            Job.Validate("Bill-to Partner No.");
            Job.Status:=Job.Status::Proposal;
            Job."Approval Status":=Job."approval status"::Open;
            Job."Creation Date":=Today;
            Job."Person Responsible":="Person Responsible";
            Job."Starting Date":="Starting Date";
            Job."Ending Date":="Ending Date";
            Job."Bill-to Name":="Bill-to Name";
            Job."Bill-to Address":="Bill-to Address";
            Job."Bill-to Address 2":="Bill-to Address 2";
            Job."Bill-to City":="Bill-to City";
            Job."Bill-to Post Code":="Bill-to Post Code";
        
            Job."Last Date Modified":=Today;
            Job.Objective:=Objective;
            Job."Job Posting Group":="Job Posting Group";
            Job."Principal Investigator":="Principal Investigator";
            Job."Concept Approval Date":=ApprovalDate;
            Job.Insert;
        
            "Converted To Proposal":=true;
            "Proposal No":=Job."No.";
            //+++++++++++++++++++++++++++++++++++++++++++++++++
        
            //++++++++++++++++++Copy Project Personnel++++++++++++++
            /*ProjPersonnel.RESET;
            ProjPersonnel.SETRANGE(ProjPersonnel.Project,"No.");
            IF ProjPersonnel.FIND('-') THEN
            REPEAT
        
            WITH ProjPersonnels DO BEGIN
            INIT;
            ProjPersonnels.Project:="Proposal No";
            ProjPersonnels."Employee No":=ProjPersonnel."Employee No";
            ProjPersonnels.VALIDATE(ProjPersonnels."Employee No");
            ProjPersonnels."Project Role":=ProjPersonnel."Project Role";
            ProjPersonnels."Start Date":=ProjPersonnel."Start Date";
            ProjPersonnels."End Date":=ProjPersonnel."End Date";
            ProjPersonnels."% Allocation Value":=ProjPersonnel."% Allocation Value";
            INSERT;
            END;
            UNTIL ProjPersonnel.NEXT=0;
            //++++++++++++++++++End Copy Project Personnel++++++++++++++
            //++++++++++++++++++Copy Partners++++++++++++++++++
            ProjectPartners.RESET;
            ProjectPartners.SETRANGE(ProjectPartners."Grant No","No.");
            IF ProjectPartners.FIND('-') THEN
            REPEAT
            WITH ProjectPartner DO BEGIN
            INIT;
            ProjectPartner."Grant No":="Proposal No";
            ProjectPartner.PartnerID:=ProjectPartners.PartnerID;
            ProjectPartner."Partner Name":=ProjectPartners."Partner Name";
            INSERT;
            END;
            UNTIL ProjectPartners.NEXT =0;
        
            //++++++++++++++++End Copy Partners++++++++++++++++
        
            //+++++++++++++++++Copy Donors+++++++++++++++++++++
            ProjectDonors.RESET;
            ProjectDonors.SETRANGE(ProjectDonors."Grant No","No.");
            IF ProjectDonors.FIND('-') THEN
            REPEAT
            WITH ProjectDonor DO BEGIN
            INIT;
            ProjectDonor."Grant No":="Proposal No";
            ProjectDonor."Shortcut Dimension 1 Code":=ProjectDonors."Shortcut Dimension 1 Code";
            ProjectDonor."Donor Name":=ProjectDonors."Donor Name";
            ProjectDonor."Expected Donation":=ProjectDonors."Expected Donation";
            INSERT;
            END;
            UNTIL ProjectDonors.NEXT=0;
            //+++++++++++++++++End Copy Donors++++++++++++++++++
        
            //++++++Copy Task Lines++++++++++++++++++++++++
            */
             JobTask.Reset;
             JobTask.SetRange(JobTask."Grant No.","No.");
             if JobTask.FindFirst then
             begin
                  repeat
                     with JobTasks do
                     begin
                     Init;
                     Validate(JobTasks."Grant No.","Proposal No");
                     JobTasks."Grant Task No.":=JobTask."Grant Task No.";
                     JobTasks.Description:=JobTask.Description;
                     Insert;
                     end
                  until JobTask.Next=0;
             end;
            //++++++++End Copy Task Lines++++++++++++++++++
        
            //++++++++Copy Planning Lines++++++++++++++++++
            JobPlanningLine.Reset;
            JobPlanningLine.SetRange(JobPlanningLine."Grant No.","No.");
            if JobPlanningLine.FindFirst then
            begin
                 repeat
                    with JobPlanningLines do
                    begin
        
                    Init;
                    Validate(JobPlanningLines."Grant No.","Proposal No");
                    JobPlanningLines."Grant Task No.":=JobPlanningLine."Grant Task No.";
                    JobPlanningLines."Line No.":=JobPlanningLine."Line No.";
                    JobPlanningLines.Type:=JobPlanningLines.Type;
                    JobPlanningLines."No.":=JobPlanningLine."No.";
                    JobPlanningLines.Quantity:=JobPlanningLine.Quantity;
                    JobPlanningLines.Partner:=JobPlanningLine.Partner;
                    JobPlanningLines."Global Dimension 1 Code":=JobPlanningLine."Global Dimension 1 Code";
                    JobPlanningLines."Unit Cost":=JobPlanningLine."Unit Cost";
                    JobPlanningLines.Validate(JobPlanningLines."Unit Cost");
                    JobPlanningLines."Budget Period":=JobPlanningLine."Budget Period";
                    JobPlanningLines.Description:=JobPlanningLine.Description;
                    //JobPlanningLines."Grant Contract Entry No.":=JobEntryNo.getGetNextEntryNo;
                    Insert;
                    end
                 until JobPlanningLine.Next=0;
            end;
            //++++++++End Copy Planning Lines++++++++++++++
        
            Message('Concept No'+' '+ "No." +' '+ 'has successfully been converted to proposal No.'+' '+"Proposal No");
            Modify;
            end else begin if Status = Status::Proposal then begin
            if Confirm('Convert Proposal to Contract?',true)=false then exit;
            //+++++++++++++++++++++++++++++++++++++++++++++++++++
            if "System Contract No" ='' then
            begin
            JobSetup.Get();
            JobSetup.TestField(JobSetup."System Contract Nos");
            NoSeriesMgt.InitSeries(JobSetup."System Contract Nos",xRec."No. Series",0D,"System Contract No","No. Series");
            end;
            //+++++++++++++++++++++++++++++++++++++++++++++++++++
        
            Job.Init;
            Job."No.":="System Contract No";
            Job.Description:=Description;
            Job."Bill-to Partner No.":="Bill-to Partner No.";
            Job.Validate("Bill-to Partner No.");
            Job.Status:=Job.Status::Contract;
            //insert project status
           // Job."Project Status":=Job."Project Status"::"In Progress";
            Job."Approval Status":=Job."approval status"::Open;
            Job."Creation Date":=Today;
            Job."Starting Date":="Starting Date";
            Job."Ending Date":="Ending Date";
            Job."Last Date Modified":=Today;
            Job.Objective:=Objective;
            Job."Principal Investigator":="Principal Investigator";
            Job."Job Posting Group":="Job Posting Group";
            Job.Insert;
        
            "System Contract No":=Job."No.";
            "Converted To Contract":=true;
        
            //++++++++++++++++++Copy Project Personnel++++++++++++++
            /*ProjPersonnel.RESET;
            ProjPersonnel.SETRANGE(ProjPersonnel.Project,"No.");
            IF ProjPersonnel.FIND('-') THEN
            REPEAT
        
            WITH ProjPersonnels DO BEGIN
            INIT;
            ProjPersonnels.Project:="System Contract No";
            ProjPersonnels."Employee No":=ProjPersonnel."Employee No";
            ProjPersonnels.VALIDATE(ProjPersonnels."Employee No");
            ProjPersonnels."Project Role":=ProjPersonnel."Project Role";
            ProjPersonnels."Start Date":=ProjPersonnel."Start Date";
            ProjPersonnels."End Date":=ProjPersonnel."End Date";
            ProjPersonnels."% Allocation Value":=ProjPersonnel."% Allocation Value";
            INSERT;
            END;
            UNTIL ProjPersonnel.NEXT=0;
            //++++++++++++++++++End Copy Project Personnel++++++++++++++
        
        
            //++++++++++++++++++Copy Partners++++++++++++++++++
            ProjectPartners.RESET;
            ProjectPartners.SETRANGE(ProjectPartners."Grant No","No.");
            IF ProjectPartners.FIND('-') THEN
            REPEAT
            WITH ProjectPartner DO BEGIN
            INIT;
            ProjectPartner."Grant No":="System Contract No";
            ProjectPartner.PartnerID:=ProjectPartners.PartnerID;
            ProjectPartner."Partner Name":=ProjectPartners."Partner Name";
            INSERT;
            END;
            UNTIL ProjectPartners.NEXT =0;
            //++++++++++++++++End Copy Partners++++++++++++++++
        
        
            //+++++++++++++++++Copy Donors+++++++++++++++++++++
            ProjectDonors.RESET;
            ProjectDonors.SETRANGE(ProjectDonors."Grant No","No.");
            IF ProjectDonors.FIND('-') THEN
            REPEAT
            WITH ProjectDonor DO BEGIN
            INIT;
            ProjectDonor."Grant No":="System Contract No";
            ProjectDonor."Shortcut Dimension 1 Code":=ProjectDonors."Shortcut Dimension 1 Code";
            ProjectDonor."Donor Name":=ProjectDonors."Donor Name";
            ProjectDonor."Expected Donation":=ProjectDonors."Expected Donation";
            INSERT;
            END;
            UNTIL ProjectDonors.NEXT=0;
            //+++++++++++++++++End Copy Donors++++++++++++++++++
        
        
            //++++++Copy Task Lines++++++++++++++++++++++++
             */
             JobTask.Reset;
             JobTask.SetRange(JobTask."Grant No.","No.");
             if JobTask.FindFirst then
             begin
                  repeat
                     with JobTasks do
                     begin
                     Init;
                     Validate(JobTasks."Grant No.","System Contract No");
                     JobTasks."Grant Task No.":=JobTask."Grant Task No.";
                     JobTasks.Description:=JobTask.Description;
                     Insert;
                     end
                  until JobTask.Next=0;
             end;
            //++++++++End Copy Task Lines++++++++++++++++++
        
                    //++++++++Copy Planning Lines++++++++++++++++++
                    JobPlanningLine.Reset;
                    JobPlanningLine.SetRange(JobPlanningLine."Grant No.","No.");
                    if JobPlanningLine.Find('-') then
                    begin
                         repeat
        
                            with JobPlanningLines do
                            begin
                            Init;
                            Validate(JobPlanningLines."Grant No.","System Contract No");
                            JobPlanningLines."Grant Task No.":=JobPlanningLine."Grant Task No.";
                            JobPlanningLines."Line No.":=JobPlanningLine."Line No.";
                            JobPlanningLines.Type:=JobPlanningLines.Type;
                            JobPlanningLines."No.":=JobPlanningLine."No.";
                            JobPlanningLines.Partner:=JobPlanningLine.Partner;
                            JobPlanningLines."Global Dimension 1 Code":=JobPlanningLine."Global Dimension 1 Code";
                            JobPlanningLines.Quantity:=JobPlanningLine.Quantity;
                            JobPlanningLines."Unit Cost":=JobPlanningLine."Unit Cost";
                            JobPlanningLines.Validate(JobPlanningLines."Unit Cost");
                            JobPlanningLines.Description:=JobPlanningLine.Description;
                            JobPlanningLines."Budget Period":=JobPlanningLine."Budget Period";
                            //JobPlanningLines."Grant Contract Entry No.":=JobEntryNo.GetNextEntryNo;
                            Insert;
                            end
                         until JobPlanningLine.Next=0;
                    end;
                    //++++++++End Copy Planning Lines++++++++++++++
        
        Message('Proposal No'+' '+ "No." +' '+ 'has succesfully been converted to Contract No.'+' '+"System Contract No");
        Modify;
        end else begin if Status = Status::Contract then begin
        
        if Confirm('Convert Contract to a project?',true)=false then exit;
        //+++++++++++++++++++++++++++++++++++++++++++++++++++
        if "Project No" ='' then
        begin
        JobSetup.Get();
        JobSetup.TestField(JobSetup."Job Nos.");
        NoSeriesMgt.InitSeries(JobSetup."Job Nos.",xRec."No. Series",0D,"Project No","No. Series");
        end;
        //+++++++++++++++++++++++++++++++++++++++++++++++++++
        
        Job.Init;
        Job."No.":="Project No";
        Job.Description:=Description;
        Job."Bill-to Partner No.":="Bill-to Partner No.";
        Job.Validate("Bill-to Partner No.");
        Job.Status:=Job.Status::Project;
        //insert project status
        Job."Project Status":=Job."project status"::"In Progress";
        Job."Approval Status":=Job."approval status"::Open;
        Job."Creation Date":=Today;
        Job."Starting Date":="Starting Date";
        Job."Ending Date":="Ending Date";
        Job."Last Date Modified":=Today;
        Job.Objective:=Objective;
        Job."Principal Investigator":="Principal Investigator";
        Job."Job Posting Group":="Job Posting Group";
        Job.Insert;
        
        "Converted To Project":=true;
        "Project No":="Project No";
        
        /*Commented and taken to only create projects that are fully approved--
        //Insert grant in Dim No.
        GLSetup.GET;
        IF Job.GET(Job."No.") THEN
        BEGIN
            WITH DimVal DO BEGIN
            INIT;
            DimVal."Dimension Code":=GLSetup."Global Dimension 2 Code";
            DimVal.Code:=Job."No.";
            DimVal.Name:=Job.Description;
            DimVal."Global Dimension No.":=2;
            INSERT
            END;
        MESSAGE('Project ID'+' '+ProjectCode+' '+'successfully added to dimension values for global dimension'
        +' '+GLSetup."Global Dimension 2 Code");
        END;
         */
        //+++++++++++++++++++++++++++++++++++
        
        //++++++++++++++++++Copy Project Personnel++++++++++++++
        /*ProjPersonnel.RESET;
        ProjPersonnel.SETRANGE(ProjPersonnel.Project,"No.");
        IF ProjPersonnel.FIND('-') THEN
        REPEAT
        
        WITH ProjPersonnels DO BEGIN
        INIT;
        ProjPersonnels.Project:="Project No";
        ProjPersonnels."Employee No":=ProjPersonnel."Employee No";
        ProjPersonnels.VALIDATE(ProjPersonnels."Employee No");
        ProjPersonnels."Project Role":=ProjPersonnel."Project Role";
        ProjPersonnels."Start Date":=ProjPersonnel."Start Date";
        ProjPersonnels."End Date":=ProjPersonnel."End Date";
        ProjPersonnels."% Allocation Value":=ProjPersonnel."% Allocation Value";
        INSERT;
        END;
        UNTIL ProjPersonnel.NEXT=0;
        //++++++++++++++++++End Copy Project Personnel++++++++++++++
        
        
        //++++++++++++++++++Copy Partners++++++++++++++++++
        ProjectPartners.RESET;
        ProjectPartners.SETRANGE(ProjectPartners."Grant No","No.");
        IF ProjectPartners.FIND('-') THEN
        REPEAT
        WITH ProjectPartner DO BEGIN
        INIT;
        ProjectPartner."Grant No":="Project No";
        ProjectPartner.PartnerID:=ProjectPartners.PartnerID;
        ProjectPartner."Partner Name":=ProjectPartners."Partner Name";
        INSERT;
        END;
        UNTIL ProjectPartners.NEXT =0;
        //++++++++++++++++End Copy Partners++++++++++++++++
        
        
        //+++++++++++++++++Copy Donors+++++++++++++++++++++
        ProjectDonors.RESET;
        ProjectDonors.SETRANGE(ProjectDonors."Grant No","No.");
        IF ProjectDonors.FIND('-') THEN
        REPEAT
        WITH ProjectDonor DO BEGIN
        INIT;
        ProjectDonor."Grant No":="Project No";
        ProjectDonor."Shortcut Dimension 1 Code":=ProjectDonors."Shortcut Dimension 1 Code";
        ProjectDonor."Donor Name":=ProjectDonors."Donor Name";
        ProjectDonor."Expected Donation":=ProjectDonors."Expected Donation";
        INSERT;
        END;
        UNTIL ProjectDonors.NEXT=0;
        //+++++++++++++++++End Copy Donors++++++++++++++++++
        
        
        //++++++Copy Task Lines++++++++++++++++++++++++
         */
         JobTask.Reset;
         JobTask.SetRange(JobTask."Grant No.","No.");
         if JobTask.FindFirst then
         begin
              repeat
                 with JobTasks do
                 begin
                 Init;
                 Validate(JobTasks."Grant No.","Project No");
                 JobTasks."Grant Task No.":=JobTask."Grant Task No.";
                 JobTasks.Description:=JobTask.Description;
                 Insert;
                 end
              until JobTask.Next=0;
         end;
        //++++++++End Copy Task Lines++++++++++++++++++
        
                //++++++++Copy Planning Lines++++++++++++++++++
                JobPlanningLine.Reset;
                JobPlanningLine.SetRange(JobPlanningLine."Grant No.","No.");
                if JobPlanningLine.Find('-') then
                begin
                     repeat
        
                        with JobPlanningLines do
                        begin
                        Init;
                        Validate(JobPlanningLines."Grant No.","Project No");
                        JobPlanningLines."Grant Task No.":=JobPlanningLine."Grant Task No.";
                        JobPlanningLines."Line No.":=JobPlanningLine."Line No.";
                        JobPlanningLines.Type:=JobPlanningLines.Type;
                        JobPlanningLines."No.":=JobPlanningLine."No.";
                        JobPlanningLines.Partner:=JobPlanningLine.Partner;
                        JobPlanningLines."Global Dimension 1 Code":=JobPlanningLine."Global Dimension 1 Code";
                        JobPlanningLines.Quantity:=JobPlanningLine.Quantity;
                        JobPlanningLines."Unit Cost":=JobPlanningLine."Unit Cost";
                        JobPlanningLines.Validate(JobPlanningLines."Unit Cost");
                        JobPlanningLines.Description:=JobPlanningLine.Description;
                        JobPlanningLines."Budget Period":=JobPlanningLine."Budget Period";
                        //JobPlanningLines."Grant Contract Entry No.":=JobEntryNo.GetNextEntryNo;
                        Insert;
                        end
                     until JobPlanningLine.Next=0;
                end;
                //++++++++End Copy Planning Lines++++++++++++++
        
        Message('Contract No'+' '+ "No." +' '+ 'has succesfully been converted to Project No.'+' '+"Project No");
        Modify;
        
        end
        end;
        
        end;

    end;


    procedure AddtoDimensionValues(ProjectCode: Code[10])
    var
        DimVal: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get;
        //Job.RESET;
        //Job.SETRANGE(Job."No.",ProjectCode);
        if Job.Get(ProjectCode) then
        begin
            with DimVal do begin
            Init;
            DimVal."Dimension Code":=GLSetup."Global Dimension 2 Code";
            DimVal.Code:=ProjectCode;
            DimVal.Name:=Job.Description;
            DimVal."Global Dimension No.":=2;
            Insert
            end;
        Message('Project ID'+' '+ProjectCode+' '+'successfully added to dimension values for global dimension'
        +' '+GLSetup."Global Dimension 2 Code");
        end;
    end;


    procedure RecordLinkMove(job: Record Jobs;newJob: Record Jobs)
    begin
    end;


    procedure CreateDim(mJobs: Record Jobs)
    begin
        //Insert grant in Dim No.
        GLSetup.Get;
            with DimVal do begin
            Init;
            DimVal."Dimension Code":=GLSetup."Global Dimension 2 Code";
            DimVal.Code:=mJobs."No.";
            DimVal.Name:=mJobs."Description 2";
            DimVal."Global Dimension No.":=2;
            Insert;
            Message('Project ID'+' '+mJobs."No."+' '+'successfully added to dimension values for global dimension'
        +' '+GLSetup."Global Dimension 2 Code");
        end;
    end;
}

