import 'package:flutter/material.dart';

class AnswerButton extends StatefulWidget {
  const AnswerButton({Key? key, required this.value, required this.onSelected})
      : super(key: key);

  final String value;
  final ValueGetter onSelected;

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            isSelected = false;
          } else {
            isSelected = true;
          }
        });

        if (isSelected) {
          Future.delayed(const Duration(milliseconds: 500), () {
            widget.onSelected.call();
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff001e3d) : const Color(0xff9483e1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: kElevationToShadow[6],
          border: Border.all(
            color: isSelected ? const Color(0xff9483e1) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            widget.value,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Lato',
              color: isSelected ? const Color(0xff9483e1) : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
