import 'package:calculator/basiccalc.dart';
import 'package:calculator/converter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

// class Appcolors {
//   static const darkBlue = Color.fromARGB(255, 12, 12, 41);
//   static const lightBlue = Color.fromARGB(255, 76, 76, 104);
// }

// class Apptheme {
//   static final lightTheme = ThemeData(
//     primaryColor: Appcolors.lightBlue,
//     brightness: Brightness.light,
//   );

//   static final darkTheme = ThemeData(
//     primaryColor: Appcolors.darkBlue,
//     brightness: Brightness.dark,
//   );
// }

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      home: Home(toggleTheme: _toggleTheme),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
    );
  }
}

class Home extends StatefulWidget {
  final VoidCallback toggleTheme;

  const Home({super.key, required this.toggleTheme});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Bottom '))
      body: PageView(
        controller: _controller,
        children: [
          BasicCalcClass(toggleTheme: widget.toggleTheme),
          Converter(toggleTheme: widget.toggleTheme),
        ],
        onPageChanged: (index) {
          currentIndex = index;
          setState(() {});
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Theme.of(context).colorScheme.surface,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        onTap: (index) {
          _controller.jumpToPage(index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate_outlined), label: 'Calculator'),
          BottomNavigationBarItem(
              icon: Icon(Icons.straighten), label: 'Converter')
        ],
      ),
    );
  }
}
