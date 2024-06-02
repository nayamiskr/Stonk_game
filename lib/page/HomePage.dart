import 'package:flutter/material.dart';
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
                  title: const Text('自選'),
                  onTap: () {
                    // 導航到自選頁面
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelfSelection()),
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
          body: const HomeScreen()),
    );
  }
}

class SelfSelection extends StatelessWidget {
  const SelfSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自選'),
      ),
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
  const Account({super.key, required this.paragraphs});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('賠率: ', style: TextStyle(fontSize: 32)),
                Text(
                  paragraphs[0],
                  style: TextStyle(
                    fontSize: 32,
                    color: paragraphs[0].startsWith('-')
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ],
            ),
            Text(
              '資金: ${paragraphs[1]}',
              style: TextStyle(fontSize: 32),
            )
          ],
        ),
      ),
    );
  }
}
