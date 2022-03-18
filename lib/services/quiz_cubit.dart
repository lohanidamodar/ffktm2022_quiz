import 'dart:async';
import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:quiz/services/appwrite.dart';

class QuizCubit {
  static QuizCubit? _instance;
  QuizCubit._internal() {
    _broadCastStream = _questionController.stream.asBroadcastStream();
  }
  factory QuizCubit() => _instance ??= QuizCubit._internal();

  final StreamController<int> _questionController = StreamController();

  late final Stream<int> _broadCastStream;

  Stream<int> get stream => _broadCastStream;

  int get currentPage => _currentPage;
  int get score => _score;

  int _currentPage = 0;
  int _score = 0;
  final List _answers = [];

  void updateQuestionNumber(int val) {
    _currentPage = val;
    _questionController.add(val);
  }

  Future<void> submitAnswer(String? phoneNumber) async {
    try {
      User sessionId = await AppwriteService().account.get();
      await AppwriteService().database.createDocument(
        collectionId: 'Scores',
        documentId: sessionId.$id,
        data: {
          'userId': sessionId.$id,
          'score': _score,
          'answers': _answers.toString(),
          'phone_number': phoneNumber,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  void checkAnswer(Document document, String answer) {
    String _correctAnswer = document.data['answer'];
    bool _correct = identical(_correctAnswer.trim(), answer.trim());
    if (_correct) {
      _score++;
    }

    _answers.add({
      {
        "questionId": document.$id,
        "selected_answer": answer,
        "correct": _correct
      }
    });
  }
}
