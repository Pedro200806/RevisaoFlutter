Lanchonete Express — Respostas Conceituais

1. Qual é a função do Scaffold em uma tela Flutter?

O Scaffold é o "esqueleto" de uma tela Flutter. Ele fornece a estrutura visual padrão de um aplicativo Material Design, incluindo slots prontos para AppBar (topo), body (conteúdo principal), bottomNavigationBar, floatingActionButton, drawer, entre outros. Sem o Scaffold, precisaríamos construir toda essa estrutura manualmente do zero.


2. Para que serve o AppBar?

O AppBar é a barra superior da tela. Ele exibe o título da tela, botões de ação (como voltar, configurações, busca) e pode ter um leading (ícone à esquerda) e actions (ícones à direita). Ele ajuda o usuário a entender em qual tela está e a navegar pelo aplicativo.


3. Qual é a diferença entre StatelessWidget e StatefulWidget?


StatelessWidget: Widget sem estado interno. Uma vez criado com seus parâmetros, ele não muda. É ideal para telas ou componentes estáticos, como a TelaInicial e o CardProduto.
StatefulWidget: Widget com estado interno que pode mudar ao longo do tempo. Possui um objeto State separado onde ficam as variáveis e a lógica que podem ser atualizadas. É usado quando a UI precisa reagir a ações do usuário, como na TelaDetalhes (destacar produto) e TelaPedido (contador de pedidos).



4. Para que serve o setState?

setState é o método que avisa o Flutter: "meu estado interno mudou, por favor redesenha este widget". Quando chamado, o Flutter agenda uma nova execução do método build() do widget, atualizando a interface com os novos valores. Sem setState, as variáveis mudam mas a tela continua mostrando os valores antigos.


5. Explique o que acontece quando usamos Navigator.push.

Navigator.push adiciona uma nova tela ao topo da pilha de navegação (stack). É como abrir uma nova página em cima da atual. A tela anterior fica "embaixo" e pode ser acessada novamente ao voltar. O Flutter aplica automaticamente uma animação de transição (deslizar da direita para a esquerda no Android).

dartNavigator.push(
  context,
  MaterialPageRoute(builder: (_) => TelaDetalhes(produto: produto)),
);


6. Explique o que acontece quando usamos Navigator.pop.

Navigator.pop remove a tela atual do topo da pilha, voltando para a tela anterior. É o oposto do push. O botão de voltar no AppBar chama pop automaticamente. É possível também passar um valor de retorno: Navigator.pop(context, resultado).


7. Para que serve o TextEditingController?

O TextEditingController é um objeto que fica "ligado" a um TextField. Ele permite:


Ler o texto digitado: controller.text
Limpar o campo: controller.clear()
Definir um valor: controller.text = 'valor'
Ouvir mudanças: controller.addListener(...)


Sem ele, não conseguimos acessar o conteúdo digitado pelo usuário fora do próprio TextField.


8. Por que é importante validar os campos antes de enviar o pedido?

A validação garante que o sistema receba dados completos e corretos. Sem ela:


Pedidos sem nome ou produto ficariam registrados de forma incompleta
Seria difícil identificar ou entregar o pedido ao cliente
A experiência do usuário seria ruim, pois ele não saberia o que errou


A validação antecipa problemas e orienta o usuário a corrigir antes de prosseguir.


9. Para que serve o SnackBar?

O SnackBar é uma mensagem temporária que aparece na parte inferior da tela por alguns segundos e desaparece automaticamente. É ideal para feedback rápido ao usuário sem interromper o fluxo, como confirmar uma ação bem-sucedida ou alertar sobre um erro de validação.


10. O que o showModalBottomSheet faz no aplicativo?

showModalBottomSheet abre um painel que desliza de baixo para cima, sobrepondo parte da tela atual. É "modal" porque bloqueia a interação com o conteúdo atrás dele até ser fechado. É muito usado para mostrar opções, filtros, confirmações ou, no nosso caso, uma promoção da lanchonete.


11. Para que serve o AnimatedContainer?

AnimatedContainer é como um Container normal, mas com superpoderes: quando suas propriedades mudam (tamanho, cor, arredondamento, padding...), ele anima suavemente a transição entre o valor antigo e o novo, sem precisar criar animações manualmente com AnimationController. Basta mudar os valores dentro de um setState que a animação acontece automaticamente.


12. Por que usamos SingleChildScrollView em algumas telas?

Quando o conteúdo de uma tela é maior do que o espaço disponível na tela do dispositivo, o Flutter lança um erro de overflow (conteúdo estourando a tela). O SingleChildScrollView envolve o conteúdo e permite que o usuário role verticalmente (ou horizontalmente) para ver tudo, evitando esse erro.


13. Qual a vantagem de criar um widget personalizado como o CardProduto?


Reutilização: o mesmo widget é usado para todos os produtos sem duplicar código
Manutenção: uma mudança no visual é feita em um único lugar e reflete em todos os cards
Legibilidade: o código da tela fica mais limpo e fácil de entender
Responsabilidade única: cada widget cuida de uma coisa só
Testabilidade: widgets isolados são mais fáceis de testar



14. Qual a diferença entre usar Column e ListView?

CaracterísticaColumnListViewScrollNão faz scroll nativamenteFaz scroll automaticamenteOverflowEstoura se conteúdo for grandeLida bem com listas longasPerformanceRenderiza todos os filhosRenderiza só os visíveis (lazy)Uso idealPoucos itens fixosListas longas ou de tamanho variável

No projeto usamos ListView.builder dentro de um SingleChildScrollView (com shrinkWrap: true) para aproveitar o builder sem criar um segundo scroll conflitante.


15. Por que separar partes do código em widgets pode deixar o projeto melhor?

Separar em widgets menores promove:


Organização: cada arquivo/classe tem uma responsabilidade clara
Legibilidade: o método build de cada tela fica curto e compreensível
Reuso: widgets genéricos podem ser usados em várias partes do app
Colaboração: em equipe, cada pessoa pode trabalhar em widgets diferentes sem conflito
Manutenção: encontrar e corrigir bugs é mais fácil quando o código está organizado em partes menores
Performance: o Flutter consegue reconstruir apenas o widget que mudou, e não a tela inteira
