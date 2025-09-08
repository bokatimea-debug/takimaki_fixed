import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final dynamic order;
  const OrderDetailsScreen({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    final o = order ?? ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(title: const Text('Rendelés részletek')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Azonosító: \', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Szolgáltatás: \'),
            Text('Megrendelő: \'),
            Text('Időpont: \'),
            Text('Ár: \'),
            const Divider(height: 24),
            if ((o?.rating) != null) ...[
              const Text('Értékelés', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('Csillag: \'),
              Text(o?.rating?.comment ?? ""),
            ] else
              const Text('Még nincs értékelés.'),
          ],
        ),
      ),
    );
  }
}
