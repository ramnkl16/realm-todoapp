import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posprovider/posDbProvider.dart';
import 'package:posprovider/schemas.dart';
import 'package:provider/provider.dart';

import 'package:flutter_todo/realm/realm_services.dart';
import 'package:flutter_todo/components/widgets.dart';

class ModifyItemForm extends ConsumerStatefulWidget {
  final Item item;
  const ModifyItemForm(this.item, {Key? key}) : super(key: key);

  @override
  _ModifyItemFormState createState() => _ModifyItemFormState(item);
}

class _ModifyItemFormState extends ConsumerState<ModifyItemForm> {
  final _formKey = GlobalKey<FormState>();
  final Item item;
  late TextEditingController _summaryController;
  late ValueNotifier<bool> _isCompleteController;

  _ModifyItemFormState(this.item);

  @override
  void initState() {
    _summaryController = TextEditingController(text: item.summary);
    _isCompleteController = ValueNotifier<bool>(item.isComplete)
      ..addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    _summaryController.dispose();
    _isCompleteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme myTextTheme = Theme.of(context).textTheme;
    final realmServices = ref.watch(posDbProvider);
    return formLayout(
        context,
        Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Update your item", style: myTextTheme.headline6),
                TextFormField(
                  controller: _summaryController,
                  validator: (value) =>
                      (value ?? "").isEmpty ? "Please enter some text" : null,
                ),
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    children: <Widget>[
                      radioButton("Complete", true, _isCompleteController),
                      radioButton("Incomplete", false, _isCompleteController),
                    ],
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cancelButton(context),
                      deleteButton(context,
                          onPressed: () =>
                              delete(realmServices, item, context)),
                      okButton(context, "Update",
                          onPressed: () async => await update(
                              context,
                              realmServices,
                              item,
                              _summaryController.text,
                              _isCompleteController.value)),
                    ],
                  ),
                ),
              ],
            )));
  }

  Future<void> update(BuildContext context, PosDbProvider realmServices,
      Item item, String summary, bool isComplete) async {
    if (_formKey.currentState!.validate()) {
      await realmServices.updateItem(item,
          summary: summary, isComplete: isComplete);
      Navigator.pop(context);
    }
  }

  void delete(PosDbProvider realmServices, Item item, BuildContext context) {
    realmServices.deleteItem(item);
    Navigator.pop(context);
  }
}
