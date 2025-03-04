import 'package:currency_calculator/core/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum MainButtonStyle { normal, hover, active, transparent }

class MainButtonStyleValue {
  final Color defaultBackgroundColor;
  final Color defaultBorderColor;
  final Color defaultShadowColor;
  final Color defaultTitleColor;
  final Size defaultIconSize;
  final double cornerRadius;
  final bool isShadow;

  MainButtonStyleValue({
    this.defaultBackgroundColor = Colors.black,
    this.defaultBorderColor = Colors.transparent,
    this.defaultShadowColor = Colors.transparent,
    this.defaultTitleColor = Colors.white,
    this.defaultIconSize = const Size(16.0, 16.0),
    this.cornerRadius = 10.0,
    this.isShadow = false,
  });
}

extension MainButtonStyleExtension on MainButtonStyle {
  MainButtonStyleValue get value {
    switch (this) {
      case MainButtonStyle.normal:
        return MainButtonStyleValue(
          defaultBackgroundColor: Colors.transparent,
          defaultBorderColor: AppTheme.primaryColor,
          defaultTitleColor: AppTheme.primaryColor,
        );
      case MainButtonStyle.hover:
        return MainButtonStyleValue(
          defaultBackgroundColor: Colors.transparent,
          defaultBorderColor: AppTheme.hintTextColor,
          defaultTitleColor: AppTheme.hintTextColor,
        );
      case MainButtonStyle.active:
        return MainButtonStyleValue(
          defaultBackgroundColor: AppTheme.primaryColor,
          defaultBorderColor: AppTheme.primaryColor,
          defaultShadowColor: AppTheme.primaryColor,
          defaultTitleColor: Colors.white,
        );

      case MainButtonStyle.transparent:
        return MainButtonStyleValue(
          defaultBackgroundColor: Colors.transparent,
          defaultTitleColor: Colors.white,
        );
    }
  }
}

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.title,
    this.leftIcon,
    this.onPressed,
    this.style = MainButtonStyle.normal,
    this.padding,
    this.height = 38.0,
    this.isExpanded = true,
  });

  final String? title;
  final Widget? leftIcon;
  final VoidCallback? onPressed;
  final MainButtonStyle style;
  final EdgeInsets? padding;
  final double height;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.all(0),
      minSize: 0,
      onPressed: onPressed,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(style.value.cornerRadius),
          border: Border.all(
            color: style.value.defaultBorderColor,
            width: 1,
          ),
          color: style.value.defaultBackgroundColor,
        ),
        padding: padding ??
            const EdgeInsets.symmetric(
              vertical: AppTheme.defaultSpace,
              horizontal: AppTheme.defaultSpace + AppTheme.defaultSpace / 2.0,
            ),
        child: Row(
          spacing: AppTheme.defaultSpace,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
          children: [
            if (leftIcon != null)
              SizedBox(
                width: style.value.defaultIconSize.width,
                height: style.value.defaultIconSize.height,
                child: leftIcon,
              ),
            Text(
              title ?? "-",
              style: TextStyle(
                color: style.value.defaultTitleColor,
                fontSize: 14,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
