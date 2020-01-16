import 'package:intl/intl.dart';

class DateBloc {
  getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("yyyy-MM-ddThh:mm:ss").format(now);
    return formattedDate;
  }
}

final dateBloc = DateBloc();