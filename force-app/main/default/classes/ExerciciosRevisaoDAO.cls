public with sharing class ExerciciosRevisaoDAO {
    
    private static ExerciciosRevisaoDAO instance = new ExerciciosRevisaoDAO();

    public static ExerciciosRevisaoDAO getInstance() {
        return instance;
    }

    public List<Contact> buscarContasValidas() {
        return  [SELECT 
                    Id, Email, Account.Name, Name
                    FROM Contact 
                    WHERE 
                    Account.Name LIKE '%United Oil & Gas%'
                ];
    }

    public List<Case> buscarTodosOsCasos() {
        return  [SELECT 
                    Id, Status, CaseNumber  
                    FROM Case 
                ];
    }

}