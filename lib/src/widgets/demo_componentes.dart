import 'package:flutter/material.dart';

// ============================================================================
// COMPONENTE SEM ESTADO (StatelessWidget)
// ============================================================================
// Este widget não possui estado interno mutável.
// Uma vez criado, suas propriedades não podem ser alteradas.
// É reconstruído apenas quando o widget pai é reconstruído.

class ComponenteSemEstado extends StatelessWidget {
  final String titulo;
  final String descricao;
  final IconData icone;
  final Color cor;
  
  // Construtor - todas as propriedades são final (imutáveis)
  const ComponenteSemEstado({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.icone,
    this.cor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    // Este método é chamado toda vez que o widget precisa ser renderizado
    // Mas o widget em si não pode alterar seu próprio estado
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icone, color: cor, size: 24),
                const SizedBox(width: 8),
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: cor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              descricao,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '📌 StatelessWidget: Sem estado interno',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// COMPONENTE COM ESTADO (StatefulWidget)
// ============================================================================
// Este widget possui estado interno mutável.
// Pode alterar suas propriedades e se reconstruir usando setState().

class ComponenteComEstado extends StatefulWidget {
  final String tituloInicial;
  
  const ComponenteComEstado({
    super.key,
    required this.tituloInicial,
  });

  @override
  State<ComponenteComEstado> createState() => _ComponenteComEstadoState();
}

// Classe de Estado - aqui ficam as variáveis mutáveis
class _ComponenteComEstadoState extends State<ComponenteComEstado>
    with TickerProviderStateMixin {
  
  // VARIÁVEIS DE ESTADO (podem ser alteradas)
  int _contador = 0;
  bool _isExpanded = false;
  Color _corAtual = Colors.blue;
  String _textoAtual = '';
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  
  // Lista de cores para demonstrar mudança de estado
  final List<Color> _cores = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
  ];

  @override
  void initState() {
    super.initState();
    // Inicialização do estado
    _textoAtual = widget.tituloInicial;
    
    // Configuração da animação
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    // Limpeza do estado
    _animationController.dispose();
    super.dispose();
  }

  // Método para alterar o estado
  void _incrementarContador() {
    setState(() {
      _contador++;
      _corAtual = _cores[_contador % _cores.length];
      _textoAtual = 'Clicado $_contador vezes';
    });
    
    // Animação de feedback
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  void _toggleExpansao() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _resetarEstado() {
    setState(() {
      _contador = 0;
      _corAtual = Colors.blue;
      _textoAtual = widget.tituloInicial;
      _isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.all(8),
            color: _corAtual.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabeçalho com estado atual
                  Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: _corAtual,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _textoAtual,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _corAtual,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Indicador de estado
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _corAtual.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '🔄 StatefulWidget: Contador = $_contador',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Botões para alterar estado
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _incrementarContador,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _corAtual,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        child: const Text(
                          'Incrementar',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      
                      const SizedBox(width: 8),
                      
                      OutlinedButton(
                        onPressed: _toggleExpansao,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _corAtual,
                          side: BorderSide(color: _corAtual),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        child: Text(
                          _isExpanded ? 'Recolher' : 'Expandir',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      
                      const Spacer(),
                      
                      IconButton(
                        onPressed: _resetarEstado,
                        icon: const Icon(Icons.refresh),
                        color: _corAtual,
                        tooltip: 'Resetar estado',
                      ),
                    ],
                  ),
                  
                  // Conteúdo expansível (demonstra mudança de estado)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: _isExpanded ? null : 0,
                    child: _isExpanded
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12),
                              const Divider(),
                              const Text(
                                'Conteúdo Expandido:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Este conteúdo só aparece quando o estado _isExpanded é true. '
                                'A cor atual é ${_corAtual.toString()} e o contador está em $_contador.',
                                style: const TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: (_contador % 10) / 10,
                                backgroundColor: Colors.grey.shade300,
                                valueColor: AlwaysStoppedAnimation<Color>(_corAtual),
                              ),
                            ],
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ============================================================================
// WIDGET DEMONSTRATIVO COMPARATIVO
// ============================================================================

class DemoComparacaoComponentes extends StatelessWidget {
  const DemoComparacaoComponentes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo: Componentes com/sem Estado'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Explicação teórica
            Card(
              color: Colors.amber.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📚 Conceitos Fundamentais',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• StatelessWidget: Imutável, sem estado interno\n'
                      '• StatefulWidget: Mutável, possui estado interno\n'
                      '• setState(): Método para atualizar o estado\n'
                      '• Ciclo de vida: initState(), dispose(), build()',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Exemplo de StatelessWidget
            const Text(
              '1. Componente SEM Estado (StatelessWidget)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const ComponenteSemEstado(
              titulo: 'Widget Imutável',
              descricao: 'Este componente não pode alterar seu estado interno. '
                  'Suas propriedades são definidas na criação e não mudam.',
              icone: Icons.lock,
              cor: Colors.green,
            ),
            
            const SizedBox(height: 24),
            
            // Exemplo de StatefulWidget
            const Text(
              '2. Componente COM Estado (StatefulWidget)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const ComponenteComEstado(
              tituloInicial: 'Widget Mutável',
            ),
            
            const SizedBox(height: 24),
            
            // Resumo das diferenças
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🔍 Principais Diferenças',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDiferencaRow(
                      'Estado',
                      'Sem estado interno',
                      'Com estado interno mutável',
                    ),
                    _buildDiferencaRow(
                      'Reconstrução',
                      'Apenas quando o pai muda',
                      'Quando setState() é chamado',
                    ),
                    _buildDiferencaRow(
                      'Performance',
                      'Mais eficiente',
                      'Menos eficiente',
                    ),
                    _buildDiferencaRow(
                      'Uso',
                      'Widgets estáticos',
                      'Widgets interativos',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiferencaRow(String aspecto, String semEstado, String comEstado) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$aspecto:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🔒 $semEstado',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green.shade700,
                  ),
                ),
                Text(
                  '🔄 $comEstado',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}