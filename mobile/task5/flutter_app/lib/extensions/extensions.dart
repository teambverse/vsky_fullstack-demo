import 'package:flutter/material.dart';
// lib/utils/date_extensions.dart
import 'package:intl/intl.dart';

extension AnyToFormattedDate on Object? {
  /// Formats ISO strings or DateTime into given pattern.
  /// Returns "" if null/invalid.
  String toFormattedDate({String format = "dd/MM/yyyy"}) {
    if (this == null) return "";

    try {
      DateTime dt;
      if (this is DateTime) {
        dt = (this as DateTime).toLocal();
      } else if (this is String) {
        final s = (this as String).trim();
        if (s.isEmpty) return "";
        dt = DateTime.parse(s); // parses ISO like 2025-09-02T00:00:00.000Z
        if (dt.isUtc) dt = dt.toLocal(); // make it local for display
      } else {
        return "N/A";
      }

      return DateFormat(format).format(dt);
    } catch (_) {
      return "N/A";
    }
  }
}

extension ExtendedString on String {
  // (<member definition>)*
  bool get isValidName {
    return !contains(RegExp(r'[0–9]'));
  }

  String get prefixWith {
    return '$this $this';
  }

  bool get isValidEmail {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(this);
  }

  String get capsFirst {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  int get toInt {
    return int.tryParse(this) ?? 0;
  }

  // String get toImageUrl{
  //   return "${ApiConstant.imageBaseUrl}$this";
  // }

  num? toNum() {
    return num.tryParse(this);
  }
}

extension ExtendedInt on int {}

extension DateTimeExtension on DateTime {
  bool isSameDateForIndicators(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension PaddingExtension on Widget {
  Widget withPadding({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: this,
    );
  }
}

// how to use
// Text('I am aligned at the start').alignAtStart(),
extension ExtendedAlign on Widget {
  alignAtTopRight() {
    return Align(alignment: Alignment.topRight, child: this);
  }

  alignAtStart() {
    return Align(alignment: Alignment.centerLeft, child: this);
  }

  alignAtCenter() {
    return Align(alignment: Alignment.center, child: this);
  }

  alignAtEnd() {
    return Align(alignment: AlignmentDirectional.centerEnd, child: this);
  }
}

extension GestureDetectorExtension on Widget {
  GestureDetector onTap(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: this,
    );
  }
}

extension EmptyPadding on num {
  SizedBox get pixelH => SizedBox(height: toDouble());

  SizedBox get pixelW => SizedBox(width: toDouble());
}

extension SizeExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;
}

extension DynamicToNum on dynamic {
  /// Converts a dynamic value to a [num].
  /// Returns `null` if the conversion fails.
  num? get toNum {
    if (this == null) return null;

    if (this is num) {
      return this as num;
    } else if (this is String) {
      return num.tryParse(this as String);
    } else if (this is bool) {
      return (this as bool) ? 1 : 0;
    } else {
      return null;
    }
  }

  bool isAtSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

extension TapCardExtension on Widget {
  Widget withTap({
    required VoidCallback onTap,
    double borderRadius = 12,
    Color? color,
    BoxShadow? boxShadow,
    EdgeInsetsGeometry? padding,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: color ?? Colors.grey,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: boxShadow != null ? [boxShadow] : null,
        ),
        child: this,
      ),
    );
  }
}

// lib/utils/date_extensions.dart
