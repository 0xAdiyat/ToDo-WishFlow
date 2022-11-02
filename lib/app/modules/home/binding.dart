import 'package:get/get.dart';
import 'package:todo_wishflow/app/data/providers/task/provider.dart';
import 'package:todo_wishflow/app/modules/home/controller.dart';

import '../../data/services/storage/repository.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
