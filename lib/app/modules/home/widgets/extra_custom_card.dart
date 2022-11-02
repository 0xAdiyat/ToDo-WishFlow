import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_wishflow/app/core/utils/extensions.dart';

import '../../../core/utils/gradientText.dart';

class ExtraCustomCard extends StatelessWidget {
  const ExtraCustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
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
                  CupertinoIcons.star_lefthalf_fill,
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
                    Text(
                      'Go Premium',
                      style: GoogleFonts.spaceGrotesk(
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GradientText(
                      'Go beyond the limits\nget exclusive features!',
                      style: GoogleFonts.workSans(
                          textStyle: TextStyle(
                        letterSpacing: 1,
                        fontSize: 16,
                      )),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 99, 66, 66),
                        Color.fromARGB(255, 250, 237, 234),
                      ]),
                    ),
                  ],
                ),
              )
            ],
          ),
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
              CupertinoIcons.arrow_right,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ));
  }
}
