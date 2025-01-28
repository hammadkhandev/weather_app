import 'package:flutter/material.dart';

class HourlyCard extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temperature;
  const HourlyCard(
      {super.key,
      required this.time,
      required this.icon,
      required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 70,
          child: Column(
            children: [
              Text(
                time,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 8,
              ),
              Icon(icon),
              SizedBox(
                height: 8,
              ),
              Text(temperature),
            ],
          ),
        ),
      ),
    );
  }
}
