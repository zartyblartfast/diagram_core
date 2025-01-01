import 'package:flutter/material.dart';
import 'demos/core_elements_demo.dart';
import 'demos/core_elements_demo2.dart';
import 'demos/core_elements_demo3.dart';
import 'demos/core_elements_demo5.dart';

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
            subtitle: const Text('Basic coordinate layout (-10 to +10 x, -10 to +10 y)'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CoreElementsDemo()),
              );
            },
          ),
          ListTile(
            title: const Text('Core Elements Demo 2'),
            subtitle: const Text('Modified coordinate layout (-5 to +5 x, 0 to 10 y)'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CoreElementsDemo2()),
              );
            },
          ),
          ListTile(
            title: const Text('Core Elements Demo 3'),
            subtitle: const Text('Asymmetric coordinate layout (-2 to +8 x, -5 to +5 y)'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CoreElementsDemo3()),
              );
            },
          ),
          ListTile(
            title: const Text('Core Elements Demo 5'),
            subtitle: const Text('Core elements from JSON configuration'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CoreElementsDemo5()),
              );
            },
          ),
          // Add more demo tiles here
        ],
      ),
    );
  }
}
