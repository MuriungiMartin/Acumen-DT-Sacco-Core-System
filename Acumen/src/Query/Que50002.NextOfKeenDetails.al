#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Query 50002 "NextOfKeenDetails"
{

    elements
    {
        dataitem(Members_Nominee;"Members Nominee")
        {
            column(Name;Name)
            {
            }
            column(Beneficiary;Beneficiary)
            {
            }
            column(Date_of_Birth;"Date of Birth")
            {
            }
            column(Address;Address)
            {
            }
            column(Telephone;Telephone)
            {
            }
            column(Email;Email)
            {
            }
            column(Account_No;"Account No")
            {
            }
            column(ID_No;"ID No.")
            {
            }
            column(Allocation;"%Allocation")
            {
            }
            dataitem(Relationship_Types;"Relationship Types")
            {
                DataItemLink = code=Members_Nominee.Relationship;
                column(Relationship;Describution)
                {
                }
            }
        }
    }
}

