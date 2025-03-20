import 'package:intl/intl.dart';

String timeFormat(DateTime time) {
  return DateFormat('hh:mm a').format(time);
}
