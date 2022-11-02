import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_wishflow/app/data/services/storage/services.dart';
import 'package:todo_wishflow/app/modules/home/binding.dart';
import 'package:todo_wishflow/app/modules/home/view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GetMaterialApp(
      title: 'WishFlow - ToDo',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}
