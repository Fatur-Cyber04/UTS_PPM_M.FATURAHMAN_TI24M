import 'package:flutter/material.dart';
import '../viewmodels/activity_viewmodel.dart';

class ActivityDetailView extends StatelessWidget {
  final ActivityViewModel viewModel;
  final int activityId;

  const ActivityDetailView(
      {super.key, required this.viewModel, required this.activityId});

  void _snack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 1),
      ));
  }

  Future<void> _confirmReset(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Counter'),
        content: const Text('Yakin ingin mengembalikan nilai counter ke 0?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Batal')),
          ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Reset')),
        ],
      ),
    );
    if (ok == true) {
      viewModel.reset(activityId);
      if (context.mounted) _snack(context, 'Counter di-reset menjadi 0');
    }
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Aktivitas'),
        content: const Text('Yakin ingin menghapus aktivitas ini?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Batal')),
          ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Hapus')),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      final messenger = ScaffoldMessenger.of(context);
      Navigator.pop(context); // kembali ke Home dulu
      viewModel.deleteActivity(activityId);
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
            const SnackBar(content: Text('Aktivitas berhasil dihapus')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final a = viewModel.getById(activityId);
        if (a == null) return const Scaffold(); // sudah dihapus

        return Scaffold(
          appBar: AppBar(
            title: const Text('Detail Aktivitas'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                tooltip: 'Hapus',
                onPressed: () => _confirmDelete(context),
              ),
            ],
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(a.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 24),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('${a.counter}',
                        style: const TextStyle(
                            fontSize: 72, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton.filledTonal(
                        iconSize: 36,
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (viewModel.decrement(activityId)) {
                            _snack(context,
                                'Counter berkurang menjadi ${a.counter}');
                          } else {
                            _snack(context,
                                'Counter tidak boleh kurang dari 0');
                          }
                        },
                      ),
                      const SizedBox(width: 24),
                      IconButton.filled(
                        iconSize: 36,
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          viewModel.increment(activityId);
                          _snack(context,
                              'Counter bertambah menjadi ${a.counter}');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _confirmReset(context),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
