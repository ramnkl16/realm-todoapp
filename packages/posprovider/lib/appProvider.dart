import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

import 'configDbProvider.dart';

final appProvider = StateNotifierProvider<AppProvider, App>((ref) {
  final config = ref.read(configDbProvider);
  final connInfo = config.getConnInfo();
  return AppProvider(appId: connInfo!.appId);

//  return ap;
});

class AppProvider extends StateNotifier<App> {
  AppProvider({required this.appId}) : super(App(AppConfiguration(appId)));
  final String appId;

  Future<User> logInUserEmailPassword(String email, String password) async {
    print('logInUserEmailPassword $email $password');

    User loggedInUser =
        await state.logIn(Credentials.emailPassword(email, password));
    print(
        'registerUserEmailPassword currentUser: ${loggedInUser.profile.email}, state.current ${state.currentUser!.id}}');
    //print('logInUserEmailPassword currentUser: ${loggedInUser.profile.email}');

    return loggedInUser;
  }

  Future<User> registerUserEmailPassword(String email, String password) async {
    //_getApp();
    EmailPasswordAuthProvider authProvider = EmailPasswordAuthProvider(state);
    await authProvider.registerUser(email, password);
    User loggedInUser =
        await state.logIn(Credentials.emailPassword(email, password));

    return loggedInUser;
  }

  Future<void> logOut() async {
    print('logOut called state.current ${state.currentUser!.profile.email}}');
    await state.currentUser!.logOut();
    print('logOut called state.current ${state.currentUser}}');
    //state = null;
  }
}
