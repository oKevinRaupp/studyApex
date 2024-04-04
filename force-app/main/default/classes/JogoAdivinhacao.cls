public with sharing class JogoAdivinhacao {
    
    public static Boolean verificar(Integer numero){
        Integer numeroAleatorio = Integer.valueof((Math.random() * 10) + 1);

        System.debug('o número aleatorio foi: ' + numeroAleatorio);

        if(numeroAleatorio == numero) {
            System.debug('o numero era: ' + numeroAleatorio + ', você jogou: ' + numero + '. Parabéns, você acertou!');
            return true;
        }
        if(numeroAleatorio > numero) System.debug('O numero jogado é menor que o numero sorteado.');
        if(numeroAleatorio < numero) System.debug('O numero jogado é maior que o numero sorteado.');
        return false;
    }

}