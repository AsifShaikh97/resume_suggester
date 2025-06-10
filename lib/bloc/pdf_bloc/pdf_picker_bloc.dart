import 'package:resume_suggester/bloc/pdf_bloc/pdf_picker_event.dart';
import 'package:resume_suggester/bloc/pdf_bloc/pdf_picker_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
class PdfPickerBloc extends Bloc<PdfPickerEvent, PdfPickerState>{
  PdfPickerBloc() : super(const PdfPickerInitial()) {
    on<PdfPickFile>((event, emit) async {
      await pickPdfFile(emit); // 👈 Pass emit here
    });
  }


  Future<String> _simulateFilePicking() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.isNotEmpty) {
      return result.files.single.name ?? '';
    } else {
      return '';
    }
  }


  Future<void> pickPdfFile(Emitter<PdfPickerState> emit) async {
    try {
      emit(const PdfPickerLoading());
      // Simulate file picking logic
      final String filePath = await _simulateFilePicking();

      if (filePath.isNotEmpty) {
        // Validate the PDF file
        if (validatePdfFile(filePath)) {
          emit(PdfPickerLoaded(filePath));
        } else {
          emit(const PdfPickerError("Invalid PDF file selected."));
        }
      } else {
        emit(const PdfPickerError("No file selected."));
      }
    } catch (e) {
      emit(PdfPickerError(e.toString()));
    }
  }

  // Example method to validate the selected PDF file
  bool validatePdfFile(String filePath) {
    // Logic to validate the PDF file
    return true; // Placeholder return value
  }

}