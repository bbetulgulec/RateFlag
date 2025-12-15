import 'package:cloud_firestore/cloud_firestore.dart';

class Calculateage {
  int calculateAge(dynamic birthDate) {
    DateTime date;
    if (birthDate is Timestamp) {
      date = birthDate.toDate();
    } else if (birthDate is String) {
      date = DateTime.parse(birthDate);
    } else if (birthDate is DateTime) {
      date = birthDate;
    } else {
      throw Exception("Invalid birthDate type");
    }

    final now = DateTime.now();
    int age = now.year - date.year;
    if (now.month < date.month ||
        (now.month == date.month && now.day < date.day)) {
      age--;
    }
    return age;
  }
}
