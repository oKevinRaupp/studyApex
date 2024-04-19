public with sharing class Rectangle {
    private Decimal largura;
    private Decimal altura;

    public  Rectangle(Decimal largura, Decimal altura){
        calcularPerimetro(this.largura, this.altura);
    }

    private static Decimal calcularPerimetro(Decimal largura, Decimal altura){
        Decimal perimetro;
        perimetro = (largura * 2) + (altura * 2);
        return perimetro;
    }

}