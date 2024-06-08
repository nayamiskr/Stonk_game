import 'package:flutter/material.dart';
import 'package:stonk_app/components/button.dart';
import 'package:stonk_app/page/order.dart';

import '../components/textinput.dart';
import '../features/gethttp.dart';

class HomeScreen extends StatefulWidget {
  final int money;

  const HomeScreen({super.key, required this.money});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime startDate = DateTime(2023, 1, 1);
  final buyPrice = TextEditingController();
  final bSell = TextEditingController();
  final stockCODE = TextEditingController();
  String imageUrl = ' ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),

          //display the time
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.wallet,
                    size: 50,
                  ),
                  Text(': ${widget.money}NTD', style: TextStyle(fontSize: 40))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Start Date: ${startDate.year}年 ${startDate.month}月 ${startDate.day}日',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustButton(
                btnText: const Text(
                  'Select Start Date',
                  style: TextStyle(fontSize: 18),
                ),
                btnColor: Colors.green,
                btnHeight: 45,
                btnWidth: 200,
                pressAction: () {
                  showDatePicker(
                    context: context,
                    initialDate: startDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  ).then((newDate) {
                    if (newDate != null) {
                      setState(() {
                        startDate = newDate;
                      });
                    }
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextInput(
                  controller: stockCODE,
                  hintText: "Enter The Code",
                  obscureText: false),
              const SizedBox(
                height: 20,
              ),
              CustButton(
                btnText: const Text(
                  'Get Graph',
                  style: TextStyle(fontSize: 18),
                ),
                btnColor: Colors.blue,
                btnHeight: 45,
                btnWidth: 200,
                pressAction: () async {
                  final url = await getImage(
                    stockCODE.text,
                    startDate,
                    startDate.add(const Duration(days: 3)),
                  );
                  setState(() {
                    imageUrl = url;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              if (imageUrl != ' ') Image.network(imageUrl),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                      child: FractionallySizedBox(
                    widthFactor: 0.8,
                    child: TextField(
                      controller: buyPrice,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter The Price",
                          hintStyle: TextStyle(
                            fontSize: 20,
                          )),
                      textAlign: TextAlign.center,
                    ),
                  )),
                  Flexible(
                      child: FractionallySizedBox(
                    widthFactor: 0.8,
                    child: TextField(
                      controller: bSell,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Sell Number",
                          hintStyle: TextStyle(
                            fontSize: 20,
                          )),
                      textAlign: TextAlign.center,
                    ),
                  )),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderPage(
                            startDate: startDate,
                            buyPrice: int.parse(buyPrice.text),
                            sBuy: int.parse(bSell.text),
                          )));
            },
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
            child: const Text(
              'Enter The Game',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
