import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:pinearth/utils/constants/local_storage_keys.dart';

import '../../../domain/services/i_local_storage_service.dart';

class HiveLocalStorageService implements ILocalStorageService {

  @override
  Future getItem(storage, key, {defaultValue}) async {
    await init();
    final box = await Hive.openBox(storage);
    return await box.get(key, defaultValue: defaultValue);
  }

  @override
  Future<void> init() async {
    final appDDir = await path.getApplicationDocumentsDirectory();
    Hive.init(appDDir.path);
    await Hive.openBox(userDataBoxKey);
    await Hive.openBox(appDataBoxKey);
  }

  @override
  Future<bool> removeItem(storage, key) async {
    await init();
    final box = await Hive.openBox(storage);
    await box.delete(key);
    return true;
  }

  @override
  Future<bool> setItem(storage, key, value) async {
    await init();
    final box = await Hive.openBox(storage);
    await box.put(key, value);
    return true;
  }
}

final hiveLocalStorageService = Provider<ILocalStorageService>((ref) => HiveLocalStorageService());