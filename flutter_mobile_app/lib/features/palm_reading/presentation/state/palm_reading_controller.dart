import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/repositories/palm_reading_repository.dart';
import 'palm_reading_state.dart';

class PalmReadingController extends StateNotifier<PalmReadingState> {
  PalmReadingController({required PalmReadingRepository repository})
      : _repository = repository,
        super(const PalmReadingState());

  final PalmReadingRepository _repository;

  Future<void> setImage(XFile? image) async {
    if (image == null) return;
    state = state.copyWith(
      image: image,
      clearError: true,
      clearResult: true,
      rawJson: null,
    );
  }

  Future<void> readPalm() async {
    final image = state.image;
    if (image == null) {
      state = state.copyWith(
        error: 'Please choose a clear palm photo first.',
        clearError: false,
      );
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final raw = await _repository.readPalm(image: image);
      final parsed = _decodeJson(raw);
      if (parsed == null) {
        state = state.copyWith(
          isLoading: false,
          error:
              'Unable to read the response. Check the raw response below or try another photo.',
          rawJson: raw,
        );
        return;
      }

      state = state.copyWith(
        isLoading: false,
        result: parsed,
        rawJson: raw,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        error: error.toString().replaceFirst('StateError: ', ''),
      );
    }
  }

  Map<String, dynamic>? _decodeJson(String raw) {
    try {
      var sanitized = raw.trim();
      if (sanitized.startsWith('```')) {
        sanitized = sanitized.replaceAll('```json', '').replaceAll('```', '');
      }
      final firstBrace = sanitized.indexOf('{');
      final lastBrace = sanitized.lastIndexOf('}');
      if (firstBrace != -1 && lastBrace != -1 && lastBrace > firstBrace) {
        sanitized = sanitized.substring(firstBrace, lastBrace + 1);
      }
      final decoded = jsonDecode(sanitized);
      return decoded is Map<String, dynamic> ? decoded : null;
    } catch (_) {
      return null;
    }
  }

}
