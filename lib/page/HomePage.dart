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
                                endDate: DateTime(0),
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
                      MaterialPageRoute(builder: (context) => const Account()),
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
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('帳務'),
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            // 可用資金
            Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Text(
                    '    可用資金             ',
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    '總報酬',
                    style: TextStyle(fontSize: 25),
                  ),
                  Spacer(),
                ],
              ),
            ),
            // 總報酬
            Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Text(
                    '    損益             ',
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    '    未實現存益',
                    style: TextStyle(fontSize: 25),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Text(
                    '    以實損益             ',
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    '庫存報',
                    style: TextStyle(fontSize: 25),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: Row(children: [
                  Text(
                    '',
                    style: TextStyle(fontSize: 25),
                  ),
                ])),
            Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Text(
                        '    名稱     市/均      股數      損益',
                        style: TextStyle(fontSize: 25),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
