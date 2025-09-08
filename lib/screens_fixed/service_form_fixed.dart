import 'package:flutter/material.dart';
import '../../widgets/district_picker.dart';

enum ServiceType { general, cleaning, moving, repair }

class ServiceFormScreenFixed extends StatefulWidget {
  final Map<String, dynamic>? existing;
  const ServiceFormScreenFixed({super.key, this.existing});
  @override
  State<ServiceFormScreenFixed> createState() => _ServiceFormScreenFixedState();
}

class _ServiceFormScreenFixedState extends State<ServiceFormScreenFixed> {
  ServiceType? _type;
  final _price = TextEditingController();
  final Set<String> _districts = {};
  final Set<DateTime> _days = {};

  bool get _valid => _type != null && _districts.isNotEmpty && _price.text.trim().isNotEmpty;

  Future<void> _pickDistricts() async {
    final picked = await showModalBottomSheet<Set<String>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => DistrictPicker(initial: _districts),
    );
    if (picked != null) setState(() { _districts..clear()..addAll(picked); });
  }

  Future<void> _pickDays() async {
    final now = DateTime.now();
    final range = await showDateRangePicker(
      context: context,
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate:  now.add(const Duration(days: 365)),
    );
    if (range != null) {
      final s = DateTime(range.start.year, range.start.month, range.start.day);
      final e = DateTime(range.end.year, range.end.month, range.end.day);
      final tmp = <DateTime>{};
      for (var d = s; !d.isAfter(e); d = d.add(const Duration(days: 1))) { tmp.add(d); }
      setState(() { _days..clear()..addAll(tmp); });
    }
  }

  void _save() {
    Navigator.pop(context, {
      'type': _type?.name,
      'price': _price.text.trim(),
      'districts': _districts.toList(),
      'days': _days.map((d)=>d.toIso8601String()).toList(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final chips = ServiceType.values.map((t) => ChoiceChip(
      label: Text(t.name),
      selected: _type == t,
      onSelected: (_) => setState(() => _type = t),
    )).toList();

    return Scaffold(
      appBar: AppBar(title: Text(widget.existing == null ? 'Új szolgáltatás' : 'Szolgáltatás szerkesztése')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Típus (egyet válassz):'), const SizedBox(height: 8),
            Wrap(spacing: 8, runSpacing: 8, children: chips),
            const SizedBox(height: 16),
            TextField(controller: _price, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Ár (Ft vagy Ft/óra)')),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              icon: const Icon(Icons.map_outlined),
              label: Text(_districts.isEmpty ? 'Budapest – kerületek kiválasztása' : 'Budapest – ' + (_districts.toList()..sort()).join(', ')),
              onPressed: _pickDistricts,
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              icon: const Icon(Icons.event_available),
              label: Text(_days.isEmpty ? 'Napok kiválasztása' : ' nap kiválasztva'),
              onPressed: _pickDays,
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: _valid ? _save : null, child: const Text('Mentés')),
          ],
        ),
      ),
    );
  }
}
