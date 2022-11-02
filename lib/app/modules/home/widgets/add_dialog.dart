import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_wishflow/app/core/utils/extensions.dart';
import 'package:todo_wishflow/app/modules/home/controller.dart';

import '../../../core/utils/gradientText.dart';

class AddDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Form(
        key: homeCtrl.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      homeCtrl.editCtrl.clear();
                      homeCtrl.changeTask(null);
                    },
                    icon: const Icon(CupertinoIcons.xmark),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      if (homeCtrl.formKey.currentState!.validate()) {
                        if (homeCtrl.task.value == null) {
                          EasyLoading.showError("Please select task type");
                        } else {
                          var success = homeCtrl.updateTask(
                            homeCtrl.task.value!,
                            homeCtrl.editCtrl.text,
                          );
                          if (success) {
                            EasyLoading.showSuccess("Todo item added");
                            Get.back();
                            homeCtrl.changeTask(null);
                          } else {
                            EasyLoading.showError('Todo item already exist');
                          }
                          homeCtrl.editCtrl.clear();
                        }
                      }
                    },
                    child: Text(
                      'Done',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                        fontSize: 14.0.sp,
                        color: Color.fromARGB(255, 252, 122, 122),
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: GradientText(
                'New Task',
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5)),
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 22, 22, 22),
                  Color.fromARGB(255, 92, 92, 170),
                ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeCtrl.editCtrl,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your todo task';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 5.0.wp, left: 5.0.wp, right: 5.0.wp, bottom: 2.0.wp),
              child: Text(
                'Add to',
                style: TextStyle(
                    fontSize: 14.0.sp,
                    color: const Color.fromRGBO(151, 159, 173, 1)),
              ),
            ),
            ...homeCtrl.tasks
                .map(
                  (element) => Obx(
                    () => InkWell(
                      onTap: () => homeCtrl.changeTask(element),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0.wp, horizontal: 5.0.wp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  IconData(
                                    element.icon,
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  color: HexColor.fromHex(element.color),
                                ),
                                SizedBox(width: 3.0.wp),
                                Text(
                                  element.title,
                                  style: TextStyle(
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.bold,
                                    // color: const Color.fromARGB(106, 54, 69, 79),
                                  ),
                                ),
                              ],
                            ),
                            if (homeCtrl.task.value == element)
                              const Icon(
                                CupertinoIcons.checkmark_alt,
                                color: Color.fromARGB(255, 252, 122, 122),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      )),
    );
  }
}
