import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// Format this DateTime with [outputFormat].
  ///
  /// [convertToLocal] = true will apply `.toLocal()`.
  ///   - Use true if your server sends UTC (with `Z`).
  ///   - Use false if server already sends local times.
  String format(String outputFormat, {bool convertToLocal = false}) {
    final dt = convertToLocal ? toLocal() : this;
    final formatter = DateFormat(outputFormat);
    return formatter.format(dt);
  }
}
