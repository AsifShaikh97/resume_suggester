import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _resumeController = TextEditingController();
  String? _suggestion;
  String? _pdfFileName;
  bool _pdfUploaded = false;

  Future<void> _pickPdf() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _pdfFileName = result.files.single.name;
        _pdfUploaded = true;
        _resumeController.text = '''Lorem ipsum dolor sit amet,
consectetur adipiscing elit.
Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.''';
      });
      Fluttertoast.showToast(
        msg: "${result.files.single.name} uploaded successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
        webBgColor: "linear-gradient(to right, #ffffff, #e0e0e0)",
        webPosition: "center",
        timeInSecForIosWeb: 2,
      );
    }
  }

  void _getSuggestions() {
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
            Row(
              children: [
                ElevatedButton(
                  onPressed: _pickPdf,
                  child: const Text('Upload PDF'),
                ),
                const SizedBox(width: 16),
              ],
            ),
            if (_pdfFileName != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.picture_as_pdf, color: Colors.red),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _pdfFileName!,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            if (_pdfUploaded) ...[
              Expanded(
                child: TextField(
                  controller: _resumeController,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Resume suggestions will appear here',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _getSuggestions,
                child: const Text('Get Suggestions'),
              ),
            ],
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