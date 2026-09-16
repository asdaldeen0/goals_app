class AppDateFormatter {
  static const List<String> arabicMonths = [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];

  static String formatRange(DateTime start, DateTime end) {
    final String startMonth = arabicMonths[start.month - 1];
    final String endMonth = arabicMonths[end.month - 1];

    if (start.year == end.year) {
      return '\u200F${start.day} $startMonth  ←  ${end.day} $endMonth';
    }
    return '\u200F${start.day} $startMonth ${start.year}  ←  ${end.day} $endMonth ${end.year}';
  }

  static String formatSingleDate(DateTime date) {
    return '${date.day} ${arabicMonths[date.month - 1]} ${date.year}';
  }

  static String getTodayFormatted() {
    return formatSingleDate(DateTime.now());
  }

  static String getRemainingDaysText(int days) {
    if (days == 0) {
      return 'ينتهي اليوم';
    } else if (days == 1) {
      return 'باقي يوم واحد';
    } else if (days == 2) {
      return 'باقي يومان';
    } else if (days >= 3 && days <= 10) {
      return 'باقي $days أيام';
    } else {
      return 'باقي $days يوماً';
    }
  }

  static int calculateDurationInDays(DateTime start, DateTime end) {
    return end.difference(start).inDays + 1;
  }
}
