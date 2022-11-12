import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({required this.color, this.child, this.onTap});

  final Color color;
  final Widget? child;
  final Function()? onTap; // equal to "VoidCallback".

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
        child: Ink(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
          // margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: color,
          ),
          child: child,
        ),
      
    );
  }
}
