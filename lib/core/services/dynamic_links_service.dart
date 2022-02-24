import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService {
  Future<Uri> createDynamicLink() async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://appsoluteapp.page.link',
      link: Uri.parse('https://google.com'),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.appsonews',
        minimumVersion: 1,
      ),
    );
    final ShortDynamicLink shortDynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    final Uri uri = shortDynamicLink.shortUrl;
    print("my URI is $uri");
    return uri;
  }
}
