import 'package:flutter/material.dart';

class DefaultContainer extends StatelessWidget {
  final double maxWidth;
  final List<Widget> children;

  const DefaultContainer({
    super.key,
    this.maxWidth = 450,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: children
          ),
        ),
      ),
    );
  }
}
