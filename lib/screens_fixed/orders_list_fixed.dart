import 'package:flutter/material.dart';

class OrdersListScreenFixed extends StatelessWidget {
  const OrdersListScreenFixed({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = List.generate(6, (i)=> {
      'id': i+100, 'serviceName': 'Munka ', 'customer':'Ügyfél ', 'when':'Jövő hét', 'price':'12 500 Ft',
      'rating': i.isEven ? {'stars': 5, 'comment':'Szuper munka!'} : null
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Összes rendelés')),
      body: ListView.separated(
        itemBuilder: (_, i) {
          final o = orders[i];
          return ListTile(
            title: Text((o['serviceName'] ?? '-').toString()),
            subtitle: Text(" •  • "),
            trailing: const Icon(Icons.chevron_right),
            onTap: ()=>Navigator.pushNamed(context, '/order/details', arguments: o),
          );
        },
        separatorBuilder: (_, __)=>const Divider(height:1),
        itemCount: orders.length,
      ),
    );
  }
}

