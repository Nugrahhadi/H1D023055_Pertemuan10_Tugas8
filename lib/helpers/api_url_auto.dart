import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiUrl {
  // Auto-detect platform dan gunakan base URL yang sesuai
  static String get baseUrl {
    if (kIsWeb) {
      // Web (Chrome, Firefox, dll)
      return 'http://localhost:8080';
    } else if (Platform.isAndroid) {
      // Android Emulator
      return 'http://10.0.2.2:8080';
    } else if (Platform.isIOS) {
      // iOS Simulator
      return 'http://localhost:8080';
    } else {
      // Default (Desktop, dll)
      return 'http://localhost:8080';
    }
  }

  static String get registrasi => baseUrl + '/registrasi';
  static String get login => baseUrl + '/login';
  static String get listProduk => baseUrl + '/produk';
  static String get createProduk => baseUrl + '/produk';

  static String updateProduk(int id) {
    return baseUrl + '/produk/' + id.toString();
  }

  static String showProduk(int id) {
    return baseUrl + '/produk/' + id.toString();
  }

  static String deleteProduk(int id) {
    return baseUrl + '/produk/' + id.toString();
  }
}
