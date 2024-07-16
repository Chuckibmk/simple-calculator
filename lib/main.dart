import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'basiccalc.dart';
import 'converter.dart';
import 'package:flutter/material.dart';
import 'ad_helper.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();

  Future<InitializationStatus> _initGoogleMobileAds() {
    //TODO : // TODO: Initialize Google Mobile Ads SDK
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

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: Adhelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
        ad.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            BasicCalcClass(toggleTheme: widget.toggleTheme);
          },
        );

        setState(() {
          _interstitialAd = ad;
        });
      }, onAdFailedToLoad: (err) {
        print('Failed to load an interstitial ad: ${err.message}');
      }),
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
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          _bannerAd = ad as BannerAd;
        });
      }, onAdFailedToLoad: (ad, err) {
        print('Failed to load a banner ad: ${err.message}');
        ad.dispose();
      }),
    ).load();
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
          // if (_bannerAd != null)
          //   Align(
          //     alignment: Alignment.topCenter,
          //     child: SizedBox(
          //       width: _bannerAd!.size.width.toDouble(),
          //       height: _bannerAd!.size.height.toDouble(),
          //       child: AdWidget(ad: _bannerAd!),
          //     ),
          //   ),
          PageView(
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
        ],
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
