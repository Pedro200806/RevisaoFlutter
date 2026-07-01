import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catálogo de Cursos',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const TelaInicial(),
    );
  }
}

final List<Map<String, String>> cursos = [
  {
    'nome': 'Flutter Básico',
    'carga': '20h',
    'nivel': 'Básico',
    'descricao':
        'Aprenda os fundamentos do Flutter e crie aplicativos modernos.'
  },
  {
    'nome': 'Dart Essencial',
    'carga': '15h',
    'nivel': 'Básico',
    'descricao':
        'Domine a linguagem Dart utilizada no desenvolvimento Flutter.'
  },
  {
    'nome': 'Interfaces Responsivas',
    'carga': '25h',
    'nivel': 'Intermediário',
    'descricao':
        'Crie layouts adaptáveis para celulares e tablets.'
  },
  {
    'nome': 'Animações no Flutter',
    'carga': '18h',
    'nivel': 'Intermediário',
    'descricao':
        'Aprenda a criar animações suaves e profissionais.'
  },
  {
    'nome': 'Navegação entre Telas',
    'carga': '12h',
    'nivel': 'Avançado',
    'descricao':
        'Gerencie rotas e a navegação entre páginas do aplicativo.'
  },
];

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4F46E5),
              Color(0xFF7C3AED),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color: Colors.white,
                  size: 90,
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Catálogo de Cursos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Explore cursos incríveis de tecnologia e desenvolvimento.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF4F46E5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                icon: const Icon(Icons.arrow_forward),
                label: const Text(
                  'Ver Cursos',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TelaListaCursos(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaListaCursos extends StatelessWidget {
  const TelaListaCursos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        title: const Text('Cursos Disponíveis'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cursos.length,
            itemBuilder: (context, index) {
              final curso = cursos[index];

              return CardCurso(
                nome: curso['nome']!,
                carga: curso['carga']!,
                nivel: curso['nivel']!,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TelaDetalhesCurso(curso: curso),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class CardCurso extends StatelessWidget {
  final String nome;
  final String carga;
  final String nivel;
  final VoidCallback onTap;

  const CardCurso({
    super.key,
    required this.nome,
    required this.carga,
    required this.nivel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.code,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    nome,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text('Carga Horária: $carga'),
            const SizedBox(height: 5),
            Text(
              'Nível: $nivel',
              style: const TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onTap,
                child: const Text('Detalhes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaDetalhesCurso extends StatefulWidget {
  final Map<String, String> curso;

  const TelaDetalhesCurso({
    super.key,
    required this.curso,
  });

  @override
  State<TelaDetalhesCurso> createState() => _TelaDetalhesCursoState();
}

class _TelaDetalhesCursoState extends State<TelaDetalhesCurso> {
  bool interessado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.curso['nome']!),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: interessado
                      ? [
                          Colors.green.shade300,
                          Colors.green.shade500,
                        ]
                      : const [
                          Color(0xFF4F46E5),
                          Color(0xFF7C3AED),
                        ],
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 15,
                    color: Colors.black26,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    widget.curso['nome']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Carga Horária: ${widget.curso['carga']}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Nível: ${widget.curso['nivel']}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    widget.curso['descricao']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: Icon(
                interessado ? Icons.check : Icons.favorite,
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 15,
                ),
              ),
              onPressed: () {
                setState(() {
                  interessado = true;
                });
              },
              label: Text(
                interessado
                    ? 'Interesse Registrado'
                    : 'Tenho Interesse',
              ),
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              opacity: interessado ? 1 : 0,
              duration: const Duration(milliseconds: 700),
              child: const Column(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 70,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Interesse registrado!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
              label: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
