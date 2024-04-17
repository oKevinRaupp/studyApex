public class EM02_BatchClass implements Database.Batchable<sObject> {

    public Iterable<sObject> start (Database.BatchableContext bc) {
        List<Opportunity> lstOpp = [SELECT Id FROM Opportunity WHERE StageName = 'Closed Lost'];
        
        return lstOpp;
    } 
    
    public void execute (Database.BatchableContext bc, List<Opportunity> lstOpp) {
        //delete da lista
    }
    
    public void finish (Database.BatchableContext bc) {
        
    }

    public static void main() {
        ExercicioMathias01  schClass = new ExercicioMathias01 ();
        String cron = '00 00 12 1 * ?';
        System.schedule('EVD_ScheduleClass: schedule alguma coisa', cron,   schClass);
    
    }

}

