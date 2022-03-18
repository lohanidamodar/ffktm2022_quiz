import 'package:animations/animations.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:quiz/services/quiz_cubit.dart';
import 'package:quiz/ui/button.dart';
import 'package:quiz/ui/submitted_screen.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2 < 500
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width / 2,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.cyan.shade100,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.info),
                    Text(
                      '  Please enter your phone number to participate in giveaway.',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  filled: true,
                  border: InputBorder.none,
                  suffixIcon: Tooltip(
                    message: 'Your Phone Number',
                    triggerMode: TooltipTriggerMode.tap,
                    child: Icon(Icons.info_outline),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              isSubmitting
                  ? const ButtonLoading()
                  : AppButton(
                      onTap: () async {
                        setState(() {
                          isSubmitting = true;
                        });
                        try {
                          await QuizCubit().submitAnswer(_phoneController.text);
                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) {
                                return FadeScaleTransition(
                                  animation: animation1,
                                  child: const SubmittedScreen(),
                                );
                              },
                            ),
                          );
                        } on AppwriteException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content:
                                  Text(e.message ?? 'Something Went Wrong'),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                'Something Went Wrong. Error Code: ${e.hashCode}',
                                style: const TextStyle(
                                  fontFamily: 'Lato',
                                ),
                              ),
                            ),
                          );
                        } finally {
                          setState(() {
                            isSubmitting = false;
                          });
                        }
                      },
                      label: 'Submit',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}