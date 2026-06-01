import 'package:flutter/material.dart';

class AppBarPadrao extends StatelessWidget implements PreferredSizeWidget {
  const AppBarPadrao({
    super.key,
    required this.title,
    this.hasLeading = false,
  });

  final String title;
  final bool hasLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: !hasLeading,
      automaticallyImplyLeading: hasLeading,
      leading: Visibility(
        visible: hasLeading,
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
