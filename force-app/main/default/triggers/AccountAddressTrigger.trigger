trigger AccountAddressTrigger on Account (before insert, before update, after insert, after update, before delete, after delete) {
    
    if (Trigger.isBefore) {

        if(Trigger.isInsert){
            AccountBO.getInstance().copyShippingAdressToBillingAdress(Trigger.new);
        }
        
        if(Trigger.isUpdate){
            AccountBO.getInstance().validateSameAdress(Trigger.new, Trigger.oldMap);
        }

        if(Trigger.isDelete){
            AccountBO.getInstance().validateRelatedCarroWhenDeleteAccount(Trigger.old);
            AccountBO.getInstance().deleteRelatedCarroWhenDeleteAccount(Trigger.old);
        }
    }
    if (Trigger.isAfter) {
        
        if(Trigger.isInsert){
            AccountBO.getInstance().createOpportunity(Trigger.new);
        }
        if(Trigger.isUpdate){
            AccountBO.getInstance().createCase(Trigger.new, Trigger.oldMap);
        }

        if(Trigger.isDelete){
            
        }
    }
    
    
    // Feito por mim
    // if (Trigger.isBefore && Trigger.isInsert) {
    //     for(Account a : Trigger.new) {
            
    //         if(a.Match_Billing_Address__c) {
    //             a.BillingStreet= a.ShippingStreet;
    //             a.BillingCity = a.ShippingCity;
    //             a.BillingState = a.ShippingState;
    //             a.BillingPostalCode = a.ShippingPostalCode;
    //             a.BillingCountry = a.ShippingCountry;

    //             for (Account newAccount : Trigger.new) {
    //                 Opportunity objOppToCreate = new Opportunity(AccountId=newAccount.Id, Name=newAccount.Name, StageName='Prospecting');
    //                 objOppToCreate.CloseDate = System.today().addDays(30);
    //             }
    //         }
    //     }
    // }

    // if (Trigger.isUpdate && Trigger.isBefore) {
        
    //     for (Account newAcc : Trigger.new) {
    //         Account oldAcc = Trigger.oldMap.get(newAcc.Id);
    //         if (newAcc.Match_Billing_Address__c && (newAcc.BillingStreet != oldAcc.BillingStreet || newAcc.BillingCity != oldAcc.BillingCity || newAcc.BillingState != oldAcc.BillingState || newAcc.BillingPostalCode != oldAcc.BillingPostalCode || newAcc.BillingCountry != oldAcc.BillingCountry)) {
    //                newAcc.addError('Preencha o endereço, por favor!');
    //         }
    //     }

    // }

    // if (Trigger.isUpdate && Trigger.isAfter) {

    //     List<Case> lstCaseToCreate = new List<Case>();

    //         for (Account newAcc : Trigger.new) {
                
    //             Account oldAcc = Trigger.oldMap.get(newAcc.Id);

    //             Case caseToCreate = new Case(Status='New', Origin='Web',Subject='Dados alterados da conta: ' + newAcc.Name);

    //             caseToCreate.AccountId = newAcc.Id;
    //             caseToCreate.Description = '';

    //             if (oldAcc.Name != newAcc.Name) {
    //                 caseToCreate.Description += 'Name ';
    //             }

                
    //             if (oldAcc.Phone != newAcc.Phone) {
    //                 caseToCreate.Description += 'Phone ';
    //             }

                
    //             if (oldAcc.Fax != newAcc.Fax) {
    //                 caseToCreate.Description += 'Fax ';
    //             }

                
    //             if (oldAcc.AccountNumber != newAcc.AccountNumber) {
    //                 caseToCreate.Description += 'AccountNumber ';
    //             }

                
    //             if (oldAcc.Website != newAcc.Website) {
    //                 caseToCreate.Description += 'Website ';
    //             }

                
    //             if (oldAcc.Site != newAcc.Site) {
    //                 caseToCreate.Description += 'Site ';
    //             }

                
    //             if (oldAcc.TickerSymbol != newAcc.TickerSymbol) {
    //                 caseToCreate.Description += 'TickerSymbol ';
    //             }

    //             if (oldAcc.Type != newAcc.Type) {
    //                 caseToCreate.Description += 'Type ';
    //             }

                
    //             if (oldAcc.Ownership != newAcc.Ownership) {
    //                 caseToCreate.Description += 'Ownership ';
    //             }

                
    //             if (oldAcc.Industry != newAcc.Industry) {
    //                 caseToCreate.Description += 'Industry ';
    //             }

                
    //             if (oldAcc.NumberOfEmployees != newAcc.NumberOfEmployees) {
    //                 caseToCreate.Description += 'NumberOfEmployees ';
    //             }

                
    //             if (oldAcc.AnnualRevenue != newAcc.AnnualRevenue) {
    //                 caseToCreate.Description += 'AnnualRevenue ';
    //             }

                
    //             if (oldAcc.Active__c != newAcc.Active__c) {
    //                 caseToCreate.Description += 'Active__c ';
    //             }

                
    //             if (oldAcc.SLA__c != newAcc.SLA__c) {
    //                 caseToCreate.Description += 'SLA__c ';
    //             }

    //             lstCaseTocreate.add(caseToCreate);
    //     }

    //     if (!lstCaseToCreate.isEmpty()) {
    //         Database.SaveResult[] srList = Database.insert(lstCaseToCreate, false);

    //         for (Database.SaveResult sr : srList) {
    //             if (sr.isSuccess()) {
    //                 // Operation was successful, so get the ID of the record that was processed
    //                 System.debug('Successfully inserted account. Account ID: ' + sr.getId());
    //             }
    //             else {
    //                 // Operation failed, so get all errors                
    //                 for(Database.Error err : sr.getErrors()) {
    //                     System.debug('The following error has occurred.');                    
    //                     System.debug(err.getStatusCode() + ': ' + err.getMessage());
    //                     System.debug('Account fields that affected this error: ' + err.getFields());
    //                 }
    //             }
    //         }
    //     }
        
    // }

    // if(Trigger.isAfter && Trigger.isInsert) {

    //     List<Opportunity> lstOpportunityToInsert = new List<Opportunity>();

    //     for (Account newAccount : Trigger.new) {
    //         Opportunity objOppToCreate = new Opportunity(AccountId=newAccount.Id, Name=newAccount.Name, StageName='Prospecting');
    //         objOppToCreate.CloseDate = System.today().addDays(30);
            
    //         lstOpportunityToInsert.add(objOppToCreate);

    //     }

    //     if (!lstOpportunityToInsert.isEmpty()) {
    //         Database.SaveResult[] srList = Database.insert(lstOpportunityToInsert, false);

    //         for (Database.SaveResult sr : srList) {
    //             if (sr.isSuccess()) {
    //                 // Operation was successful, so get the ID of the record that was processed
    //                 System.debug('Successfully inserted account. Account ID: ' + sr.getId());
    //             }
    //             else {
    //                 // Operation failed, so get all errors                
    //                 for(Database.Error err : sr.getErrors()) {
    //                     System.debug('The following error has occurred.');                    
    //                     System.debug(err.getStatusCode() + ': ' + err.getMessage());
    //                     System.debug('Account fields that affected this error: ' + err.getFields());
    //                 }
    //             }
    //         }
    //     }
    // }

    // if(Trigger.isDelete && Trigger.isBefore) {

    //     if (Trigger.isBefore) {
         
    //         List<Carro__c> lstCarrosToDelete = new List<Carro__c>();

    //         for (Account accountToDelete : Trigger.old) {

    //             List<Carro__c> lstCarrosVinculados = New List<Carro__c>();
    //             lstCarrosVinculados =   [ 
    //                                         SELECT
    //                                         Id, Vendido__c
    //                                         FROM Carro__c
    //                                         WHERE
    //                                         Account__c =:  accountToDelete.Id
    //                                     ];

    //             for (Carro__c carroToDelete : lstCarrosVinculados) {
    //                 if (carroToDelete.Vendido__c) {
    //                     accountToDelete.addError('Conta com carros vendidos, não será possível efetuar a deleção da conta. ');
    //                 } else {
    //                     lstCarrosToDelete.add(carroToDelete);
    //                 }
    //             }
    //         }

    //         if (!lstCarrosToDelete.isEmpty()) {
    //             Database.DeleteResult[] drList = Database.delete(lstCarrosToDelete, false);

    //             // Iterate through each returned result
    //             for(Database.DeleteResult dr : drList) {
    //                 if (dr.isSuccess()) {
    //                     // Operation was successful, so get the ID of the record that was processed
    //                     System.debug('Successfully deleted account with ID: ' + dr.getId());
    //                 } else {
    //                     // Operation failed, so get all errors                
    //                     for(Database.Error err : dr.getErrors()) {
    //                         System.debug('The following error has occurred.');                    
    //                         System.debug(err.getStatusCode() + ': ' + err.getMessage());
    //                         System.debug('Account fields that affected this error: ' + err.getFields());
    //                     }
    //                 }
    //             }
    //         }
    //     }
    // } 
}