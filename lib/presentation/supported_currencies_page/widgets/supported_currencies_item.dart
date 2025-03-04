import 'package:currency_calculator/core/theme/app_theme.dart';
import 'package:currency_calculator/core/ui/bordered_default.dart';
import 'package:flutter/material.dart';

class SupportedCurrenciesItem extends StatelessWidget {
  const SupportedCurrenciesItem({
    super.key,
    required this.code,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String code;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: BorderedContainer(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        backgroundColor: isSelected ? AppTheme.primaryColor : Colors.white,
        child: Row(
          spacing: 8.0,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    code,
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: isSelected ? Colors.white : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            isSelected
                ? Icon(
                    Icons.check,
                    size: 15.0,
                    color: isSelected ? Colors.white : AppTheme.primaryColor,
                  )
                : Container(
                    width: 18.0,
                    height: 18.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color:
                            isSelected ? Colors.white : AppTheme.hintTextColor,
                        width: 1.2,
                      ),
                    ),
                    child: Center(
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              size: 15.0,
                              color: isSelected
                                  ? Colors.white
                                  : AppTheme.primaryColor,
                            )
                          : SizedBox.shrink(),
                    ),
                  ),
            // : Checkbox.adaptive(
            //     activeColor: AppTheme.primaryColor,
            //     value: isSelected,
            //     onChanged: (value) {
            //       onTap.call();
            // }),
          ],
        ),
      ),
    );
  }
}
