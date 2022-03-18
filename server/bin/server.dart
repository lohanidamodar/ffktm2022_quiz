import 'dart:math';

import 'account.dart';

void main(List<String> args) async {
  List<Map<String, dynamic>> _questions = const [
    {
      "question": "What are the build modes in flutter?",
      "options": ["Debug", "Release", "Profile", "All the Above"],
      "answer": "All the Above"
    },
    {
      "question": "Which company developed flutter?",
      "options": ["Facebook", "Khalti", "Google", "Jio"],
      "answer": "Google"
    },
    {
      "question":
          "Stable support for windows was announced in flutter version?",
      "options": ["2.10.0", "2.10.1", "2.10.2", "2.10.2"],
      "answer": "2.10.0"
    },
    {
      "question": "Which is not a life cycle of StatefulWidget?",
      "options": ["build()", "didUpdateWidget()", "useState()", "deactivate()"],
      "answer": "useState()"
    },
    {
      "question": "Primary programming language used to build Flutter apps is?",
      "options": ["Javascript", "Dart", "C++", "Go"],
      "answer": "Dart"
    },
    {
      "question": "The first alpha version of Flutter was released in",
      "options": ["May 2017", "May 2018", "May 2016", "May 2019"],
      "answer": "May 2017"
    },
    {
      "question": "The Dart language can be compiled using _______ compiler.",
      "options": ["AOT", "JIT", "Both AOT and JIT", "None of the above"],
      "answer": "Both AOT and JIT"
    },
    {
      "question": "What types of tests can you perform in Flutter?",
      "options": [
        "Unit Tests",
        "Widget Tests",
        "Integration Tests",
        "All of the above"
      ],
      "answer": "All the Above"
    },
    {
      "question": "What was the first name of the flutter?",
      "options": ["Dart Native", "Sky", "Dash", "Universe"],
      "answer": "Sky"
    },
    {
      "question": "In which version of dart null safety was introduced?",
      "options": ["2.0.0", "2.2.0", "2.12.0", "2.15.0"],
      "answer": "2.12.0"
    },
    {
      "question":
          "Which of these functions contain the code which houses the widgets of your app?",
      "options": ["debug()", "runApp()", "random()", "build()"],
      "answer": "build()"
    },
    {
      "question": "Which command is used for the switching Flutter channel?",
      "options": [
        "Git switch <channel-name>",
        "flutter switch <channel-name>",
        "flutter checkout <channel-name>",
        "flutter channel <channel-name>"
      ],
      "answer": "flutter channel <channel-name>"
    },
    {
      "question":
          "Which web renderer flutter uses by default to render web content on mobile?",
      "options": ["Html", "Canvaskit", "None", "Both"],
      "answer": "Html"
    },
    {
      "question": "Flutter’s web support became stable on?",
      "options": ["March 2021", "March 2020", "December 2019", "May 2021"],
      "answer": "March 2021"
    },
    {
      "question": "First public commit to flutter repository was made on?",
      "options": ["February 2015", "May 2020", "December 2014", "October 2014"],
      "answer": "October 2014"
    },
  ];

  final AppwriteService _appwriteService = AppwriteService();

  await Future.wait(_questions.map((e) async {
    try {
      await _appwriteService.database.createDocument(
          collectionId: 'questions',
          documentId: Random().nextInt(9999999).toString(),
          data: e,
          read: ['role:member']);
      print('success');
    } catch (e) {
      print('$e');
    }
  }));

  // var col =
  //     await _appwriteService.database.listDocuments(collectionId: 'questions');
  // await Future.wait(col.documents.map((element) async {
  //   await _appwriteService.database
  //       .deleteDocument(collectionId: 'questions', documentId: element.$id);
  // }));
}
