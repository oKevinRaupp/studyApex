@isTest
public with sharing class LeadProcessorTest {

    @IsTest
    static void test(){
        
        List<Lead> lstLeads = new List<Lead>();

        for (Integer i = 0; i < 200; i++) {
            Lead objLead = new Lead();
            objLead.LastName = 'lead name' + i;
            objLead.Company = 'lead company';
            objLead.Status = 'New';
            lstLeads.add(objLead);
        }

        insert lstLeads;

        Test.startTest();
        LeadProcessor leadProcessor = new LeadProcessor();
        Id jobId = Database.executeBatch(leadProcessor);
        Test.stopTest();
        
    }

}