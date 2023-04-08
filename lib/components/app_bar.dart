// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/realm/posDbProvider.dart';
import 'package:flutter_todo/realm/appProvider.dart';

class TodoAppBar extends ConsumerWidget with PreferredSizeWidget {
  TodoAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('TodoAppBar build() called');
    //final realmServices = Provider.of<RealmServices>(context);
    //final realmServices = ref.watch(posDbProvider);
    return AppBar(
      title: const Text('Realm Flutter To-Do'),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        IconButton(
            icon: Icon(true ? Icons.wifi_off_rounded : Icons.wifi_rounded),
            tooltip: 'Offline mode',
            onPressed: () async {
              var realm = ref.read(posDbProvider);
              await realm.sessionSwitch();
            }),
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'Log out',
          onPressed: () async => await logOut(context, ref),
        ),
      ],
    );
  }

  Future<void> logOut(BuildContext context, WidgetRef ref) async {
    //final appServices = Provider.of<AppServices>(context, listen: false);
    final auth = ref.watch(appProvider);
    final realmServices = ref.watch(posDbProvider);
    if (auth.currentUser != null) {
      await auth.currentUser?.logOut();
      await realmServices.close();
    }

    Navigator.pushNamed(context, '/login');
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
