abstract class PdfPickerState {
  const PdfPickerState();
}

class PdfPickerInitial extends PdfPickerState {
  const PdfPickerInitial();
}

class PdfPickerLoading extends PdfPickerState {
  const PdfPickerLoading();
}

class PdfPickerLoaded extends PdfPickerState {
  final String filePath;

  const PdfPickerLoaded(this.filePath);
}

class PdfPickerError extends PdfPickerState {
  final String message;

  const PdfPickerError(this.message);
}