import 'package:deep_rooted/components/CryptoDetailWidget.dart';
import 'package:deep_rooted/model/CryptoData.dart';
import 'package:deep_rooted/provider/CryptoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                color: Colors.grey.shade300,
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Enter currency pair',
                    contentPadding: const EdgeInsets.all(8.0),
                    suffix: GestureDetector(
                      onTap: () {
                        if (_controller.text.isNotEmpty) {
                          Provider.of<CryptoProvider>(context, listen: false)
                              .getDataForcurrencyPair(_controller.text);
                        }
                      },
                      child: const Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              Selector<CryptoProvider, bool>(
                shouldRebuild: (prev, next) => prev != next,
                selector: (context, cryptoProvider) =>
                    cryptoProvider.initialState,
                builder: (context, initialState, _) {
                  if (initialState) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.search,
                            size: 150,
                            color: Colors.grey,
                          ),
                          Text("Enter a currency pair to load data"),
                        ],
                      ),
                    );
                  } else {
                    return Selector<CryptoProvider, bool>(
                      shouldRebuild: (prev, next) => prev != next,
                      selector: (context, cryptoProvider) =>
                          cryptoProvider.fetchingCryptoData,
                      builder: (context, fetchingCryptoData, _) {
                        if (fetchingCryptoData) {
                          return const CircularProgressIndicator();
                        } else {
                          return Selector<CryptoProvider, CryptoData?>(
                            shouldRebuild: (prev, next) => true,
                            selector: (context, cryptoProvider) =>
                                cryptoProvider.cryptoData,
                            builder: (copntxt, cryptoData, _) {
                              if (cryptoData == null) {
                                return const Text("No Data Found");
                              } else {
                                return CryptoDetailWidget(
                                    cryptoData: cryptoData);
                              }
                            },
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Provider.of<CryptoProvider>(context,listen:false).get
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
