public with sharing class AccountDAO {

    private static AccountDAO instance = new AccountDAO();

    public static AccountDAO getInstance() {
        return instance;
    }

    public List<Carro__c> buscarCarrosPorAccountID(Set<Id> setIdAccount) {
        List<Carro__c> retorno = new List<Carro__c>();
        retorno = [SELECT 
                        Id, 
                        Vendido__c, 
                        Account__c 
                    FROM Carro__c 
                    WHERE 
                    Account__c IN: setIdAccount];
                    
        return retorno;
    }

}