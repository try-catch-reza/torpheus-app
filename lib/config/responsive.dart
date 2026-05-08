import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

abstract class Responsive {
  static const double _mobileBreakpoint = 768;
  static const double _tabletBreakpoint = 1024;

  /// Layout mobile: app nativo OU browser com tela < 768px
  static bool isMobile(BuildContext context) {
    if (!kIsWeb) return true;
    return MediaQuery.sizeOf(context).width < _mobileBreakpoint;
  }

  /// Layout tablet: browser entre 768px e 1024px
  static bool isTablet(BuildContext context) {
    if (!kIsWeb) return false;
    final width = MediaQuery.sizeOf(context).width;
    return width >= _mobileBreakpoint && width < _tabletBreakpoint;
  }

  /// Layout desktop: browser >= 1024px
  static bool isDesktop(BuildContext context) {
    if (!kIsWeb) return false;
    return MediaQuery.sizeOf(context).width >= _tabletBreakpoint;
  }
}