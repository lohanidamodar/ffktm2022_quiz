import 'package:animate_do/animate_do.dart';
import 'package:animations/animations.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:quiz/ui/submitted_screen.dart';

import '../services/quiz_cubit.dart';
import 'answer_button.dart';

class QuizWidget extends StatelessWidget {
  QuizWidget({
    Key? key,
    required this.documents,
  }) : super(key: key);

  final PageController _pageController = PageController(keepPage: false);
  final List<Document> documents;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        itemCount: 10,
        pageSnapping: true,
        reverse: false,
        allowImplicitScrolling: true,
        onPageChanged: (index) {
          QuizCubit().updateQuestionNumber(index + 1);
        },
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: FadeIn(
                  child: Text(
                    documents.sublist(0, 10)[index].data['question'],
                    style: TextStyle(
                      color: const Color(0xff9483e1),
                      fontFamily: 'Lato',
                      fontSize: MediaQuery.of(context).size.width / 30 >= 18
                          ? MediaQuery.of(context).size.width / 30
                          : 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio:
                      MediaQuery.of(context).size.width < 500 ? 2 : 5,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  shrinkWrap: true,
                  children: [
                    ...documents.sublist(0, 10)[index].data['options'].map(
                      (e) {
                        return FadeInUp(
                          child: AnswerButton(
                            value: '$e',
                            onSelected: () async {
                              QuizCubit().checkAnswer(
                                  documents.sublist(0, 10)[index], e);
                              if (QuizCubit().currentPage >= 10) {
                                Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) {
                                      return FadeScaleTransition(
                                        animation: animation1,
                                        child: SubmittedScreen(
                                          score: QuizCubit().score,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                          ),
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
    );
  }
}
