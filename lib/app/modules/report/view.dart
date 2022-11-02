import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_wishflow/app/core/utils/extensions.dart';
import 'package:todo_wishflow/app/modules/home/controller.dart';
import 'package:todo_wishflow/app/modules/home/widgets/extra_custom_card.dart';
import 'package:todo_wishflow/app/modules/home/widgets/report_card.dart';

import '../../core/utils/gradientText.dart';

class ReportPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 250, 244),
        body: SafeArea(
          child: Obx(() {
            var createdTasks = homeCtrl.getTotalTask();
            var completedTasks = homeCtrl.getTotalDoneTask();
            var liveTasks = createdTasks - completedTasks;
            var percent =
                (completedTasks / createdTasks * 100).toStringAsFixed(2);

            return ListView(
              children: [
                ReportCard(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 3.0.wp, horizontal: 4.0.wp),
                  child: const Divider(
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 3.0.wp, horizontal: 5.0.wp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatus(Color.fromARGB(255, 22, 22, 22), liveTasks,
                          'Live Tasks'),
                      _buildStatus(Color.fromARGB(255, 22, 22, 22),
                          completedTasks, 'Completed'),
                      _buildStatus(Color.fromARGB(255, 22, 22, 22),
                          createdTasks, 'Created'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0.wp,
                ),
                Padding(
                  padding: EdgeInsets.all(7.0.wp),
                  child: UnconstrainedBox(
                    child: SizedBox(
                      width: 70.0.wp,
                      height: 70.0.wp,
                      child: CircularStepProgressIndicator(
                        totalSteps: createdTasks == 0 ? 1 : createdTasks,
                        currentStep: completedTasks,
                        stepSize: 20,
                        selectedColor: Color.fromARGB(255, 252, 122, 122),
                        unselectedColor: Colors.grey,
                        padding: 0,
                        width: 150,
                        height: 150,
                        selectedStepSize: 22,
                        roundedCap: (_, __) => true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GradientText(
                              '${createdTasks == 0 ? 0 : percent}%',
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                fontSize: 20.0.sp,
                                fontWeight: FontWeight.bold,
                              )),
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(255, 0, 0, 0),
                                Color.fromARGB(255, 95, 110, 138),
                              ]),
                            ),
                            SizedBox(
                              height: 1.0.wp,
                            ),
                            GradientText(
                              'Efficiency',
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.bold,
                              )),
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(255, 0, 0, 0),
                                Color.fromARGB(255, 95, 110, 138),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
        ));
  }

  Row _buildStatus(Color color, int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 3.0.wp,
          width: 3.0.wp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1.6.wp,
              color: color,
            ),
          ),
        ),
        SizedBox(width: 3.0.wp),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(
              '$number',
              style: GoogleFonts.workSans(
                  textStyle: TextStyle(
                fontSize: 16.0.sp,
                fontWeight: FontWeight.bold,
              )),
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 41, 49, 70),
                Color.fromARGB(255, 34, 38, 48).withOpacity(0.5),
              ]),
            ),
            SizedBox(height: 2.0.wp),
            GradientText(
              text,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                fontSize: 12.0.sp,
                fontWeight: FontWeight.bold,
              )),
              gradient: LinearGradient(colors: [
                Colors.black.withOpacity(0.6),
                Color.fromARGB(255, 56, 68, 99),
              ]),
            ),
          ],
        )
      ],
    );
  }
}
