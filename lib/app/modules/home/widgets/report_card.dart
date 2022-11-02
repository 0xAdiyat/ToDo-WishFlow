import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_wishflow/app/core/utils/extensions.dart';

import '../../../core/utils/gradientText.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 28, 29, 33),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.grey[800], shape: BoxShape.circle),
                    child: const Icon(
                      CupertinoIcons.chart_bar_alt_fill,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.0.wp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GradientText(
                          'Report Summary',
                          style: GoogleFonts.spaceGrotesk(
                              textStyle: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5)),
                          gradient: LinearGradient(colors: [
                            Colors.grey,
                            Color.fromARGB(255, 57, 57, 63),
                          ]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GradientText(
                          DateFormat.yMMMMd().format(DateTime.now()),
                          style: GoogleFonts.workSans(
                              textStyle: TextStyle(
                            letterSpacing: 1,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 66, 92, 99),
                            Color.fromARGB(255, 250, 237, 234),
                          ]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 15,
          right: 15,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 252, 122, 122),
                borderRadius: BorderRadius.circular(15)),
            child: Icon(
              CupertinoIcons.arrow_turn_left_down,
              color: Colors.white,
              size: 19,
            ),
          ),
        ),
      ],
    ));
  }
}
