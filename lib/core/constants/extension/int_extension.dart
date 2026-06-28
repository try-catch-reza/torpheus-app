extension DurationFormatter on int {
  String get toHourMinute {
    final horas = this ~/ 60;
    final minutos = this % 60;

    return '${horas.toString().padLeft(2, '0')}:${minutos.toString().padLeft(2, '0')}';
  }
}
