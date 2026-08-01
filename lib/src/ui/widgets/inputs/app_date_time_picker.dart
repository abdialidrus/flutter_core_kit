import 'package:flutter/material.dart';

/// Themed date/time picker helpers. Wraps the native `showDatePicker` /
/// `showTimePicker` so call sites don't repeat the same boilerplate, and so
/// styling stays centralized (Material derives the picker's look from the
/// ambient [Theme] automatically — override here only if you need to diverge
/// from that, e.g. a custom [DatePickerThemeData]).
class AppDateTimePicker {
  AppDateTimePicker._();

  static Future<DateTime?> pickDate({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    String? helpText,
  }) {
    final now = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: firstDate ?? DateTime(now.year - 5),
      lastDate: lastDate ?? DateTime(now.year + 5),
      helpText: helpText,
    );
  }

  static Future<TimeOfDay?> pickTime({
    required BuildContext context,
    TimeOfDay? initialTime,
    String? helpText,
  }) {
    return showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      helpText: helpText,
    );
  }

  /// Picks a date then a time in sequence and combines them into one
  /// [DateTime] — common for scheduling flows (e.g. driver session times).
  static Future<DateTime?> pickDateTime({
    required BuildContext context,
    DateTime? initialDateTime,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final date = await pickDate(
      context: context,
      initialDate: initialDateTime,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (date == null || !context.mounted) return null;

    final time = await pickTime(
      context: context,
      initialTime: initialDateTime != null
          ? TimeOfDay.fromDateTime(initialDateTime)
          : null,
    );
    if (time == null) return date;

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
