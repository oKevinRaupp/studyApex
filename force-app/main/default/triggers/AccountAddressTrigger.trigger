trigger AccountAddressTrigger on Account (before insert, before update, after insert) {

    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        for(Account a : Trigger.new) {
            if(a.Match_Billing_Address__c) {
                a.BillingStreet= a.ShippingStreet;
                a.BillingCity = a.ShippingCity;
                a.BillingState = a.ShippingState;
                a.BillingPostalCode = a.ShippingPostalCode;
                a.BillingCountry = a.ShippingCountry;
                for (Account newAccount : Trigger.new) {
                    Opportunity objOppToCreate = new Opportunity(AccountId=newAccount.Id, Name=newAccount.Name, StageName='Prospecting');
                    objOppToCreate.CloseDate = System.today().addDays(30);
                }
            }
        }
    }

    if(Trigger.isAfter && Trigger.isInsert) {

        List<Opportunity> lstOpportunityToInsert = new List<Opportunity>();

        for (Account newAccount : Trigger.new) {
            Opportunity objOppToCreate = new Opportunity(AccountId=newAccount.Id, Name=newAccount.Name, StageName='Prospecting');
            objOppToCreate.CloseDate = System.today().addDays(30);
            
            lstOpportunityToInsert.add(objOppToCreate);

        }

        if (!lstOpportunityToInsert.isEmpty()) {
            Database.SaveResult[] srList = Database.insert(lstOpportunityToInsert, false);

            for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully inserted account. Account ID: ' + sr.getId());
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Account fields that affected this error: ' + err.getFields());
                    }
                }
            }
        }
    }
}