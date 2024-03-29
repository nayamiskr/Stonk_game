import 'package:flutter/material.dart';
import 'package:stonk_app/components/textinput.dart';
import 'package:stonk_app/features/gethttp.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final stockCODE = TextEditingController();
  String imageUrl = ' ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextInput(
            controller: stockCODE,
            hintText: 'Input the code of stock',``
            obscureText: false,
          ),
          const SizedBox(height: 20),
          GestureDetector(
              onTap: () async {
                final url = await getImage(stockCODE.text);
                print(url);
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
          if (imageUrl != ' ') Image.network(imageUrl)
        ],
      ),
    ));
  }
}
