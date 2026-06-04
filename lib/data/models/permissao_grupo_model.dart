import 'package:torpheus/data/models/permissao_model.dart';

class PermissaoGrupoModel {
  final String recurso;
  final String titulo;
  final List<PermissaoModel> itens;

  const PermissaoGrupoModel({
    required this.recurso,
    required this.titulo,
    required this.itens,
  });

  bool get todosSelecionados => itens.every((p) => p.isSelected);
  bool get algumSelecionado => itens.any((p) => p.isSelected);
}