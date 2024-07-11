import 'package:flutter/material.dart';

class IconPlaceholder extends StatelessWidget {
  const IconPlaceholder({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    this.onTap
  });

  final Color color;
  final IconData icon;
  final String title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(icon),
          ),
          Text(title)
        ],
      ),
    );
  }
}
