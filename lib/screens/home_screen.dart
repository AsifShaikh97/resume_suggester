import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resume_suggester/bloc/pdf_bloc/pdf_picker_bloc.dart';
import 'package:resume_suggester/bloc/pdf_bloc/pdf_picker_state.dart';

import '../bloc/pdf_bloc/pdf_picker_event.dart';

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

  /* Future<void> _pickPdf() async {
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

    }
  }
*/
  void _getSuggestions() {
    setState(() {
      if (_resumeController.text.trim().isEmpty) {
        _suggestion = 'Please paste your resume text above.';
      } else {
        _suggestion =
            'Consider adding more quantifiable achievements and using active verbs.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resume Suggester',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<PdfPickerBloc, PdfPickerState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Center(
                  child: BlocBuilder<PdfPickerBloc, PdfPickerState>(
                    builder: (context, state) {
                      if (state is PdfPickerInitial) {
                        return ElevatedButton(
                          onPressed: () {
                            context.read<PdfPickerBloc>().add(PdfPickFile(''));
                          },
                          child: Text("Pick PDF"),
                        );
                      } else if (state is PdfPickerLoading) {
                        return CircularProgressIndicator();
                      } else if (state is PdfPickerLoaded) {
                        Fluttertoast.showToast(
                          msg: "${state.filePath} uploaded successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM_RIGHT,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: 16.0,
                          webBgColor: "linear-gradient(to right, #ffffff, #e0e0e0)",
                          webPosition: "center",
                          timeInSecForIosWeb: 2,
                        );
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Picked File: ${state.filePath}"),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                Fluttertoast.showToast(
                                  msg: "Please wait while we process your PDF",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM_RIGHT,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  fontSize: 16.0,
                                  webBgColor: "linear-gradient(to right, #ffffff, #e0e0e0)",
                                  webPosition: "center",
                                  timeInSecForIosWeb: 2,
                                );
                              },
                              child: Text("Get Suggestions"),
                            )
                          ],
                        );
                      } else if (state is PdfPickerError) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Error: ${state.message}", style: TextStyle(color: Colors.red)),
                            ElevatedButton(
                              onPressed: () {
                                context.read<PdfPickerBloc>().add(PdfPickFile(''));
                              },
                              child: Text("Try Again"),
                            ),
                          ],
                        );
                      }
                      return Container(); // fallback
                    },
                  ),
                ),
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ElevatedButton(
                    //   onPressed: state is PdfPickerLoading
                    //       ? null
                    //       : () {
                    //           context.read<PdfPickerBloc>().add(PdfPickFile(''));
                    //         },
                    //   child: const Text('Upload PDF'),
                    // ),
                    const SizedBox(width: 16),
                  ],
                ),*/
                SizedBox(height: 20),
                if (_pdfFileName != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.picture_as_pdf, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _pdfFileName!,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 20),
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
            );
          },
        ),
      ),
    );
  }
}
