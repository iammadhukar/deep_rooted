class Price {
  final double price;
  final double quantity;

  Price({
    required this.price,
    required this.quantity,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}
