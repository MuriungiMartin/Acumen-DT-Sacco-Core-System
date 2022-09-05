#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516044 "CloudPESA MPESA Change Card"
{
    PageType = Card;
    SourceTable = "CloudPESA MPESA Change";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(idx; idx)
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        cloudpesaMpesaTrans: Record "CloudPESA MPESA Trans";
                    begin
                        cloudpesaMpesaTrans.Reset;
                        cloudpesaMpesaTrans.SetRange("Document No", xRec."Document No");
                        if cloudpesaMpesaTrans.Find('-') then begin
                            xRec."Original Account No" := cloudpesaMpesaTrans."Account No";
                            xRec."Account Name" := cloudpesaMpesaTrans."Account Name";
                            xRec.Amount := cloudpesaMpesaTrans.Amount;
                            xRec."Document Date" := cloudpesaMpesaTrans."Transaction Date";
                            xRec."Document Time" := cloudpesaMpesaTrans."Transaction Time";
                            xRec.Telephone := cloudpesaMpesaTrans.Telephone;
                            xRec."Changed By" := UserId;
                        end;
                    end;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Document Time"; "Document Time")
                {
                    ApplicationArea = Basic;
                }
                field("Original Account No"; "Original Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Document Change Date"; "Document Change Date")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone; Telephone)
                {
                    ApplicationArea = Basic;
                }
                field("Changed By"; "Changed By")
                {
                    ApplicationArea = Basic;
                }
                field("Change Status"; "Change Status")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
}
