import 'dart:async';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:quiz/services/appwrite.dart';
import 'package:quiz/services/quiz_cubit.dart';
import 'package:quiz/ui/prompt.dart';
import 'package:quiz/ui/question_loading.widget.dart';
import 'package:quiz/ui/quiz.widget.dart';

import 'button.dart';
import 'countdown_timer.widget.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key, required this.back}) : super(key: key);
  final Function() back;
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  DocumentList? questions;
  List<Document> documents = [];
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
    documents.addAll(questions!.documents);
    documents.shuffle();
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
                        title: const Text(
                          'Are you sure?',
                          style: TextStyle(
                            fontFamily: 'Lato',
                          ),
                        ),
                        content: const Text(
                          'Closing now will clear your progress.',
                          style: TextStyle(
                            fontFamily: 'Lato',
                          ),
                        ),
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
                if (questions != null)
                  const CountdownTimer(),
                StreamBuilder<int>(
                    stream: QuizCubit().stream,
                    builder: (context, snapshot) {
                      return Text(
                        '${snapshot.data ?? 0} / 10',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Lato',
                          color: Colors.white,
                        ),
                      );
                    }),
              ],
            ),
          ),
          questions == null
              ? QuestionLoadingWidget()
              : QuizWidget( documents: documents)
        ],
      ),
    );
  }
}
