import 'package:currency_calculator/core/theme/app_theme.dart';
import 'package:currency_calculator/core/ui/buttons/bordered_button.dart';
import 'package:flutter/material.dart';

class MainRadioFieldItem<T> {
  final String title;
  final Widget? iconPath;
  final T value;

  MainRadioFieldItem({
    required this.value,
    required this.title,
    this.iconPath,
  });
}

class MainRadioField<T> extends StatefulWidget {
  final List<MainRadioFieldItem<T>> items;
  final ValueChanged<T>? onChanged;
  final T? initialValue;
  final bool isReadOnly;
  final EdgeInsets? padding;
  final Widget? prefix;

  const MainRadioField({
    super.key,
    required this.items,
    this.onChanged,
    this.initialValue,
    this.isReadOnly = false,
    this.padding,
    this.prefix,
  });

  @override
  _MainRadioFieldState<T> createState() => _MainRadioFieldState<T>();
}

class _MainRadioFieldState<T> extends State<MainRadioField<T>> {
  late T _currentValue;

  @override
  void initState() {
    if (widget.initialValue == null && widget.items.isNotEmpty) {
      this._currentValue = widget.items.first.value;
    } else {
      this._currentValue = widget.initialValue as T;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: widget.padding,
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: AppTheme.defaultSpace,
          children: [
            if (widget.prefix != null) widget.prefix!,
            ...widget.items.map((item) => BorderedButton(
                  title: item.title,
                  leftIcon: item.iconPath,
                  size: BorderedButtonSize.small,
                  style: this._currentValue == item.value
                      ? BorderedButtonStyle.actived
                      : BorderedButtonStyle.disabled,
                  onPressed: !widget.isReadOnly
                      ? () {
                          setState(() {
                            this._currentValue = item.value;
                          });

                          widget.onChanged?.call(this._currentValue);
                        }
                      : null,
                ))
          ],
        ),
      ),
    );
  }
}
