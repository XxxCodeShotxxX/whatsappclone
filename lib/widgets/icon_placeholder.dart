import 'package:flutter/material.dart';

class IconPlaceholder extends StatelessWidget {
  const IconPlaceholder({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
  });

  final Color color;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
