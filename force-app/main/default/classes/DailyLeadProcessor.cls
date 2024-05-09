global class DailyLeadProcessor implements Schedulable{
	
    global void execute(SchedulableContext ctx) {
        List<Lead> leadsToUpdate = new List<Lead>();
        List<lead> lstLeads = [SELECT Id FROM Lead WHERE LeadSource = NULL LIMIT 200];

        for (Lead objLead : lstLeads) {
            objLead.LeadSource = 'Dreamforce';
            leadsToUpdate.add(objLead);
        }
        update leadsToUpdate;
    }
    
}