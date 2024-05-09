public class Teste implements Database.Batchable<sObject> {

    public Iterable<sObject> start (Database.BatchableContext bc) {
        List<Opportunity> lstOpp = [SELECT Id FROM Opportunity WHERE StageName = 'Closed Lost'];
        
        return lstOpp;
    } 
    
    public void execute (Database.BatchableContext bc, List<Opportunity> lstOpp) {
        //delete da lista
    }
    
    public void finish (Database.BatchableContext bc) {
        
    }

}