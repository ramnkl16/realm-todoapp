import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter_todo/realm/posDbProvider.dart';
import 'package:flutter_todo/theme.dart';
import 'dart:convert';
import 'package:flutter_todo/screens/homepage.dart';
import 'package:flutter_todo/screens/log_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'realm/appProvider.dart';
import 'realm/configDbProvider.dart';
import 'screens/configPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final realmConfig = json
      .decode(await rootBundle.loadString('assets/config/atlasConfig.json'));
  String appId = realmConfig['appId'];
  return runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final currentUser = Provider.of<RealmServices?>(context, listen: false)?.currentUser;

    final configDb = ref.watch(configDbProvider);
    final connInfo = configDb.getConnInfo();

    String initialRoute = '/';
    if (connInfo == null) {
      // final realm = ref.read(posDbProvider);
      // realm.initRealm();
      print('App build called, connInfo: null');
      initialRoute = '/';
    } else {
      final auth = ref.watch(appProvider);
      if (auth.currentUser == null) {
        print('App build called, currentUser: null');
        initialRoute = '/login';
        // final realm = ref.read(posDbProvider);
        // realm.initRealm();
        print(
            'App build called, currentUser: ${auth.currentUser?.profile.email}');
      } else {
        initialRoute = '/home';
        final realm = ref.read(posDbProvider);
        realm.initRealm();
        print('App build called, currentUser: null');
      }
    }
    print('initialRoute: $initialRoute');
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        title: 'Realm Flutter Todo',
        theme: appThemeData(),
        initialRoute: initialRoute,
        routes: {
          '/': (context) => const AppConfigPage(),
          '/home': (context) => const HomePage(),
          '/login': (context) => LogIn(),
        },
      ),
    );
  }
}
