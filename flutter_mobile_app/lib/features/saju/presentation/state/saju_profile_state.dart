import 'package:flutter/material.dart';

import '../../domain/entities/saju_profile.dart';

class SajuProfileState {
  const SajuProfileState({
    this.birthDate,
    this.birthTime,
    this.birthCity = '',
    this.birthCountry = '',
    this.profile,
    this.errorMessage,
  });

  final DateTime? birthDate;
  final TimeOfDay? birthTime;
  final String birthCity;
  final String birthCountry;
  final SajuProfile? profile;
  final String? errorMessage;

  bool get canCalculate {
    return birthDate != null &&
        birthTime != null &&
        birthCity.trim().isNotEmpty &&
        birthCountry.trim().isNotEmpty;
  }

  SajuProfileState copyWith({
    DateTime? birthDate,
    TimeOfDay? birthTime,
    String? birthCity,
    String? birthCountry,
    SajuProfile? profile,
    String? errorMessage,
    bool clearProfile = false,
    bool clearError = false,
  }) {
    return SajuProfileState(
      birthDate: birthDate ?? this.birthDate,
      birthTime: birthTime ?? this.birthTime,
      birthCity: birthCity ?? this.birthCity,
      birthCountry: birthCountry ?? this.birthCountry,
      profile: clearProfile ? null : (profile ?? this.profile),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
