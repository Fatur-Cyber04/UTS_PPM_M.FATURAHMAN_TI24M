import 'package:flutter/material.dart';
import 'data/activity_data.dart';
import 'repositories/activity_repository.dart';
import 'viewmodels/activity_viewmodel.dart';
import 'views/home_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Data -> Repository -> ViewModel (dibuat sekali)
  late final ActivityViewModel viewModel =
      ActivityViewModel(ActivityRepository(ActivityData()));

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: HomeView(viewModel: viewModel),
    );
  }
}
