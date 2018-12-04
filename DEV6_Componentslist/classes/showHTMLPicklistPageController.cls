public class showHTMLPicklistPageController 
{
    public list<Membership_Fee__mdt> membershipFeeList {get;set;}
    public list<Membership_Payment_Category__mdt> membershipPmtCtryList {get;set;}
    public string selectedValue {get;set;}
	public string displayValue {get;set;}
	public string counter  {get;set;}
    public Map<String, List<Membership_Type__mdt>> membershipTypeMap{get;set;}
    public showHTMLPicklistPageController()
    {
        displayValue = 'none';
        counter = '';
        membershipFeeList = new list<Membership_Fee__mdt>();
        membershipPmtCtryList = new list<Membership_Payment_Category__mdt>();
        membershipPmtCtryList = [select Id, MasterLabel from Membership_Payment_Category__mdt order by Id ASC];
        membershipFeeList = [select Id, MasterLabel, Membership_Payment_Type__c,Membership_Payment_Category__c from Membership_Fee__mdt order by Membership_Payment_Category__c ASC];
        membershipTypeMap = MembershipUtilties.getMembershipTypeMap('Individual');
        //system.debug('*$*$*$*  membershipFeeList   ' + membershipFeeList);    
    }
    public void displayValue()
    {
        system.debug('*$*$*$*  selectedValue   ' + selectedValue);
    }
}