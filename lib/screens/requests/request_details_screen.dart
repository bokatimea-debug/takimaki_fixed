import 'package:flutter/material.dart';

class RequestDetailsScreen extends StatelessWidget {
  final dynamic request;
  const RequestDetailsScreen({super.key, this.request});

  @override
  Widget build(BuildContext context) {
    final r = request ?? ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(title: const Text('Ajánlatkérés részletek')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Szolgáltatás: \', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Ügyfél: \'),
            Text('Helyszín: \'),
            Text('Időpont: \'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: FilledButton.icon(
                  onPressed: () => Navigator.pop(context, {'action':'accept', 'id': r?.id}),
                  icon: const Icon(Icons.check),
                  label: const Text('Gyors elfogadás'),
                )),
                const SizedBox(width: 12),
                Expanded(child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context, {'action':'reject', 'id': r?.id}),
                  icon: const Icon(Icons.close),
                  label: const Text('Elutasítás'),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
