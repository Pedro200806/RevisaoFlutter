import 'package:flutter/material.dart';
import '../produto.dart';
 
// StatefulWidget é usado aqui porque o estado da tela muda quando o usuário
// clica em "Adicionar destaque" — precisamos de setState para atualizar a UI.
class TelaDetalhes extends StatefulWidget {
  final Produto produto;
 
  const TelaDetalhes({super.key, required this.produto});
 
  @override
  State<TelaDetalhes> createState() => _TelaDetalhesState();
}
 
class _TelaDetalhesState extends State<TelaDetalhes> {
  // Variáveis de estado que controlam a animação e o destaque
  bool _destacado = false;
  double _containerSize = 80;
  Color _containerColor = const Color(0xFFFFF8F0);
  double _borderRadius = 16;
  String _mensagemDestaque = '';
 
  // setState notifica o Flutter que o estado mudou e redesenha os widgets afetados
  void _adicionarDestaque() {
    setState(() {
      _destacado = !_destacado;
      if (_destacado) {
        _containerSize = 110;
        _containerColor = const Color(0xFFFF6B35).withOpacity(0.12);
        _borderRadius = 32;
        _mensagemDestaque = '⭐ Produto mais pedido da semana!';
      } else {
        _containerSize = 80;
        _containerColor = const Color(0xFFFFF8F0);
        _borderRadius = 16;
        _mensagemDestaque = '';
      }
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // O AppBar fornece o botão de voltar automaticamente quando há uma rota anterior.
      // Navigator.pop é chamado ao pressionar a seta de voltar — remove a tela atual da pilha.
      appBar: AppBar(
        title: Text(
          widget.produto.nome,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          // Navigator.pop remove a tela atual e volta para a tela anterior
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero section com emoji animado
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  // AnimatedContainer anima suavemente mudanças de tamanho, cor e forma
                  // sem precisar escrever animações manualmente
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.elasticOut,
                    width: _containerSize + 60,
                    height: _containerSize + 60,
                    decoration: BoxDecoration(
                      color: _containerColor,
                      borderRadius: BorderRadius.circular(_borderRadius + 20),
                      boxShadow: _destacado
                          ? [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                blurRadius: 30,
                                spreadRadius: 5,
                              )
                            ]
                          : [],
                    ),
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.elasticOut,
                        width: _containerSize,
                        height: _containerSize,
                        child: Center(
                          child: Text(
                            widget.produto.emoji,
                            style: TextStyle(
                              fontSize: _destacado ? 64 : 52,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Badge de destaque animado
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _mensagemDestaque.isNotEmpty
                        ? Container(
                            key: const ValueKey('badge'),
                            margin: const EdgeInsets.only(bottom: 20),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Text(
                              _mensagemDestaque,
                              style: const TextStyle(
                                color: Color(0xFFFF6B35),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          )
                        : const SizedBox(key: ValueKey('empty'), height: 20),
                  ),
                ],
              ),
            ),
            // Conteúdo do produto
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.produto.nome,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D1B00),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF6B35), Color(0xFFFFB347)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.produto.preco,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Linha divisória estilizada
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 20,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B35),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Sobre o produto',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D1B00),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.produto.descricaoLonga,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.7,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Info chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _InfoChip(icon: Icons.star, label: 'Mais vendido'),
                      _InfoChip(icon: Icons.timer_outlined, label: '15-20 min'),
                      _InfoChip(
                          icon: Icons.local_offer_outlined, label: 'Promoção'),
                    ],
                  ),
                  const SizedBox(height: 28),
                  // Botão de destaque — chama setState ao ser pressionado
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      gradient: _destacado
                          ? const LinearGradient(
                              colors: [Color(0xFFFFB347), Color(0xFFFF6B35)],
                            )
                          : const LinearGradient(
                              colors: [Color(0xFFFF6B35), Color(0xFFFFB347)],
                            ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF6B35).withOpacity(0.35),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _adicionarDestaque,
                        borderRadius: BorderRadius.circular(14),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _destacado ? Icons.star : Icons.star_border,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                _destacado
                                    ? 'Destaque removido'
                                    : 'Adicionar destaque',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Botão voltar
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFFFF6B35),
                        size: 18,
                      ),
                      label: const Text(
                        'Voltar ao cardápio',
                        style: TextStyle(
                          color: Color(0xFFFF6B35),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Color(0xFFFF6B35), width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 
// Widget auxiliar para os chips de informação
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
 
  const _InfoChip({required this.icon, required this.label});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFF6B35).withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFF6B35).withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFFFF6B35)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFFFF6B35),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
 