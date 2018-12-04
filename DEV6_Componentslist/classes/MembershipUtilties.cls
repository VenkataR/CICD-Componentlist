/**
*   @author:  Mahanth Garlapati
*   @description: This class provides the utilities for membership functionality
*
*    19/11/2018 MG Initial Implementation
**/

public with sharing class MembershipUtilties {

 
    /**
    *   @contactType : This is contact type and can be Individual,Joint, Volunteer, Practitioner
    *   returns valid Memberships as map.
    *   @targetCustomer : This is a target customer and should have Parent, (Parent, Companion), Volunteer/Practitioner,
    *   Parent on benefits, Staff only --> Updated on 29/11/2018 added by ujwal
    *    
    **/
    public static Map<String, List<sObject>> getMembershipTypeMap(String contactType, String targetCustomer){

        Map<String, List<Membership_Type__mdt>> membershipTypeMap = new Map<String, List<Membership_Type__mdt>>();

        List<Membership_Type__mdt> membershipTypeList = [
                                                            SELECT 
                                                                Id, 
                                                                MasterLabel, 
                                                                Eligible_for_Gift_Aid__c, 
                                                                Installment_Amount__c, 
                                                                No_of_Installments__c,
                                                                Payment_Type__c, 
                                                                Payment_Method__c, 
                                                                Recursive__c, 
                                                                Total_Amount__c, 
                                                                Contact_Type__c,
                                                                Target_Customer__c, 
                                                                Membership__c 
                                                            FROM 
                                                                Membership_Type__mdt 
                                                            WHERE 
                                                                ET_Specific__c = false AND Contact_Type__c = :contactType AND Target_Customer__c = :targetCustomer
                                                        ];

        for (Membership_Type__mdt membershipType : membershipTypeList ){
            if (membershipTypeMap.get(membershipType.Membership__c) == null){
                List<Membership_Type__mdt> tempMembershipTypeList = new List<Membership_Type__mdt>();
                tempMembershipTypeList.add(membershipType);
                membershipTypeMap.put(membershipType.Membership__c,tempMembershipTypeList);
            }else{
                membershipTypeMap.get(membershipType.Membership__c).add(membershipType);
            }

        }
        return membershipTypeMap;   
    }

    //This method takes payment type value as parameters and returns mem
    public List<Membership_Type__mdt> paymentTypeMethod(String payType){

        List<Membership_Type__mdt> paymentType = [
                                                    SELECT 
                                                        MasterLabel, 
                                                        Eligible_for_Gift_Aid__c, 
                                                        Installment_Amount__c, 
                                                        No_of_Installments__c, 
                                                        Payment_Method__c, 
                                                        Recursive__c, 
                                                        Total_Amount__c 
                                                    FROM 
                                                        Membership_Type__mdt 
                                                    WHERE 
                                                        Payment_Method__c =: payType
                                                 ];

        return paymentType; 
    }

}