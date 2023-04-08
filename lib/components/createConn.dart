import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/components/widgets.dart';
import 'package:posprovider/configDbProvider.dart';

class CreateConnAction extends StatelessWidget {
  const CreateConnAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return styledFloatingAddButton(context,
        onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (_) => Wrap(children: const [CreateConnForm()]),
            ));
  }
}

class CreateConnForm extends ConsumerStatefulWidget {
  const CreateConnForm({Key? key}) : super(key: key);

  @override
  createState() => _CreateConnFormState();
}

class _CreateConnFormState extends ConsumerState<CreateConnForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _ConnEditingController;

  @override
  void initState() {
    _ConnEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _ConnEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('CreateConnForm build() called');
    TextTheme theme = Theme.of(context).textTheme;
    return formLayout(
        context,
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Create a new Conn", style: theme.headline6),
              TextFormField(
                controller: _ConnEditingController,
                validator: (value) =>
                    (value ?? "").isEmpty ? "Please enter some text" : null,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cancelButton(context),
                    okButton(context, "Create", onPressed: () => save(context)),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void save(BuildContext context) {
    final realmServices = ref.read(configDbProvider);
    if (_formKey.currentState!.validate()) {
      final appId = _ConnEditingController.text;
      realmServices.createConn(appId);
      Navigator.pop(context);
    }
  }
}
