import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resident_app/src/constant/navigator_key.dart';

class FormatDate {
  String formatDate(date, {format = 'EEE, dd MMM yyyy', context}) {
    return DateFormat(format).format(
      DateTime.parse(date).toLocal(),
    );
  }

  String formatTime(date, context) {
    return DateFormat.jm(
            Localizations.localeOf(context ?? navigatorKey.currentContext)
                .languageCode)
        .format(
      DateTime.parse(date).toLocal(),
    );
  }

  String isTodayOrTommorow(date, context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final dateToCheck = date;
    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    String code = Localizations.localeOf(context ?? navigatorKey.currentContext)
        .languageCode;
    if (code == 'id') {
      if (aDate == today) {
        return 'Hari ini,';
      } else if (aDate == tomorrow) {
        return 'Besok,';
      } else {
        return '';
      }
    } else {
      if (aDate == today) {
        return 'Today,';
      } else if (aDate == tomorrow) {
        return 'Tomorrow,';
      } else {
        return '';
      }
    }
  }

  String formatDashboard(date, context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final dateToCheck = date;
    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (aDate == today) {
      return 'Today at ${formatDate(date.toString(), format: 'h:mm a', context: context ?? navigatorKey.currentContext)}';
    } else if (aDate == tomorrow) {
      return 'Tomorrow at ${formatDate(date.toString(), format: 'h:mm a', context: context ?? navigatorKey.currentContext)}';
    } else {
      return formatDate(date.toString(),
          context: context ?? navigatorKey.currentContext);
    }
  }
}
