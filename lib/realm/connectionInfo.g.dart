// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectionInfo.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class ConnectionInfo extends _ConnectionInfo
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  ConnectionInfo(
    ObjectId id,
    String appId, {
    String? appUrl,
    String? baseUrl,
    String? dataSourceName = "mongodb-atlas",
    String? host,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<ConnectionInfo>({
        'dataSourceName': "mongodb-atlas",
      });
    }
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'appId', appId);
    RealmObjectBase.set(this, 'appUrl', appUrl);
    RealmObjectBase.set(this, 'baseUrl', baseUrl);
    RealmObjectBase.set(this, 'dataSourceName', dataSourceName);
    RealmObjectBase.set(this, 'host', host);
  }

  ConnectionInfo._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get appId => RealmObjectBase.get<String>(this, 'appId') as String;
  @override
  set appId(String value) => RealmObjectBase.set(this, 'appId', value);

  @override
  String? get appUrl => RealmObjectBase.get<String>(this, 'appUrl') as String?;
  @override
  set appUrl(String? value) => RealmObjectBase.set(this, 'appUrl', value);

  @override
  String? get baseUrl =>
      RealmObjectBase.get<String>(this, 'baseUrl') as String?;
  @override
  set baseUrl(String? value) => RealmObjectBase.set(this, 'baseUrl', value);

  @override
  String? get dataSourceName =>
      RealmObjectBase.get<String>(this, 'dataSourceName') as String?;
  @override
  set dataSourceName(String? value) =>
      RealmObjectBase.set(this, 'dataSourceName', value);

  @override
  String? get host => RealmObjectBase.get<String>(this, 'host') as String?;
  @override
  set host(String? value) => RealmObjectBase.set(this, 'host', value);

  @override
  Stream<RealmObjectChanges<ConnectionInfo>> get changes =>
      RealmObjectBase.getChanges<ConnectionInfo>(this);

  @override
  ConnectionInfo freeze() => RealmObjectBase.freezeObject<ConnectionInfo>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ConnectionInfo._);
    return const SchemaObject(
        ObjectType.realmObject, ConnectionInfo, 'ConnectionInfo', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('appId', RealmPropertyType.string),
      SchemaProperty('appUrl', RealmPropertyType.string, optional: true),
      SchemaProperty('baseUrl', RealmPropertyType.string, optional: true),
      SchemaProperty('dataSourceName', RealmPropertyType.string,
          optional: true),
      SchemaProperty('host', RealmPropertyType.string, optional: true),
    ]);
  }
}
