import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class QuestionLoadingWidget extends StatelessWidget {

  final RiveAnimationController _danceAnimation = SimpleAnimation('slowDance');
  final RiveAnimationController _lookUpAnimation = OneShotAnimation('lookUp');

  QuestionLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: (MediaQuery.of(context).size.width / 5) < 250
              ? 250
              : (MediaQuery.of(context).size.width / 5),
          height: 300,
          child: RiveAnimation.asset(
            'assets/animations/dash.riv',
            fit: BoxFit.contain,
            controllers: [
              _danceAnimation,
              _lookUpAnimation,
            ],
            onInit: (artboard) {
              Future.delayed(const Duration(seconds: 1), () {
                _lookUpAnimation.isActive = true;
                _danceAnimation.isActive = true;
              });
            },
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 40.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontFamily: 'Lato',
            ),
            textAlign: TextAlign.center,
            child: AnimatedTextKit(
              pause: const Duration(milliseconds: 700),
              isRepeatingAnimation: false,
              animatedTexts: [
                FadeAnimatedText('Hi!'),
                FadeAnimatedText('I am Dash'),
                FadeAnimatedText('I am preparing questions for you',
                    textAlign: TextAlign.center),
                FadeAnimatedText('Almost Done'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
