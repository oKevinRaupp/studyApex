@isTest
public with sharing class Lead2triggerTest {

    @isTest
    static void test() {
        Campanha2__c newCapanha = new Campanha2__c();
        newCapanha.Name = 'teste';
        newCapanha.TitleMSG__c = 'aaa';
        newCapanha.WelcomeMSG__c = 'aaa';
        insert newCapanha;

        Lead2__c newLead = new Lead2__c();    
        newLead.Name = 'teste';
        newLead.Email__c = 'teste@teste.com';
        newLead.Campanha2__c = newCapanha.Id;
        insert newLead;
    }

}