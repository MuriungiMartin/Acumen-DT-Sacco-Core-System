#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516555 "Lead Management"
{
    DrillDownPageID = "Collateral Depr. Schedule";
    LookupPageID = "Collateral Depr. Schedule";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    LDSetup.Get;
                    NoSeriesMgt.TestManual(LDSetup."Lead Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                //NameBreakdown;
                //ProcessNameChange;
            end;
        }
        field(3; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }
        field(4; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(5; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(6; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
            TableRelation = if ("Country/Region Code" = const('')) "Post Code".City
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(10; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
        }
        field(15; "Territory Code"; Code[20])
        {
            Caption = 'Territory Code';
            TableRelation = Territory;
        }
        field(22; "Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(24; "Language Code"; Code[20])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(29; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(35; "Country/Region Code"; Code[20])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(38; Comment; Boolean)
        {
            CalcFormula = exist("Rlshp. Mgt. Comment Line" where("Table Name" = const(Contact),
                                                                  "No." = field("No."),
                                                                  "Sub No." = const(0)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(54; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(84; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(85; "Telex Answer Back"; Text[20])
        {
            Caption = 'Telex Answer Back';
        }
        field(86; "VAT Registration No."; Text[20])
        {
            Caption = 'Tax Registration No.';

            trigger OnValidate()
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
                VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
            begin
                /*IF VATRegNoFormat.Test("VAT Registration No.","Country/Region Code","No.",DATABASE::Contact) THEN
                  IF "VAT Registration No." <> xRec."VAT Registration No." THEN
                    VATRegistrationLogMgt.LogContact(Rec);*/

            end;
        }
        field(89; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(91; "Post Code"; Code[20])
        {
            Caption = 'ZIP Code';
            TableRelation = if ("Country/Region Code" = const('')) "Post Code"
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(92; County; Text[30])
        {
            Caption = 'State';
        }
        field(102; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            begin
                if ("Search E-Mail" = UpperCase(xRec."E-Mail")) or ("Search E-Mail" = '') then
                    "Search E-Mail" := "E-Mail";
            end;
        }
        field(103; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(107; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(5050; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Company,Person';
            OptionMembers = Company,Person;

            trigger OnValidate()
            begin
                /*IF (CurrFieldNo <> 0) AND ("No." <> '') THEN BEGIN
                  TypeChange;
                  MODIFY;
                END;*/

            end;
        }
        field(5051; "Company No."; Code[20])
        {
            Caption = 'Company No.';
            TableRelation = Contact where(Type = const(Company));

            trigger OnValidate()
            var
                Opp: Record Opportunity;
                OppEntry: Record "Opportunity Entry";
                Todo: Record "To-do";
                InteractLogEntry: Record "Interaction Log Entry";
                SegLine: Record "Segment Line";
                SalesHeader: Record "Sales Header";
                OriginalEmail: Text[80];
            begin
                /*IF "Company No." = xRec."Company No." THEN
                  EXIT;
                
                OriginalEmail := "E-Mail";
                
                TESTFIELD(Type,Type::Person);
                
                SegLine.SETCURRENTKEY("Contact No.");
                SegLine.SETRANGE("Contact No.","No.");
                IF SegLine.FINDFIRST THEN
                  ERROR(Text012,FIELDCAPTION("Company No."));
                
                IF Cont.GET("Company No.") THEN
                  InheritCompanyToPersonData(Cont,xRec."Company No." = '')
                ELSE
                  CLEAR("Company Name");
                
                IF Cont.GET("No.") THEN BEGIN
                  IF xRec."Company No." <> '' THEN BEGIN
                    Opp.SETCURRENTKEY("Contact Company No.","Contact No.");
                    Opp.SETRANGE("Contact Company No.",xRec."Company No.");
                    Opp.SETRANGE("Contact No.","No.");
                    Opp.MODIFYALL("Contact No.",xRec."Company No.");
                    OppEntry.SETCURRENTKEY("Contact Company No.","Contact No.");
                    OppEntry.SETRANGE("Contact Company No.",xRec."Company No.");
                    OppEntry.SETRANGE("Contact No.","No.");
                    OppEntry.MODIFYALL("Contact No.",xRec."Company No.");
                    Todo.SETCURRENTKEY("Contact Company No.","Contact No.");
                    Todo.SETRANGE("Contact Company No.",xRec."Company No.");
                    Todo.SETRANGE("Contact No.","No.");
                    Todo.MODIFYALL("Contact No.",xRec."Company No.");
                    InteractLogEntry.SETCURRENTKEY("Contact Company No.","Contact No.");
                    InteractLogEntry.SETRANGE("Contact Company No.",xRec."Company No.");
                    InteractLogEntry.SETRANGE("Contact No.","No.");
                    InteractLogEntry.MODIFYALL("Contact No.",xRec."Company No.");
                    ContBusRel.RESET;
                    ContBusRel.SETCURRENTKEY("Link to Table","No.");
                    ContBusRel.SETRANGE("Link to Table",ContBusRel."Link to Table"::Customer);
                    ContBusRel.SETRANGE("Contact No.",xRec."Company No.");
                    SalesHeader.SETCURRENTKEY("Sell-to Customer No.","External Document No.");
                    SalesHeader.SETRANGE("Sell-to Contact No.","No.");
                    IF ContBusRel.FINDFIRST THEN
                      SalesHeader.SETRANGE("Sell-to Customer No.",ContBusRel."No.")
                    ELSE
                      SalesHeader.SETRANGE("Sell-to Customer No.",'');
                    IF SalesHeader.FIND('-') THEN
                      REPEAT
                        SalesHeader."Sell-to Contact No." := xRec."Company No.";
                        IF SalesHeader."Sell-to Contact No." = SalesHeader."Bill-to Contact No." THEN
                          SalesHeader."Bill-to Contact No." := xRec."Company No.";
                        SalesHeader.MODIFY;
                      UNTIL SalesHeader.NEXT = 0;
                    SalesHeader.RESET;
                    SalesHeader.SETCURRENTKEY("Bill-to Contact No.");
                    SalesHeader.SETRANGE("Bill-to Contact No.","No.");
                    SalesHeader.MODIFYALL("Bill-to Contact No.",xRec."Company No.");
                  END ELSE BEGIN
                    Opp.SETCURRENTKEY("Contact Company No.","Contact No.");
                    Opp.SETRANGE("Contact Company No.",'');
                    Opp.SETRANGE("Contact No.","No.");
                    Opp.MODIFYALL("Contact Company No.","Company No.");
                    OppEntry.SETCURRENTKEY("Contact Company No.","Contact No.");
                    OppEntry.SETRANGE("Contact Company No.",'');
                    OppEntry.SETRANGE("Contact No.","No.");
                    OppEntry.MODIFYALL("Contact Company No.","Company No.");
                    Todo.SETCURRENTKEY("Contact Company No.","Contact No.");
                    Todo.SETRANGE("Contact Company No.",'');
                    Todo.SETRANGE("Contact No.","No.");
                    Todo.MODIFYALL("Contact Company No.","Company No.");
                    InteractLogEntry.SETCURRENTKEY("Contact Company No.","Contact No.");
                    InteractLogEntry.SETRANGE("Contact Company No.",'');
                    InteractLogEntry.SETRANGE("Contact No.","No.");
                    InteractLogEntry.MODIFYALL("Contact Company No.","Company No.");
                  END;
                  IF OriginalEmail <> '' THEN
                    "E-Mail" := OriginalEmail;
                  IF CurrFieldNo <> 0 THEN
                    MODIFY;
                END;
                */

            end;
        }
        field(5052; "Company Name"; Text[50])
        {
            Caption = 'Company Name';
            Editable = false;
        }
        field(5053; "Lookup Contact No."; Code[20])
        {
            Caption = 'Lookup Contact No.';
            Editable = false;
            TableRelation = Contact;

            trigger OnValidate()
            begin
                if Type = Type::Company then
                    "Lookup Contact No." := ''
                else
                    "Lookup Contact No." := "No.";
            end;
        }
        field(5054; "First Name"; Text[30])
        {
            Caption = 'First Name';

            trigger OnValidate()
            begin
                /*Name := CalculatedName;
                ProcessNameChange;
                */

            end;
        }
        field(5055; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';

            trigger OnValidate()
            begin
                /*Name := CalculatedName;
                ProcessNameChange;*/

            end;
        }
        field(5056; Surname; Text[30])
        {
            Caption = 'Surname';

            trigger OnValidate()
            begin
                /*Name := CalculatedName;
                ProcessNameChange;
                */

            end;
        }
        field(5058; "Job Title"; Text[30])
        {
            Caption = 'Job Title';
        }
        field(5059; Initials; Text[30])
        {
            Caption = 'Initials';
        }
        field(5060; "Extension No."; Text[30])
        {
            Caption = 'Extension No.';
        }
        field(5061; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(5062; Pager; Text[30])
        {
            Caption = 'Pager';
        }
        field(5063; "Organizational Level Code"; Code[20])
        {
            Caption = 'Organizational Level Code';
            TableRelation = "Organizational Level";
        }
        field(5064; "Exclude from Segment"; Boolean)
        {
            Caption = 'Exclude from Segment';
        }
        field(5065; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5066; "Next Action Date"; Date)
        {
            CalcFormula = min("Meetings Schedule"."Meeting Date" where("Lead No" = field("No."),
                                                                        "Meeting Status" = filter(Due)));
            Caption = 'Next To-do Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5067; "Last Date Attempted"; Date)
        {
            CalcFormula = max("Interaction Log Entry".Date where("Contact Company No." = field("Company No."),
                                                                  "Contact No." = field(filter("Lookup Contact No.")),
                                                                  "Initiated By" = const(Us),
                                                                  Postponed = const(false)));
            Caption = 'Last Date Attempted';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5068; "Date of Last Interaction"; Date)
        {
            CalcFormula = max("Meetings Schedule"."Meeting Date" where("Lead No" = field("No."),
                                                                        "Meeting Status" = filter(Done)));
            Caption = 'Date of Last Interaction';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5069; "No. of Job Responsibilities"; Integer)
        {
            CalcFormula = count("Contact Job Responsibility" where("Contact No." = field("No.")));
            Caption = 'No. of Job Responsibilities';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5070; "No. of Industry Groups"; Integer)
        {
            CalcFormula = count("Contact Industry Group" where("Contact No." = field("Company No.")));
            Caption = 'No. of Industry Groups';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5071; "No. of Business Relations"; Integer)
        {
            CalcFormula = count("Contact Business Relation" where("Contact No." = field("Company No.")));
            Caption = 'No. of Business Relations';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5072; "No. of Mailing Groups"; Integer)
        {
            CalcFormula = count("Contact Mailing Group" where("Contact No." = field("No.")));
            Caption = 'No. of Mailing Groups';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5073; "External ID"; Code[20])
        {
            Caption = 'External ID';
        }
        field(5074; "No. of Interactions"; Integer)
        {
            CalcFormula = count("Interaction Log Entry" where("Contact Company No." = field(filter("Company No.")),
                                                               Canceled = const(false),
                                                               "Contact No." = field(filter("Lookup Contact No.")),
                                                               Date = field("Date Filter"),
                                                               Postponed = const(false)));
            Caption = 'No. of Interactions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5076; "Cost (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Interaction Log Entry"."Cost (LCY)" where("Contact Company No." = field("Company No."),
                                                                          Canceled = const(false),
                                                                          "Contact No." = field(filter("Lookup Contact No.")),
                                                                          Date = field("Date Filter"),
                                                                          Postponed = const(false)));
            Caption = 'Cost ($)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5077; "Duration (Min.)"; Decimal)
        {
            CalcFormula = sum("Interaction Log Entry"."Duration (Min.)" where("Contact Company No." = field("Company No."),
                                                                               Canceled = const(false),
                                                                               "Contact No." = field(filter("Lookup Contact No.")),
                                                                               Date = field("Date Filter"),
                                                                               Postponed = const(false)));
            Caption = 'Duration (Min.)';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5078; "No. of Opportunities"; Integer)
        {
            CalcFormula = count("Opportunity Entry" where(Active = const(true),
                                                           "Contact Company No." = field("Company No."),
                                                           "Estimated Close Date" = field("Date Filter"),
                                                           "Contact No." = field(filter("Lookup Contact No.")),
                                                           "Action Taken" = field("Action Taken Filter")));
            Caption = 'No. of Opportunities';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5079; "Estimated Value (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Opportunity Entry"."Estimated Value (LCY)" where(Active = const(true),
                                                                                 "Contact Company No." = field("Company No."),
                                                                                 "Estimated Close Date" = field("Date Filter"),
                                                                                 "Contact No." = field(filter("Lookup Contact No.")),
                                                                                 "Action Taken" = field("Action Taken Filter")));
            Caption = 'Estimated Value ($)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5080; "Calcd. Current Value (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Opportunity Entry"."Calcd. Current Value (LCY)" where(Active = const(true),
                                                                                      "Contact Company No." = field("Company No."),
                                                                                      "Estimated Close Date" = field("Date Filter"),
                                                                                      "Contact No." = field(filter("Lookup Contact No.")),
                                                                                      "Action Taken" = field("Action Taken Filter")));
            Caption = 'Calcd. Current Value ($)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5082; "Opportunity Entry Exists"; Boolean)
        {
            CalcFormula = exist("Opportunity Entry" where(Active = const(true),
                                                           "Contact Company No." = field("Company No."),
                                                           "Contact No." = field(filter("Lookup Contact No.")),
                                                           "Sales Cycle Code" = field("Sales Cycle Filter"),
                                                           "Sales Cycle Stage" = field("Sales Cycle Stage Filter"),
                                                           "Salesperson Code" = field("Salesperson Filter"),
                                                           "Campaign No." = field("Campaign Filter"),
                                                           "Action Taken" = field("Action Taken Filter"),
                                                           "Estimated Value (LCY)" = field("Estimated Value Filter"),
                                                           "Calcd. Current Value (LCY)" = field("Calcd. Current Value Filter"),
                                                           "Completed %" = field("Completed % Filter"),
                                                           "Chances of Success %" = field("Chances of Success % Filter"),
                                                           "Probability %" = field("Probability % Filter"),
                                                           "Estimated Close Date" = field("Date Filter"),
                                                           "Close Opportunity Code" = field("Close Opportunity Filter")));
            Caption = 'Opportunity Entry Exists';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5083; "To-do Entry Exists"; Boolean)
        {
            CalcFormula = exist("To-do" where("Contact Company No." = field("Company No."),
                                               "Contact No." = field(filter("Lookup Contact No.")),
                                               "Team Code" = field("Team Filter"),
                                               "Salesperson Code" = field("Salesperson Filter"),
                                               "Campaign No." = field("Campaign Filter"),
                                               Date = field("Date Filter"),
                                               Status = field("To-do Status Filter"),
                                               Priority = field("Priority Filter"),
                                               Closed = field("To-do Closed Filter")));
            Caption = 'To-do Entry Exists';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5084; "Salesperson Filter"; Code[20])
        {
            Caption = 'Salesperson Filter';
            FieldClass = FlowFilter;
            TableRelation = "Salesperson/Purchaser";
        }
        field(5085; "Campaign Filter"; Code[20])
        {
            Caption = 'Campaign Filter';
            FieldClass = FlowFilter;
            TableRelation = Campaign;
        }
        field(5087; "Action Taken Filter"; Option)
        {
            Caption = 'Action Taken Filter';
            FieldClass = FlowFilter;
            OptionCaption = ' ,Next,Previous,Updated,Jumped,Won,Lost';
            OptionMembers = " ",Next,Previous,Updated,Jumped,Won,Lost;
        }
        field(5088; "Sales Cycle Filter"; Code[20])
        {
            Caption = 'Sales Cycle Filter';
            FieldClass = FlowFilter;
            TableRelation = "Sales Cycle";
        }
        field(5089; "Sales Cycle Stage Filter"; Integer)
        {
            Caption = 'Sales Cycle Stage Filter';
            FieldClass = FlowFilter;
            TableRelation = "Sales Cycle Stage".Stage where("Sales Cycle Code" = field("Sales Cycle Filter"));
        }
        field(5090; "Probability % Filter"; Decimal)
        {
            Caption = 'Probability % Filter';
            DecimalPlaces = 1 : 1;
            FieldClass = FlowFilter;
            MaxValue = 100;
            MinValue = 0;
        }
        field(5091; "Completed % Filter"; Decimal)
        {
            Caption = 'Completed % Filter';
            DecimalPlaces = 1 : 1;
            FieldClass = FlowFilter;
            MaxValue = 100;
            MinValue = 0;
        }
        field(5092; "Estimated Value Filter"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Estimated Value Filter';
            FieldClass = FlowFilter;
        }
        field(5093; "Calcd. Current Value Filter"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Calcd. Current Value Filter';
            FieldClass = FlowFilter;
        }
        field(5094; "Chances of Success % Filter"; Decimal)
        {
            Caption = 'Chances of Success % Filter';
            DecimalPlaces = 0 : 0;
            FieldClass = FlowFilter;
            MaxValue = 100;
            MinValue = 0;
        }
        field(5095; "To-do Status Filter"; Option)
        {
            Caption = 'To-do Status Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Not Started,In Progress,Completed,Waiting,Postponed';
            OptionMembers = "Not Started","In Progress",Completed,Waiting,Postponed;
        }
        field(5096; "To-do Closed Filter"; Boolean)
        {
            Caption = 'To-do Closed Filter';
            FieldClass = FlowFilter;
        }
        field(5097; "Priority Filter"; Option)
        {
            Caption = 'Priority Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Low,Normal,High';
            OptionMembers = Low,Normal,High;
        }
        field(5098; "Team Filter"; Code[20])
        {
            Caption = 'Team Filter';
            FieldClass = FlowFilter;
            TableRelation = Team;
        }
        field(5099; "Close Opportunity Filter"; Code[20])
        {
            Caption = 'Close Opportunity Filter';
            FieldClass = FlowFilter;
            TableRelation = "Close Opportunity Code";
        }
        field(5100; "Correspondence Type"; Option)
        {
            Caption = 'Correspondence Type';
            OptionCaption = ' ,Hard Copy,E-Mail,Fax';
            OptionMembers = " ","Hard Copy","E-Mail",Fax;
        }
        field(5101; "Salutation Code"; Code[20])
        {
            Caption = 'Salutation Code';
            TableRelation = Salutation;
        }
        field(5102; "Search E-Mail"; Code[80])
        {
            Caption = 'Search E-Mail';
        }
        field(5104; "Last Time Modified"; Time)
        {
            Caption = 'Last Time Modified';
        }
        field(5105; "E-Mail 2"; Text[80])
        {
            Caption = 'E-Mail 2';
            ExtendedDatatype = EMail;
        }
        field(5106; status; Option)
        {
            OptionCaption = 'Case,Opportunity';
            OptionMembers = "Case",Opportunity;
        }
        field(5107; "Lead Type"; Option)
        {
            OptionCaption = ',As Member,As Employer,As Non Member,As Others';
            OptionMembers = ".As Member","As Employer","As Non Member","As Others";
        }
        field(5108; "member no"; Code[20])
        {
            TableRelation = Customer;
        }
        field(5109; "Lost Reasons"; Option)
        {
            OptionCaption = ',price,Timing,Authority,missing feature,usability,unknown,No need,Others';
            OptionMembers = ,price,Timing,Authority,"missing feature",usability,unknown,"No need",Others;
        }
        field(5110; "Application User"; Code[50])
        {
        }
        field(5111; "Application Date"; Date)
        {
        }
        field(5112; "Application Time"; Time)
        {
        }
        field(5113; "Receive User"; Code[50])
        {
        }
        field(5114; "Receive date"; Date)
        {
        }
        field(5115; "Receive Time"; Time)
        {
        }
        field(5116; "Resolved User"; Code[50])
        {
        }
        field(5117; "Resolved Date"; Date)
        {
        }
        field(5118; "Resolved Time"; Time)
        {
        }
        field(5119; "Caller Reffered To"; Code[50])
        {
            Description = 's';
            TableRelation = User."User Name";

            trigger OnLookup()
            var
                UserMgt: Codeunit UserManagementCUExt;
            begin
                UserMgt.LookupUser("Caller Reffered To");
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit UserManagementCUExt;
                User: record User;
            begin
                UserMgt.ValidateUserName(User, User, "Caller Reffered To");
            end;
        }
        field(5120; "Received From"; Code[50])
        {
            TableRelation = User."User Name";
        }
        field(5121; "Date Sent"; Date)
        {
        }
        field(5122; "Time Sent"; Time)
        {
        }
        field(5123; "Sent By"; Code[50])
        {
            Description = '//surestep crm';
        }
        field(5124; "ID No"; Code[20])
        {
        }
        field(5125; Description; Text[100])
        {
        }
        field(5126; Converted; Boolean)
        {
        }
        field(68035; "Terms of Employment"; Option)
        {
            OptionMembers = " ",Permanent,Contract,Casual;
        }
        field(68121; "Employment Info"; Option)
        {
            OptionCaption = ' ,Employed,Self-Employed,Contracting,Others';
            OptionMembers = " ",Employed,"Self-Employed",Contracting,Others;
        }
        field(68123; "Others Details"; Text[30])
        {
        }
        field(69167; "Employment Terms"; Option)
        {
            OptionCaption = ' ,Permanent,Casual';
            OptionMembers = " ",Permanent,Casual;
        }
        field(69168; "Employer Type"; Option)
        {
            OptionCaption = ' ,Employed,Business';
            OptionMembers = " ",Employed,Business;
        }
        field(69174; "Employer Address"; Code[20])
        {
        }
        field(69175; "Date of Employment"; Date)
        {
        }
        field(69176; "Position Held"; Code[20])
        {
        }
        field(69177; "Expected Monthly Income"; Decimal)
        {
        }
        field(69178; "Nature Of Business"; Option)
        {
            OptionCaption = 'Sole Proprietorship, Partnership';
            OptionMembers = "Sole Proprietorship"," Partnership";
        }
        field(69179; Industry; Code[20])
        {
        }
        field(69180; "Business Name"; Code[20])
        {
        }
        field(69181; "Physical Business Location"; Code[20])
        {
        }
        field(69182; "Year of Commence"; Date)
        {
        }
        field(69183; "Employer Code"; Code[20])
        {
            TableRelation = "Sacco Employers".Code;

            trigger OnValidate()
            begin
                if ObjEmployers.Get("Employer Code") then begin
                    "Employer Name" := ObjEmployers.Description;
                end;
            end;
        }
        field(69184; "Employer Name"; Code[50])
        {
        }
        field(69185; Department; Code[20])
        {
        }
        field(69188; "Referee Member No"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Referee Member No") then begin
                    "Referee Name" := Cust.Name;
                    "Referee Mobile Phone No" := Cust."Mobile Phone No";
                    "Referee ID No" := Cust."ID No.";
                end;
            end;
        }
        field(69189; "Referee Name"; Code[40])
        {
            Editable = false;
        }
        field(69190; "Referee ID No"; Code[20])
        {
            Editable = false;
        }
        field(69191; "Referee Mobile Phone No"; Code[20])
        {
            Editable = false;
        }
        field(69192; Occupation; Code[30])
        {
        }
        field(69193; "Lead Status"; Option)
        {
            OptionCaption = 'Open,Converted to Opportunity,Closed';
            OptionMembers = Open,"Converted to Opportunity",Closed;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LDSetup: Record "Crm General Setup.";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PostCode: Integer;
        Cust: Record Customer;
        ObjEmployers: Record "Sacco Employers";
}

