//Auto code generated from xml definition 2023-01-18 21:06:32.3753491 +0530 IST
//UserInfo
import 'package:realm/realm.dart';
part 'connectionInfo.g.dart';

@RealmModel()
class _ConnectionInfo {
  @MapTo('_id')
  @PrimaryKey()
  late ObjectId id;
  late String appId;
  late String? appUrl;
  late String? baseUrl;
  late String? dataSourceName = "mongodb-atlas";
  late String? host;
}
