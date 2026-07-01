import 'package:flutter/material.dart';
import '../produto.dart';
import '../card_produto.dart';
import 'tela_detalhes.dart';
import 'tela_pedido.dart';

// Tela inicial — usa StatelessWidget pois não tem estado interno que mude.
// O Scaffold fornece a estrutura básica da tela com AppBar, body, etc.
class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  // Exibe o modal de promoção usando showModalBottomSheet.
  // O BottomSheet desliza de baixo para cima e sobrepõe a tela atual.
  void _mostrarPromocao(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Indicador visual do bottom sheet
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            // Ícone animado
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B35), Color(0xFFFFB347)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text('🔥', style: TextStyle(fontSize: 36)),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Promoção do Dia!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D1B00),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B35).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Válida somente hoje!',
                style: TextStyle(
                  color: Color(0xFFFF6B35),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Na compra de um X-Burguer, o suco natural sai pela metade do preço!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Color(0xFF555555),
              ),
            ),
            const SizedBox(height: 16),
            // Destaque do desconto
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B35), Color(0xFFFFB347)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Column(
                children: [
                  Text(
                    'De R\$ 26,00',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Por R\$ 22,00 🎉',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'X-Burguer + Suco Natural',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Aproveitar Promoção'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // O AppBar fica no topo da tela e mostra o título e ações
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('🍔', style: TextStyle(fontSize: 22)),
            SizedBox(width: 8),
            Text(
              'Lanchonete Express',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      // SingleChildScrollView evita erro de overflow quando o conteúdo é maior que a tela
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner de boas-vindas
            _BannerBoasVindas(),
            const SizedBox(height: 8),
            // Botões de ação rápida
            _BotoesAcao(
              onFazerPedido: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TelaPedido()),
              ),
              onVerPromocao: () => _mostrarPromocao(context),
            ),
            const SizedBox(height: 24),
            // Título do cardápio
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Nosso Cardápio',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D1B00),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${cardapio.length} opções deliciosas para você',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              ),
            ),
            const SizedBox(height: 16),
            // Lista de produtos usando o widget CardProduto personalizado
            // Navigator.push empurra uma nova tela para a pilha de navegação
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cardapio.length,
                itemBuilder: (context, index) {
                  final produto = cardapio[index];
                  return CardProduto(
                    nome: produto.nome,
                    preco: produto.preco,
                    descricao: produto.descricao,
                    emoji: produto.emoji,
                    aoClicar: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TelaDetalhes(produto: produto),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            // Rodapé
            Center(
              child: Text(
                'Feito com ❤️ pela Lanchonete Express',
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// Widget do banner de boas-vindas
class _BannerBoasVindas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2D1B00), Color(0xFF4A3000)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2D1B00).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bem-vindo! 👋',
                  style: TextStyle(
                    color: Color(0xFFFFB347),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'O que vai ser hoje?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Escolha seu lanche favorito\ne peça agora mesmo!',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text('🍟', style: TextStyle(fontSize: 44)),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget dos botões de ação rápida
class _BotoesAcao extends StatelessWidget {
  final VoidCallback onFazerPedido;
  final VoidCallback onVerPromocao;

  const _BotoesAcao({
    required this.onFazerPedido,
    required this.onVerPromocao,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onFazerPedido,
              icon: const Icon(Icons.shopping_bag_outlined, size: 18),
              label: const Text(
                'Fazer Pedido',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onVerPromocao,
              icon: const Icon(
                Icons.local_offer_outlined,
                size: 18,
                color: Color(0xFFFF6B35),
              ),
              label: const Text(
                'Ver Promoção',
                style: TextStyle(
                  color: Color(0xFFFF6B35),
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFFF6B35), width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}