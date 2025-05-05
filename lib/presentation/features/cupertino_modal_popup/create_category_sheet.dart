import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showCustomModal(BuildContext context, String title, Widget content) {
  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return Container(
        width: double.infinity,
        height: 400,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(child: content),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
            const SizedBox(height: 30),
          ],
        ),
      );
    },
  );
}