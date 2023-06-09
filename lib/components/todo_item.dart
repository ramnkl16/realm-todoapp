import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/components/modify_item.dart';
import 'package:flutter_todo/components/widgets.dart';

import 'package:flutter_todo/theme.dart';
import 'package:posprovider/appProvider.dart';
import 'package:posprovider/posDbProvider.dart';
import 'package:posprovider/schemas.dart';
import 'package:provider/provider.dart';

import 'package:flutter_todo/realm/realm_services.dart';

enum MenuOption { edit, delete }

class TodoItem extends ConsumerWidget {
  final Item item;

  const TodoItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('TodoItem build() called');
    //final realmServices = Provider.of<RealmServices>(context);
    final auth = ref.read(appProvider);
    final realmServices = ref.watch(posDbProvider);
    bool isMine = (item.ownerId == auth.currentUser?.id);
    return item.isValid
        ? ListTile(
            leading: Checkbox(
              value: item.isComplete,
              onChanged: (bool? value) async {
                if (isMine) {
                  await realmServices.updateItem(item,
                      isComplete: value ?? false);
                } else {
                  errorMessageSnackBar(context, "Change not allowed!",
                          "You are not allowed to change the status of \n tasks that don't belog to you.")
                      .show(context);
                }
              },
            ),
            title: Text(item.summary),
            subtitle: Text(
              isMine ? '(mine) ' : '',
              style: boldTextStyle(),
            ),
            trailing: SizedBox(
              width: 25,
              child: PopupMenuButton<MenuOption>(
                onSelected: (menuItem) =>
                    handleMenuClick(context, menuItem, item, ref),
                itemBuilder: (context) => [
                  const PopupMenuItem<MenuOption>(
                    value: MenuOption.edit,
                    child: ListTile(
                        leading: Icon(Icons.edit), title: Text("Edit item")),
                  ),
                  const PopupMenuItem<MenuOption>(
                    value: MenuOption.delete,
                    child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text("Delete item")),
                  ),
                ],
              ),
            ),
            shape: const Border(bottom: BorderSide()),
          )
        : Container();
  }

  void handleMenuClick(
      BuildContext context, MenuOption menuItem, Item item, WidgetRef ref) {
    final PosDbProvider realmServices = ref.read(posDbProvider);
    final auth = ref.watch(appProvider);
    print(
        "handleMenuClick: item.ownerId: ${item.ownerId}, auth?.user?.id: ${auth.currentUser?.id} auth?.user?.id == item.ownerId: ${auth?.currentUser?.id == item.ownerId}");

    bool isMine = (item.ownerId == auth.currentUser?.id);
    switch (menuItem) {
      case MenuOption.edit:
        if (isMine) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => Wrap(children: [ModifyItemForm(item)]),
          );
        } else {
          errorMessageSnackBar(context, "Edit not allowed!",
                  "You are not allowed to edit tasks \nthat don't belog to you.")
              .show(context);
        }
        break;
      case MenuOption.delete:
        if (isMine) {
          realmServices.deleteItem(item);
        } else {
          errorMessageSnackBar(context, "Delete not allowed!",
                  "You are not allowed to delete tasks \n that don't belog to you.")
              .show(context);
        }
        break;
    }
  }
}
