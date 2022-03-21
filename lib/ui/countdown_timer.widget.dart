import 'package:animations/animations.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz/ui/submitted_screen.dart';

import '../services/quiz_cubit.dart';

class CountdownTimer extends StatelessWidget {
  const CountdownTimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: 10 * 10,
      initialDuration: 0,
      controller: CountDownController(),
      width: 50,
      height: 50,
      ringColor: Colors.grey[300]!,
      ringGradient: null,
      fillColor: const Color(0xff9483e1),
      backgroundColor: const Color(0xff001e3d),
      backgroundGradient: null,
      strokeWidth: 2.0,
      strokeCap: StrokeCap.round,
      textStyle: const TextStyle(
          fontSize: 14.0,
          color: Colors.white,
          fontFamily: 'Lato',
          fontWeight: FontWeight.bold),
      textFormat: CountdownTextFormat.MM_SS,
      isReverse: true,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: true,
      onComplete: () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return FadeScaleTransition(
                animation: animation1,
                child: SubmittedScreen(
                  score: QuizCubit().score,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
