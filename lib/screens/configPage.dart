import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:posprovider/configDbProvider.dart';
import 'package:posprovider/connectionInfo.dart';

import '../components/app_bar.dart';

class AppConfigPage extends ConsumerStatefulWidget {
  const AppConfigPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AppConfigPage> createState() => _AppConfigPageState();
}

class _AppConfigPageState extends ConsumerState<AppConfigPage> {
  final _formKey = GlobalKey<FormState>();
  late bool isWebOrDesktop;
  late bool isLandscapeInMobileView;
  late TextEditingController _appIdController;
  late TextEditingController _appUrlController;
  late TextEditingController _baseUrlController;
  late TextEditingController _dsController;
  late TextEditingController _hostController;
  late ConnectionInfo? _ci;

  @override
  void initState() {
    super.initState();
    _ci = ref.read(configDbProvider).getConnInfo();
    _appIdController = TextEditingController();
    _appUrlController = TextEditingController();
    _baseUrlController = TextEditingController();
    _dsController = TextEditingController();
    _hostController = TextEditingController();
    _appIdController.text = _ci?.appId ?? 'todoapp-zszwu';
    _appUrlController.text = _ci?.appUrl ??
        'https://realm.mongodb.com/groups/629a7fcd50cf43191ab6d65c/apps/642c4dccdb581cf00dd68bb3';
    _baseUrlController.text = _ci?.baseUrl ?? 'https://realm.mongodb.com';
    _dsController.text = _ci?.dataSourceName ?? 'mongodb-atlas';
    _hostController.text = _ci?.host ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
          appBar: TodoAppBar(),
          //bottomSheet: UIHelper.bottomBar(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //add multiple widgets here
              const Text(
                  'Welcome to Ez Point of sale\nPlease provide connection information.',
                  style: TextStyle(
                    fontSize: 16,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 400,
                  child: TextFormField(
                      controller: _appIdController,
                      decoration: const InputDecoration(
                        labelText: 'App Id',
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 400,
                  child: TextFormField(
                      controller: _appUrlController,
                      decoration: const InputDecoration(
                        labelText: 'App Url',
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 400,
                  child: TextFormField(
                      controller: _baseUrlController,
                      decoration: const InputDecoration(
                        labelText: 'Base Url',
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 400,
                  child: TextFormField(
                      controller: _dsController,
                      decoration: const InputDecoration(
                        labelText: 'Data Source',
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 400,
                  child: TextFormField(
                      controller: _hostController,
                      decoration: const InputDecoration(
                        labelText: 'Host',
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextButton(
                    onPressed: () {
                      var appconfig = ref.read(configDbProvider);
                      var status = appconfig.createConn(
                        _appIdController.text,
                        appUrl: _appUrlController.text,
                        baseUrl: _baseUrlController.text,
                        host: _hostController.text,
                      );

                      if (status) {
                        Navigator.pushNamed(context, '/login');
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content:
                              Text('Please provide valid connection info.'),
                        ));
                      }
                    },
                    child: const Text(
                      'Continue to Login.',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      //exit(0);
                      // BlocProvider.of<LoginCubit>(context).emitInitialState();
                      // MyApp.of(context).authService.authenticated = false;
                      // var storage = getIt<HydratedStorage>();
                      // await storage.clear();
                      // var prefs = getIt<StorageService>();
                      // await prefs.clearAuthInfo();
                      // Global.clearAllMetaDatas(context);

                      // Navigator.pop(context);
                      print("Exist");
                    },
                    child: const Text(
                      'Exit',
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
