import 'package:appsonews/utils/constants/strings.dart';
import 'package:appsonews/utils/constants/url.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService {
  Future<Uri> buildLink() async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: AppUrl.DYNAMIC_LINKS,
      link: Uri.parse('${AppUrl.DYNAMIC_LINKS}/news?'),
      androidParameters: AndroidParameters(
        packageName: AppStrings.APP_PACKAGE,
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

        return article;
      }
    }
    return null;
  }
}
