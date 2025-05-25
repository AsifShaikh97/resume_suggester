import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _resumeController = TextEditingController();
  String? _suggestion;

  void _getSuggestions() {
    // Mock suggestion logic
    setState(() {
      if (_resumeController.text.trim().isEmpty) {
        _suggestion = 'Please paste your resume text above.';
      } else {
        _suggestion = 'Consider adding more quantifiable achievements and using active verbs.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resume Suggester')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _resumeController,
              maxLines: 10,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Paste your resume here',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getSuggestions,
              child: const Text('Get Suggestions'),
            ),
            const SizedBox(height: 24),
            if (_suggestion != null)
              Card(
                color: Colors.amber[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(_suggestion!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}