import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BasicInfoScreenFixed extends StatefulWidget {
  const BasicInfoScreenFixed({super.key});
  @override
  State<BasicInfoScreenFixed> createState() => _BasicInfoScreenFixedState();
}

class _BasicInfoScreenFixedState extends State<BasicInfoScreenFixed> {
  final _first = TextEditingController();
  final _last = TextEditingController();
  final _ok = ValueNotifier<bool>(false);
  XFile? _photo;

  @override
  void initState() {
    super.initState();
    void watch() => _ok.value = _first.text.trim().isNotEmpty && _last.text.trim().isNotEmpty && _photo != null;
    _first.addListener(watch);
    _last.addListener(watch);
  }

  Future<void> _pick() async {
    final p = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (p != null) {
      _photo = p;
      _ok.value = _first.text.trim().isNotEmpty && _last.text.trim().isNotEmpty && _photo != null;
      setState(() {});
    }
  }

  void _next() {
    Navigator.pop(context, {
      'first': _first.text.trim(),
      'last': _last.text.trim(),
      'photo': _photo?.path,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alapadatok')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _first, decoration: const InputDecoration(labelText: 'Vezetéknév *')),
            TextField(controller: _last,  decoration: const InputDecoration(labelText: 'Keresztnév *')),
            const SizedBox(height: 12),
            Row(
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.photo),
                  label: Text(_photo == null ? 'Profilkép feltöltése *' : 'Profilkép kiválasztva'),
                  onPressed: _pick,
                ),
              ],
            ),
            const Spacer(),
            ValueListenableBuilder<bool>(
              valueListenable: _ok,
              builder: (_, ok, __) => FilledButton(
                onPressed: ok ? _next : null,
                child: const Text('Tovább'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
