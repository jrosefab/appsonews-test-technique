import 'package:appsonews/core/services/dynamic_links_service.dart';
import 'package:appsonews/ui/router.dart';
import 'package:appsonews/ui/viewmodels/shared_pref_view_model.dart';
import 'package:appsonews/ui/screens/page_view_hanlder.dart';
import 'package:appsonews/ui/viewmodels/news_viewmodel.dart';
import 'package:appsonews/utils/constants/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DynamicLinkService();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsViewModel()),
        ChangeNotifierProvider(create: (context) => SharedPrefViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: AppRoutes.HOME_ROUTE,
      onGenerateRoute: MyRouter.generateRoute,
      home: SafeArea(top: false, child: PageViewHandler()),
    );
  }
}
