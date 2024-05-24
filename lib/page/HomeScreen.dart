import 'package:flutter/material.dart';
import 'package:stonk_app/components/button.dart';
import 'package:stonk_app/page/order.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _funds = 100;
  DateTime startDate = DateTime(2023, 1, 1);
  DateTime endDate = DateTime(2023, 1, 7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Text(
            'Capital: ${_funds}W',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),

          const SizedBox(height: 5),

          // 資金條設定
          Slider(
            value: _funds,
            max: 1000,
            min: 0,
            divisions: 2000,
            label: '${_funds}W',
            onChanged: (double value) {
              setState(() {
                _funds = value;
              });
            },
          ),

          const SizedBox(height: 30),

          //display the time
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Start Date: ${startDate.year}年 ${startDate.month}月 ${startDate.day}日',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              const SizedBox(width: 25),
              Center(
                child: Text(
                  'End Date: ${endDate.year}年 ${endDate.month}月 ${endDate.day}日',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
              )
            ],
          ),

          const SizedBox(height: 25),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //select start date button
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
                    lastDate: endDate.subtract(Duration(days: 1)),
                  ).then((newDate) {
                    if (newDate != null) {
                      setState(() {
                        startDate = newDate;
                      });
                    }
                  });
                },
              ),

              const SizedBox(height: 20),

              //select end date button
              CustButton(
                btnColor: Colors.red,
                btnText: const Text(
                  'Select End Date',
                  style: TextStyle(fontSize: 18),
                ),
                btnHeight: 45,
                btnWidth: 200,
                pressAction: () {
                  showDatePicker(
                    context: context,
                    initialDate: endDate,
                    firstDate: startDate.add(Duration(days: 1)),
                    lastDate: DateTime(2023, 12, 31),
                  ).then((newDate) {
                    if (newDate != null) {
                      setState(() {
                        endDate = newDate;
                      });
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderPage()));
            },
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 30)),
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
