// dart
import 'package:flutter/material.dart';
import 'package:torpheus/core/constants/custom_colors.dart';

class DialogMobilePadrao extends StatefulWidget {
  const DialogMobilePadrao({
    super.key,
    required this.icon,
    required this.message,
    required this.onPress,
    this.isDismissable = true,
    this.buttonLabel = 'OK',
    this.title,
    this.aditionalInfo,
  });

  final Icon icon;
  final String message;
  final Function() onPress;
  final bool isDismissable;
  final String? buttonLabel;
  final String? title;
  final String? aditionalInfo;

  @override
  State<DialogMobilePadrao> createState() => _DialogMobilePadraoState();

  static Future<T?> successDialog<T>({
    required BuildContext context,
    required String message,
    required Function() onPress,
    String? buttonLabel,
    String title = 'Sucesso',
    bool isDismissable = true,
    String? aditionalInfo,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: isDismissable,
      builder: (_) => DialogMobilePadrao(
        icon: _iconSuccess,
        message: message,
        onPress: () {
          Navigator.of(context, rootNavigator: true).pop();
          onPress();
        },
        title: title,
        buttonLabel: buttonLabel,
        isDismissable: isDismissable,
        aditionalInfo: aditionalInfo,
      ),
    );
  }

  static Future<T?> warningDialog<T>({
    required BuildContext context,
    required String message,
    required Function() onPress,
    String? buttonLabel,
    String title = 'Atenção',
    bool isDismissable = true,
    String? aditionalInfo,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: isDismissable,
      builder: (_) => DialogMobilePadrao(
        icon: _iconWarning,
        message: message,
        onPress: () {
          Navigator.of(context, rootNavigator: true).pop();
          onPress();
        },
        title: title,
        buttonLabel: buttonLabel,
        isDismissable: isDismissable,
        aditionalInfo: aditionalInfo,
      ),
    );
  }

  static Future<T?> errorDialog<T>({
    required BuildContext context,
    required String message,
    required Function() onPress,
    String? buttonLabel,
    String title = 'Erro',
    bool isDismissable = true,
    String? aditionalInfo,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: isDismissable,
      builder: (_) => DialogMobilePadrao(
        icon: _iconError,
        message: message,
        onPress: () {
          Navigator.of(context, rootNavigator: true).pop();
          onPress();
        },
        title: title,
        buttonLabel: buttonLabel,
        isDismissable: isDismissable,
        aditionalInfo: aditionalInfo,
      ),
    );
  }

  static Icon get _iconSuccess =>
      Icon(Icons.check, color: ColorConstants.chambray, size: 40);

  static Icon get _iconError =>
      const Icon(Icons.close, color: ColorConstants.redDelete, size: 40);

  static Icon get _iconWarning =>
      const Icon(Icons.priority_high, color: ColorConstants.orange, size: 40);
}

class _DialogMobilePadraoState extends State<DialogMobilePadrao> {
  BorderRadius get _borderRadius => BorderRadius.circular(16);

  BorderRadius get _borderIcon => BorderRadius.circular(32);

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.isDismissable,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .75,
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
          decoration: BoxDecoration(
            color: ColorConstants.paleGrey,
            borderRadius: _borderRadius,
          ),
          child: Material(
            color: ColorConstants.paleGrey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _icon(),
                _title(),
                _message(),
                _adicionalInfo(),
                _button(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Material(
        color: ColorConstants.morningMist,
        borderRadius: _borderIcon,
        child: Padding(padding: const EdgeInsets.all(12.0), child: widget.icon),
      ),
    );
  }

  Widget _title() {
    return Visibility(
      visible: widget.title != null,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          widget.title ?? '',
          style: TextStyle(
            color: widget.icon.color,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _message() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Text(
        widget.message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black, fontSize: 17.5),
      ),
    );
  }

  Widget _button(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      width: MediaQuery.of(context).size.width * .4,
      child: ElevatedButton(
        onPressed: widget.onPress,
        style: ElevatedButton.styleFrom(
          elevation: 8,
          backgroundColor: widget.icon.color,
          shape: RoundedRectangleBorder(borderRadius: _borderIcon),
        ),
        child: Text(
          widget.buttonLabel ?? 'OK',
          style: const TextStyle(fontSize: 17, color: Colors.white),
        ),
      ),
    );
  }

  Widget _adicionalInfo() {
    return Visibility(
      visible: widget.aditionalInfo != null,
      child: Flexible(
        child: SizedBox(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                widget.aditionalInfo ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: ColorConstants.squant,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
