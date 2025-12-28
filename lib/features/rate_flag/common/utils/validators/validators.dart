import 'package:rate_flag/features/rate_flag/common/constants/text_constant.dart';

class Validators {
  Validators._(); // private constructor

  // E-posta validator
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return TextConstants.emailEmpty;
    }
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value.trim())) {
      return TextConstants.emailInvalid;
    }
    return null;
  }

  // Şifre validator (minimum 6 karakter)
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return TextConstants.passwordEmpty;
    }
    if (value.length < 6) {
      return TextConstants.passwordMin6;
    }
    return null;
  }

  // Şifre (minimum 8 + büyük harf + rakam)
  static String? strongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return TextConstants.passwordEmpty;
    }
    if (value.length < 8) {
      return TextConstants.passwordMin8;
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return TextConstants.passwordUppercase;
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return TextConstants.passwordDigit;
    }
    return null;
  }

  // Şifre tekrarı
  static String? passwordMatch(String? value, String original) {
    if (value == null || value.isEmpty) {
      return TextConstants.passwordRepeatEmpty;
    }
    if (value != original) {
      return TextConstants.passwordMismatch;
    }
    return null;
  }

  // Boş olamaz
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null ? "$fieldName " : TextConstants.requiredField;
    }
    return null;
  }

  // Minimum uzunluk
  static String? minLength(String? value, int min, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null ? "$fieldName " : TextConstants.requiredField;
    }
    if (value.trim().length < min) {
      return fieldName != null
          ? "$fieldName en az $min karakter olmalı"
          : "En az $min karakter olmalı";
    }
    return null;
  }

  // Telefon (Türkiye formatı)
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return TextConstants.phoneEmpty;
    final cleaned = value.replaceAll(RegExp(r'\D'), '');
    if (cleaned.length != 10 || !cleaned.startsWith('5')) {
      return TextConstants.phoneInvalid;
    }
    return null;
  }

  // Sadece rakam
  static String? number(String? value) {
    if (value == null || value.isEmpty) return TextConstants.numberEmpty;
    if (int.tryParse(value) == null) return TextConstants.numberInvalid;
    return null;
  }

  //sadece harf
  static String? onlyLetters(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null ? "$fieldName " : TextConstants.requiredField;
    }

    final regex = RegExp(r"^[a-zA-ZğüşöçıİĞÜŞÖÇ\s]+$");

    if (!regex.hasMatch(value.trim())) {
      return fieldName != null
          ? "$fieldName ${TextConstants.lettersOnly}"
          : TextConstants.lettersOnly;
    }

    return null;
  }

  ///date
  static String? date(String? value) {
    if (value == null || value.isEmpty) {
      return TextConstants.dateEmpty;
    }

    try {
      DateTime.parse(value);
      return null;
    } catch (_) {
      return TextConstants.dateInvalid;
    }
  }
}
