import 'dart:io';

class Adhelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9734967621956740/2431165448';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-9734967621956740/2431165448';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9734967621956740/9780413091';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-9734967621956740/9780413091';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  // static String get rewardedAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-3940256099942544/5224354917';
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-3940256099942544/1712485313';
  //   } else {
  //     throw UnsupportedError('Unsupported platform');
  //   }
  // }
}
