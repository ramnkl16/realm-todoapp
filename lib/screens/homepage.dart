import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posprovider/posDbProvider.dart';

import 'package:provider/provider.dart';
import 'package:flutter_todo/components/todo_list.dart';
import 'package:flutter_todo/components/create_item.dart';
import 'package:flutter_todo/components/app_bar.dart';
import 'package:flutter_todo/realm/realm_services.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('HomePage build() called');
    var r = ref.watch(posDbProvider);
    //print('r.app.currentUser: ${r.app.currentUser!.profile.email}');
    return r.app.currentUser == null
        ? const Center(
            child: Text('No user logged in'),
          )
        : Scaffold(
            appBar: TodoAppBar(),
            body: const TodoList(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: const CreateItemAction(),
          );
  }
}
