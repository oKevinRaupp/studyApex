public with sharing class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer numcnt,String l){
        List<Contact> contacts=new List<Contact>();
        for(Integer i=0;i<numcnt;i++){
            Contact cnt=new Contact(FirstName='Test '+i,LastName=l);
            contacts.add(cnt);
        }
        return contacts;
    }
}