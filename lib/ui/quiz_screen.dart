import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:appwrite/models.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz/services/appwrite.dart';
import 'package:quiz/services/quiz_cubit.dart';
import 'package:quiz/ui/animated_bs.dart';
import 'package:quiz/ui/answer_button.dart';
import 'package:quiz/ui/prompt.dart';
import 'package:quiz/ui/register_widget.dart';
import 'package:rive/rive.dart';

import 'button.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key, required this.back}) : super(key: key);
  final Function() back;
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final RiveAnimationController _danceAnimation = SimpleAnimation('slowDance');
  final RiveAnimationController _lookUpAnimation = OneShotAnimation('lookUp');

  final PageController _pageController = PageController();

  DocumentList? questions;
  bool isFetching = true;
  int score = 0;
  List answers = [];

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 10), () {
      fetchQuestions();
    });

    super.initState();
  }

  void fetchQuestions() async {
    questions = await AppwriteService().fetchQuizes();
    setState(() {
      isFetching = false;
    });
    QuizCubit().updateQuestionNumber(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff001e3d),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  color: Colors.white,
                  onPressed: () {
                    openPrompt(
                      context: context,
                      child: AlertDialog(
                        actionsAlignment: MainAxisAlignment.spaceBetween,
                        actionsPadding: const EdgeInsets.all(5),
                        actionsOverflowButtonSpacing: 10,
                        title: const Text('Are you sure?'),
                        content:
                            const Text('Closing now will clear your progress.'),
                        actions: [
                          AppButton(
                            isSecondary: true,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            label: 'Cancel',
                          ),
                          AppButton(
                            onTap: () {
                              Navigator.pop(context);
                              widget.back.call();
                            },
                            label: 'I Understand',
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.close_rounded),
                ),
                questions != null
                    ? CircularCountDownTimer(
                        duration: 20 * 10,
                        initialDuration: 0,
                        controller: CountDownController(),
                        width: 50,
                        height: 50,
                        ringColor: Colors.grey[300]!,
                        ringGradient: null,
                        fillColor: const Color(0xff9483e1),
                        backgroundColor: const Color(0xff001e3d),
                        backgroundGradient: null,
                        strokeWidth: 3.0,
                        strokeCap: StrokeCap.round,
                        textStyle: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textFormat: CountdownTextFormat.MM_SS,
                        isReverse: true,
                        isReverseAnimation: false,
                        isTimerTextShown: true,
                        autoStart: true,
                        onComplete: () {
                          widget.back.call();
                        },
                      )
                    : const SizedBox(),
                StreamBuilder<int>(
                    stream: QuizCubit().stream,
                    builder: (context, snapshot) {
                      return Text(
                        '${snapshot.data ?? 0}/10',
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      );
                    }),
              ],
            ),
          ),
          questions == null
              ? Column(
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
                          fontWeight: FontWeight.w100,
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
                )
              : Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 10,
                    pageSnapping: true,
                    reverse: true,
                    allowImplicitScrolling: true,
                    onPageChanged: (index) {
                      QuizCubit().updateQuestionNumber(index + 1);
                    },
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            child: Text(
                              questions!.documents[index].data['question'],
                              style: TextStyle(
                                color: const Color(0xff9483e1),
                                fontSize:
                                    MediaQuery.of(context).size.width / 30 >= 18
                                        ? MediaQuery.of(context).size.width / 30
                                        : 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio:
                                  MediaQuery.of(context).size.width < 500
                                      ? 2
                                      : 5,
                              padding: const EdgeInsets.all(20),
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              shrinkWrap: true,
                              children: [
                                ...questions!.documents[index].data['options']
                                    .map(
                                  (e) {
                                    return AnswerButton(
                                      value: '$e',
                                      onSelected: () async {
                                        QuizCubit().checkAnswer(
                                            questions!.documents[index], e);
                                        if (QuizCubit().currentPage >= 10) {
                                          Scaffold.of(context).showBottomSheet(
                                            (context) => AnimatedBottomSheet(
                                              child: const RegisterWidget(),
                                              title: 'Register',
                                              buildContext: context,
                                            ),
                                          );
                                        } else {
                                          _pageController.nextPage(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeInOut,
                                          );
                                        }
                                      },
                                    );
                                  },
                                ).toList(),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }
}
