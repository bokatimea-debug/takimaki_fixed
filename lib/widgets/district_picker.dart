import 'package:flutter/material.dart';

class DistrictPicker extends StatefulWidget {
  const DistrictPicker({super.key, this.initial});
  final Set<String>? initial;
  @override
  State<DistrictPicker> createState() => _DistrictPickerState();
}

class _DistrictPickerState extends State<DistrictPicker> {
  static const roman = [
    'I','II','III','IV','V','VI','VII','VIII','IX','X',
    'XI','XII','XIII','XIV','XV','XVI','XVII','XVIII','XIX','XX',
    'XXI','XXII','XXIII'
  ];
  late Set<String> sel = {...?widget.initial};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Kerületek (Budapest I–XXIII)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: roman.map((d) => FilterChip(
                label: Text(d),
                selected: sel.contains(d),
                onSelected: (v) => setState(() => v ? sel.add(d) : sel.remove(d)),
              )).toList(),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => Navigator.pop<Set<String>>(context, sel),
              child: const Text('Kész'),
            ),
          ],
        ),
      ),
    );
  }
}
