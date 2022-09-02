#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 51516900 "CRBA Datas"
{

    fields
    {
        field(1;No;Integer)
        {
        }
        field(2;Surname;Text[100])
        {
        }
        field(3;"Date of Birth";Text[30])
        {
        }
        field(4;"Client Code";Code[20])
        {
        }
        field(5;"Account Number";Code[20])
        {
        }
        field(6;Gender;Option)
        {
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(7;Nationality;Text[30])
        {
        }
        field(8;"Marital Status";Option)
        {
            OptionCaption = ' ,Single,Married,Devorced,Widower';
            OptionMembers = " ",Single,Married,Devorced,Widower;
        }
        field(9;"Primary Identification 1";Text[30])
        {
        }
        field(10;"Primary Identification 2";Text[30])
        {
        }
        field(11;"Mobile No";Text[30])
        {
        }
        field(12;"Work Telephone";Code[50])
        {
        }
        field(13;"Postal Address 1";Code[100])
        {
        }
        field(14;"Postal Address 2";Code[100])
        {
        }
        field(15;"Postal Location Town";Text[30])
        {
        }
        field(16;"Postal Location Country";Text[30])
        {
        }
        field(17;"Post Code";Code[50])
        {
        }
        field(18;"Physical Address 1";Text[50])
        {
        }
        field(19;"Physical Address 2";Text[50])
        {
        }
        field(20;"Location Town";Text[50])
        {
        }
        field(21;"Location Country";Text[50])
        {
        }
        field(22;"Date of Physical Address";Date)
        {
        }
        field(23;"Customer Work Email";Text[100])
        {
        }
        field(24;"Employer Name";Text[30])
        {
        }
        field(25;"Employment Type";Option)
        {
            OptionCaption = ' ,Affiliates, Embassies, Spouse, NGOs';
            OptionMembers = " ",Affiliates," Embassies"," Spouse"," NGOs";
        }
        field(26;"Account Type";Text[30])
        {
        }
        field(27;"Account Product Type";Code[10])
        {
        }
        field(28;"Date Account Opened";Text[30])
        {
        }
        field(29;"Installment Due Date";Date)
        {
        }
        field(30;"Original Amount";Text[30])
        {
        }
        field(31;"Currency of Facility";Code[10])
        {
        }
        field(32;"Amonut in Kenya shillings";Text[30])
        {
            AutoFormatType = 0;
        }
        field(33;"Current Balance";Text[30])
        {
        }
        field(34;"Overdue Balance";Decimal)
        {
        }
        field(35;"No of Days in Arreas";Integer)
        {
        }
        field(36;"No of Installment In";Integer)
        {
        }
        field(37;"Performing / NPL Indicator";Text[30])
        {
        }
        field(38;"Account Status";Code[10])
        {
        }
        field(39;"Account Status Date";Text[30])
        {
        }
        field(40;"Repayment Period";Integer)
        {
        }
        field(41;"Payment Frequency";Text[30])
        {
        }
        field(42;"Disbursement Date";Date)
        {
        }
        field(43;"Insallment Amount";Decimal)
        {
        }
        field(44;"Date of Latest Payment";Text[30])
        {
        }
        field(45;"Last Payment Amount";Decimal)
        {
        }
        field(46;"Forename 1";Text[30])
        {
        }
        field(47;"Forename 2";Text[30])
        {
        }
        field(48;"Forename 3";Text[30])
        {
        }
        field(49;Salutation;Text[30])
        {
        }
        field(50;"Primary Identification code";Code[30])
        {
        }
        field(51;"Secondary Identification code";Code[30])
        {
        }
        field(52;"Other Identification Type";Text[30])
        {
        }
        field(53;"Home Telephone";Text[30])
        {
        }
        field(54;"Plot Number";Text[30])
        {
        }
        field(55;"PIN Number";Text[30])
        {
        }
        field(56;"Employment Date";Text[30])
        {
        }
        field(57;"Salary Band";Text[30])
        {
        }
        field(58;"Lenders Registered Name";Text[30])
        {
        }
        field(59;"Lenders Trading Name";Text[30])
        {
        }
        field(60;"Lenders Branch Name";Text[30])
        {
        }
        field(61;"Lenders Branch Code";Code[30])
        {
        }
        field(62;"Account Closure Reason";Text[30])
        {
        }
        field(63;"Deferred Payment Date";Text[30])
        {
        }
        field(64;"Deferred Payment";Decimal)
        {
        }
        field(65;"Type of Security";Text[30])
        {
        }
        field(66;"Other Identification Code";Code[30])
        {
        }
        field(67;"Employer Industry Type";Text[30])
        {
        }
        field(68;"Overdue Date";Text[30])
        {
        }
        field(69;"Name 2";Text[30])
        {
        }
        field(70;"Name 3";Text[30])
        {
        }
    }

    keys
    {
        key(Key1;No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

