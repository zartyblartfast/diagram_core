import 'package:flutter/material.dart';
import 'demos/core_elements_demo.dart';

void main() {
  runApp(const DiagramCoreExampleApp());
}

class DiagramCoreExampleApp extends StatelessWidget {
  const DiagramCoreExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diagram Core Examples',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ExampleGallery(),
    );
  }
}

class ExampleGallery extends StatelessWidget {
  const ExampleGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagram Core Examples'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Core Elements Demo'),
            subtitle: const Text('Demonstrates Grid, Axis, and Frame elements'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CoreElementsDemo(),
                ),
              );
            },
          ),
          // Add more demo tiles here
        ],
      ),
    );
  }
}
