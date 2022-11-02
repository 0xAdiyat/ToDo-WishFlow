import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_wishflow/app/core/utils/extensions.dart';
import 'package:todo_wishflow/app/modules/details/widgets/doing_list.dart';
import 'package:todo_wishflow/app/modules/details/widgets/done_list.dart';
import 'package:todo_wishflow/app/modules/home/controller.dart';

class DetailPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value!;
    var color = HexColor.fromHex(task.color);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 250, 244),
        body: Form(
          key: homeCtrl.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        homeCtrl.updateTodos();
                        homeCtrl.changeTask(null);
                        homeCtrl.editCtrl.clear();
                      },
                      icon: const Icon(CupertinoIcons.arrow_left),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                child: Row(
                  children: [
                    Icon(
                      IconData(task.icon, fontFamily: 'MaterialIcons'),
                      color: color,
                      size: 9.0.wp,
                    ),
                    SizedBox(width: 3.0.wp),
                    Text(task.title,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 20.0.sp,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(197, 30, 31, 31)),
                        ))
                  ],
                ),
              ),
              Obx(() {
                var totalTodos =
                    homeCtrl.doingTodos.length + homeCtrl.doneTodos.length;
                return Padding(
                  padding: EdgeInsets.only(
                    top: 3.0.wp,
                    left: 16.0.wp,
                    right: 16.0.wp,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '$totalTodos Tasks',
                        style: TextStyle(fontSize: 12.0.sp, color: Colors.grey),
                      ),
                      SizedBox(width: 3.0.wp),
                      Expanded(
                          child: StepProgressIndicator(
                        totalSteps: totalTodos == 0 ? 1 : totalTodos,
                        currentStep: homeCtrl.doneTodos.length,
                        size: 5,
                        padding: 0,
                        selectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [color.withOpacity(0.5), color],
                        ),
                        unselectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey[300]!, Colors.grey[300]!],
                        ),
                      )),
                    ],
                  ),
                );
              }),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 5.0.wp),
                child: TextFormField(
                  controller: homeCtrl.editCtrl,
                  autofocus: true,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(bottom: 1.3.wp),
                      child: Icon(
                        CupertinoIcons.square,
                        color: Colors.grey[400],
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (homeCtrl.formKey.currentState!.validate()) {
                          var success =
                              homeCtrl.addTodo(homeCtrl.editCtrl.text);

                          if (success) {
                            EasyLoading.showSuccess('Item added');
                          } else {
                            EasyLoading.showError('Item already exist');
                          }

                          homeCtrl.editCtrl.clear();
                        }
                      },
                      icon: const Icon(
                        CupertinoIcons.checkmark_alt_circle_fill,
                        color: Color.fromARGB(255, 252, 122, 122),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your todo item';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              DoingList(),
              DoneList(),
            ],
          ),
        ),
      ),
    );
  }
}
