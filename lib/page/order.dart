import 'package:flutter/material.dart';
import 'package:stonk_app/components/button.dart';
import 'package:stonk_app/features/gethttp.dart';
import 'package:stonk_app/page/HomePage.dart';

class OrderPage extends StatefulWidget {
  final DateTime startDate;
  final int buyPrice;
  final int sBuy;
  const OrderPage(
      {super.key,
      required this.startDate,
      required this.buyPrice,
      required this.sBuy});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final stockCODE = TextEditingController();
  final sellPrice = TextEditingController();
  final sSell = TextEditingController();
  late DateTime endDate;

  @override
  void initState() {
    super.initState();
    endDate = widget.startDate;
  }

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
            const SizedBox(
              height: 10,
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
              btnColor: Colors.blue,
              btnText: const Text(
                '==>',
                style: TextStyle(fontSize: 18),
              ),
              btnHeight: 45,
              btnWidth: 100,
              pressAction: () {
                setState(() {
                  endDate = endDate.add(const Duration(days: 1));
                });
              },
            ),
            const SizedBox(height: 20),
            Flexible(
                child: FractionallySizedBox(
              widthFactor: 0.8,
              child: TextField(
                controller: stockCODE,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter The Code",
                    hintStyle: TextStyle(
                      fontSize: 20,
                    )),
                textAlign: TextAlign.center,
              ),
            )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                    child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: TextField(
                    controller: sellPrice,
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
                    controller: sSell,
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
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () async {
                final url = await getImage(
                  stockCODE.text,
                  widget.startDate,
                  endDate,
                );
                print('Image URL: $url');
                setState(() {
                  imageUrl = url;
                });
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
              pressAction: () async {
                await fetchParagraphs(
                    'https://stonkgraph-api.an.r.appspot.com/stonk_api/${stockCODE.text}?start=${widget.startDate.year}-${widget.startDate.month}-${widget.startDate.day}&end=${endDate.year}-${endDate.month}-${endDate.day}&Buy=${widget.buyPrice}&Sell=${int.parse(sellPrice.text)}&SBuy=${widget.sBuy}&SSell=${int.parse(sSell.text)}');

                if (result.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Account(
                        paragraphs: result,
                        imgUrl: imageUrl,
                      ),
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
