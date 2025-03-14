import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'basiccalc.dart';
import 'converter.dart';
import 'package:flutter/material.dart';
import 'ad_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();

  Future<InitializationStatus> _initGoogleMobileAds() {
    // Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }
}

class _MainAppState extends State<MainApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.system) {
        // Get the current system brightness
        final brightness = MediaQuery.of(context).platformBrightness;
        if (brightness == Brightness.light) {
          _themeMode = ThemeMode.dark;
        } else {
          _themeMode = ThemeMode.light;
        }
      } else if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }
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
  // Todo: add _interstitalAd
  InterstitialAd? _interstitialAd;

  void _loadInterstitialAd(index) {
    InterstitialAd.load(
      adUnitId: Adhelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _navigateToNextPage(index);
              _interstitialAd = null;
            },
          );

          setState(() {
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          _navigateToNextPage(index);
          print('Failed to load an interstitial ad: ${err.message}');
          _interstitialAd = null;
        },
      ),
    );
  }

  // add banner ad
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    // load banner ad

    BannerAd(
      adUnitId: Adhelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  void _navigateToNextPage(index) {
    // Replace with your actual navigation logic
    _controller.jumpToPage(index);
  }

  @override
  void dispose() {
    //todo dispose banner object
    _bannerAd?.dispose();
    super.dispose();
  }

  final _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Bottom '))
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                BasicCalcClass(
                  toggleTheme: widget.toggleTheme,
                  ads: _bannerAd,
                ),
                Converter(
                  toggleTheme: widget.toggleTheme,
                  ads: _bannerAd,
                ),
              ],
              onPageChanged: (index) {
                currentIndex = index;
                setState(() {});
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Theme.of(context).colorScheme.surface,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        onTap: (index) {
          if (_interstitialAd != null) {
            _interstitialAd?.show();
          } else {
            // _loadInterstitialAd(index);
            _controller.jumpToPage(index);
          }
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
