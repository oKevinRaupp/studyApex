@isTest
public class AddPrimaryContactTest {

    static testmethod void testQueueable() {
        List<Account> lstAccountTest = new List<Account>();
        for(Integer i=0; i<50; i++) {
            lstAccountTest.add(new Account(Name='Account' + i,BillingState='CA'));
        }
        
        for(Integer j=0; j<50; j++) {
            lstAccountTest.add(new Account(Name='Account' + j,BillingState='NY'));
        }
        insert lstAccountTest;
        
        Contact testContact = new Contact(FirstName='Kevin', LastName='Raupp');
        insert testContact;
        
        AddPrimaryContact addPrimaryContact = new AddPrimaryContact(testContact,'CA');
        
        Test.startTest();
        System.enqueueJob(addPrimaryContact);
        Test.stopTest();
        
        System.assertEquals(50,[Select count() FROM Contact WHERE accountId in (Select Id FROM Account WHERE BillingState='CA')]);
        
        
        
    }
    	
    
}