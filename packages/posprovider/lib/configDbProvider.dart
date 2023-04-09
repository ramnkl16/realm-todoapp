import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:realm/realm.dart';

import 'connectionInfo.dart';
import 'loggedInUser.dart';

final configDbProvider = StateProvider((ref) {
  //final app = ref.read(appProvider);
  var rp = ConfigDbProvider();
  return rp;
});

class ConfigDbProvider extends StateNotifier<Realm> {
  //final String realmPath = "${Configuration.defaultRealmPath.split("default.realm")[0]}\\config.realm";

  ConfigDbProvider()
      : super(Realm(Configuration.local(
          path:
              "${Configuration.defaultRealmPath.split("default.realm")[0]}\\config.realm",
          [
            ConnectionInfo.schema,
            LoggedInUser.schema,
          ],
        )));

  Realm get realm {
    return state;
  }

  LoggedInUser? getLastLoggedInUser() {
    try {
      var result =
          state.query<LoggedInUser>('userId LIKE "." SORT(lastLoginDt DESC');
      LoggedInUser? liu;
      if (result.isEmpty) {
        liu = null;
      } else {
        var o = result.first;
        liu = LoggedInUser(
            o.id, o.userId, o.userInfoId, o.password, o.lastLoginDt,
            firstName: o.firstName, lastName: o.lastName, roles: o.roles);
      }
      //db.close();
      return liu;
    } catch (e) {
      print("Error in getLastLoggedInUser: $e");
      return null;
    }
  }

  ConnectionInfo? getConnInfo() {
    try {
      var result = state.all<ConnectionInfo>();
      print("getConnInfo|result: ${result.length}");
      ConnectionInfo? ci;
      if (result.isEmpty) {
        ci = null;
      } else {
        var o = result.first;
        ci = ConnectionInfo(o.id, o.appId);
        ci.appUrl = o.appUrl;
        ci.baseUrl = o.baseUrl;
        ci.host = o.host;
        ci.dataSourceName = o.dataSourceName;
      }
      close();
      return ci;
    } catch (e) {
      print("Error in getConnInfo: $e");
      return null;
    }
  }

  LoggedInUser? getLoggedInUser(String userId) {
    var result = state.query<LoggedInUser>('userId == "$userId"');
    if (result.isEmpty) {
      // state.close();
      return null;
    } else {
      // state.close();
      return result.first;
    }
  }

  bool createConn(String appId,
      {String? appUrl, String? baseUrl, String? host}) {
    var obj = ConnectionInfo(ObjectId(), appId);
    try {
      state.write<ConnectionInfo>(() => state.add<ConnectionInfo>(obj));
    } catch (e) {
      print("Error in createConn: $e");
      return false;
    }
    return true;
  }

  void deleteConn(ConnectionInfo item) {
    state.write(() => state.delete(item));
    //notifyListeners();
  }

  Future<void> updateConn(ConnectionInfo item,
      {String? appId, String? appUrl, String? baseUrl, String? host}) async {
    state.write(() {
      if (appId != null) {
        item.appId = appId;
      }
      if (appUrl != null) {
        item.appUrl = appUrl;
      }
      if (baseUrl != null) {
        item.baseUrl = baseUrl;
      }
      if (host != null) {
        item.host = host;
      }
    });
  }

  Future<void> close() async {
    //state.close();
    //app!.currentUser = null;
  }

  @override
  void dispose() {
    print('ConfigDB object disposed');
    state.close();
    super.dispose();
  }
}
