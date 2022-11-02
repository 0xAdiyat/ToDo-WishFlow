import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_wishflow/app/core/utils/keys.dart';

class StorageService extends GetxService {
  late GetStorage _box;
  Future<StorageService> init() async {
    _box = GetStorage();
    // await _box.write(taskKey, []);
    await _box.writeIfNull(taskKey, []);
    return this;
  }

  T read<T>(String key) {
    return _box.read(key);
  }

  void write(String key, dynamic value) async {
    await _box.write(key, value);
  }
}
