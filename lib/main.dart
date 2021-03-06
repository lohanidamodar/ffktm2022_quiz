import 'package:animations/animations.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:quiz/services/appwrite.dart';
import 'package:quiz/ui/button.dart';
import 'package:quiz/ui/quiz_screen.dart';
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
    super.initState();
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
                children: [
                  const FlutterLogo(
                    size: 150,
                    style: FlutterLogoStyle.markOnly,
                  ),
                  const Text(
                    'Flutter Kathmandu',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          launch(
                              'https://www.facebook.com/groups/2276413572590610');
                        },
                        icon: const Icon(FontAwesome5Brands.facebook),
                        color: Colors.white60,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {
                          launch('https://www.meetup.com/flutter-kathmandu/');
                        },
                        icon: const Icon(FontAwesome5Brands.meetup),
                        color: Colors.white60,
                      )
                    ],
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
