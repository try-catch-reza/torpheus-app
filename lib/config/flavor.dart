
enum Flavor { homolog, prod }

class FlavorConfig {
  final Flavor _flavor;

  static FlavorConfig? _instance;

  factory FlavorConfig(bool prod) {
    return _instance ??=
        FlavorConfig._internal(prod ? Flavor.prod : Flavor.homolog);
  }

  FlavorConfig._internal(this._flavor);

  static String envString() => isHomolog() ? 'HOMOLOG' : 'PROD';

  // static String baseUrlEapi() {
  //   return isProduction() ? EapiSchema.baseUrlProd : EapiSchema.baseUrlHomolog;
  // }

  static bool isHomolog() => _instance!._flavor == Flavor.homolog;

  static bool isProduction() => _instance!._flavor == Flavor.prod;
}
