global class LeadProcessor implements Database.Batchable<sObject> {

    global Integer count = 0;

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead');
    }

    global void execute(Database.BatchableContext bc, List<Lead> records){
       List<Lead> lstLeadNew = new List<Lead>();

        for (Lead objLead : records) {
            objLead.LeadSource = 'Dreamforce';
            lstLeadNew.add(objLead);
            count += 1;
        }

        update lstLeadNew;

    }

    global void finish(Database.BatchableContext bc){
        System.debug('count = ' + count);
    }
}