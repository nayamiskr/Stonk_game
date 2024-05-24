import 'package:flutter/material.dart';
import 'package:stonk_app/components/button.dart';
import 'package:stonk_app/components/textinput.dart';
import 'package:stonk_app/features/gethttp.dart';

import 'HomePage.dart';

class OrderPage extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  const OrderPage({super.key, required this.startDate, required this.endDate});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final stockCODE = TextEditingController();
  String imageUrl = ' ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("下單"),
        ),
        body: Center(
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text('購買股票',
                      style: TextStyle(
                        fontSize: 30,
                      ))),
              TextInput(
                controller: stockCODE,
                hintText: 'Input the code of stock',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                  onTap: () async {
                    final url = await getImage(
                        stockCODE.text, widget.startDate, widget.endDate);
                    setState(() {
                      imageUrl = url;
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(218, 3, 121, 255),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                          child: Text(
                        'Search',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )))),
              if (imageUrl != ' ') Image.network(imageUrl),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: CustButton(
                        btnColor: Colors.green,
                        btnText: const Text(
                          'Buy',
                          style: TextStyle(fontSize: 15),
                        ),
                        btnHeight: 30,
                        btnWidth: 100,
                        pressAction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Account()),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: CustButton(
                        btnColor: Colors.red,
                        btnText: const Text(
                          'Sell',
                          style: TextStyle(fontSize: 15),
                        ),
                        btnHeight: 30,
                        btnWidth: 100,
                        pressAction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Account()),
                          );
                        }),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
