import 'package:flutter/material.dart';
import 'package:stonk_app/components/button.dart';
import 'package:stonk_app/components/textinput.dart';
import 'package:stonk_app/features/gethttp.dart';
import 'package:stonk_app/page/HomePage.dart';

class OrderPage extends StatefulWidget {
  final DateTime startDate;
  final int buyPrice;

  const OrderPage({super.key, required this.startDate, required this.buyPrice});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final stockCODE = TextEditingController();
  final sellPrice = TextEditingController();
  DateTime endDate = DateTime(2023, 12, 1);
  String imageUrl = ' ';
  List<String> result = [];

  Future<void> fetchParagraphs(String url) async {
    try {
      List<String> pTexts = await getParagraphs(url);
      print('Fetched paragraphs: $pTexts');
      setState(() {
        result = pTexts;
      });
    } catch (e) {
      print('Error fetching paragraphs: $e');
    }
  }

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
              padding: EdgeInsets.all(20),
              child: Text('購買股票', style: TextStyle(fontSize: 30)),
            ),
            Center(
              child: Text(
                'End Date: ${endDate.year}年 ${endDate.month}月 ${endDate.day}日',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            const SizedBox(height: 20),
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
                  firstDate: widget.startDate,
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
            const SizedBox(height: 40),
            TextInput(
              controller: stockCODE,
              hintText: 'Input the code of stock',
              obscureText: false,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: TextField(
                controller: sellPrice,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter the Price",
                    hintStyle: TextStyle(
                      fontSize: 20,
                    )),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () async {
                try {
                  final url = await getImage(
                    stockCODE.text,
                    widget.startDate,
                    endDate,
                    widget.buyPrice,
                    int.parse(sellPrice.text),
                  );
                  print('Image URL: $url');
                  await fetchParagraphs(
                      'https://stonkgraph-api.an.r.appspot.com/stonk_api/${stockCODE.text}?start=${widget.startDate.year}-${widget.startDate.month}-${widget.startDate.day}&end=${endDate.year}-${endDate.month}-${endDate.day}&Buy=${widget.buyPrice}&Sell=${int.parse(sellPrice.text)}');
                  setState(() {
                    imageUrl = url;
                  });
                } catch (e) {
                  // Handle exceptions
                  print('Error: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('發生錯誤: $e'),
                    ),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(218, 3, 121, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Search',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            if (imageUrl != ' ') Image.network(imageUrl),
            const SizedBox(height: 30),
            CustButton(
              btnColor: Colors.red,
              btnText: const Text(
                'Sell',
                style: TextStyle(fontSize: 25),
              ),
              btnHeight: 40,
              btnWidth: 150,
              pressAction: () {
                if (result.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Account(paragraphs: result),
                    ),
                  );
                } else {
                  // Handle empty paragraphs case
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('未能獲取資料，請重試'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
