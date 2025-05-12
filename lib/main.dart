import 'package:flutter/material.dart';
import 'package:test_survey/TallyFormWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TallyFormScreen(),
    );
  }
}

class TallyFormScreen extends StatefulWidget {
  const TallyFormScreen({super.key});

  @override
  State<TallyFormScreen> createState() => _TallyFormScreenState();
}

class _TallyFormScreenState extends State<TallyFormScreen> {
  bool _completed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tally Form')),
      body: Stack(
        children: [
          if (!_completed)
            TallyFormWidget(
              formId: 'mYgyM0',
              onSubmit: () {
                setState(() => _completed = true);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("✅ ¡Formulario Tally enviado!")),
                );
              },
            )
          else
            const Center(
              child: Icon(Icons.check_circle, size: 100, color: Colors.green),
            ),
        ],
      ),
    );
  }
}
