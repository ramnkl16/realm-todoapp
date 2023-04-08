// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authInfo.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class LoggedInUser extends _LoggedInUser
    with RealmEntity, RealmObjectBase, RealmObject {
  LoggedInUser(
    ObjectId id,
    String userId,
    String userInfoId,
    String password,
    String lastLoginDt, {
    String? firstName,
    String? lastName,
    Iterable<String> roles = const [],
    Iterable<String> distributors = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'userInfoId', userInfoId);
    RealmObjectBase.set(this, 'password', password);
    RealmObjectBase.set(this, 'lastLoginDt', lastLoginDt);
    RealmObjectBase.set(this, 'firstName', firstName);
    RealmObjectBase.set(this, 'lastName', lastName);
    RealmObjectBase.set<RealmList<String>>(
        this, 'roles', RealmList<String>(roles));
    RealmObjectBase.set<RealmList<String>>(
        this, 'distributors', RealmList<String>(distributors));
  }

  LoggedInUser._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get userId => RealmObjectBase.get<String>(this, 'userId') as String;
  @override
  set userId(String value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String get userInfoId =>
      RealmObjectBase.get<String>(this, 'userInfoId') as String;
  @override
  set userInfoId(String value) =>
      RealmObjectBase.set(this, 'userInfoId', value);

  @override
  String get password =>
      RealmObjectBase.get<String>(this, 'password') as String;
  @override
  set password(String value) => RealmObjectBase.set(this, 'password', value);

  @override
  String get lastLoginDt =>
      RealmObjectBase.get<String>(this, 'lastLoginDt') as String;
  @override
  set lastLoginDt(String value) =>
      RealmObjectBase.set(this, 'lastLoginDt', value);

  @override
  String? get firstName =>
      RealmObjectBase.get<String>(this, 'firstName') as String?;
  @override
  set firstName(String? value) => RealmObjectBase.set(this, 'firstName', value);

  @override
  String? get lastName =>
      RealmObjectBase.get<String>(this, 'lastName') as String?;
  @override
  set lastName(String? value) => RealmObjectBase.set(this, 'lastName', value);

  @override
  RealmList<String> get roles =>
      RealmObjectBase.get<String>(this, 'roles') as RealmList<String>;
  @override
  set roles(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<String> get distributors =>
      RealmObjectBase.get<String>(this, 'distributors') as RealmList<String>;
  @override
  set distributors(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<LoggedInUser>> get changes =>
      RealmObjectBase.getChanges<LoggedInUser>(this);

  @override
  LoggedInUser freeze() => RealmObjectBase.freezeObject<LoggedInUser>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(LoggedInUser._);
    return const SchemaObject(
        ObjectType.realmObject, LoggedInUser, 'LoggedInUser', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('userId', RealmPropertyType.string),
      SchemaProperty('userInfoId', RealmPropertyType.string),
      SchemaProperty('password', RealmPropertyType.string),
      SchemaProperty('lastLoginDt', RealmPropertyType.string),
      SchemaProperty('firstName', RealmPropertyType.string, optional: true),
      SchemaProperty('lastName', RealmPropertyType.string, optional: true),
      SchemaProperty('roles', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('distributors', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
    ]);
  }
}
