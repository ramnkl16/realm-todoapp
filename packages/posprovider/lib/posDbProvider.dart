import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posprovider/product/product.dart';
import 'package:realm/realm.dart';

import 'appProvider.dart';
import 'schemas.dart';

final posDbProvider = StateProvider((ref) {
  print('objectProvider called');
  final app = ref.read(appProvider);
  var rp = PosDbProvider(app: app);
  return rp;
});

class PosDbProvider extends StateNotifier<Realm> {
  PosDbProvider({required this.app})
      : super(Realm(Configuration.flexibleSync(
          app.currentUser!,
          [Item.schema, Product.schema],
          path:
              "${Configuration.defaultRealmPath.split("default.realm")[0]}\\pos.realm",
        )));
  final App app;

  static const String queryAllName = "getAllItemsSubscription";
  static const String queryMyItemsName = "getMyItemsSubscription";

  bool showAll = false;
  bool offlineModeOn = false;
  bool isWaiting = false;

  Realm get realm {
    return state;
  }

  void initRealm() {
    print('realmProvider.initRealm called state: $state');
    // if (app.currentUser != null) {
    //   state =
    //       Realm(Configuration.flexibleSync(app.currentUser!, [Item.schema]));

    showAll =
        (state.subscriptions.findByName(PosDbProvider.queryAllName) != null);
    if (state.subscriptions.isEmpty) {
      updateSubscriptions();
    }
    //}
  }

  Future<void> updateSubscriptions() async {
    state.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.clear();
      if (showAll) {
        mutableSubscriptions.add(state.all<Item>(), name: queryAllName);
      } else {
        mutableSubscriptions.add(
            state.query<Item>(r'owner_id == $0', [app.currentUser!.id]),
            name: queryMyItemsName);
      }
    });
    await state.subscriptions.waitForSynchronization();
  }

  Future<void> sessionSwitch() async {
    offlineModeOn = !offlineModeOn;
    if (offlineModeOn) {
      state.syncSession.pause();
    } else {
      try {
        isWaiting = true;
        //
        state.syncSession.resume();
        await updateSubscriptions();
      } finally {
        isWaiting = false;
      }
    }
    //notifyListeners();
  }

  Future<void> switchSubscription(bool value) async {
    showAll = value;
    if (!offlineModeOn) {
      try {
        isWaiting = true;
        //  notifyListeners();
        await updateSubscriptions();
      } finally {
        isWaiting = false;
      }
    }
    //notifyListeners();
  }

  void createItem(String summary, bool isComplete) {
    final newItem =
        Item(ObjectId(), summary, app.currentUser!.id, isComplete: isComplete);
    state.write<Item>(() => state.add<Item>(newItem));
    //notifyListeners();
  }

  void deleteItem(Item item) {
    state.write(() => state.delete(item));
    //notifyListeners();
  }

  Future<void> updateItem(Item item,
      {String? summary, bool? isComplete}) async {
    state.write(() {
      if (summary != null) {
        item.summary = summary;
      }
      if (isComplete != null) {
        item.isComplete = isComplete;
      }
    });
    //notifyListeners();
  }

  Future<void> close() async {
    if (app.currentUser != null) {
      await app.currentUser?.logOut();
      state.close();
      //app!.currentUser = null;
    }
  }

  @override
  void dispose() {
    state.close();
    super.dispose();
  }
}
