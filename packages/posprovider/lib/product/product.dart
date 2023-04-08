import 'package:realm/realm.dart';

part 'product.g.dart';

@RealmModel()
class _Product {
  @MapTo('_id')
  @PrimaryKey()
  late ObjectId id;
  late String name;
  late String? desc;
}
