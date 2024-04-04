public with sharing class Vendedor {
    public Decimal salarioFixo;
    public Decimal valorVendas;
    public Decimal salarioFinal = 0;

    public Vendedor(Decimal salarioFixo, Decimal valorVendas){
        this.salarioFixo = salarioFixo;
        this.valorVendas = valorVendas;
    }

    public Decimal calcularComissao(){
        if(valorVendas <= 1500){
            salarioFinal = salarioFixo + valorVendas + (valorVendas * 0.03);
            System.debug(salarioFinal);
            return salarioFinal;
        } else {
            Decimal calculoPorCinco = valorVendas - 1500;
            salarioFinal = (calculoPorCinco * 0.05) + ((valorVendas - 1500) * 0.03) + salarioFixo + valorVendas;
            System.debug(salarioFinal);
            return salarioFinal;
        }
    }

}