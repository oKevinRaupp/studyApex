public class AddPrimaryContact implements Queueable{
	
    private Contact objContact;
    private String state;
    
    public AddPrimaryContact(Contact objContact, String state) {
        this.objContact = objContact;
        this.state = state;
    }
    
    public void execute(QueueableContext ct) {
        List<Account> lstAccounts = [SELECT Id, 
                                     		Name, 
                                     		(SELECT FirstName, LastName FROM Contacts) 
                                     		FROM Account 
                                     		WHERE BillingState =:state limit 200];
        
        List<Contact> primaryContacts = new List<Contact>();
        
        for(Account acc: lstAccounts) {
            Contact c = objContact.clone();
            c.AccountId = acc.Id;
            primaryContacts.add(c);
        }
        
        if(primaryContacts.size() > 0) {
            insert primaryContacts;
        }
        
    }
    
}