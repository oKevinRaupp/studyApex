public with sharing class Aula3ExemploController {
    
    @AuraEnabled
    public static Account searchAccountByCEP(String cep){
        try {
            Account account = AccountDAO.getInstance().searchAccountByCEP(cep);
            return account;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}