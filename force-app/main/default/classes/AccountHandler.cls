public with sharing class AccountHandler {
    public static Account insertNewAccount(String accountName) {
        try {
            Account objAcctToInsert = new Account(Name=accountName);    
            insert objAcctToInsert;
            return objAcctToInsert;
        } catch (Exception e) {
            System.debug('A DML exception has occurred: ' +
                e.getMessage());
                return null;
        }
    }
}