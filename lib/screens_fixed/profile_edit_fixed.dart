import 'package:flutter/material.dart';

class ProfileEditScreenFixed extends StatefulWidget {
  const ProfileEditScreenFixed({super.key});
  @override
  State<ProfileEditScreenFixed> createState() => _ProfileEditScreenFixedState();
}

class _ProfileEditScreenFixedState extends State<ProfileEditScreenFixed> {
  final _bio = TextEditingController();
  Future<void> _save() async {
    // Itt hívd meg a valódi repo mentést
    if (mounted) Navigator.pop(context, {'bio': _bio.text.trim()});
  }
  Future<void> _delete() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Profil törlése'),
        content: const Text('Biztosan törlöd a profilt?'),
        actions: [
          TextButton(onPressed: ()=>Navigator.pop(context,false), child: const Text('Mégse')),
          TextButton(onPressed: ()=>Navigator.pop(context,true),  child: const Text('Törlés')),
        ],
      ),
    ) ?? false;
    if (!ok) return;
    // Itt töröld a profilod a repo-ban
    if (mounted) Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil szerkesztése')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(controller: _bio, decoration: const InputDecoration(labelText: 'Bemutatkozás')),
            const SizedBox(height: 16),
            FilledButton(onPressed: _save, child: const Text('Mentés')),
            const SizedBox(height: 8),
            TextButton.icon(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              label: const Text('Profil törlése', style: TextStyle(color: Colors.red)),
              onPressed: _delete,
            ),
          ],
        ),
      ),
    );
  }
}
