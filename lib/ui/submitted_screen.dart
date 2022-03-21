import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:quiz/main.dart';
import 'package:quiz/ui/button.dart';
import 'package:rive/rive.dart';
import 'package:url_launcher/url_launcher.dart';

class SubmittedScreen extends StatelessWidget {
  const SubmittedScreen({Key? key, required this.score}) : super(key: key);

  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff001e3d),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 200,
            width: 200,
            child: RiveAnimation.asset('assets/animations/done.riv'),
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
          ),
          Text(
            'your Score : $score'.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50.0,
              color: Colors.green,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 200,
            child: AppButton(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return FadeScaleTransition(
                          animation: animation1,
                          child: const MyHomePage(),
                        );
                      },
                    ),
                  );
                },
                label: 'Retry'),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  launch('https://www.facebook.com/groups/2276413572590610');
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
    );
  }
}
