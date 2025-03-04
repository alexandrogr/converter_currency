import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final Widget child;
  const BottomBar({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Color(0xFFF8F8F8),
      child: Column(
        children: [
          PreferredSize(
            preferredSize: Size.fromHeight(1), // Height of bottom line
            child: Container(
              color: Colors.grey[300], // Bottom border color
              height: 1, // Thickness
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: child,
              ),
              SizedBox(
                height: MediaQuery.paddingOf(context).bottom,
              )
            ],
          ),
        ],
      ),
    );
  }
}
