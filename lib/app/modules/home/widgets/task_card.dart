import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_wishflow/app/core/utils/extensions.dart';
import 'package:todo_wishflow/app/data/models/task.dart';
import 'package:todo_wishflow/app/modules/details/view.dart';
import 'package:todo_wishflow/app/modules/details/widgets/done_list.dart';
import 'package:todo_wishflow/app/modules/home/controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final Task task;
  TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    var squareWidth = Get.width - 12.0.wp;

    return GestureDetector(
      onTap: () {
        homeCtrl.changeTask(task);
        homeCtrl.changeTodos(task.todos ?? []);

        Get.to(() => DetailPage());
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 252, 122, 122),
              blurRadius: 5,
              offset: const Offset(0, 7),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 11, right: 10),
              child: StepProgressIndicator(
                roundedEdges: Radius.circular(10),
                totalSteps: homeCtrl.isTodoEmpty(task) ? 1 : task.todos!.length,
                currentStep:
                    homeCtrl.isTodoEmpty(task) ? 0 : homeCtrl.getDoneTodo(task),
                size: 5.5,
                padding: 0,
                selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.6), color.withOpacity(0.7)],
                ),
                unselectedGradientColor: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white70, Colors.white70],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Icon(
                IconData(task.icon, fontFamily: 'MaterialIcons'),
                color: color,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 2.0.wp),
                    child: Text(
                      task.title,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0.sp,
                        ),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 2.0.wp),
                  Row(
                    children: [
                      _buildTaskStatus(task),
                      SizedBox(width: 10),
                      _buildTaskStatusDone(task)
                    ],
                  ),
                  // check the todos whether it's null or not,
                  // not null => return length, null => return 0
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTaskStatus(task) {
  var _createdTasksCurrent;
  var _createdTasksLeft;

  if (_createdTasksCurrent != 0) {
    _createdTasksCurrent = Get.find<HomeController>().getDoneTodo(task);
    _createdTasksLeft = task.todos?.length - _createdTasksCurrent;
  } else {
    _createdTasksCurrent = 1;
    _createdTasksLeft = 1;
  }
  return Container(
    width: 71,
    height: 30.5,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 24, 25, 25),
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 25, 25, 25).withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Center(
      child: Text(
        '${_createdTasksLeft > 0 ? _createdTasksLeft : 0} left',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget _buildTaskStatusDone(task) {
  var _createdTasksCurrent = Get.find<HomeController>().getDoneTodo(task);

  return Container(
    width: 64,
    height: 27,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 252, 244, 243),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Center(
      child: Text(
        '${_createdTasksCurrent} done',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10,
          color: Colors.black54,
        ),
      ),
    ),
  );
}
