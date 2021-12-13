class CryptoData {
  final String name;
  final DateTime timeStamp;
  final double openPrice;
  final double highPrice;
  final double lowPrice;
  final double lastPrice;
  final double volume;

  CryptoData({
    required this.name,
    required this.timeStamp,
    required this.openPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.lastPrice,
    required this.volume,
  });

  factory CryptoData.fromJson(Map<String, dynamic> json, String name) {
    return CryptoData(
      name: name,
      timeStamp:
          DateTime.fromMillisecondsSinceEpoch(int.parse(json['timestamp'])),
      openPrice: json['open'],
      highPrice: double.parse(json['high']),
      lowPrice: double.parse(json['low']),
      lastPrice: double.parse(json['last']),
      volume: double.parse(json['volume']),
    );
  }
}
