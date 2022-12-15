import 'package:flutter/material.dart';

class CustomChip extends StatefulWidget {
  const CustomChip({Key? key}) : super(key: key);

  @override
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        '룰루랄라',
        style: Theme.of(context).textTheme.labelSmall,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      avatar: const Icon(
        Icons.location_on,
        size: 16,
      ),
      showCheckmark: false,
      selected: isSelected,
      selectedColor: Theme.of(context).colorScheme.primary,
      backgroundColor: Colors.white,
      onSelected: (bool) {
        setState(() {
          isSelected = bool;
        });
      },
    );
  }
}
