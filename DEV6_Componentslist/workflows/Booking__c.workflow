<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Booking_Status_is_Paid_or_Installment_mail_to_parent</fullName>
        <description>Booking Status is Paid or Installment mail to parent</description>
        <protected>false</protected>
        <recipients>
            <field>First_Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <recipient>harjinder.kaur@nct.org.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NCT_Templates/Booking_Status_is_Paid_or_Installment</template>
    </alerts>
    <alerts>
        <fullName>Booking_status_is_Cancelling_and_StartDate_is_less_than_10_days</fullName>
        <description>Booking status is Cancelling and StartDate is less than 10 days</description>
        <protected>false</protected>
        <recipients>
            <recipient>Enquiry_PSA_group</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NCT_Templates/Booking_status_is_Cancelling_and_StartDate_is_less_than_10_days</template>
    </alerts>
    <alerts>
        <fullName>Course_booking_status_confirmed</fullName>
        <description>Course booking status confirmed</description>
        <protected>false</protected>
        <recipients>
            <recipient>anjineyulu.valasa@csscorp.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>harjinder.kaur@nct.org.uk</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>ranjithkumar.sareeswaran@csscorp.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>venkata.ramana@csscorp.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NCT_Templates/Course_booking_status_Confirmed</template>
    </alerts>
    <alerts>
        <fullName>Course_booking_status_reserved</fullName>
        <description>Course booking status reserved</description>
        <protected>false</protected>
        <recipients>
            <recipient>anjineyulu.valasa@csscorp.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>harjinder.kaur@nct.org.uk</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>shilpi.shrangee@csscorp.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NCT_Templates/Course_booking_status_reserved</template>
    </alerts>
    <alerts>
        <fullName>Send_Confirmation_Email</fullName>
        <description>Send Confirmation Email</description>
        <protected>false</protected>
        <recipients>
            <field>Client__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NCT_Templates/Booking_Confirmation</template>
    </alerts>
    <alerts>
        <fullName>Send_Reservation_Email</fullName>
        <description>Send Reservation Email</description>
        <protected>false</protected>
        <recipients>
            <field>Client__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NCT_Templates/Course_Reservation</template>
    </alerts>
    <fieldUpdates>
        <fullName>Couples_Update_Field</fullName>
        <field>Attendees__c</field>
        <literalValue>Couples</literalValue>
        <name>Couples Update Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Booking_to_Lapsed</fullName>
        <field>Status__c</field>
        <literalValue>Lapsed</literalValue>
        <name>Set Booking to Lapsed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Offer_Email_Sent_Time</fullName>
        <field>Offer_Email_Sent__c</field>
        <formula>NOW()</formula>
        <name>Set Offer Email Sent Time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Singles_Update_Field</fullName>
        <field>Attendees__c</field>
        <literalValue>Single</literalValue>
        <name>Singles Update Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Attendees Field Update Automate to Couples</fullName>
        <actions>
            <name>Couples_Update_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>IF( AND( NOT( ISBLANK( First_Contact__c ) ) , NOT( ISBLANK( Second_Contact__c ) )) , true, false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Attendees Field Update Automate to Singles</fullName>
        <actions>
            <name>Singles_Update_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>IF( AND( NOT( ISBLANK( First_Contact__c ) ) , ISBLANK( Second_Contact__c ) ) , true, false)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Booking Status is Paid or Installment</fullName>
        <actions>
            <name>Booking_Status_is_Paid_or_Installment_mail_to_parent</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Booking Status is Paid or Installment sent email to customer</description>
        <formula>AND( ISPICKVAL(  Status__c,  &apos;Installment&apos;) || ISPICKVAL(  Status__c, &apos;Paid&apos; ))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Booking status is Cancelling and StartDate is less than 10 days</fullName>
        <actions>
            <name>Booking_status_is_Cancelling_and_StartDate_is_less_than_10_days</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Booking status is Cancelling and StartDate is less than 10 days</description>
        <formula>AND( ISPICKVAL(  Status__c ,&apos;Cancelling&apos;) , DATEVALUE( Course__r.Start_Date__c )&lt;= (TODAY()+10))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Course booking status Confirmed</fullName>
        <actions>
            <name>Course_booking_status_confirmed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Booking__c.Status__c</field>
            <operation>equals</operation>
            <value>Confirmed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Course booking status reserved</fullName>
        <actions>
            <name>Course_booking_status_reserved</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1</booleanFilter>
        <criteriaItems>
            <field>Booking__c.Status__c</field>
            <operation>equals</operation>
            <value>Reserved</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Confirmation Email</fullName>
        <actions>
            <name>Send_Confirmation_Email</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Booking__c.Status__c</field>
            <operation>equals</operation>
            <value>Confirmed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Reservation Email</fullName>
        <actions>
            <name>Send_Reservation_Email</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Set_Offer_Email_Sent_Time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Booking__c.Status__c</field>
            <operation>equals</operation>
            <value>Reserved</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Set_Booking_to_Lapsed</name>
                <type>FieldUpdate</type>
            </actions>
            <timeLength>10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
