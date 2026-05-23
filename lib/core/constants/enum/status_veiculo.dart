enum StatusVeiculo { emAndamento, concluido, aguardando, cancelado }

extension StatusVeiculoExt on StatusVeiculo {
  String get label {
    return switch (this) {
      StatusVeiculo.emAndamento => 'Em andamento',
      StatusVeiculo.concluido   => 'Concluído',
      StatusVeiculo.aguardando  => 'Aguardando',
      StatusVeiculo.cancelado   => 'Cancelado',
    };
  }
}