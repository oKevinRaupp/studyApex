public with sharing class Util {
    public Util() {}

    public static String validarAlteracaoCampos(Sobject registro, Sobject registroAntigo, String objeto, List<String> campos){
        String erroTratado;
        List<String> camposErro = new List<String>();

        for(String campo : campos){
            if(registro.get(campo) != registroAntigo.get(campo)){
                camposErro.add(Schema.getGlobalDescribe().get(objeto).getDescribe().fields.getMap().get(campo).getDescribe().getLabel());
            }
        }

        if(!camposErro.isEmpty()){
            String mensagemJoin = String.join(camposErro, ', ');
            Integer indexString = mensagemJoin.lastIndexOf(',');

            String mensagemTratada;
            if(indexString > -1){
                mensagemTratada = mensagemJoin.substring(0, indexString);
                mensagemTratada += ' e' + mensagemJoin.substring(indexString+1);
            }
            else{
                mensagemTratada = mensagemJoin;
            }
            erroTratado = 'O campos modificados foram: ' + mensagemTratada; 
        }
        return erroTratado;
    }
}