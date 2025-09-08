import 'package:flutter/material.dart';

class MyServicesScreenFixed extends StatefulWidget {
  const MyServicesScreenFixed({super.key});
  @override
  State<MyServicesScreenFixed> createState() => _MyServicesScreenFixedState();
}

class _MyServicesScreenFixedState extends State<MyServicesScreenFixed> {
  final List<Map<String, dynamic>> _items = [];

  void _new() async {
    final res = await Navigator.pushNamed(context, '/service/new_fixed');
    if (res is Map<String, dynamic>) setState(()=>_items.add(res));
  }

  void _edit(int idx) async {
    final res = await Navigator.pushNamed(context, '/service/edit_fixed', arguments: _items[idx]);
    if (res is Map<String, dynamic>) setState(()=>_items[idx]=res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Szolgáltatásaim')),
      floatingActionButton: FloatingActionButton(onPressed: _new, child: const Icon(Icons.add)),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemBuilder: (_, i) {
          final s = _items[i];
          return ListTile(
            title: Text(s['type'] ?? 'Ismeretlen'),
            subtitle: Text((s['districts'] as List?)?.join(', ') ?? ''),
            trailing: const Icon(Icons.edit),
            onTap: ()=>_edit(i),
          );
        },
        separatorBuilder: (_, __)=>const Divider(height: 1),
        itemCount: _items.length,
      ),
    );
  }
}
