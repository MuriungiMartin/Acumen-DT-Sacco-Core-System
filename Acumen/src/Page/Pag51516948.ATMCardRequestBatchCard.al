#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516948 "ATM Card Request Batch Card"
{
    PageType = Card;
    SourceTable = "ATM Card Order Batch";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Batch No.";"Batch No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Description/Remarks";"Description/Remarks")
                {
                    ApplicationArea = Basic;
                }
                field(Requested;Requested)
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Date Created";"Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Date Requested";"Date Requested")
                {
                    ApplicationArea = Basic;
                }
                field("Requested By";"Requested By")
                {
                    ApplicationArea = Basic;
                }
                field("Prepared By";"Prepared By")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control11;"ATM Card Applications SubPage")
            {
                SubPageLink = "Application Date"=field("Date Requested");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(OrderCards)
            {
                ApplicationArea = Basic;
                Caption = 'Order Cards';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*ObjATMApplications.RESET;
                    ObjATMApplications.SETRANGE(ObjATMApplications."Application Date","Date Requested");
                    ObjATMApplications.SETRANGE(ObjATMApplications."Order ATM Card",TRUE);
                    IF ObjATMApplications.FINDSET THEN BEGIN
                      DestinationFile := FileMgt.SaveFileDialog('Window Title','file.txt','Text files (*.txt)|(*.txt)');
                      END;*/
                    
                      //[FnXmlExportCardApplications();
                    
                    ObjATMApplications.Reset;
                    ObjATMApplications.SetRange(ObjATMApplications."Application Date","Date Requested");
                    ObjATMApplications.SetRange(ObjATMApplications."Order ATM Card",true);
                    if ObjATMApplications.FindSet then begin
                    CardTxtFile.Create('C:\ATMCardApplications\ATM Card Applications.txt');
                    CardTxtFile.CreateOutstream(TxtStream);
                    CardTxtFile.Write(ObjATMApplications."Account No");
                    CardTxtFile.Write(ObjATMApplications."Account Name");
                    CardTxtFile.Write(ObjATMApplications."Account Type");
                    CardTxtFile.Write(ObjATMApplications."Phone No.");
                    CardTxtFile.Close;
                    
                    //ObjATMApplications.MODIFY();
                    end;

                end;
            }
        }
    }

    trigger OnInit()
    begin
        "Date Requested":=Today;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Date Requested":=Today;
    end;

    var
        FileMgt: Codeunit "File Management";
        DestinationFile: Text[150];
        ObjATMApplications: Record "ATM Card Applications";
        CardTxtFile: File;
        TxtStream: OutStream;
        varTxtData: XmlPort "ATM Card Appl";

    local procedure FnXmlExportCardApplications()
    begin

          CardTxtFile.Create('C:\ATMCardApplications\ATM Card Applications.txt');
          CardTxtFile.CreateOutstream(TxtStream);
          Xmlport.Export(51516038, TxtStream);
          CardTxtFile.Close;

    end;
}

