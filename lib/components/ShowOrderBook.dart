import 'package:deep_rooted/model/Price.dart';
import 'package:deep_rooted/provider/CryptoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowOrderBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ORDER BOOK',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Selector<CryptoProvider, List<Price>?>(
                shouldRebuild: (prev, next) => true,
                selector: (context, provider) => provider.bidPrice,
                builder: (context, bidPrices, _) {
                  if (bidPrices != null) {
                    return SizedBox(
                      width: (MediaQuery.of(context).size.width - 32) * 0.5,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return const Text("BID PRICE");
                                } else {
                                  return Text(bidPrices[index]
                                      .price
                                      .toStringAsFixed(2)
                                      .toString());
                                }
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 10);
                              },
                              itemCount: 6,
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return const Text("QTY");
                                } else {
                                  return Text(
                                      bidPrices[index].quantity.toString());
                                }
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 10);
                              },
                              itemCount: 6,
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              Selector<CryptoProvider, List<Price>?>(
                shouldRebuild: (prev, next) => true,
                selector: (context, provider) => provider.askPrice,
                builder: (context, askPrice, _) {
                  if (askPrice != null) {
                    return SizedBox(
                      width: (MediaQuery.of(context).size.width - 32) * 0.5,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return const Text("QTY");
                                } else {
                                  return Text(
                                      askPrice[index].quantity.toString());
                                }
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 10);
                              },
                              itemCount: 6,
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return const Text("ASK PRICE");
                                } else {
                                  return Text(askPrice[index]
                                      .price
                                      .toStringAsFixed(2)
                                      .toString());
                                }
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 10);
                              },
                              itemCount: 6,
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
