import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class HashingPassword {
  static String hashPassword(String password, String salt) {
    final passwordSalt = password + salt;
    final bytes = utf8.encode(passwordSalt);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  static bool verifyPassword(
      String password, String hashedPassword, String salt) {
    final hashedEnteredPassword = hashPassword(password, salt);
    return hashedEnteredPassword == hashedPassword;
  }

  static String generateSalt([int length = 16]) {
    final secureRandom = Random.secure();
    final List<int> saltBytes =
        List<int>.generate(length, (i) => secureRandom.nextInt(256));
    return base64Url.encode(saltBytes);
  }
}
