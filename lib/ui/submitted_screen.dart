import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SubmittedScreen extends StatelessWidget {
  const SubmittedScreen({Key? key}) : super(key: key);

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
            'Quiz Submitted'.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50.0,
              color: Colors.green,
            ),
          ),
          const Text(
            'If selected, You will receive a call from us shortly.',
            style: TextStyle(
              color: Colors.white70,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w100,
              fontSize: 20,
            ),
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
