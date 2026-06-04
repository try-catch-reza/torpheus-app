class PermissaoModel {
  final String recurso;   // ex: "users"
  final String acao;      // ex: "create"
  final String valor;     // ex: "users.create"
  final String titulo;    // ex: "Criar usuário"
  final bool isSelected;

  const PermissaoModel({
    required this.recurso,
    required this.acao,
    required this.valor,
    required this.titulo,
    this.isSelected = false,
  });

  PermissaoModel copyWith({bool? isSelected}) {
    return PermissaoModel(
      recurso: recurso,
      acao: acao,
      valor: valor,
      titulo: titulo,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  /// Constrói o model a partir de uma string como "users.create"
  factory PermissaoModel.fromString(String valor) {
    final partes = valor.split('.');
    final recurso = partes.isNotEmpty ? partes[0] : valor;
    final acao = partes.length > 1 ? partes[1] : '';

    return PermissaoModel(
      recurso: recurso,
      acao: acao,
      valor: valor,
      titulo: _gerarTitulo(recurso, acao),
    );
  }

  static String _gerarTitulo(String recurso, String acao) {
    final recursos = {
      'users': 'Usuários',
      'clients': 'Clientes',
      'roles': 'Perfis',
      'employees': 'Funcionários',
      'tenants': 'Empresas',
      'vehicles': 'Veículos',
    };

    final acoes = {
      'create': 'Criar',
      'read': 'Visualizar',
      'update': 'Editar',
      'delete': 'Excluir',
      'assign_role': 'Atribuir perfil',
    };

    final nomeRecurso = recursos[recurso] ?? _capitalizar(recurso);
    final nomeAcao = acoes[acao] ?? _capitalizar(acao);

    return '$nomeAcao $nomeRecurso';
  }

  static String _capitalizar(String texto) {
    if (texto.isEmpty) return texto;
    return texto[0].toUpperCase() + texto.substring(1);
  }
}