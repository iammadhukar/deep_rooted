import 'Price.dart';

class OrderBook {
  final List<Price> bidPrices;
  final List<Price> askPrices;

  OrderBook(this.bidPrices, this.askPrices);

  factory OrderBook.fromJson(Map<String, dynamic> json) {
    List<Price> bidPrice = [];
    List<Price> askPrice = [];

    json['bids']?.forEach((element) {
      bidPrice.add(
        Price(price: element[0], quantity: element[1]),
      );
    });
    json['asks']?.forEach((element) {
      askPrice.add(
        Price(price: element[0], quantity: element[1]),
      );
    });

    return OrderBook(
      bidPrice,
      askPrice,
    );
  }
}
