public with sharing class ContactAndLeadSearch {
    public static List<List< sObject>> searchContactsAndLeads(String s) {
        List<List<SObject>> searchList = [FIND :s IN ALL FIELDS 
                                      RETURNING Contact(FirstName,LastName), Lead(FirstName,LastName)];

        return searchList;
    }
}