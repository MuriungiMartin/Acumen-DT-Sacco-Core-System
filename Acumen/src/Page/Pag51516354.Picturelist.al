#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 51516354 "Picturelist"
{
    PageType = List;
    SourceTable = Pictures;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No;No)
                {
                    ApplicationArea = Basic;
                }
                field(Picture;Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature;Signature)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

