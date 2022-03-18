import 'package:animations/animations.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:quiz/services/appwrite.dart';
import 'package:quiz/ui/button.dart';
import 'package:quiz/ui/quiz_screen.dart';

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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              size: MediaQuery.of(context).size.width / 4 < 180
                  ? 180
                  : MediaQuery.of(context).size.width / 4,
              style: FlutterLogoStyle.horizontal,
            ),
            OpenContainer(
              closedColor: Colors.white70,
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
            )
          ],
        ),
      ),
    );
  }
}
