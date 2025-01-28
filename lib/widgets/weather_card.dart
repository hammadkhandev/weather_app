import 'dart:ui';

import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String temp;
  final IconData icon;
  final String label;
  const WeatherCard({super.key, required this.temp, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Text(temp,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Icon(icon,
                    size: 64,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(label,
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
