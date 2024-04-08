public with sharing class AccountBO {

    static final String OBJ_ACCOUNT = 'Account';

    private static AccountBO instance = new AccountBO();

    public static AccountBO getInstance() {
        return instance;
    }

    public void criarOportunidade(List<Account> lstNewAccount) {
        List<Opportunity> lstOpportunidade = new List<Opportunity>();
            for (Account conta : lstNewAccount) {
                Opportunity objOppToCreate = new Opportunity(AccountId=conta.Id, Name=conta.Name, StageName='Prospecting');
                objOppToCreate.CloseDate = System.today().addDays(30);
                lstOpportunidade.add(objOppToCreate);
            }
            if (!lstOpportunidade.isEmpty()) {
                insert lstOpportunidade;
            }
    }

    public void criarCaso(List<Account> lstNewAccount, Map<Id, Account> mapIdOldAccount) {
        List<Case> cases = new List<Case>();
        for(Account conta : lstNewAccount){
            Account contaAntiga = mapIdOldAccount.get(conta.Id);
            List<String> campos = new List<String>{'Name', 'Phone', 'Fax', 'Type'};
            String erro = Util.validarAlteracaoCampos(conta, contaAntiga, OBJ_ACCOUNT, campos);
            if(!String.isBlank(erro)){
                Case caso = new Case();
                caso.Status = 'New';
                caso.Origin = 'Web';
                caso.subject = 'Dados alterados da conta: ' + conta.Name;
                caso.description = erro;
                caso.AccountId = conta.Id;
                cases.add(caso);
            }
        }
        if(!cases.isEmpty()){
            insert cases;
        }
    }

    public void copiarDadosEnvioEnderecoCobranca(List<Account> lstNewAccount) {
        for (Account conta : lstNewAccount) {
            if (conta.Match_Billing_Address__c) {
                conta.BillingPostalCode = conta.ShippingPostalCode;
                conta.BillingStreet = conta.ShippingStreet;
                conta.BillingCountry = conta.ShippingCountry;
                conta.BillingCity = conta.ShippingCity;
                conta.BillingState = conta.ShippingState;
            }
        }
    }

    public void verificarEnderecosIguais(List<Account> lstNewAccount, Map<Id, Account> mapIdOldAccount) {
        for(Account conta : lstNewAccount){
            Account contaAntiga = mapIdOldAccount.get(conta.Id);
            if(conta.BillingPostalCode != contaAntiga.BillingPostalCode 
            || conta.BillingStreet != contaAntiga.BillingStreet 
            || conta.BillingCountry != contaAntiga.BillingCountry 
            || conta.BillingCity != contaAntiga.BillingCity 
            || conta.BillingState != contaAntiga.BillingState ){
                conta.addError('Não é possivel alterar o endereço de cobrança');                    
            }
        }
    }

    public void validateRelatedCarroWhenDeleteAccount(List<Account> lstOldAccount) {
        //Preparando os dados necessarios
        Set<Id> setIdConta = new Set<Id>();
        for(Account conta : lstOldAccount){
            setIdConta.add(conta.id);
        }
        
        List<Carro__c> carros = AccountDAO.getInstance().buscarCarrosPorAccountID(setIdConta);

        if(carros != null){
            Map<Id, List<Carro__c>> mapIdContaPorCarro = new Map<Id, List<Carro__c>>();
            for(Carro__c carro : carros){
                if(mapIdContaPorCarro.containsKey(carro.Account__c)){
                    List<Carro__c> carrosTemp = mapIdContaPorCarro.get(carro.Account__c);
                    carrosTemp.add(carro);
                    mapIdContaPorCarro.put(carro.Account__c, carrosTemp);
                }
                else{
                    mapIdContaPorCarro.put(carro.Account__c, new List<Carro__c>{carro});
                }
            }

            //Regra de negocio
            for(Account conta : lstOldAccount){
                if(mapIdContaPorCarro.containsKey(conta.Id)){
                    List<Carro__c> carrosAux = mapIdContaPorCarro.get(conta.Id);
                    for(Carro__c carro : carrosAux){
                        if(carro.Vendido__c){
                            conta.addError('A conta não pode ser deletada por que possui um carro vendido');
                        }
                    }
                }
            }
        }
    }

    public void deleteRelatedCarroWhenDeleteAccount(List<Account> lstOldAccount) {
        //preparar os dados
        Set<Id> setIdConta = new Set<Id>();
        for(Account conta : lstOldAccount){
            setIdConta.add(conta.Id);
        }
        List<Carro__c> carros = AccountDAO.getInstance().buscarCarrosPorAccountID(setIdConta);
        if(carros != null){
            Map<Id, List<Carro__c>> mapIdContaPorCarro = new Map<Id, List<Carro__c>>();
            for(Carro__c carro : carros){
                if(mapIdContaPorCarro.containsKey(carro.Account__c)){
                    List<Carro__c> carrosTemp = mapIdContaPorCarro.get(carro.Account__c);
                    carrosTemp.add(carro);
                    mapIdContaPorCarro.put(carro.Account__c, carrosTemp);
                }
                else{
                    mapIdContaPorCarro.put(carro.Account__c, new List<Carro__c>{carro});
                }
            }

            //regra de negocio
            List<Carro__c> carrosDeletar = new List<Carro__c>();
            for(Account conta : lstOldAccount){
                if(mapIdContaPorCarro.containsKey(conta.Id)){
                    List<Carro__c> carrosAux = mapIdContaPorCarro.get(conta.Id);
                    for(Carro__c carro : carrosAux){
                        carrosDeletar.add(carro);
                    }
                }
            }

            System.debug(JSON.serializePretty('Carros deletar ' + JSON.serializePretty(carrosDeletar)));

            if (!carrosDeletar.isEmpty()) {
                Database.DeleteResult[] drList = Database.delete(carrosDeletar, false);
    
                // Iterate through each returned result
                for(Database.DeleteResult dr : drList) {
                    if (dr.isSuccess()) {
                        // Operation was successful, so get the ID of the record that was processed
                        System.debug('Successfully deleted account with ID: ' + dr.getId());
                    }
                    else {
                        // Operation failed, so get all errors                
                        for(Database.Error err : dr.getErrors()) {
                            System.debug('The following error has occurred.');                    
                            System.debug(err.getStatusCode() + ': ' + err.getMessage());
                            System.debug('Account fields that affected this error: ' + err.getFields());
                        }
                    }
                }
            }
        }
    }
}