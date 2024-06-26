import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/common/validator/validator.dart';
import 'package:plo/views/log_in_screen/log_in_controller.dart';

class LogInTextFieldWidget extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LogInTextFieldWidget(
      {super.key,
      required this.formKey,
      required this.emailController,
      required this.passwordController});
  static const defaultSpacing = SizedBox(height: 10);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("E-Mail"),
            defaultSpacing,
            TextFormField(
                controller: ref.watch(loginController.notifier).emailController,
                validator: (value) => Validator.validatePSUEmail(value),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: Theme.of(context).inputDecorationTheme.border,
                  hintText: 'abc1234@psu.edu',
                ),
                onChanged: (text) {}),
            const SizedBox(height: 25),
            const Text("Password"),
            defaultSpacing,
            TextFormField(
              controller:
                  ref.watch(loginController.notifier).passwordController,
              validator: (value) => Validator.validatePassword(value),
            ),
          ],
        ));
  }
}
