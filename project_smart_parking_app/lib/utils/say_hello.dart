import 'package:intl/intl.dart';

String getTimeBasedGreeting() {var now = DateTime.now();
var hour = now.hour;

if (hour < 12) {
  return 'Good Morning';
} else if (hour < 18) {
  return 'Good Afternoon';
} else {
  return 'Good Evening';
}
}
