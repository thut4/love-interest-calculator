import 'package:image_picker/image_picker.dart';

class PalmReadingState {
  const PalmReadingState({
    this.image,
    this.isLoading = false,
    this.error,
    this.result,
    this.rawJson,
  });

  final XFile? image;
  final bool isLoading;
  final String? error;
  final Map<String, dynamic>? result;
  final String? rawJson;

  bool get hasResult => result != null;

  PalmReadingState copyWith({
    XFile? image,
    bool? isLoading,
    String? error,
    Map<String, dynamic>? result,
    String? rawJson,
    bool clearError = false,
    bool clearResult = false,
  }) {
    return PalmReadingState(
      image: image ?? this.image,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
      result: clearResult ? null : result ?? this.result,
      rawJson: rawJson ?? this.rawJson,
    );
  }
}
