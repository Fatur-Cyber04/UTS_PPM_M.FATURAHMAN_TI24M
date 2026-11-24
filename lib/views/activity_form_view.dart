import 'package:flutter/material.dart';
import '../viewmodels/activity_viewmodel.dart';

/// Halaman Tambah / Edit (mode edit jika activityId != null).
class ActivityFormView extends StatefulWidget {
  final ActivityViewModel viewModel;
  final int? activityId;

  const ActivityFormView({super.key, required this.viewModel, this.activityId});

  @override
  State<ActivityFormView> createState() => _ActivityFormViewState();
}

class _ActivityFormViewState extends State<ActivityFormView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;

  bool get _isEdit => widget.activityId != null;

  @override
  void initState() {
    super.initState();
    final existing =
        _isEdit ? widget.viewModel.getById(widget.activityId!) : null;
    _controller = TextEditingController(text: existing?.name ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final name = _controller.text;
    final messenger = ScaffoldMessenger.of(context);

    if (_isEdit) {
      widget.viewModel.updateActivity(widget.activityId!, name);
    } else {
      widget.viewModel.addActivity(name);
    }
    Navigator.pop(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(_isEdit
            ? 'Aktivitas berhasil diubah'
            : 'Aktivitas berhasil ditambahkan'),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Aktivitas' : 'Tambah Aktivitas'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Nama Aktivitas',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Nama aktivitas tidak boleh kosong'
                    : null,
                onFieldSubmitted: (_) => _save(),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
