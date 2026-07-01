class Produto {
  final String nome;
  final String preco;
  final String descricao;
  final String emoji;
  final String descricaoLonga;

  const Produto({
    required this.nome,
    required this.preco,
    required this.descricao,
    required this.emoji,
    required this.descricaoLonga,
  });
}

// Lista de produtos disponíveis no cardápio
const List<Produto> cardapio = [
  Produto(
    nome: 'X-Burguer',
    preco: 'R\$ 18,00',
    descricao: 'Pão, carne, queijo e molho especial.',
    emoji: '🍔',
    descricaoLonga:
        'Nosso clássico X-Burguer com pão brioche tostado, carne artesanal 180g, queijo prato derretido, alface americana, tomate fresco e nosso irresistível molho especial da casa. Uma explosão de sabor em cada mordida!',
  ),
  Produto(
    nome: 'Batata Frita',
    preco: 'R\$ 12,00',
    descricao: 'Porção individual crocante.',
    emoji: '🍟',
    descricaoLonga:
        'Batatas selecionadas cortadas em palito fino, fritas duas vezes para garantir o máximo de crocância por fora e maciez por dentro. Temperadas com sal e ervas da nossa mistura secreta. Acompanha molho rosé.',
  ),
  Produto(
    nome: 'Suco Natural',
    preco: 'R\$ 8,00',
    descricao: 'Suco gelado da fruta.',
    emoji: '🧃',
    descricaoLonga:
        'Suco feito na hora com frutas frescas e naturais, sem conservantes e sem adição de açúcar. Disponível nos sabores: laranja, maracujá, abacaxi com hortelã e melancia. Servido bem gelado no copo de 400ml.',
  ),
  Produto(
    nome: 'Combo Especial',
    preco: 'R\$ 28,00',
    descricao: 'X-Burguer, batata e suco.',
    emoji: '🎁',
    descricaoLonga:
        'A combinação perfeita para um almoço completo e satisfatório! Leve o nosso famoso X-Burguer acompanhado de uma porção de batata frita crocante e um suco natural de sua escolha, tudo por um preço especial. Economize R\$ 10,00 em relação ao valor individual!',
  ),
  Produto(
    nome: 'Hot Dog Gourmet',
    preco: 'R\$ 15,00',
    descricao: 'Salsicha especial com bastante recheio.',
    emoji: '🌭',
    descricaoLonga:
        'Hot Dog com salsicha defumada premium no pão francês macio, coberto com purê de batata cremoso, milho verde, ervilha, vinagrete, queijo ralado, batata palha e nosso ketchup artesanal. Uma refeição que satisfaz!',
  ),
  Produto(
    nome: 'Milk Shake',
    preco: 'R\$ 16,00',
    descricao: 'Cremoso e gelado, vários sabores.',
    emoji: '🥤',
    descricaoLonga:
        'Milk Shake ultra cremoso feito com sorvete artesanal e leite integral. Disponível nos sabores: chocolate belga, morango, baunilha, Ovomaltine, Nutella e doce de leite. Servido em copo grande de 500ml com chantilly e cobertura.',
  ),
];