import 'package:currency_calculator/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

enum BorderedButtonStyle {
  disabled,
  hover,
  actived,
}

class BorderedButtonStyleValue {
  final Color textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool isBright;

  BorderedButtonStyleValue({
    required this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.isBright = false,
  });
}

extension BorderedButtonStyleExtension on BorderedButtonStyle {
  BorderedButtonStyleValue get value {
    switch (this) {
      case BorderedButtonStyle.disabled:
        return BorderedButtonStyleValue(
          textColor: AppTheme.hintTextColor,
          borderColor: AppTheme.hintTextColor,
        );
      case BorderedButtonStyle.hover:
        return BorderedButtonStyleValue(
          textColor: AppTheme.primaryColor,
          borderColor: AppTheme.primaryColor,
        );

      case BorderedButtonStyle.actived:
        return BorderedButtonStyleValue(
          textColor: Colors.white,
          borderColor: AppTheme.primaryColor,
          backgroundColor: AppTheme.primaryColor,
        );
    }
  }
}

enum BorderedButtonSize { normal, small }

class BorderedButtonSizeValue {
  final double height;
  final EdgeInsets padding;
  final Size iconSize;
  final double fontSize;
  final FontWeight fontWeight;
  final double blurRadius;

  BorderedButtonSizeValue({
    required this.height,
    required this.iconSize,
    required this.padding,
    this.fontSize = 13.0,
    this.fontWeight = FontWeight.w500,
    this.blurRadius = 0.0,
  });
}

extension BorderedButtonSizeExtension on BorderedButtonSize {
  BorderedButtonSizeValue get value {
    switch (this) {
      case BorderedButtonSize.normal:
        return BorderedButtonSizeValue(
          height: 32.0,
          iconSize: Size(16.0, 16.0),
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 8.0,
          ),
          blurRadius: 8.0,
          fontSize: 11.0,
        );
      case BorderedButtonSize.small:
        return BorderedButtonSizeValue(
          height: 28.0,
          iconSize: Size(14.0, 14.0),
          padding: EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: 6.0,
          ),
          fontSize: 10.0,
          // fontWeight: FontWeight.w500,
          blurRadius: 4.0,
        );
    }
  }
}

class BorderedButton extends StatefulWidget {
  const BorderedButton({
    super.key,
    this.title,
    this.leftIcon,
    this.onPressed,
    this.size = BorderedButtonSize.normal,
    this.style = BorderedButtonStyle.disabled,
    this.isExpanded = false,
    this.fontSize,
    this.badgeCount,
    this.isSquare = false,
  });

  final String? title;
  final Widget? leftIcon;
  final VoidCallback? onPressed;
  final BorderedButtonSize size;
  final BorderedButtonStyle style;
  final bool isExpanded;
  final double? fontSize;
  final int? badgeCount;
  final bool isSquare;

  @override
  _BorderedButtonState createState() => _BorderedButtonState();
}

class _BorderedButtonState extends State<BorderedButton> {
  late bool isTaped;

  @override
  void initState() {
    isTaped = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.onPressed != null
        ? GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _tap,
            child: _buildMainBorerByCondition(),
          )
        : Container(
            child: _buildMainBorerByCondition(),
          );
  }

  void _tap() {
    if (widget.onPressed != null) {
      if (isTaped == false) {
        setState(() {
          isTaped = true;
        });

        Future.delayed(Duration(milliseconds: 50), () {
          setState(() {
            isTaped = false;
          });

          Future.delayed(Duration(milliseconds: 50), () {
            widget.onPressed?.call();
          });
        });
      }
    }
  }

  Widget _buildMainBorerByCondition() {
    return Stack(
      children: [
        Container(
          width: widget.isExpanded ? double.infinity : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: widget.style.value.borderColor!,
              width: 1,
            ),
            color: widget.style.value.backgroundColor,
          ),
          child: _buildContainer(),
        ),
        if ((widget.badgeCount ?? 0) > 0)
          Positioned(
            right: 12.0,
            top: 8.0,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppTheme.primaryColor,
              ),
              alignment: Alignment.center,
              child: Text(
                "${widget.badgeCount ?? 0}",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget _buildContainer() {
    return Container(
      height: widget.size.value.height,
      width: widget.isSquare ? widget.size.value.height : null,
      // height: 100,
      padding: widget.size.value.padding,
      child: Row(
        spacing: widget.size.value.padding.left - 2,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.leftIcon != null) widget.leftIcon!,
          if (widget.title != null)
            Text(
              widget.title!,
              style: TextStyle(
                color: widget.style.value.textColor,
                fontSize: widget.fontSize ?? widget.size.value.fontSize,
                fontFamily: "Montserrat",
                fontWeight: widget.size.value.fontWeight,
                letterSpacing: 0.70,
              ),
            ),
        ],
      ),
    );
  }
}
