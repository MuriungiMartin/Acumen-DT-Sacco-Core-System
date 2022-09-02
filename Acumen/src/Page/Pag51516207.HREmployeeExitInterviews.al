#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516207 "HR Employee Exit Interviews"
{
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Exit Interview';
    SourceTable = "HR Employee Exit Interviews";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Exit Interview No";"Exit Interview No")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Employee No.";"Employee No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;

                    trigger OnValidate()
                    begin



                                         if HREmp.Get("Employee No.") then begin
                                         JobTitle:=HREmp."Job Title";
                                         sUserID:=HREmp."User ID";
                                         end else begin
                                         JobTitle:='';
                                         sUserID:='';
                                         "Global Dimension 2":=HREmp."Global Dimension 2 Code";
                                         end;

                                         RecalcDates;
                          EmployeeNoOnAfterValidate;
                    end;
                }
                field("Employee Name";"Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(JobTitle;JobTitle)
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Title';
                    Editable = false;
                    Importance = Promoted;
                    Visible = false;
                }
                field(DService;DService)
                {
                    ApplicationArea = Basic;
                    Caption = 'Length of Service';
                    Editable = false;
                    Importance = Promoted;
                    Visible = false;
                }
                field("Global Dimension 2";"Global Dimension 2")
                {
                    ApplicationArea = Basic;
                }
                field("HREmpForm.GetSupervisor(sUserID)";HREmpForm.GetSupervisor(sUserID))
                {
                    ApplicationArea = Basic;
                    Caption = 'Supervisor';
                    Editable = false;
                    Importance = Promoted;
                }
                field("Date Of Interview";"Date Of Interview")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Interview Done By";"Interview Done By")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Interviewer Name";"Interviewer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Reason For Leaving";"Reason For Leaving")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Reason For Leaving (Other)";"Reason For Leaving (Other)")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Date Of Leaving";"Date Of Leaving")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Re Employ In Future";"Re Employ In Future")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Form Submitted";"Form Submitted")
                {
                    ApplicationArea = Basic;
                }
                field(Comment;Comment)
                {
                    ApplicationArea = Basic;
                }
            }
            part(SF;"HR Asset Return Form")
            {
                Caption = 'Misc Articles';
            }
        }
        area(factboxes)
        {
            systempart(Control1102755008;Outlook)
            {
            }
            systempart(Control1102755010;Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Exit Interview")
            {
                Caption = '&Exit Interview';
                action(Form)
                {
                    ApplicationArea = Basic;
                    Caption = 'Form';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if DoclLink.Get("Employee No.",'Exit Interview') then begin
                        DoclLink.PlaceFilter(true,DoclLink."Employee No");
                        Page.RunModal(55537,DoclLink);
                        end else begin
                        DoclLink.Init;
                        DoclLink."Employee No":="Employee No.";
                        DoclLink."Document Description":='Exit Interview';
                        DoclLink.Insert;
                        Commit;
                        DoclLink.PlaceFilter(true,DoclLink."Employee No");
                        Page.RunModal(55537,DoclLink);
                        end;
                    end;
                }
                action("Departmental Clearance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Departmental Clearance';
                    Image = CheckList;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Exit Interview Checklist";
                    RunPageLink = "Exit Interview No"=field("Exit Interview No"),
                                  "Employee No"=field("Employee No.");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        if HREmp.Get("Employee No.") then begin
        JobTitle:=HREmp."Job Title";
        sUserID:=HREmp."User ID";
        end else begin
        JobTitle:='';
        sUserID:='';
        end;


        SetRange("Employee No.");
        DAge:='';
        DService:='';
        DPension:='';
        DMedical:='';

        RecalcDates;
    end;

    var
        JobTitle: Text[30];
        Supervisor: Text[60];
        HREmp: Record "HR Employees";
        Dates: Codeunit "HR Datess";
        DAge: Text[100];
        DService: Text[100];
        DPension: Text[100];
        DMedical: Text[100];
        HREmpForm: Page "HR Employee Card";
        sUserID: Code[30];
        DoclLink: Record "HR Employee Attachments";
        InteractTemplLanguage: Record "Interaction Tmpl. Language";
        D: Date;
        Misc: Record "Misc. Article Information";
        Text19062217: label 'Misc Articles';


    procedure RecalcDates()
    begin
        //Recalculate Important Dates
          if (HREmp."Date Of Leaving the Company" = 0D) then begin
            if  (HREmp."Date Of Birth" <> 0D) then
            DAge:= Dates.DetermineAge(HREmp."Date Of Birth",Today);
            if  (HREmp."Date Of Joining the Company" <> 0D) then
            DService:= Dates.DetermineAge(HREmp."Date Of Joining the Company",Today);
            if  (HREmp."Pension Scheme Join Date" <> 0D) then
            DPension:= Dates.DetermineAge(HREmp."Pension Scheme Join Date",Today);
            if  (HREmp."Medical Scheme Join Date" <> 0D) then
            DMedical:= Dates.DetermineAge(HREmp."Medical Scheme Join Date",Today);
            //MODIFY;
          end else begin
            if  (HREmp."Date Of Birth" <> 0D) then
            DAge:= Dates.DetermineAge(HREmp."Date Of Birth",HREmp."Date Of Leaving the Company");
            if  (HREmp."Date Of Joining the Company" <> 0D) then
            DService:= Dates.DetermineAge(HREmp."Date Of Joining the Company",HREmp."Date Of Leaving the Company");
            if  (HREmp."Pension Scheme Join Date" <> 0D) then
            DPension:= Dates.DetermineAge(HREmp."Pension Scheme Join Date",HREmp."Date Of Leaving the Company");
            if  (HREmp."Medical Scheme Join Date" <> 0D) then
            DMedical:= Dates.DetermineAge(HREmp."Medical Scheme Join Date",HREmp."Date Of Leaving the Company");
            //MODIFY;
          end;
    end;

    local procedure EmployeeNoOnAfterValidate()
    begin
        CurrPage.SaveRecord;
        FilterGroup := 2;
        Misc.SetRange(Misc."Employee No.","Employee No.");
        FilterGroup := 0;
        if Misc.Find('-') then;
        CurrPage.Update(false);
    end;
}

