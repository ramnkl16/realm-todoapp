import 'package:realm/realm.dart';
part 'loggedInUser.g.dart';

@RealmModel()
class _LoggedInUser {
  @MapTo('_id')
  @PrimaryKey()
  late ObjectId id;
  late String userId;
  late String userInfoId;
  late String password;
  late String lastLoginDt;
  late String? firstName;
  late String? lastName;
  late List<String> roles;
  late List<String> distributors;
}
