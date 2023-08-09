import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/theme.dart';
import 'package:frontend/logic/cubits/user_cubit/user_cubit.dart';
import 'package:frontend/logic/cubits/user_cubit/user_state.dart';
import 'package:frontend/ui/screens/auth/provider/login_provider.dart';
import 'package:frontend/ui/screens/auth/signup_screen.dart';
import 'package:frontend/ui/screens/home/home_screen.dart';
import 'package:frontend/ui/widgets/gap_widget.dart';
import 'package:frontend/ui/widgets/link_button.dart';
import 'package:frontend/ui/widgets/primary_button.dart';
import 'package:frontend/ui/widgets/primary_textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = "login-screen";

  void swichToSignupScreen(BuildContext context) {
    Navigator.of(context).pushNamed(SignUpScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedInState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Ecommerce App')),
        body: Form(
          key: provider.formKey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text("Log In", style: TextStyles.heading2),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      LinkButton(
                        onPressed: () {},
                        text: 'Forget Password?',
                      )
                    ],
                  ),
                  const GapWidget(),
                  PrimaryButton(
                    text: provider.isLoading ? '...' : 'Log In',
                    onPressed: provider.isLoading ? null : provider.login,
                  ),
                  const GapWidget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyles.body2,
                      ),
                      const GapWidget(),
                      LinkButton(
                          text: "Sign Up",
                          onPressed: () => swichToSignupScreen(context))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
