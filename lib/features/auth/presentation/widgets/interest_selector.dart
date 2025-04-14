import 'package:flutter/material.dart';

class InterestSelector extends StatefulWidget {
  const InterestSelector({super.key});

  @override
  State<InterestSelector> createState() => _InterestSelectorState();
}

class _InterestSelectorState extends State<InterestSelector> {
  final List<String> interests = ["Music", "Sports", "Travel", "Art", "Gaming", "Reading"];
  final List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Interests:"),
        Wrap(
          spacing: 8,
          children: interests.map((interest) {
            final isSelected = selected.contains(interest);
            return FilterChip(
              label: Text(interest),
              selected: isSelected,
              onSelected: (bool selectedChip) {
                setState(() {
                  selectedChip ? selected.add(interest) : selected.remove(interest);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
