<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Practitioner_changed_in_Session_Object</fullName>
        <description>Practitioner changed in Session Object</description>
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
        <template>NCT_Templates/Practitioner_Changes_sessions</template>
    </alerts>
    <fieldUpdates>
        <fullName>SessionStatusChangedToConfirmed</fullName>
        <field>Status__c</field>
        <literalValue>Confirmed</literalValue>
        <name>SessionStatusChangedToConfirmed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>statuschangedtoconfirmed</fullName>
        <field>Status__c</field>
        <literalValue>Confirmed</literalValue>
        <name>statuschangedtoconfirmed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>SessionStatusChangedToConfirmed</fullName>
        <actions>
            <name>statuschangedtoconfirmed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Course__c.Course_Name__c</field>
            <operation>equals</operation>
            <value>Antenatal</value>
        </criteriaItems>
        <criteriaItems>
            <field>Session__c.Session_Type__c</field>
            <operation>equals</operation>
            <value>Reunion</value>
        </criteriaItems>
        <criteriaItems>
            <field>Session__c.Start__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Session__c.End__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
