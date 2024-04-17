public class ExercicioMathias06 implements Database.Batchable<sObject> {

    public Iterable<sObject> start (Database.BatchableContext bc) {
        //TODO HERE (QUERY)
        return null;
    } 
    
    public void execute (Database.BatchableContext bc, List<Opportunity> lstOpp) {
        //TODO HERE (ATUALIZAR OPP)
    }
    
    public void finish (Database.BatchableContext bc) {
        //TODO HERE
    }

    
}