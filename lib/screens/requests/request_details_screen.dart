import 'package:flutter/material.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? r =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(title: const Text('Ajánlatkérés részletek')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _row('Szolgáltatás:', r?['serviceName']?.toString() ?? '-'),
          const SizedBox(height: 8),
          _row('Ügyfél:', r?['customer']?.toString() ?? '-'),
          const SizedBox(height: 8),
          _row('Helyszín:', r?['cityDist']?.toString() ?? '-'),
          const SizedBox(height: 8),
          _row('Időpont:', r?['when']?.toString() ?? '-'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('Gyors elfogadás'),
                  onPressed: () {
                    Navigator.pop(context, {'action': 'accept', 'id': r?['id']});
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.close),
                  label: const Text('Elutasítás'),
                  onPressed: () {
                    Navigator.pop(context, {'action': 'reject', 'id': r?['id']});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
        Expanded(child: Text(value)),
      ],
    );
  }
}
