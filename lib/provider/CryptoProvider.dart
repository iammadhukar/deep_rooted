import 'dart:convert';

import 'package:deep_rooted/model/CryptoData.dart';
import 'package:deep_rooted/model/OrderBook.dart';
import 'package:deep_rooted/model/Price.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CryptoProvider extends ChangeNotifier {
  CryptoProvider();
  static const String dataUrl = 'https://www.bitstamp.net/api/ticker/';
  static const String orderBookUrl = 'https://www.bitstamp.net/api/order_book/';

  CryptoData? _cryptoData;
  CryptoData? get cryptoData => _cryptoData;
  List<Price>? _bidPrice;
  List<Price>? get bidPrice => _bidPrice;
  List<Price>? _askPrice;
  List<Price>? get askPrice => _askPrice;
  bool _fetchingCryptoData = false;
  bool get fetchingCryptoData => _fetchingCryptoData;
  bool _initialState = true;
  bool get initialState => _initialState;

  Future<CryptoData?> getDataForcurrencyPair(String currencyPair) async {
    _fetchingCryptoData = true;
    _initialState = false;
    _cryptoData = null;
    notifyListeners();
    final response = await http.get(Uri.parse('$dataUrl+$currencyPair'));
    if (response.statusCode == 200) {
      _cryptoData =
          CryptoData.fromJson(jsonDecode(response.body), currencyPair);
    }
    _fetchingCryptoData = false;
    notifyListeners();
  }

  getOrderBookForPair(String currencyPair) async {
    _bidPrice = null;
    _askPrice = null;
    notifyListeners();
    final response = await http.get(Uri.parse('$orderBookUrl+$currencyPair'));
    if (response.statusCode == 200) {
      if (bidPrice == null) {
        _bidPrice = [];
      }
      jsonDecode(response.body)['bids'].forEach((element) {
        _bidPrice!.add(Price(
            price: double.parse(element[0]),
            quantity: double.parse(element[1])));
      });
      if (askPrice == null) {
        _askPrice = [];
      }
      jsonDecode(response.body)['asks'].forEach((element) {
        _askPrice!.add(Price(
            price: double.parse(element[0]),
            quantity: double.parse(element[1])));
      });
    }
    bidPrice!.sort((a, b) => a.price.compareTo(b.price));
    if (bidPrice!.isNotEmpty) {
      bidPrice!.sort((a, b) => a.price.compareTo(b.price));
    }
    if (askPrice!.isNotEmpty) {
      askPrice!.sort((a, b) => a.price.compareTo(b.price));
    }
    notifyListeners();
  }
}
