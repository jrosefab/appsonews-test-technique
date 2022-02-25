import 'package:appsonews/core/models/article_model.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService {
  Future<Uri> buildLink() async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://appsonewstest.page.link',
      link: Uri.parse('https://appsonewstest.page.link/news?'),
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

    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      _handleDeepLink(dynamicLinkData);
    }).onError((error) {
      print("Dynamic Link failed : $error");
    });

    return _handleDeepLink(initialLink);
  }

  Future<String?> _handleDeepLink(PendingDynamicLinkData? data) async {
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      final queryParams = deepLink.queryParameters;
      if (queryParams.isNotEmpty) {
        String? article = queryParams["article"];
        // verify the username is parsed correctly
        return article;
      }
    }
    return null;
  }
}
