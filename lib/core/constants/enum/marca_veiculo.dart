enum MarcaVeiculo {
  toyota(1, 'Toyota'),
  volkswagen(2, 'Volkswagen'),
  chevrolet(3, 'Chevrolet'),
  fiat(4, 'Fiat'),
  honda(5, 'Honda'),
  hyundai(6, 'Hyundai'),
  ford(7, 'Ford'),
  renault(8, 'Renault'),
  nissan(9, 'Nissan'),
  jeep(10, 'Jeep'),
  peugeot(11, 'Peugeot'),
  citroen(12, 'Citroen'),
  mitsubishi(13, 'Mitsubishi'),
  kia(14, 'Kia'),
  bmw(15, 'Bmw'),
  mercedesBenz(16, 'MercedesBenz'),
  audi(17, 'Audi'),
  volvo(18, 'Volvo'),
  subaru(19, 'Subaru'),
  landRover(20, 'LandRover'),
  byd(21, 'Byd'),
  chery(22, 'Chery'),
  ram(23, 'Ram'),
  suzuki(24, 'Suzuki'),
  hondaMotos(25, 'HondaMotos'),
  yamaha(26, 'Yamaha'),
  kawasaki(27, 'Kawasaki'),
  suzukiMotos(28, 'SuzukiMotos'),
  bmwMotorrad(29, 'BmwMotorrad'),
  dafra(30, 'Dafra'),
  shineray(31, 'Shineray'),
  royalEnfield(32, 'RoyalEnfield'),
  triumph(33, 'Triumph'),
  harleyDavidson(34, 'HarleyDavidson'),
  ducati(35, 'Ducati'),
  ktm(36, 'Ktm');

  final int value;
  final String label;

  const MarcaVeiculo(this.value, this.label);

  static MarcaVeiculo fromValue(int value) {
    return MarcaVeiculo.values.firstWhere((e) => e.value == value, orElse: () {
      throw ArgumentError('Valor inválido para MarcaVeiculo: $value');
    });
  }
}