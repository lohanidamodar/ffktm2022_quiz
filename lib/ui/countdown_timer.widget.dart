import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz/ui/register_widget.dart';

import 'animated_bs.dart';

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
        Scaffold.of(context).showBottomSheet(
          (context) => AnimatedBottomSheet(
            child: const RegisterWidget(),
            title: 'Register',
            buildContext: context,
          ),
        );
      },
    );
  }
}
