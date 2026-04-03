import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/tarot_card.dart';
import '../../domain/repositories/tarot_reading_repository.dart';

class TarotReadingRepositoryImpl implements TarotReadingRepository {
  TarotReadingRepositoryImpl({http.Client? client})
    : _client = client ?? http.Client();

  static const String _defaultModel = 'gemini-2.0-flash';
  static const List<String> _positions = ['Your Card'];
  static const String _systemPrompt = '''
You are an expert Tarot card reader with deep knowledge of Rider-Waite,
Thoth, and traditional Tarot symbolism.

TONE: Mystical, warm, poetic, and empowering. Never alarming or fatalistic.
Speak directly to the person as "you".

OUTPUT RULE: Return valid JSON only. No markdown, no extra text outside JSON.
Keep the reading concise, complete, and emotionally rich.
''';

  final http.Client _client;

  @override
  Future<String> readSpread({required List<TarotCard> cards}) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    if (apiKey.isEmpty) {
      throw StateError('Missing GEMINI_API_KEY.');
    }

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
              {'text': _systemPrompt},
              {'text': _buildPrompt(cards)},
            ],
          },
        ],
        'generationConfig': {
          'temperature': 0.7,
          'maxOutputTokens': 10000,
          'responseMimeType': 'application/json',
          'responseSchema': {
            'type': 'object',
            'properties': {
              'spread_name': {'type': 'string'},
              'overall_theme': {'type': 'string'},
              'cards': {
                'type': 'array',
                'items': {
                  'type': 'object',
                  'properties': {
                    'position': {'type': 'string'},
                    'card_name': {'type': 'string'},
                    'orientation': {'type': 'string'},
                    'keywords': {'type': 'string'},
                    'meaning': {'type': 'string'},
                    'advice': {'type': 'string'},
                  },
                  'required': [
                    'position',
                    'card_name',
                    'orientation',
                    'keywords',
                    'meaning',
                    'advice',
                  ],
                },
              },
              'combination_message': {'type': 'string'},
              'life_areas': {
                'type': 'object',
                'properties': {
                  'love': {'type': 'string'},
                  'career': {'type': 'string'},
                  'spirituality': {'type': 'string'},
                },
                'required': ['love', 'career', 'spirituality'],
              },
              'action_to_take': {'type': 'string'},
              'closing_message': {'type': 'string'},
              'confidence_note': {'type': 'string'},
            },
            'required': [
              'spread_name',
              'overall_theme',
              'cards',
              'combination_message',
              'life_areas',
              'action_to_take',
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
      throw StateError('Tarot reading was cut off before the JSON finished.');
    }

    return text.trim();
  }

  String _buildPrompt(List<TarotCard> cards) {
    final cardLines = cards
        .asMap()
        .entries
        .map(
          (entry) =>
              '- ${_positions.isNotEmpty && entry.key < _positions.length ? _positions[entry.key] : 'Card'}: ${entry.value.name} '
              '(${entry.value.isReversed ? 'Reversed' : 'Upright'})',
        )
        .join('\n');

    return '''
The user has drawn a single Tarot card from the Major Arcana. Give a focused single-card reading.

Card drawn:
$cardLines

Return ONLY this JSON with no extra text:
{
  "spread_name": "Name of this reading type",
  "overall_theme": "The overarching theme in 2-3 sentences",
  "cards": [
    {
      "position": "Position name",
      "card_name": "Card name",
      "orientation": "Upright or Reversed",
      "keywords": "3 keywords for this card, comma separated",
      "meaning": "What this card means for the user right now in 2-3 sentences",
      "advice": "Practical spiritual advice from this card in 1-2 sentences"
    }
  ],
  "combination_message": "How this card profoundly connects to the user's current situation in 3-4 sentences",
  "life_areas": {
    "love": "What the card reveals about love in 2 sentences",
    "career": "What the card reveals about career in 2 sentences",
    "spirituality": "What the card reveals about spiritual growth in 2 sentences"
  },
  "action_to_take": "One clear action or mindset shift the person should embrace",
  "closing_message": "A warm poetic personal message based on the card in 2-3 sentences",
  "confidence_note": "A gentle reminder this is for reflection and entertainment"
}
''';
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
    print('[Tarot] $message');
  }

  void _logResponse(int status, String body) {
    final safeBody = body.length > 2000 ? body.substring(0, 2000) : body;
    _logInfo('Response status: $status');
    _logInfo('Response body (first 2000 chars): $safeBody');
  }
}
