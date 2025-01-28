import 'package:flutter/material.dart';

class ItemInformation extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const ItemInformation({super.key, required this.icon, required this.label, required this.value, });
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Icon(icon),
        SizedBox(
          height: 8,
        ),
        Text(label),
        SizedBox(
          height: 8,
        ),
        Text(value),
      ],
    );
  }
}
