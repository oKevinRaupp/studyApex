public with sharing class Retangulo {
    public Decimal largura;
    public Decimal altura;
    public Decimal perimetro;
    public Decimal area;

    public Retangulo(Decimal largura, Decimal altura){
        this.largura = largura;
        this.altura = altura;
        this.perimetro = calcularPerimetro(this.largura, this.altura);
        this.area = calcularArea(this.largura, this.altura);
    }

    public Decimal calcularPerimetro(Decimal largura, Decimal altura){
        return (largura * 2) + (altura * 2);
    }

    public Decimal calcularArea(Decimal largura, Decimal altura){
        return  largura * altura;
    }

}