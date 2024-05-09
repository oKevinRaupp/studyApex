@IsTest
public with sharing class DailyLeadProcessorTest {
    
    public static String CRON_EXP = '20 30 8 10 2 ?';

    @IsTest
    static void test(){

        List<Lead> lstLeads = new List<Lead>();

        for (Integer i = 0; i < 200; i++) {
            Lead newLead = new Lead(FirstName='Name'+i,LastName='Last'+i,Company='Company');
            lstLeads.add(newLead);
        }
        insert lstLeads;
        
        Test.startTest();
        String jobId = System.schedule('ScheduleTest', CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();
        
        List<Lead> lstLeadsChecked = new List<Lead>();
        lstLeadsChecked = [SELECT Id FROM Lead WHERE LeadSource = 'Dreamforce' AND Company = 'Company'];

        System.assertEquals(200, lstLeadsChecked.size(),'Nao deu boa não gurizao');

    }

}