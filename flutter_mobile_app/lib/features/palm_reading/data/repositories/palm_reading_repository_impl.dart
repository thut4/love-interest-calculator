import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../domain/repositories/palm_reading_repository.dart';

class PalmReadingRepositoryImpl implements PalmReadingRepository {
  PalmReadingRepositoryImpl({http.Client? client})
    : _client = client ?? http.Client();

  static const String _defaultModel = 'gemini-2.0-flash';
  static const String _prompt =
      '''You are an expert palm reader blending Indian, Chinese, and Western palmistry.
Return valid JSON only.
Keep the full response concise and complete.
Use short descriptions and single-sentence readings.
Include at most 4 items in "lines".
Include at most 2 items in "mounts".
If the image is not a palm, still return the same JSON shape with brief fallback text.

Use exactly this JSON format:
{
  "overall_energy": "Short mystical summary",
  "hand_type": {
    "element": "Earth | Air | Fire | Water",
    "description": "Brief hand type meaning"
  },
  "lines": [
    {
      "name": "Heart Line",
      "visibility": "clear | faint | not_visible",
      "reading": "Short reading",
      "trait": "One-word trait"
    }
  ],
  "mounts": [
    {
      "name": "Mount of Venus",
      "prominence": "strong | moderate | flat",
      "reading": "Short reading"
    }
  ],
  "life_areas": {
    "love": "Short guidance",
    "career": "Short guidance",
    "health": "Short guidance",
    "destiny": "Short guidance"
  },
  "special_markings": "Short note or None",
  "closing_message": "Short empowering close",
  "confidence_note": "Brief entertainment disclaimer"
}''';

  final http.Client _client;

  @override
  Future<String> readPalm({required XFile image}) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      throw StateError('Missing GEMINI_API_KEY.');
    }

    final bytes = await image.readAsBytes();
    final mimeType = _resolveMimeType(image.path);
    final model = _resolveModel(dotenv.env['GEMINI_MODEL']);

    _logInfo('Gemini model: $model');

    final uri = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/'
      '$model:generateContent?key=$apiKey',
    );

    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'role': 'user',
            'parts': [
              {'text': _prompt},
              {
                'inlineData': {
                  'mimeType': mimeType,
                  'data': base64Encode(bytes),
                },
              },
            ],
          },
        ],
        'generationConfig': {
          'temperature': 0.4,
          'maxOutputTokens': 12000,
          'responseMimeType': 'application/json',
          'responseSchema': {
            'type': 'object',
            'properties': {
              'overall_energy': {'type': 'string'},
              'hand_type': {
                'type': 'object',
                'properties': {
                  'element': {'type': 'string'},
                  'description': {'type': 'string'},
                },
                'required': ['element', 'description'],
              },
              'lines': {
                'type': 'array',
                'items': {
                  'type': 'object',
                  'properties': {
                    'name': {'type': 'string'},
                    'visibility': {'type': 'string'},
                    'reading': {'type': 'string'},
                    'trait': {'type': 'string'},
                  },
                  'required': ['name', 'visibility', 'reading', 'trait'],
                },
              },
              'mounts': {
                'type': 'array',
                'items': {
                  'type': 'object',
                  'properties': {
                    'name': {'type': 'string'},
                    'prominence': {'type': 'string'},
                    'reading': {'type': 'string'},
                  },
                  'required': ['name', 'prominence', 'reading'],
                },
              },
              'life_areas': {
                'type': 'object',
                'properties': {
                  'love': {'type': 'string'},
                  'career': {'type': 'string'},
                  'health': {'type': 'string'},
                  'destiny': {'type': 'string'},
                },
                'required': ['love', 'career', 'health', 'destiny'],
              },
              'special_markings': {'type': 'string'},
              'closing_message': {'type': 'string'},
              'confidence_note': {'type': 'string'},
            },
            'required': [
              'overall_energy',
              'hand_type',
              'lines',
              'mounts',
              'life_areas',
              'special_markings',
              'closing_message',
              'confidence_note',
            ],
          },
        },
      }),
    );

    _logResponse(response.statusCode, response.body);

    if (response.statusCode != 200) {
      final payload = _tryDecode(response.body);
      final message = payload?['error']?['message']?.toString();
      throw StateError(
        message?.isNotEmpty == true
            ? message!
            : 'Gemini request failed (${response.statusCode}).',
      );
    }

    final decoded = _tryDecode(response.body);
    final finishReason = decoded?['candidates']?[0]?['finishReason']
        ?.toString();
    _logInfo('Finish reason: ${finishReason ?? 'unknown'}');

    final parts = decoded?['candidates']?[0]?['content']?['parts'];
    final text = _joinParts(parts);
    if (text == null || text.trim().isEmpty) {
      throw StateError('Empty response from Gemini.');
    }

    if (finishReason == 'MAX_TOKENS') {
      throw StateError(
        'Gemini returned HTTP 200, but the reading was cut off before the JSON finished.',
      );
    }

    return text.trim();
  }

  String _resolveMimeType(String path) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    return 'image/jpeg';
  }

  String _resolveModel(String? raw) {
    final value = (raw ?? '').trim();
    if (value.isEmpty) return _defaultModel;
    return value.startsWith('models/') ? value.substring(7) : value;
  }

  Map<String, dynamic>? _tryDecode(String body) {
    try {
      final decoded = jsonDecode(body);
      return decoded is Map<String, dynamic> ? decoded : null;
    } catch (_) {
      return null;
    }
  }

  String? _joinParts(dynamic parts) {
    if (parts is! List) return null;
    final buffer = StringBuffer();
    for (final part in parts) {
      final text = part is Map<String, dynamic> ? part['text'] : null;
      if (text is String) {
        if (buffer.isNotEmpty) buffer.write('\n');
        buffer.write(text);
      }
    }
    final result = buffer.toString().trim();
    return result.isEmpty ? null : result;
  }

  void _logInfo(String message) {
    // ignore: avoid_print
    print('[PalmReading] $message');
  }

  void _logResponse(int status, String body) {
    final safeBody = body.length > 2000 ? body.substring(0, 2000) : body;
    _logInfo('Response status: $status');
    _logInfo('Response body (first 2000 chars): $safeBody');
  }
}
