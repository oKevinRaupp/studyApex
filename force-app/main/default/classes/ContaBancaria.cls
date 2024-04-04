public with sharing class ContaBancaria {
    public String nomeTitularConta;
    public final Decimal numeroConta;
    public Decimal saldoConta = 0;

    public ContaBancaria(String nome, Decimal numeroConta) {
        this.nomeTitularConta = nome;
        this.numeroConta = numeroConta;
    }

    public void depositar(Decimal valorDeposito){
        saldoConta += valorDeposito;
    }

    public void sacar(Decimal valorSaque){
        if(valorSaque > saldoConta){
            System.debug('Transação cancelada! Saque indisponível, o valor da conta ficara negativo!');
            return;
        }

       saldoConta -= valorSaque;
       
    }

}