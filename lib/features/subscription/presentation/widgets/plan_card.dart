import 'package:flutter/material.dart';

class PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final bool selected;
  final VoidCallback onTap;

  const PlanCard({
    super.key,
    required this.title,
    required this.price,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: selected ? Colors.green.shade700 : Colors.grey.shade800,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
              Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
              if (selected) const Icon(Icons.check, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
