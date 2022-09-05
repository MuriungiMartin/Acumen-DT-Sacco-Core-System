#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516251 "HR Leave Application Comments"
{
    PageType = Card;
    SourceTable = "Approval Comment Line";

    layout
    {
        area(content)
        {
            field(DocType;DocType)
            {
                ApplicationArea = Basic;
                Editable = false;
                OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Payment Voucher,Petty Cash,Imprest,Requisition,ImprestSurrender,Interbank,Receipt,Staff Claim,Staff Advance,AdvanceSurrender,Bank Slip,Grant,Grant Surrender,Employee Requisition,Leave Application,Training Application,Transport Requisition';
            }
            field(DocNo;DocNo)
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            repeater(Control1102755000)
            {
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Date and Time";"Date and Time")
                {
                    ApplicationArea = Basic;
                }
                field(Comment;Comment)
                {
                    ApplicationArea = Basic;
                }
                field("Approved Days";"Approved Days")
                {
                    ApplicationArea = Basic;
                }
                // field("Approved Start Date";"Approved Start Date")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Approved Return Date";"Approved Return Date")
                // {
                //     ApplicationArea = Basic;
                // }
                // field(Reason;Reason)
                // {
                //     ApplicationArea = Basic;
                // }
                // field("Leave Allowance Granted";"Leave Allowance Granted")
                // {
                //     ApplicationArea = Basic;
                // }
            }
        }
    }

    actions
    {
    }

    var
        NewTableId: Integer;
        NewDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application";
        NewDocumentNo: Code[20];
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application";
        DocNo: Code[20];


    procedure SetUpLine(TableId: Integer;DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application";DocumentNo: Code[20])
    begin
        NewTableId := TableId;
        NewDocumentType := DocumentType;
        NewDocumentNo := DocumentNo;
    end;


    procedure Setfilters(TableId: Integer;DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application";DocumentNo: Code[20])
    begin
        if TableId <> 0 then begin
          FilterGroup(2);
          SetCurrentkey("Table ID","Document Type","Document No.");
          SetRange("Table ID",TableId);
          SetRange("Document Type",DocumentType);
          if DocumentNo <> '' then
            SetRange("Document No.",DocumentNo);
          FilterGroup(0);
        end;

        DocType := DocumentType;
        DocNo := DocumentNo;
    end;
}

