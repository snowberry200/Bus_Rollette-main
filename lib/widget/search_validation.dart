import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchValidation {
  SearchValidation._();

  static void showProgress(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  static void showSuccess(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.green),
      );
    }
  }

  static void showError(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }

  static CircularProgressIndicator showProgressiveBar() {
    return const CircularProgressIndicator(
      strokeCap: StrokeCap.square,
      backgroundColor: CupertinoColors.darkBackgroundGray,
      valueColor: AlwaysStoppedAnimation<Color>(CupertinoColors.systemBlue),
      strokeWidth: 5.0,
    );
  }

  // FIXED: This should return true when validation passes
  static bool validateSearch({
    required BuildContext context,
    required String? fromCity,
    required String? toCity,
    required DateTime? departureDate,
  }) {
    // Validate fromCity
    if (fromCity == null || fromCity.isEmpty) {
      showError(context, "Please select a departure city.");
      return false;
    }

    // Validate toCity
    if (toCity == null || toCity.isEmpty) {
      showError(context, "Please select a destination city.");
      return false;
    }

    // Validate cities are not the same
    if (fromCity == toCity) {
      showError(
        context,
        "Departure and destination cities cannot be the same.",
      );
      return false;
    }

    // Validate departureDate
    if (departureDate == null) {
      showError(context, "Please select a departure date.");
      return false;
    }

    // Validate date is not in the past
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDate = DateTime(
      departureDate.year,
      departureDate.month,
      departureDate.day,
    );

    if (selectedDate.isBefore(today)) {
      showError(context, "Please select a future date.");
      return false;
    }

    // If all validations pass, return true
    return true;
  }
}
