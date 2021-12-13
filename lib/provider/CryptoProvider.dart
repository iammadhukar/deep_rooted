import 'dart:convert';

import 'package:deep_rooted/model/CryptoData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CryptoProvider extends ChangeNotifier {
  CryptoProvider();
  static const String dataUrl = 'https://www.bitstamp.net/api/ticker/';

  CryptoData? _cryptoData;
  CryptoData? get cryptoData => _cryptoData;

  Future<CryptoData?> getDataForCryptoPair(String cryptoPair) async {
    _cryptoData = null;
    final response = await http.get(Uri.parse('$dataUrl+$cryptoPair'));
    if (response.statusCode == 200) {
      _cryptoData = CryptoData.fromJson(jsonDecode(response.body), cryptoPair);
    }
    print("hjhjhjhjhjhj ${_cryptoData?.highPrice}");
    notifyListeners();
  }
}
