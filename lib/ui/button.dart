import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onTap,
    required this.label,
    this.isSecondary = false,
  }) : super(key: key);

  final Function() onTap;
  final String label;
  final bool isSecondary;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          border: isSecondary
              ? Border.all(width: 2.0, color: const Color(0xff9483e1))
              : null,
          gradient: isSecondary
              ? const LinearGradient(colors: [Colors.white, Colors.white])
              : const LinearGradient(
                  colors: [Color(0xff001e3d), Color(0xff9483e1)],
                ),
          borderRadius: BorderRadius.circular(3),
          boxShadow: kElevationToShadow[6],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 18,
              color: isSecondary ? const Color(0xff9483e1) : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonLoading extends StatelessWidget {
  const ButtonLoading({
    Key? key,
    this.child = const CircularProgressIndicator(
      color: Colors.white,
    ),
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff001e3d), Color(0xff9483e1)],
        ),
        borderRadius: BorderRadius.circular(100),
        boxShadow: kElevationToShadow[6],
      ),
      child: child,
    );
  }
}
