abstract class ICache<T> {
  bool shouldSyncCache = true;
  Future<void> syncCache();
}
