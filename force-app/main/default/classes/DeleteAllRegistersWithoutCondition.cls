public class DeleteAllRegistersWithoutCondition {
	
    public static void apagarTodosRegistros(String nomeObjeto) {
        try {
            String query = 'SELECT Id FROM ' + nomeObjeto;
            List<SObject> registrosParaApagar = Database.query(query);
            delete registrosParaApagar;
            System.debug('Todos os registros de ' + nomeObjeto + ' foram apagados com sucesso.');
        } catch (Exception e) {
            System.debug('Erro ao apagar registros: ' + e.getMessage());
        }
    }
    
    
}