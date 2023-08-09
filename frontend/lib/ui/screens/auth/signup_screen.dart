import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme.dart';
import 'package:frontend/ui/screens/auth/provider/signup_provider.dart';
import 'package:frontend/ui/widgets/gap_widget.dart';
import 'package:frontend/ui/widgets/link_button.dart';
import 'package:frontend/ui/widgets/primary_button.dart';
import 'package:frontend/ui/widgets/primary_textfield.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const routeName = "signup-screen";

  void swichToLoginScreen(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Ecommerce App')),
      body: Form(
        key: provider.formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text("Create Account", style: TextStyles.heading2),
                if (provider.error != "")
                  Text(provider.error,
                      style: const TextStyle(color: Colors.red)),
                const GapWidget(),
                PrimaryTextField(
                  controller: provider.emailController,
                  labelText: "Email Address",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email required";
                    }
                    if (!EmailValidator.validate(value)) {
                      return "Invalid Email";
                    }
                    return null;
                  },
                ),
                const GapWidget(),
                PrimaryTextField(
                  controller: provider.passwordController,
                  obscureText: true,
                  labelText: "Password ",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password required";
                    }
                    return null;
                  },
                ),
                const GapWidget(),
                PrimaryTextField(
                  controller: provider.confirmPasswordController,
                  obscureText: true,
                  labelText: "Confirm Password ",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "confirm password required";
                    }
                    if (value.trim() !=
                        provider.passwordController.text.trim()) {
                      return "Passwords not matched";
                    }
                    return null;
                  },
                ),
                const GapWidget(),
                PrimaryButton(
                  text: provider.isLoading ? '...' : 'Create Account',
                  onPressed: provider.isLoading ? null : provider.createAccount,
                ),
                const GapWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyles.body2,
                    ),
                    const GapWidget(),
                    LinkButton(
                        text: "Log In",
                        onPressed: () => swichToLoginScreen(context))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
