import 'package:currency_calculator/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MainCheckbox extends StatefulWidget {
  final String? title;
  final ValueChanged<bool>? onChanged;
  final bool isChecked;
  final bool isReadOnly;

  const MainCheckbox({
    super.key,
    this.title,
    this.onChanged,
    this.isChecked = false,
    this.isReadOnly = false,
  });

  @override
  _MainCheckboxState createState() => _MainCheckboxState();
}

class _MainCheckboxState extends State<MainCheckbox> {
  late bool isChecked;

  @override
  void initState() {
    isChecked = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isReadOnly) {
          setState(() {
            isChecked = !isChecked;
            widget.onChanged?.call(isChecked);
          });
        }
      },
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Icon(
              isChecked ? Icons.check_box : Icons.check_box_outline_blank,
              color: isChecked
                  ? AppTheme.primaryColor
                  : AppTheme.hintTextColor, // Custom color
              size: 24, // Custom size
            ),
          ),
          if (widget.title != null) ...[
            const SizedBox(
              width: AppTheme.defaultSpace,
            ),
            Expanded(
              child: Text(
                widget.title!,
                style: TextStyle(
                  color: AppTheme.hintTextColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
