import 'package:flutter/material.dart';

// ============================================================================
// COMPONENTES LEADING PERSONALIZADOS
// ============================================================================
// O componente 'leading' é o widget que aparece no início do AppBar,
// geralmente usado para navegação ou ações principais.

// Leading simples com ícone personalizado
class IconeLeadingPersonalizado extends StatelessWidget {
  final IconData icone;
  final Color? cor;
  final VoidCallback? onPressed;
  final String? tooltip;
  
  const IconeLeadingPersonalizado({
    super.key,
    required this.icone,
    this.cor,
    this.onPressed,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icone),
      color: cor ?? Colors.white,
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
      tooltip: tooltip ?? 'Voltar',
    );
  }
}

// Leading com avatar do usuário
class AvatarLeading extends StatelessWidget {
  final String? urlImagem;
  final String iniciais;
  final VoidCallback? onTap;
  
  const AvatarLeading({
    super.key,
    this.urlImagem,
    required this.iniciais,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: urlImagem != null
              ? ClipOval(
                  child: Image.network(
                    urlImagem!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Text(
                        iniciais,
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                )
              : Text(
                  iniciais,
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}

// Leading com logo da empresa
class LogoLeading extends StatelessWidget {
  final String? logoPath;
  final String textoFallback;
  final VoidCallback? onTap;
  
  const LogoLeading({
    super.key,
    this.logoPath,
    required this.textoFallback,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: logoPath != null
              ? Image.asset(
                  logoPath!,
                  height: 32,
                  errorBuilder: (context, error, stackTrace) {
                    return Text(
                      textoFallback,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    );
                  },
                )
              : Text(
                  textoFallback,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}

// Leading animado com múltiplas funcionalidades
class LeadingAnimado extends StatefulWidget {
  final List<IconData> icones;
  final List<VoidCallback?> acoes;
  final Duration duracao;
  
  const LeadingAnimado({
    super.key,
    required this.icones,
    required this.acoes,
    this.duracao = const Duration(seconds: 3),
  });

  @override
  State<LeadingAnimado> createState() => _LeadingAnimadoState();
}

class _LeadingAnimadoState extends State<LeadingAnimado>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  int _iconeAtual = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    
    // Alternar ícones automaticamente
    _iniciarAnimacao();
  }

  void _iniciarAnimacao() {
    Future.delayed(widget.duracao, () {
      if (mounted) {
        setState(() {
          _iconeAtual = (_iconeAtual + 1) % widget.icones.length;
        });
        _controller.forward().then((_) {
          _controller.reverse();
        });
        _iniciarAnimacao();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotationAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationAnimation.value * 2 * 3.14159,
          child: IconButton(
            icon: Icon(widget.icones[_iconeAtual]),
            color: Colors.white,
            onPressed: widget.acoes[_iconeAtual],
            tooltip: 'Ação ${_iconeAtual + 1}',
          ),
        );
      },
    );
  }
}

// Leading com contador (ex: notificações)
class LeadingComContador extends StatelessWidget {
  final IconData icone;
  final int contador;
  final VoidCallback? onPressed;
  final Color corContador;
  
  const LeadingComContador({
    super.key,
    required this.icone,
    required this.contador,
    this.onPressed,
    this.corContador = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(icone),
          color: Colors.white,
          onPressed: onPressed,
        ),
        if (contador > 0)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: corContador,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                contador > 99 ? '99+' : contador.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

// Leading com menu dropdown
class LeadingComMenu extends StatelessWidget {
  final List<PopupMenuEntry> itensMenu;
  final IconData icone;
  
  const LeadingComMenu({
    super.key,
    required this.itensMenu,
    this.icone = Icons.menu,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(icone, color: Colors.white),
      itemBuilder: (context) => itensMenu,
      offset: const Offset(0, 50),
    );
  }
}

// Leading responsivo que muda baseado no tamanho da tela
class LeadingResponsivo extends StatelessWidget {
  final Widget leadingMobile;
  final Widget leadingTablet;
  final double breakpoint;
  
  const LeadingResponsivo({
    super.key,
    required this.leadingMobile,
    required this.leadingTablet,
    this.breakpoint = 600,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (MediaQuery.of(context).size.width > breakpoint) {
          return leadingTablet;
        } else {
          return leadingMobile;
        }
      },
    );
  }
}

// ============================================================================
// TELA DEMONSTRATIVA DOS COMPONENTES LEADING
// ============================================================================

class DemoLeadingComponents extends StatefulWidget {
  const DemoLeadingComponents({super.key});

  @override
  State<DemoLeadingComponents> createState() => _DemoLeadingComponentsState();
}

class _DemoLeadingComponentsState extends State<DemoLeadingComponents> {
  int _tipoLeading = 0;
  int _contadorNotificacoes = 5;
  
  final List<String> _tiposLeading = [
    'Ícone Personalizado',
    'Avatar do Usuário',
    'Logo da Empresa',
    'Leading Animado',
    'Com Contador',
    'Com Menu Dropdown',
    'Responsivo',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo: ${_tiposLeading[_tipoLeading]}'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        leading: _buildLeadingAtual(),
        actions: [
          IconButton(
            icon: const Icon(Icons.skip_next),
            onPressed: () {
              setState(() {
                _tipoLeading = (_tipoLeading + 1) % _tiposLeading.length;
              });
            },
            tooltip: 'Próximo exemplo',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Informações sobre o leading atual
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tipo Atual: ${_tiposLeading[_tipoLeading]}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getDescricaoLeading(_tipoLeading),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Controles interativos
            if (_tipoLeading == 4) // Leading com contador
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Controle do Contador:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _contadorNotificacoes++;
                              });
                            },
                            child: const Text('+ Notificação'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _contadorNotificacoes > 0
                                ? () {
                                    setState(() {
                                      _contadorNotificacoes--;
                                    });
                                  }
                                : null,
                            child: const Text('- Notificação'),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Total: $_contadorNotificacoes',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            
            // Lista de todos os tipos
            const Text(
              'Todos os Tipos de Leading:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            ...List.generate(_tiposLeading.length, (index) {
              return Card(
                color: index == _tipoLeading ? Colors.blue.shade100 : null,
                child: ListTile(
                  leading: Icon(
                    _getIconeParaTipo(index),
                    color: Colors.blue.shade700,
                  ),
                  title: Text(_tiposLeading[index]),
                  subtitle: Text(_getDescricaoLeading(index)),
                  trailing: index == _tipoLeading
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.blue.shade700,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      _tipoLeading = index;
                    });
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadingAtual() {
    switch (_tipoLeading) {
      case 0: // Ícone Personalizado
        return const IconeLeadingPersonalizado(
          icone: Icons.restaurant,
          tooltip: 'Menu da Pizzaria',
        );
      
      case 1: // Avatar do Usuário
        return AvatarLeading(
          iniciais: 'PZ',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Avatar clicado! 👤')),
            );
          },
        );
      
      case 2: // Logo da Empresa
        return LogoLeading(
          textoFallback: '🍕',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logo da pizzaria! 🍕')),
            );
          },
        );
      
      case 3: // Leading Animado
        return LeadingAnimado(
          icones: const [
            Icons.restaurant,
            Icons.local_pizza,
            Icons.delivery_dining,
          ],
          acoes: [
            () => _mostrarMensagem('Restaurante! 🏪'),
            () => _mostrarMensagem('Pizza! 🍕'),
            () => _mostrarMensagem('Delivery! 🚚'),
          ],
        );
      
      case 4: // Com Contador
        return LeadingComContador(
          icone: Icons.notifications,
          contador: _contadorNotificacoes,
          onPressed: () {
            _mostrarMensagem('$_contadorNotificacoes notificações! 🔔');
          },
        );
      
      case 5: // Com Menu Dropdown
        return LeadingComMenu(
          itensMenu: [
            const PopupMenuItem(
              value: 'perfil',
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Perfil'),
              ),
            ),
            const PopupMenuItem(
              value: 'configuracoes',
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configurações'),
              ),
            ),
            const PopupMenuItem(
              value: 'sair',
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sair'),
              ),
            ),
          ],
        );
      
      case 6: // Responsivo
        return LeadingResponsivo(
          leadingMobile: const IconeLeadingPersonalizado(
            icone: Icons.menu,
            tooltip: 'Menu Mobile',
          ),
          leadingTablet: LogoLeading(
            textoFallback: 'PIZZARIA',
            onTap: () => _mostrarMensagem('Versão Tablet! 📱'),
          ),
        );
      
      default:
        return const IconeLeadingPersonalizado(icone: Icons.arrow_back);
    }
  }

  void _mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  String _getDescricaoLeading(int tipo) {
    switch (tipo) {
      case 0:
        return 'Ícone personalizado com ação customizada';
      case 1:
        return 'Avatar do usuário com iniciais ou foto';
      case 2:
        return 'Logo da empresa ou marca';
      case 3:
        return 'Ícone que muda automaticamente com animação';
      case 4:
        return 'Ícone com contador de notificações';
      case 5:
        return 'Menu dropdown com múltiplas opções';
      case 6:
        return 'Adapta-se ao tamanho da tela';
      default:
        return 'Descrição não disponível';
    }
  }

  IconData _getIconeParaTipo(int tipo) {
    switch (tipo) {
      case 0:
        return Icons.star;
      case 1:
        return Icons.account_circle;
      case 2:
        return Icons.business;
      case 3:
        return Icons.animation;
      case 4:
        return Icons.notifications;
      case 5:
        return Icons.menu;
      case 6:
        return Icons.dashboard;
      default:
        return Icons.help;
    }
  }
}