import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? o =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(title: const Text('Rendelés részletei')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _row('Azonosító:', o?['id']?.toString() ?? '-'),
          const SizedBox(height: 8),
          _row('Szolgáltatás:', o?['service']?.toString() ?? '-'),
          const SizedBox(height: 8),
          _row('Szolgáltató:', o?['providerName']?.toString() ?? '-'),
          const SizedBox(height: 8),
          _row('Időpont:', o?['time']?.toString() ?? '-'),
          const SizedBox(height: 8),
          _row('Helyszín:', o?['location']?.toString() ?? '-'),

          // Értékelés (ha van)
          if (o?['rating'] != null) ...[
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Text('Értékelés', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 6),
                Text(
                  (o?['rating']['stars'] ?? o?['rating']).toString(),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            if ((o?['rating']['comment'] ?? '').toString().isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(o?['rating']['comment'] ?? ''),
            ],
          ],
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
