public with sharing class AccountProcessor {
    @future
    public static void countContacts(List<Id> lstAccountIds) {
        
        Map<Id,Integer> mapAccount = new Map<Id,Integer>(); 
        List<account> lstAccounts = new List<account>([SELECT id, (select id from contacts) from account]);
        for(account a : lstAccounts) {
            mapAccount.put(a.id,a.contacts.size()); //populate the map
        }
            		
        List<account> account_lst = new List<account>(); // list of account that we will upsert
        	
        for(Id accountId : lstAccountIds) {
            if(mapAccount.containsKey(accountId)) {
                account acc = new account();
                acc.Id = accountId;
                acc.Number_of_Contacts__c = mapAccount.get(accountId);
                account_lst.add(acc);
            }
            
        }
        upsert account_lst;
    }

}