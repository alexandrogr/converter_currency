import 'package:currency_calculator/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  const AppBarDefault({
    super.key,
    required this.title,
    this.actions = const [],
    this.leading,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Color(0xFFF8F8F8), // Light grey background
      leading: leading,
      actions: actions,
      title: Column(
        spacing: 4.0,
        children: [
          Text(
            title,
            style: AppTheme.defaultTextStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: AppTheme.defaultTextStyle.copyWith(
                fontSize: 12,
                color: AppTheme.hintTextColor,
              ),
            ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1), // Height of bottom line
        child: Container(
          color: Colors.grey[300], // Bottom border color
          height: 1, // Thickness
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
