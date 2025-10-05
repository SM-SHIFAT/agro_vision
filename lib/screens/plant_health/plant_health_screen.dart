import 'package:flutter/material.dart';

import 'rose_disease.dart';

class PlantHealthScreen extends StatelessWidget {
  const PlantHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plant Health')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.local_florist),
              title: Text('Rose Plant'),
              subtitle: Text('Identify diseases in plant using rose images.'),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RoseLeafDeseaseDetectionApp(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
