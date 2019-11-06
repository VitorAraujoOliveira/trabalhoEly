class PedidosLista{
  final int id;
  final String pedido;
  final double valor;
  final int mesa;
  final String imagem;

  PedidosLista({this.id, this.mesa, this.pedido, this.valor, this.imagem});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pedido': pedido,
      'valor': valor,
      'mesa':mesa,
      'imagem':imagem
    };
  }
}