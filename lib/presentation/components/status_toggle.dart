import 'package:flutter/material.dart';

class StatusToggle extends StatefulWidget {
  final bool isActive;
  final ValueChanged<bool> onChanged;

  const StatusToggle({
    super.key,
    required this.isActive,
    required this.onChanged,
  });

  @override
  State<StatusToggle> createState() => _StatusToggleState();
}

class _StatusToggleState extends State<StatusToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _isActive = widget.isActive;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: widget.isActive ? 1.0 : 0.0,
    );
    _slideAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isActive = !_isActive;
    });
    if (_isActive) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    widget.onChanged(_isActive);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 116,
        height: 32,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: _isActive
              ? const Color(0xFFD1FAE5)
              : const Color(0xFFFEE2E2),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: _isActive
                ? const Color(0xFF6EE7B7)
                : const Color(0xFFFCA5A5),
            width: 0.5,
          ),
        ),
        child: Stack(
          children: [
            // ── Label ativo ──
            Positioned.fill(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 150),
                opacity: _isActive ? 1.0 : 0.0,
                child: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ativo',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF065F46),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ── Label inativo ──
            Positioned.fill(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 150),
                opacity: _isActive ? 0.0 : 1.0,
                child: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Inativo',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF991B1B),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ── Thumb deslizante ──
            AnimatedBuilder(
              animation: _slideAnimation,
              builder: (context, child) {
                return Align(
                  alignment: Alignment(
                    -1.0 + (_slideAnimation.value * 2.0),
                    0,
                  ),
                  child: child,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: _isActive
                      ? const Color(0xFF065F46)
                      : const Color(0xFF991B1B),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Icon(
                  _isActive ? Icons.check : Icons.close,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}