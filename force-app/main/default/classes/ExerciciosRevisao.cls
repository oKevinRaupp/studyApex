public with sharing class ExerciciosRevisao {
    


    public static Boolean isEmailOnContacts(String email, List<Contact> lstContacts) {
        String emailExemplo = 'rauppke@gmail.com';
        List<Contact> lstContactsExemplo = ExerciciosRevisaoDAO.getInstance().buscarContasValidas();

        email = emailExemplo;
        lstContacts = lstContactsExemplo;

        System.debug('Email: ' + email);

        List<Contact> contactsThatContaisnEmail = new List<Contact>();

        for (Contact objContact : lstContacts) {
            if (objContact.email == email) {
                contactsThatContaisnEmail.add(objContact);
            }
            System.debug(objContact.email);
        }

        System.debug('Tamanho da lsita que contem: ' + contactsThatContaisnEmail.size());

        if (contactsThatContaisnEmail.size() > 0) {
            return true;
        } else {
            return false;
        }
    }

    public static List<Integer> buscarNumerosPares(Integer n1, Integer n2) {

        List<Integer> lstPares = new List<Integer>();

        for (Integer i = n1; i <= n2; i++) {
            if (Math.Mod(i, 2) == 0) {
                lstPares.add(i);
            }
        }

        return lstPares;

    }

    public static Map<String, Boolean> consultarCasos() {
        List<Case> lstCase = ExerciciosRevisaoDAO.getInstance().buscarTodosOsCasos();

        Map<String, Boolean> mapCaseAbertoOuFechado = new Map<String, Boolean>();

        for (Case objCase : lstCase) {
            if (objCase.Status == 'Closed') {
                mapCaseAbertoOuFechado.put(objCase.CaseNumber, true);
            } else {
                mapCaseAbertoOuFechado.put(objCase.CaseNumber, false);
            }
        }

        return mapCaseAbertoOuFechado;

    }

}