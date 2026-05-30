import 'package:flutter/material.dart';

class ToggleFall extends StatefulWidget {
  final bool isActive;
  final ValueChanged<bool> onChanged;

  const ToggleFall({
    super.key,
    required this.isActive,
    required this.onChanged,
  });

  @override
  State<ToggleFall> createState() => _ToggleFallState();
}

class _ToggleFallState extends State<ToggleFall>
    with SingleTickerProviderStateMixin {
  late bool _isActive;

  static const _activeBorder = Color(0xFF6EE7B7);
  static const _activeThumb = Color(0xFF065F46);

  static const _inactiveBorder = Color(0xFFFCA5A5);
  static const _inactiveThumb = Color(0xFF991B1B);

  @override
  void initState() {
    _isActive = widget.isActive;
    super.initState();
  }

  void _toggle() {
    setState(() {
      _isActive = !_isActive;
    });

    widget.onChanged(_isActive);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          _isActive ? 'Ativo' : 'Inativo',
          style: const TextStyle(fontSize: 17),
        ),
        Switch(
          value: _isActive,
          onChanged: widget.onChanged,
          activeColor: _activeThumb,
          activeTrackColor: _activeBorder,
          inactiveThumbColor: _inactiveThumb,
          inactiveTrackColor: _inactiveBorder,
        ),
      ],
    );
  }
}
