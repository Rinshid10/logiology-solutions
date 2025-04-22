import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;

Widget items(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(title, style: TextStyle(color: Colors.grey[600])),
        ),
        const Gap(8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  );
}
