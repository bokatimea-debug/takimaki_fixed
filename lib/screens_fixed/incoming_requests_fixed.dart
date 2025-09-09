import 'package:flutter/material.dart';

class IncomingRequestsScreenFixed extends StatefulWidget {
  const IncomingRequestsScreenFixed({super.key});
  @override
  State<IncomingRequestsScreenFixed> createState() => _IncomingRequestsScreenFixedState();
}

class _IncomingRequestsScreenFixedState extends State<IncomingRequestsScreenFixed> {
  final _reqs = List.generate(5, (i)=> {
    'id': i+1, 'serviceName':'Általános ', 'customer':'Ügyfél ', 'cityDist':'Budapest XIII', 'when':'Holnap 10:00'
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beérkezett kérések')),
      body: ListView.separated(
        itemBuilder: (_, i) {
          final r = _reqs[i];
          return ListTile(
            title: Text((r['serviceName'] ?? '-').toString()),
            subtitle: Text(" •  • "),
            onTap: ()=>Navigator.pushNamed(context, '/request/details', arguments: r),
            trailing: IconButton(
              tooltip: 'Gyors elfogadás',
              icon: const Icon(Icons.check_circle, color: Colors.green),
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Elfogadva')));
              },
            ),
          );
        },
        separatorBuilder: (_, __)=>const Divider(height:1),
        itemCount: _reqs.length,
      ),
    );
  }
}

