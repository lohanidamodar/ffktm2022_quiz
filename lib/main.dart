import 'package:animations/animations.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quiz/services/appwrite.dart';
import 'package:quiz/ui/button.dart';
import 'package:quiz/ui/quiz_screen.dart';
import 'package:quiz/ui/submitted_screen.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Festival Kathmandu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    AppwriteService();
    checkSubmissionStatus();
    super.initState();
  }

  Future<void> checkSubmissionStatus() async {
    setState(() {
      isLoading = true;
    });
    User _user;
    try {
      _user = await AppwriteService().account.get();
      try {
        await AppwriteService()
            .database
            .getDocument(collectionId: 'Scores', documentId: _user.$id);
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return FadeScaleTransition(
                animation: animation1,
                child: const SubmittedScreen(),
              );
            },
          ),
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            colorFilter: ColorFilter.mode(
              Colors.black54,
              BlendMode.multiply,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: const [
                  FlutterLogo(
                    size: 150,
                    style: FlutterLogoStyle.markOnly,
                  ),
                  Text(
                    'Flutter Kathmandu',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              OpenContainer(
                closedColor: Colors.transparent,
                closedElevation: 0,
                closedBuilder: (BuildContext context, void Function() action) {
                  return isLoading
                      ? const ButtonLoading()
                      : SizedBox(
                          width: MediaQuery.of(context).size.width / 5 < 200
                              ? 200
                              : MediaQuery.of(context).size.width / 5,
                          child: AppButton(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });

                              try {
                                await AppwriteService().account.get();
                                action.call();
                              } catch (e) {
                                try {
                                  await AppwriteService()
                                      .account
                                      .createAnonymousSession();
                                  action.call();
                                } on AppwriteException catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          e.message ?? 'Something went wrong!'),
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Something went wrong!'),
                                    ),
                                  );
                                }
                              }
                              setState(() {
                                isLoading = false;
                              });
                            },
                            label: 'Start Quiz',
                          ),
                        );
                },
                openBuilder: (BuildContext context,
                    void Function({Object? returnValue}) action) {
                  return QuizScreen(
                    back: action,
                  );
                },
              ),
              RichText(
                text: TextSpan(
                    children: [
                      const TextSpan(text: 'Built with '),
                      TextSpan(
                        text: 'Flutter',
                        style: const TextStyle(
                          color: Colors.redAccent,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch('https://flutter.dev/');
                          },
                      ),
                      const TextSpan(text: ' & '),
                      TextSpan(
                        text: 'Appwrite',
                        style: const TextStyle(
                          color: Colors.redAccent,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch('https://appwrite.io/');
                          },
                      ),
                    ],
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lato',
                      fontSize: 16,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
