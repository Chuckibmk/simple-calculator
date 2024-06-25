import 'package:calculator/basiccalc.dart';
import 'package:calculator/converter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Bottom '))
      body: PageView(
        controller: _controller,
        children: [
          BasicCalcClass(),
          Converter(),
        ],
        onPageChanged: (index) {
          currentIndex = index;
          setState(() {});
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Color.fromARGB(255, 228, 222, 222),
        unselectedItemColor: Color.fromARGB(255, 32, 30, 30),
        onTap: (index) {
          _controller.jumpToPage(index);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate_outlined), label: 'Calculator'),
          BottomNavigationBarItem(
              icon: Icon(Icons.straighten), label: 'Converter')
        ],
      ),
    );
  }
}
