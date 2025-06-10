import 'package:flutter/material.dart';
import 'package:resume_suggester/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/pdf_bloc/pdf_picker_bloc.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<PdfPickerBloc>(create: (_) => PdfPickerBloc()),
      ],
      child: MaterialApp(
        title: 'Resume Suggester',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: HomeScreen(),
      ),
    );
  }
}

