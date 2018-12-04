<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>New_course_updated</fullName>
        <description>New course updated</description>
        <protected>false</protected>
        <recipients>
            <recipient>anjineyulu.valasa@csscorp.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NCT_Templates/Course_Created</template>
    </alerts>
    <alerts>
        <fullName>Practitioner_changed</fullName>
        <description>Practitioner changed</description>
        <protected>false</protected>
        <recipients>
            <field>Practitioner__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <recipient>harjinder.kaur@nct.org.uk</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>NCT_Templates/Practitioner_Changes_Course</template>
    </alerts>
    <fieldUpdates>
        <fullName>Course_Status_Field_Update</fullName>
        <description>Fully Booked</description>
        <field>Status__c</field>
        <literalValue>Fully Booked</literalValue>
        <name>Course Status Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>test</fullName>
        <actions>
            <name>New_course_updated</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Course__c.Status__c</field>
            <operation>equals</operation>
            <value>Confirmed</value>
        </criteriaItems>
        <description>Successfully your payment completed</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
