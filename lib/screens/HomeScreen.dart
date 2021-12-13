import 'package:deep_rooted/provider/CryptoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                color: Colors.grey.shade400,
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Enter currency pair',
                    contentPadding: const EdgeInsets.all(8.0),
                    suffix: GestureDetector(
                      onTap: () {
                        if (_controller.text.isNotEmpty) {
                          Provider.of<CryptoProvider>(context, listen: false)
                              .getDataForCryptoPair(_controller.text);
                        }
                      },
                      child: const Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
