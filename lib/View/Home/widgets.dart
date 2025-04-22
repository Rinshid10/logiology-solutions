import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Widget buildCategoryItem(String title, IconData icon) {
  return Container(
    width: 80,
    margin: const EdgeInsets.only(right: 12),
    child: Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(icon, size: 30, color: Colors.blue),
        ),
        const Gap(8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    ),
  );
}
