import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/calculate_saju_profile.dart';
import 'saju_profile_state.dart';

class SajuProfileController extends StateNotifier<SajuProfileState> {
  SajuProfileController(this._calculateSajuProfile)
    : super(const SajuProfileState());

  final CalculateSajuProfile _calculateSajuProfile;

  void setBirthDate(DateTime date) {
    state = state.copyWith(
      birthDate: _dateOnly(date),
      clearProfile: true,
      clearError: true,
    );
  }

  void setBirthTime(TimeOfDay time) {
    state = state.copyWith(
      birthTime: time,
      clearProfile: true,
      clearError: true,
    );
  }

  void setBirthCity(String city) {
    state = state.copyWith(
      birthCity: city,
      clearProfile: true,
      clearError: true,
    );
  }

  void setBirthCountry(String country) {
    state = state.copyWith(
      birthCountry: country,
      clearProfile: true,
      clearError: true,
    );
  }

  void calculate() {
    if (!state.canCalculate) {
      state = state.copyWith(
        errorMessage:
            'Please enter full birth date, exact birth time, and birth city/country.',
      );
      return;
    }

    final date = state.birthDate!;
    final time = state.birthTime!;
    final birthMoment = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    if (birthMoment.isAfter(DateTime.now())) {
      state = state.copyWith(
        errorMessage: 'Birth date/time cannot be in the future.',
      );
      return;
    }

    final profile = _calculateSajuProfile(
      birthDate: date,
      birthHour: time.hour,
      birthMinute: time.minute,
      birthCity: state.birthCity.trim(),
      birthCountry: state.birthCountry.trim(),
    );

    state = state.copyWith(profile: profile, clearError: true);
  }

  DateTime _dateOnly(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }
}
