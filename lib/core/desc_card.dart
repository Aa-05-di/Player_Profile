import 'package:flutter/material.dart';

class DescCard extends StatelessWidget {
  final String skill;
  final String rating;

  const DescCard({super.key, required this.skill, required this.rating});

  @override
  Widget build(BuildContext context) {
    // Determine what content to display
    Widget content;
    IconData iconData;
    String title;
    String value;
    Color iconColor;
    Color titleColor;

    if (skill.isNotEmpty) {
      iconData = Icons.sports_cricket_sharp;
      title = "Skill Level";
      value = skill;
      iconColor = Colors.green[800]!; // Ensure non-null for use
      titleColor = Colors.black54;
    } else if (rating.isNotEmpty) {
      iconData = Icons.star;
      title = "Player Rating";
      value = double.tryParse(rating)?.toStringAsFixed(1) ?? 'N/A';
      iconColor = Colors.amber[800]!; // Ensure non-null for use
      titleColor = Colors.black54;
    } else {
      // Fallback if neither is provided
      iconData = Icons.help_outline;
      title = "No Data";
      value = "N/A";
      iconColor = Colors.grey;
      titleColor = Colors.grey;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icon
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(
            iconData,
            color: iconColor,
            size: 25,
          ),
        ),
        // Text Column
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 12, color: titleColor),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}