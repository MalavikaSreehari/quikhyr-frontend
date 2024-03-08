import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quikhyr/common/constants/app_sizing.dart';
import 'package:quikhyr/features/auth/blocs/sign_in_bloc/sign_in_bloc.dart';

class HomeDetailsScreen extends StatelessWidget {
  const HomeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          automaticallyImplyLeading: false, // Remove back button
          backgroundColor: Colors.transparent,
          title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("Hi")]),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<SignInBloc>().add(const SignOutRequired());
                },
                icon: const Icon(
                  Icons.login,
                  color: Colors.white,
                ))
          ],
        ),
        body: const Center(child: Text("HomeDetailsScreen")));
  }
}
