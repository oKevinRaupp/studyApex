trigger Lead2trigger on Lead2__c (before insert, after insert) {
	
    System.debug('[TRIGGER]');
    
    if(Trigger.isBefore){
        System.debug(Trigger.isBefore);
        System.debug(trigger.new[0].Email__c);
        
        
        Campanha2__c campanha = [SELECT Name, TitleMSG__c, WelcomeMSG__c FROM Campanha2__c WHERE Id = :trigger.new[0].Campanha2__c];
        
        System.debug(campanha.TitleMSG__c);
        System.debug(campanha.WelcomeMSG__c);
        System.debug(campanha.Name);

        EmailManager.sendMail(trigger.new[0].Email__c,campanha.TitleMSG__c,campanha.WelcomeMSG__c);
        
    }
}