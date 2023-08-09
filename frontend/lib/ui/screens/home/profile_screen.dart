import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/theme.dart';
import 'package:frontend/data/model/user/user_model.dart';
import 'package:frontend/logic/cubits/user_cubit/user_cubit.dart';
import 'package:frontend/logic/cubits/user_cubit/user_state.dart';
import 'package:frontend/ui/screens/auth/login_screen.dart';
import 'package:frontend/ui/screens/users/edit_profile_screen.dart';
import 'package:frontend/ui/widgets/link_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedOutState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            LoginScreen.routeName,
            (_) => false,
          );
        }
      },
      builder: (context, state) {
        if (state is UserLoadingState || state is UserLoggedOutState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is UserErrorState) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is UserLoggedInState) {
          return userProfile(state.userModel);
        }

        return const Center(
          child: Text("An error occured!"),
        );
      },
    );
  }

  Widget userProfile(UserModel userModel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${userModel.fullName}", style: TextStyles.heading3),
            Text(
              "${userModel.email}",
              style: TextStyles.body2,
            ),
            LinkButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProfileScreen.routeName);
              },
              text: "Edit Profile",
            ),
          ],
        ),
        const Divider(),
        ListTile(
            onTap: () {
              // Navigator.pushNamed(context, MyOrderScreen.routeName);
            },
            contentPadding: EdgeInsets.zero,
            leading: const Icon(CupertinoIcons.cube_box_fill),
            title: Text(
              "My Orders",
              style: TextStyles.body1,
            )),
        ListTile(
            onTap: () {
              BlocProvider.of<UserCubit>(context).signOut();
            },
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            title: Text("Sign Out",
                style: TextStyles.body1.copyWith(color: Colors.red))),
      ],
    );
  }
}
