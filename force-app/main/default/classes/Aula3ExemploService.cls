public with sharing class Aula3ExemploService {
    @AuraEnabled
    public static Boolean saveAddressInformation(Id accountId, addressTO addressInformations){
        try {
            Account account = AccountDAO.getInstance().searchAccountById(accountId);

            account.BillingPostalCode = addressInformations.cep;
            account.BillingStreet = addressInformations.rua;
            account.BillingCountry = addressInformations.bairro;
            account.BillingCity = addressInformations.cidade;
            account.BillingState = addressInformations.estado;
            account.BillingNumber__c = addressInformations.numero;

            update account;
            return true;
        } catch (Exception e) {
            //throw new AuraHandledException(e.getMessage());
            return false;
        }
    }

    public class addressTO {
        @AuraEnabled public String cep { get; set; }
        @AuraEnabled public String rua { get; set; }
        @AuraEnabled public String bairro { get; set; }
        @AuraEnabled public String cidade { get; set; }
        @AuraEnabled public String estado { get; set; }
        @AuraEnabled public String numero { get; set; }
    }
}