import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:stonk_app/components/button.dart';
import 'package:stonk_app/page/HomeScreen.dart';
import 'package:stonk_app/page/order.dart';

class HomePage extends StatelessWidget {
  final currentValue = 20;

  HomePage({super.key});
  final GlobalKey<ScaffoldState> _myKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Drawer',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('股票學習系統'),
            backgroundColor: Colors.amber,
          ),
          key: _myKey,
          endDrawer: Drawer(
            child: ListView(
              children: [
                // 自選
                ListTile(
                  title: const Text('查詢'),
                  onTap: () {
                    // 導航到自選頁面
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Search()),
                    );
                  },
                ),
                // 下單
                ListTile(
                  title: const Text('下單'),
                  onTap: () {
                    // 導航到下單頁面
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderPage(
                                startDate: DateTime(0),
                                buyPrice: 200,
                                sBuy: 20,
                              )),
                    );
                  },
                ),
                // 委託
                ListTile(
                  title: const Text('委託'),
                  onTap: () {
                    // 導航到委託頁面
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Entrust()),
                    );
                  },
                ),
                // 帳務
                ListTile(
                  title: const Text('帳務'),
                  onTap: () {
                    // 導航到帳務頁面
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Account(
                                paragraphs: [],
                                imgUrl: "",
                              )),
                    );
                  },
                ),
                // 首頁
                ListTile(
                  title: const Text('首頁'),
                  onTap: () {
                    // 導航回首頁
                  },
                ),
                // 登出
                ListTile(
                  title: const Text('登出'),
                  onTap: () {
                    // 執行登出的動作
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: const HomeScreen(
            money: 1000000,
          )),
    );
  }
}

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late PdfControllerPinch pdfControllerPinch;

  void initState() {
    super.initState();
    pdfControllerPinch =
        PdfControllerPinch(document: PdfDocument.openAsset('assets/Code.pdf'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('查詢'),
      ),
      body: _pdfView(),
    );
  }

  Widget _pdfView() {
    return Column(
      children: [
        Expanded(
            child: PdfViewPinch(
          controller: pdfControllerPinch,
        ))
      ],
    );
  }
}

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('下單'),
      ),
    );
  }
}

class Entrust extends StatelessWidget {
  const Entrust({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('委託'),
      ),
    );
  }
}

class Account extends StatelessWidget {
  final List<String> paragraphs;
  final String imgUrl;
  const Account({super.key, required this.paragraphs, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('帳務'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(imgUrl),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('投資報酬率: ', style: TextStyle(fontSize: 32)),
                Text(
                  paragraphs[0],
                  style: TextStyle(
                    fontSize: 32,
                    color: paragraphs[0].startsWith('-')
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
            Text(
              '資金: ${paragraphs[1]}',
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustButton(
                  btnText: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 18),
                  ),
                  btnColor: Color.fromARGB(255, 1, 181, 7),
                  btnHeight: 45,
                  btnWidth: 200,
                  pressAction: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(
                                  money: int.parse(paragraphs[1]),
                                )));
                  },
                ),
                CustButton(
                  btnText: const Text(
                    'Restart',
                    style: TextStyle(fontSize: 18),
                  ),
                  btnColor: const Color.fromARGB(255, 243, 33, 33),
                  btnHeight: 45,
                  btnWidth: 200,
                  pressAction: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen(
                                  money: 1000000,
                                )));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
