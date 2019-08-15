import 'package:goalkeeper/Services/Interfaces/IDatabase.dart';
import 'package:goalkeeper/Services/Interfaces/IRepository.dart';
import 'package:goalkeeper/Services/NotificationCenter.dart';

class Factory {
  static IDatabase databaseSingleton;
  static IRepository repositorySingleton;
  static NotificationCenter notificationCenterSingleton;

  static Factory _instance = Factory.createInstance();
  Factory.createInstance();
  factory Factory() => _instance;

  // each of the services must comply to the corresponding contract (i.e: interface - which is also class in dart..)
  // thats why we bound the types with generics

  void registerDatabase<T extends IDatabase>(T database) {
    if (databaseSingleton == null) databaseSingleton = database;
  }

  void registerRepository<T extends IRepository>(T repository) {
    if (repositorySingleton == null) repositorySingleton = repository;
  }

  void registerNotificationCenter<T extends NotificationCenter>(
      T notificationCenter) {
    if (notificationCenterSingleton == null)
      notificationCenterSingleton = notificationCenter;
  }

  IDatabase get database => databaseSingleton != null
      ? databaseSingleton
      : throw StateError('Register your dependencies before requisting them !');

  IRepository get repository => repositorySingleton != null
      ? repositorySingleton
      : throw StateError('Register your dependencies before requisting them !');

  NotificationCenter get notificationCenter => notificationCenterSingleton !=
          null
      ? notificationCenterSingleton
      : throw StateError('Register your dependencies before requisting them !');
}
