public with sharing class Produto {
    public String nomeProduto;
    public Decimal precoProduto;
    public Decimal qtdeEstoqueProduto;

    public Produto(String nome, Decimal preco, Decimal qtdeEstoque) {
        this.nomeProduto = nome;
        this.precoProduto = preco;
        this.qtdeEstoqueProduto = qtdeEstoque;
    }

    public Decimal calcularValorTotalEmEstoquePorProduto(){
        return this.precoProduto * this.qtdeEstoqueProduto;
    }

    public Boolean isDisponivel(){
        if(qtdeEstoqueProduto <= 0) return false;

        return true;
    }  

}