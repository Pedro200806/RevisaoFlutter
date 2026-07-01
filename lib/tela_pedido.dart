import 'package:flutter/material.dart';
import '../produto.dart';

// StatefulWidget é necessário porque o estado do formulário e o contador
// de pedidos mudam conforme o usuário interage com a tela.
class TelaPedido extends StatefulWidget {
  const TelaPedido({super.key});

  @override
  State<TelaPedido> createState() => _TelaPedidoState();
}

class _TelaPedidoState extends State<TelaPedido> {
  // TextEditingController permite ler e controlar o texto dos campos TextField
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _produtoController = TextEditingController();
  final TextEditingController _observacaoController = TextEditingController();

  // Variável de estado para o contador de pedidos
  int _contadorPedidos = 0;

  // Produto selecionado no dropdown
  String? _produtoSelecionado;

  // Estado de carregamento
  bool _enviando = false;

  // Libera os controllers da memória quando o widget é destruído
  @override
  void dispose() {
    _nomeController.dispose();
    _produtoController.dispose();
    _observacaoController.dispose();
    super.dispose();
  }

  // Valida e envia o pedido
  // A validação evita dados incompletos e garante uma boa experiência ao usuário
  void _enviarPedido() async {
    final nome = _nomeController.text.trim();
    final produto = _produtoSelecionado ?? _produtoController.text.trim();

    // Validação: verifica se os campos obrigatórios estão preenchidos
    if (nome.isEmpty || produto.isEmpty) {
      // SnackBar exibe uma mensagem temporária na parte inferior da tela
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'Preencha o nome e o produto!',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          backgroundColor: const Color(0xFFE53935),
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    // Simula um pequeno delay de envio
    setState(() => _enviando = true);
    await Future.delayed(const Duration(milliseconds: 800));

    // Campos válidos: incrementa o contador e exibe mensagem de sucesso
    // setState atualiza a UI com o novo valor do contador
    setState(() {
      _contadorPedidos++;
      _enviando = false;
    });

    // Limpa os campos após o envio
    _nomeController.clear();
    _produtoController.clear();
    _observacaoController.clear();
    setState(() => _produtoSelecionado = null);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Pedido enviado com sucesso! 🎉',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF43A047),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fazer Pedido',
          style: TextStyle(fontWeight: FontWeight.bold),
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card do contador de pedidos
              _ContadorPedidosCard(contador: _contadorPedidos),
              const SizedBox(height: 24),

              // Título do formulário
              const Row(
                children: [
                  Icon(Icons.receipt_long, color: Color(0xFFFF6B35), size: 22),
                  SizedBox(width: 8),
                  Text(
                    'Dados do Pedido',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D1B00),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Campo: Nome do cliente
              _LabelCampo(label: 'Seu nome', obrigatorio: true),
              const SizedBox(height: 8),
              TextField(
                controller: _nomeController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: 'Ex: João Silva',
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Color(0xFFFF6B35),
                  ),
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                ),
              ),
              const SizedBox(height: 20),

              // Campo: Produto desejado (com sugestões do cardápio)
              _LabelCampo(label: 'Produto desejado', obrigatorio: true),
              const SizedBox(height: 8),
              // Dropdown com os produtos do cardápio
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<String>(
                      value: _produtoSelecionado,
                      hint: Row(
                        children: [
                          const Icon(
                            Icons.fastfood_outlined,
                            color: Color(0xFFFF6B35),
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Selecione um produto',
                            style: TextStyle(color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(12),
                      icon: const Icon(
                        Icons.expand_more,
                        color: Color(0xFFFF6B35),
                      ),
                      items: cardapio.map((produto) {
                        return DropdownMenuItem<String>(
                          value: produto.nome,
                          child: Row(
                            children: [
                              Text(
                                produto.emoji,
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      produto.nome,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      produto.preco,
                                      style: const TextStyle(
                                        color: Color(0xFFFF6B35),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _produtoSelecionado = value;
                          _produtoController.text = value ?? '';
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Campo texto alternativo para produto personalizado
              TextField(
                controller: _produtoController,
                decoration: InputDecoration(
                  hintText: 'Ou digite um produto personalizado...',
                  prefixIcon: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xFFFF6B35),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 13,
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() => _produtoSelecionado = null);
                  }
                },
              ),
              const SizedBox(height: 20),

              // Campo: Observação (opcional)
              _LabelCampo(label: 'Observação', obrigatorio: false),
              const SizedBox(height: 8),
              TextField(
                controller: _observacaoController,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText:
                      'Ex: Sem cebola, molho à parte, ponto da carne...',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Icon(
                      Icons.note_outlined,
                      color: Color(0xFFFF6B35),
                    ),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 13,
                  ),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 32),

              // Botão Enviar Pedido
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6B35), Color(0xFFFFB347)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF6B35).withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _enviando ? null : _enviarPedido,
                    borderRadius: BorderRadius.circular(14),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: _enviando
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.send_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Enviar Pedido',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Botão voltar
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancelar e voltar',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget do card de contador de pedidos
class _ContadorPedidosCard extends StatelessWidget {
  final int contador;

  const _ContadorPedidosCard({required this.contador});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2D1B00), Color(0xFF4A3000)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2D1B00).withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Ícone com círculo
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: Text('🛍️', style: TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pedidos enviados',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                // AnimatedSwitcher anima a troca do número do contador
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -0.5),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: Text(
                    '$contador',
                    key: ValueKey<int>(contador),
                    style: const TextStyle(
                      color: Color(0xFFFFB347),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Badge de status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: contador > 0
                  ? const Color(0xFF43A047).withOpacity(0.2)
                  : Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: contador > 0
                    ? const Color(0xFF43A047).withOpacity(0.4)
                    : Colors.white.withOpacity(0.1),
              ),
            ),
            child: Text(
              contador > 0 ? 'Ativo ✓' : 'Aguardando',
              style: TextStyle(
                color:
                    contador > 0 ? const Color(0xFF81C784) : Colors.white38,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget auxiliar para o label dos campos com indicador de obrigatoriedade
class _LabelCampo extends StatelessWidget {
  final String label;
  final bool obrigatorio;

  const _LabelCampo({required this.label, required this.obrigatorio});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D1B00),
          ),
        ),
        if (obrigatorio) ...[
          const SizedBox(width: 4),
          const Text(
            '*',
            style: TextStyle(
              color: Color(0xFFFF6B35),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ] else ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'opcional',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ],
      ],
    );
  }
}