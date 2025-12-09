class Validators {
  Validators._(); // private constructor

  // E-posta validator
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "E-posta boş olamaz";
    }
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value.trim())) {
      return "Geçerli bir e-posta giriniz";
    }
    return null;
  }

  // Şifre validator (minimum 6 karakter)
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Şifre boş olamaz";
    }
    if (value.length < 6) {
      return "Şifre en az 6 karakter olmalı";
    }
    return null;
  }

  // Şifre (minimum 8 + büyük harf + rakam)
  static String? strongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Şifre boş olamaz";
    }
    if (value.length < 8) {
      return "Şifre en az 8 karakter olmalı";
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "En az 1 büyük harf olmalı";
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "En az 1 rakam olmalı";
    }
    return null;
  }

  // Şifre tekrarı
  static String? passwordMatch(String? value, String original) {
    if (value == null || value.isEmpty) {
      return "Şifre tekrarı boş olamaz";
    }
    if (value != original) {
      return "Şifreler eşleşmiyor";
    }
    return null;
  }

  // Boş olamaz
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null ? "$fieldName boş olamaz" : "Bu alan boş olamaz";
    }
    return null;
  }

  // Minimum uzunluk
  static String? minLength(String? value, int min, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null ? "$fieldName boş olamaz" : "Bu alan boş olamaz";
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
    if (value == null || value.trim().isEmpty) return "Telefon boş olamaz";
    final cleaned = value.replaceAll(RegExp(r'\D'), '');
    if (cleaned.length != 10 || !cleaned.startsWith('5')) {
      return "Geçerli bir telefon numarası giriniz";
    }
    return null;
  }

  // Sadece rakam
  static String? number(String? value) {
    if (value == null || value.isEmpty) return "Sayı giriniz";
    if (int.tryParse(value) == null) return "Geçerli bir sayı giriniz";
    return null;
  }

  //sadece harf
  static String? onlyLetters(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null ? "$fieldName boş olamaz" : "Bu alan boş olamaz";
    }

    final regex = RegExp(r"^[a-zA-ZğüşöçıİĞÜŞÖÇ\s]+$");

    if (!regex.hasMatch(value.trim())) {
      return fieldName != null
          ? "$fieldName sadece harf içerebilir"
          : "Sadece harf içerebilir";
    }

    return null;
  }
}
