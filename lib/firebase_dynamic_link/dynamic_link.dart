import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLink {
  static DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://haarway.page.link',
    link: Uri.parse('https://haarway.page.link/helloworld'),
    androidParameters: AndroidParameters(
      packageName: 'com.haarway.app',
      minimumVersion: 0,
    ),
    iosParameters: IosParameters(
      bundleId: 'com.example.ios',
      minimumVersion: '1.0.1',
      appStoreId: '123456789',
    ),
    googleAnalyticsParameters: GoogleAnalyticsParameters(
      campaign: 'example-promo',
      medium: 'social',
      source: 'orkut',
    ),
    itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
      providerToken: '123456',
      campaignToken: 'example-promo',
    ),
    socialMetaTagParameters: SocialMetaTagParameters(
      title: 'Example of a Dynamic Link',
      description: 'This link works whether app is installed or not!',
    ),
  );

//  final Uri dynamicUrl = await parameters.buildUrl();
}
