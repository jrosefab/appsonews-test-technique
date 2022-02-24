import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService {
  Future<Uri> buildLink(String article) async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://appsonews-app.page.link',
      link: Uri.parse('https://appsonews-app.page.link/news?article=$article'),
      androidParameters: const AndroidParameters(
        packageName: "com.exemple.appsonews",
        minimumVersion: 1,
      ),
    );

    final Uri uri = await dynamicLinks.buildLink(parameters);

    return uri;
  }

  Future handleDynamicLinks() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    _handleDeepLink(initialLink);

    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      _handleDeepLink(dynamicLinkData);
    }).onError((error) {
      print("Dynamic Link failed : $error");
    });
  }

  void getLinkForegroundAndBackground() {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      print("getLinkForegroundAndBackground $dynamicLinkData");
    }).onError((error) {
      // Handle errors
    });
  }

  void _handleDeepLink(PendingDynamicLinkData? data) {
    final Uri? deepLink = data?.link;

    print("hello there");
    print(deepLink);
    if (deepLink != null) {
      print("there ${deepLink.queryParameters["article"]}");
      final queryParams = deepLink.queryParameters;
      if (queryParams.isNotEmpty) {
        String? article = queryParams["article"];
        // verify the username is parsed correctly
        print("The article is: $article");
      }
      print("handleDeepLink ${deepLink.queryParameters}");
    }
  }
}
