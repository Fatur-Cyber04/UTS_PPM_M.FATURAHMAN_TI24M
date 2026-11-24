import 'package:flutter/material.dart';
import '../viewmodels/activity_viewmodel.dart';
import 'activity_detail_view.dart';
import 'activity_form_view.dart';

class HomeView extends StatelessWidget {
  final ActivityViewModel viewModel;

  const HomeView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Counter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // Otomatis rebuild saat ViewModel memanggil notifyListeners()
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          final items = viewModel.activities;
          if (items.isEmpty) {
            return const Center(
                child: Text('Belum ada aktivitas. Tekan Tambah untuk membuat.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            itemBuilder: (context, i) {
              final a = items[i];
              return Card(
                child: ListTile(
                  title: Text(a.name,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('Counter: ${a.counter}'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ActivityDetailView(
                          viewModel: viewModel, activityId: a.id),
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ActivityFormView(
                            viewModel: viewModel, activityId: a.id),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ActivityFormView(viewModel: viewModel)),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
    );
  }
}
