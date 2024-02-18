import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _currentValue = 100;
  DateTime selectDate = DateTime(2023, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          'Capital: ${_currentValue}W',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        const SizedBox(
          height: 5,
        ),
        // 資金條設定
        Slider(
            value: _currentValue,
            max: 1000,
            min: 0,
            divisions: 2000,
            label: '${_currentValue}W',
            onChanged: (double value) {
              setState(() {
                _currentValue = value;
              });
            }),
        const SizedBox(
          height: 30,
        ),
        Text(
          'Date: $selectDate',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        const SizedBox(
          height: 5,
        ),
        CalendarDatePicker(
            initialDate: DateTime(2023, 1),
            firstDate: DateTime(2000, 1),
            lastDate: DateTime(2023, 12),
            onDateChanged: (newDate) {
              setState(() {
                selectDate = newDate;
              });
            }),
        GestureDetector(
            onTap: () {
              ;
            },
            child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(218, 3, 121, 255),
                    borderRadius: BorderRadius.circular(8)),
                child: const Center(
                    child: Text(
                  'Enter The Game',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )))),
      ],
    ));
  }
}
