abstract class PdfPickerEvent {}

class PdfPickFile extends PdfPickerEvent {
  final String filePath;

  PdfPickFile(this.filePath);
}